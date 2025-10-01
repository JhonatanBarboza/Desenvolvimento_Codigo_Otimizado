# Atividade 2 - SSC0951 Desenvolvimento de Código Otimizado
## Análise de Performance com gprof

### Descrição
Este programa implementa três algoritmos de ordenação (Bubble Sort, Selection Sort e Insertion Sort) para análise de performance usando a ferramenta gprof.

### Algoritmos Implementados
1. **Bubble Sort** - O(n²)
2. **Selection Sort** - O(n²) 
3. **Insertion Sort** - O(n²)

### Funcionalidades
- Função `clean_cache()` para limpar caches do processador antes de cada execução
- Execução de cada algoritmo 10 vezes para obter tempo médio
- Array de 5000 elementos aleatórios para teste
- Análise de profiling com gprof

### Como Usar

#### Compilação
```bash
make
```

#### Execução Simples
```bash
make run
```

#### Análise Completa (Executa + Gera Relatório)
```bash
make profile
```

#### Ver Análise
```bash
cat analysis.txt
```

#### Limpeza
```bash
make clean
```
<!-- 
### Análise dos Resultados

Os resultados do gprof mostram:

1. **Bubble Sort** - 44.80% do tempo total (0.56s)
   - Mais lento dos três algoritmos
   - 56ms por chamada em média

2. **Selection Sort** - 16.00% do tempo total (0.20s)
   - Performance intermediária
   - 20ms por chamada em média

3. **Insertion Sort** - 11.20% do tempo total (0.14s)
   - Mais rápido dos três algoritmos
   - 14ms por chamada em média

4. **clean_cache()** - 28.00% do tempo total (0.35s)
   - Função executada 30 vezes (3x por algoritmo)
   - Essencial para garantir medições justas

### Conclusões Teóricas vs Práticas

Embora todos os algoritmos tenham complexidade assintótica O(n²), na prática:

- **Insertion Sort** mostrou melhor performance devido ao seu comportamento otimizado para dados parcialmente ordenados
- **Selection Sort** teve performance intermediária com número fixo de comparações
- **Bubble Sort** foi o mais lento devido ao maior número de trocas necessárias

### Arquivos Gerados
- `ex2` - Executável compilado
- `gmon.out` - Arquivo de profiling gerado pelo gprof
- `analysis.txt` - Relatório de análise em texto
-->