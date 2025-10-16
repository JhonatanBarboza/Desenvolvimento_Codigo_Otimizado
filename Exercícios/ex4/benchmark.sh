#!/bin/bash

# Script para automatizar compilação e benchmark de programas C
# Uso: ./benchmark.sh <arquivo_fonte.c>

# Verifica se foi fornecido o arquivo fonte
if [ $# -eq 0 ]; then
    echo "Uso: $0 <arquivo_fonte.c>"
    echo "Exemplo: $0 fasta.c"
    exit 1
fi

SOURCE_FILE="$1"
BASE_NAME=$(basename "$SOURCE_FILE" .c)

# Verifica se o arquivo fonte existe
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Erro: Arquivo '$SOURCE_FILE' não encontrado!"
    exit 1
fi

echo "=================================================="
echo "BENCHMARK DE OTIMIZAÇÃO - $SOURCE_FILE"
if [ -n "$PROGRAM_ARGS" ]; then
    echo "Parâmetros de execução: $PROGRAM_ARGS"
fi
echo "=================================================="
echo

# Arrays com as configurações de compilação
FLAGS=("" "-O1" "-O2" "-O3" "-Os")
SUFFIXES=("base" "o1" "o2" "o3" "os")
DESCRIPTIONS=("Sem otimização" "Otimização -O1" "Otimização -O2" "Otimização -O3" "Otimização -Os")

# Número de execuções para calcular a média
NUM_EXECUTIONS=10

# Determina parâmetros baseado no nome do arquivo
PROGRAM_ARGS=""
case "$BASE_NAME" in
    "fasta")
        PROGRAM_ARGS="50000000"
        ;;
    "n-body")
        PROGRAM_ARGS="50000000"
        ;;
    *)
        PROGRAM_ARGS=""
        ;;
esac

# Arquivo para salvar os resultados
RESULTS_FILE="resultados_${BASE_NAME}.txt"

# Limpa arquivo de resultados anterior
echo "RESULTADOS DO BENCHMARK - $SOURCE_FILE" > "$RESULTS_FILE"
echo "Data: $(date)" >> "$RESULTS_FILE"
echo "=================================================" >> "$RESULTS_FILE"
echo >> "$RESULTS_FILE"

# Header da tabela
printf "%-20s %-15s %-15s %-15s\n" "CONFIGURAÇÃO" "TEMPO COMP.(s)" "TAMANHO(KB)" "TEMPO EXEC.(s)"
printf "%-20s %-15s %-15s %-15s\n" "CONFIGURAÇÃO" "TEMPO COMP.(s)" "TAMANHO(KB)" "TEMPO EXEC.(s)" >> "$RESULTS_FILE"
echo "--------------------------------------------------------------------"
echo "--------------------------------------------------------------------" >> "$RESULTS_FILE"

# Loop através de cada configuração
for i in "${!FLAGS[@]}"; do
    FLAG="${FLAGS[$i]}"
    SUFFIX="${SUFFIXES[$i]}"
    DESC="${DESCRIPTIONS[$i]}"
    EXECUTABLE="executavel_${SUFFIX}"
    
    echo
    echo "Testando: $DESC ($FLAG)"
    echo "Testando: $DESC ($FLAG)" >> "$RESULTS_FILE"
    
    # 1. TEMPO DE COMPILAÇÃO
    echo "  Medindo tempo de compilação..."
    
    # Compila 10 vezes e calcula a média do tempo de compilação
    TOTAL_COMPILE_TIME=0
    for j in {1..10}; do
        # Determina flags extras baseado no nome do arquivo
        EXTRA_FLAGS=""
        case "$BASE_NAME" in
            "n-body")
                EXTRA_FLAGS="-mavx -lm"
                ;;
            *)
                EXTRA_FLAGS=""
                ;;
        esac
        
        COMPILE_TIME=$((/usr/bin/time -f "%e" gcc $FLAG $EXTRA_FLAGS -o "$EXECUTABLE" "$SOURCE_FILE") 2>&1 | tail -n1)
        TOTAL_COMPILE_TIME=$(echo "$TOTAL_COMPILE_TIME + $COMPILE_TIME" | bc -l)
    done
    AVG_COMPILE_TIME=$(echo "scale=4; $TOTAL_COMPILE_TIME / 10" | bc -l)
    
    # 2. TAMANHO DO EXECUTÁVEL
    if [ -f "$EXECUTABLE" ]; then
        SIZE_BYTES=$(stat -c%s "$EXECUTABLE")
        SIZE_KB=$(echo "scale=2; $SIZE_BYTES / 1024" | bc -l)
    else
        echo "  Erro: Executável não foi criado!"
        continue
    fi
    
    # 3. TEMPO DE EXECUÇÃO
    echo "  Medindo tempo de execução ($NUM_EXECUTIONS execuções)..."
    
    TOTAL_EXEC_TIME=0
    SUCCESSFUL_RUNS=0
    
    for j in $(seq 1 $NUM_EXECUTIONS); do
        echo -n "    Execução $j/$NUM_EXECUTIONS... "
        
        # Executa o programa e mede o tempo (com parâmetros se necessário)
        if [ -n "$PROGRAM_ARGS" ]; then
            EXEC_TIME=$((/usr/bin/time -f "%e" ./"$EXECUTABLE" $PROGRAM_ARGS) 2>&1 | tail -n1)
        else
            EXEC_TIME=$((/usr/bin/time -f "%e" ./"$EXECUTABLE") 2>&1 | tail -n1)
        fi
        
        # Verifica se o tempo é um número válido
        if [[ $EXEC_TIME =~ ^[0-9]+\.?[0-9]*$ ]]; then
            TOTAL_EXEC_TIME=$(echo "$TOTAL_EXEC_TIME + $EXEC_TIME" | bc -l)
            SUCCESSFUL_RUNS=$((SUCCESSFUL_RUNS + 1))
            echo "OK (${EXEC_TIME}s)"
        else
            echo "ERRO"
        fi
    done
    
    if [ $SUCCESSFUL_RUNS -gt 0 ]; then
        AVG_EXEC_TIME=$(echo "scale=4; $TOTAL_EXEC_TIME / $SUCCESSFUL_RUNS" | bc -l)
    else
        AVG_EXEC_TIME="ERRO"
    fi
    
    # Exibe e salva os resultados
    printf "%-20s %-15s %-15s %-15s\n" "$DESC" "$AVG_COMPILE_TIME" "$SIZE_KB" "$AVG_EXEC_TIME"
    printf "%-20s %-15s %-15s %-15s\n" "$DESC" "$AVG_COMPILE_TIME" "$SIZE_KB" "$AVG_EXEC_TIME" >> "$RESULTS_FILE"
done

echo
echo "=================================================="
echo "RESUMO EXECUTÁVEIS GERADOS:"
echo "=================================================="
ls -lh executavel_* 2>/dev/null | awk '{printf "%-20s %8s\n", $9, $5}'

echo
echo "=================================================="
echo "Resultados salvos em: $RESULTS_FILE"
echo "=================================================="

# Salva também o resumo dos arquivos no final do arquivo de resultados
echo >> "$RESULTS_FILE"
echo "RESUMO DOS EXECUTÁVEIS GERADOS:" >> "$RESULTS_FILE"
echo "================================" >> "$RESULTS_FILE"
ls -lh executavel_* 2>/dev/null >> "$RESULTS_FILE"

echo
echo "Para limpar os executáveis gerados, execute:"
echo "rm executavel_*"