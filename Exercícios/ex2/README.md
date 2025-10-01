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

### Arquivos Gerados
- `ex2` - Executável compilado
- `gmon.out` - Arquivo de profiling gerado pelo gprof
- `analysis.txt` - Relatório de análise em texto