# Apriori

# Preprocesado de Datos
#install.packages("arules")
library(arules) 
library(arulesViz)

dataset = read.csv("Market_Basket_Optimisation.csv", header = FALSE)
dataset = read.transactions("Market_Basket_Optimisation.csv",
                            sep = ",", rm.duplicates = TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# Entrenar algoritmo Apriori con el dataset
rules = apriori(data = dataset, 
                parameter = list(support = 0.004, confidence = 0.2)) #Un nivel de confianza más bajo nos permite arrojar más reglas.
  
# Visualización de los resultados
inspect(sort(rules, by = 'lift')[1:10]) #Escogemos las 10 reglas de asociación mas fuertes.
  
plot(rules, method = "graph", engine = "htmlwidget")


  
