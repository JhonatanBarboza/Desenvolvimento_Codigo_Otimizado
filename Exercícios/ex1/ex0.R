# Instala o pacote FrF2 se não estiver instalado
.libPaths("~/R/x86_64-pc-linux-gnu-library/4.5")

if (!requireNamespace("FrF2", quietly = TRUE)) {
  install.packages("FrF2", repos = "http://cran.rstudio.com/")
}

library(FrF2)

# exemplo do slide (retirado do livro do Jain)
plan.person = FrF2(nruns = 4,
                   nfactors =  2,
                   replications = 1,
                   repeat.only = FALSE,
                   factor.names = list(
                     Rede = c("crossbar", "omega"),
                     Acesso = c("Aleatorio", "Matriz")),
                   randomize = FALSE)

# apresenta a configuração do planejamento de experimentos
summary(plan.person)

# Vetor de resultados
resultados = c(0.6041, 0.4220, 0.7922, 0.4717)

# adiciona os resultados no planejamento de experimentos
plan.atualizado = add.response(design = plan.person, response = resultados)

# apresenta a configuração do planejamento de experimentos
summary(plan.atualizado)

# Plota os gráficos de efeitos principais
MEPlot(plan.atualizado)

# Plota os gráficos de interação entre as variáveis
IAPlot(plan.atualizado)

# Modelo linear
plan.formula = lm(plan.atualizado$resultados ~ (plan.atualizado$Rede * plan.atualizado$Acesso))

# Resumo dos coeficientes
summary(plan.formula)

# ANOVA
plan.anova = anova(plan.formula)
summary(plan.anova$`Mean Sq`)

# Soma dos Quadrados Total
SST = plan.anova$"Mean Sq"[1] + plan.anova$"Mean Sq"[2] + plan.anova$"Mean Sq"[3]

# Influência de cada fator
InfluenciaA = plan.anova$"Mean Sq"[1] / SST
InfluenciaB = plan.anova$"Mean Sq"[2] / SST
InfluenciaAB = plan.anova$"Mean Sq"[3] / SST

cat("Influencia devido ao fator Redes:", InfluenciaA, "\n")
cat("Influencia devido ao fator Acesso:", InfluenciaB, "\n")
cat("Influencia devido à interação dos fatores:", InfluenciaAB, "\n")
