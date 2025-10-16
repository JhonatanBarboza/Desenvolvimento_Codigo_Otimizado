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
## Limpeza:

Para remover os executáveis gerados:
```bash
rm executavel_*
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
- Compila cada versão 10 vezes e calcula a média
- Usa o comando `time` para medir precisão

#### II. Tamanho do Executável:
- Mede o tamanho em KB usando `stat`
- Mostra resumo com `ls -lh`

#### III. Tempo de Execução:
- Executa cada programa 10 vezes
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

## Resultados típicos observados:

#### fasta.c
- **Melhor performance:** -O3 (52% mais rápido)
- **Comportamento consistente:** -O1, -O2 e -O3 apresentam performance similar (~51-52% melhoria)
- **-Os neutro:** Performance equivalente ao código não otimizado
- **Ganho moderado:** Máximo de 1.52x de speedup

#### n-body.c
- **Melhor performance:** -O3 (7.37x mais rápido)
- **Ganho significativo:** Todas as otimizações oferecem speedup > 5x
- **Progressão clara:** O1 ≈ O2 ≈ Os < O3
- **Alto potencial de otimização:** Devido à natureza matemática intensiva
