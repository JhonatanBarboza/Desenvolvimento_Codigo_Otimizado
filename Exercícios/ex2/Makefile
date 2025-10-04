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

# Executar programa 10 vezes
run10: $(TARGET)
	@echo "Executando o programa 10 vezes..."
	@i=1; while [ $$i -le 10 ]; do \
		echo ""; \
		echo "=== Execução $$i/10 ==="; \
		./$(TARGET); \
		echo "Execução $$i concluída"; \
		if [ $$i -lt 10 ]; then \
			echo "Aguardando 1 segundo..."; \
			sleep 1; \
		fi; \
		i=$$((i + 1)); \
	done
	@echo ""
	@echo "Todas as 10 execuções concluídas!"

# Versão rápida - executa 10 vezes sem pausa
run10fast: $(TARGET)
	@echo "Executando o programa 10 vezes (versão rápida)..."
	@i=1; while [ $$i -le 10 ]; do \
		echo "Execução $$i/10:"; \
		./$(TARGET); \
		i=$$((i + 1)); \
	done
	@echo "Todas as 10 execuções concluídas!"

# Executar 10 vezes e gerar análise final
profile10: $(TARGET)
	@echo "Executando programa 10 vezes e coletando dados de profiling..."
	@rm -f gmon.out analysis_*.txt
	@i=1; while [ $$i -le 10 ]; do \
		echo "Execução $$i/10:"; \
		./$(TARGET); \
		if [ -f gmon.out ]; then \
			gprof $(TARGET) gmon.out > analysis_$$i.txt; \
		fi; \
		if [ $$i -lt 10 ]; then \
			sleep 1; \
		fi; \
		echo ""; \
		i=$$((i + 1)); \
	done
	done
	@echo "Gerando análise final..."
	@gprof $(TARGET) gmon.out > analysis_final.txt
	@echo "Análises salvas em analysis_1.txt até analysis_10.txt e analysis_final.txt"

# Gerar grafo visual do profiling
graph: gmon.out
	@echo "Gerando grafo visual do profiling..."
	gprof $(TARGET) gmon.out | python3 gprof2dot.py | dot -Tpng -o profile_graph.png
	@echo "Grafo visual salvo em profile_graph.png"

# Executar e gerar grafo visual
profile_visual: $(TARGET)
	./$(TARGET)
	gprof $(TARGET) gmon.out > analysis_visual.txt
	gprof $(TARGET) gmon.out | python3 gprof2dot.py | dot -Tpng -o profile_graph.png
	@echo "Análise salva em analysis_visual.txt"
	@echo "Grafo visual salvo em profile_graph.png"

# Limpar arquivos gerados
clean:
	rm -f $(TARGET) gmon.out analysis*.txt profile_graph.png

.PHONY: run analyze profile clean run10 run10fast profile10 graph profile_visual