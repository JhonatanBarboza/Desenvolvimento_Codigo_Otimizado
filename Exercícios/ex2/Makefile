# Makefile para Atividade 2 - SSC0951

CC = gcc
CFLAGS = -pg -O0 -Wall
TARGET = ex2
SOURCE = ex2.c

# Compilar com profiling
$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

# Executar o programa
run: $(TARGET)
	./$(TARGET)

# Gerar análise do gprof
analyze: gmon.out
	gprof $(TARGET) gmon.out > analysis.txt
	@echo "Análise salva em analysis.txt"
	@echo "Para ver a análise: cat analysis.txt"

# Executar análise completa
profile: $(TARGET)
	./$(TARGET)
	gprof $(TARGET) gmon.out > analysis.txt
	@echo "Análise completa salva em analysis.txt"
	@echo "Para ver a análise: cat analysis.txt"

# Limpar arquivos gerados
clean:
	rm -f $(TARGET) gmon.out analysis.txt

.PHONY: run analyze profile clean