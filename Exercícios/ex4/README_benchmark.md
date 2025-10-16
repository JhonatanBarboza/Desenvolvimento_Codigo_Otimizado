# Script de Benchmark de Otimização GCC

Este script automatiza todo o processo de compilação e medição solicitado na atividade.

## Como usar:

```bash
# Torna o script executável (só precisa fazer uma vez)
chmod +x benchmark.sh

# Executa o benchmark
./benchmark.sh fasta.c
./benchmark.sh n-body.c
```

## O que o script faz:

### A. Compilação com todas as flags:
- **Sem otimização**: `gcc -o executavel_base codigo_fonte.c`
- **-O1**: `gcc -O1 -o executavel_o1 codigo_fonte.c`
- **-O2**: `gcc -O2 -o executavel_o2 codigo_fonte.c`
- **-O3**: `gcc -O3 -o executavel_o3 codigo_fonte.c`
- **-Os**: `gcc -Os -o executavel_os codigo_fonte.c`

**Nota**: O script detecta automaticamente se o programa precisa de flags especiais (como `-mavx -lm` para n-body.c).

### B. Medições automáticas:

#### I. Tempo de Compilação:
- Compila cada versão 3 vezes e calcula a média
- Usa o comando `time` para medir precisão

#### II. Tamanho do Executável:
- Mede o tamanho em KB usando `stat`
- Mostra resumo com `ls -lh`

#### III. Tempo de Execução:
- Executa cada programa 5 vezes
- Calcula a média dos tempos
- Usa `time` para medição precisa
- **Parâmetros automáticos**:
  - `fasta.c`: executa com parâmetro `50000000`
  - `n-body.c`: executa com parâmetro `50000000`

## Resultados:

O script gera:
1. **Saída na tela**: Tabela formatada com todos os resultados
2. **Arquivo de resultados**: `resultados_<nome_programa>.txt` com dados detalhados
3. **Resumo dos executáveis**: Tamanhos dos arquivos gerados

## Exemplo de uso:

```bash
# Para o arquivo fasta.c
./benchmark.sh fasta.c

# Para o arquivo n-body.c  
./benchmark.sh n-body.c
```

## Resultados típicos observados:

### n-body.c:
- **Tempo de execução sem otimização**: ~20.5s
- **Tempo de execução com -O3**: ~2.8s (**7x mais rápido!**)
- **Tamanho sem otimização**: ~20KB
- **Tamanho com otimização**: ~16KB

### fasta.c:
- **Tempo de execução sem otimização**: ~3.58s
- **Tempo de execução com -O1**: ~2.41s (**1.5x mais rápido!**)
- **Tempo de execução com -O2**: ~2.41s (similar ao -O1)
- **Tempo de execução com -O3**: ~2.45s (ligeiramente mais lento que -O1/-O2)
- **Tempo de execução com -Os**: ~3.68s (mais lento que sem otimização)
- **Tamanho sem otimização**: ~16.29KB
- **Tamanho com otimizações**: ~16.01KB (redução mínima)
- **Melhor performance**: -O1 e -O2 oferecem o melhor custo-benefício

## Limpeza:

Para remover os executáveis gerados:
```bash
rm executavel_*
```