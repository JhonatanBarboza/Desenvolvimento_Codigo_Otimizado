# Análise de Experimento Factorial 2³ - Adesão Dental
# Baseado nos dados de Ray Bowen (patent 4,251,565, Feb. 17, 1981)
# Efeito de Cleanser/Mordant/Agent na adesão de composites dentais

# Instala o pacote FrF2 se não estiver instalado
if (!requireNamespace("FrF2", quietly = TRUE)) {
  install.packages("FrF2", repos = "http://cran.rstudio.com/")
}

library(FrF2)

# Criação do planejamento de experimentos 2³
plan.dental = FrF2(nruns = 8,
                   nfactors = 3,
                   replications = 1,
                   repeat.only = FALSE,
                   factor.names = list(
                     Cleanser = c("Distilled H2O", "Formic Acid"),
                     Mordant = c("Distilled H2O", "Isotonic Ferric Chloride"),
                     Coupling_Agent = c("No Polysac", "With Polysac")),
                   randomize = FALSE)

# Apresenta a configuração do planejamento de experimentos
summary(plan.dental)

# Dados de adesão dental (kPa) conforme a tabela
# Ordem: Y, X1, X2, X3 (Adhesion, Cleanser, Mordant, Coupling Agent)
resultados_adesao = c(680,   # -1, -1, -1
                      620,   #  1, -1, -1
                      1630,  # -1,  1, -1
                      1730,  #  1,  1, -1
                      1030,  # -1, -1,  1
                      640,   #  1, -1,  1
                      1280,  # -1,  1,  1
                      2580)  #  1,  1,  1

# Adiciona os resultados no planejamento de experimentos
plan.atualizado = add.response(design = plan.dental, response = resultados_adesao)

# Apresenta a configuração atualizada
summary(plan.atualizado)

# Visualiza os dados em formato tabular
print(plan.atualizado)

# Plota os gráficos de efeitos principais
MEPlot(plan.atualizado, main="Efeitos Principais - Adesão Dental")

# Plota os gráficos de interação entre as variáveis
IAPlot(plan.atualizado, main="Gráficos de Interação - Adesão Dental")

# Modelo linear completo com todas as interações possíveis
plan.formula = lm(resultados_adesao ~ Cleanser * Mordant * Coupling_Agent, 
                  data = plan.atualizado)

# Resumo dos coeficientes
summary(plan.formula)

# ANOVA
plan.anova = anova(plan.formula)
print(plan.anova)

# Cálculo das influências de cada fator e interações
# Soma dos Quadrados Total
SST = sum(plan.anova$"Sum Sq"[1:7])  # Exclui o resíduo (8º termo)

# Influência de cada fator e interações
InfluenciaCleanser = plan.anova$"Sum Sq"[1] / SST
InfluenciaMordant = plan.anova$"Sum Sq"[2] / SST
InfluenciaCoupling = plan.anova$"Sum Sq"[3] / SST
InfluenciaCleanser_Mordant = plan.anova$"Sum Sq"[4] / SST
InfluenciaCleanser_Coupling = plan.anova$"Sum Sq"[5] / SST
InfluenciaMordant_Coupling = plan.anova$"Sum Sq"[6] / SST
InfluenciaTriple = plan.anova$"Sum Sq"[7] / SST

cat("Influência devido ao fator Cleanser:", InfluenciaCleanser, "%\n")
cat("Influência devido ao fator Mordant:", InfluenciaMordant, "%\n")
cat("Influência devido ao fator Coupling Agent:", InfluenciaCoupling, "%\n")
cat("Influência da interação Cleanser:Mordant:", InfluenciaCleanser_Mordant, "%\n")
cat("Influência da interação Cleanser:Coupling Agent:", InfluenciaCleanser_Coupling, "%\n")
cat("Influência da interação Mordant:Coupling Agent:", InfluenciaMordant_Coupling, "%\n")
cat("Influência da interação tripla:", InfluenciaTriple, "%\n")