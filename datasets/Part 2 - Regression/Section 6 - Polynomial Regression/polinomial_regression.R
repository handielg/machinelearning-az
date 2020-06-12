# Regresión Polinómica

# Importar el dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[, 2:3] #porque lo primero es la posición del trabajador en la empresa.

# Dividir los datos en conjunto de entrenamiento y conjunto de test
# install.packages("caTools")
# library(caTools)
# set.seed(123)
# split = sample.split(dataset$Purchased, SplitRatio = 0.8)
# training_set = subset(dataset, split == TRUE)
# testing_set = subset(dataset, split == FALSE)


# Escalado de valores
# training_set[,2:3] = scale(training_set[,2:3])
# testing_set[,2:3] = scale(testing_set[,2:3])

# Ajustar Modelo de Regresión Lineal con el Conjunto de Datos
lin_reg = lm(formula = Salary ~ ., 
             data = dataset) 
summary(lin_reg) #vemos que el intercepto es negativo, por lo que con x cero, ganaria un salario negativo, por lo que el modelo no funciona.

# Ajustar Modelo de Regresión Polinómica con el Conjunto de Datos
dataset$Level2 = dataset$Level^2 #añadimos la primera columna con x elevada al cuadrado.
dataset$Level3 = dataset$Level^3 #añadimos columna con x elevada al cubo.
dataset$Level4 = dataset$Level^4 #añadimos columna con x elevada a la 4.
poly_reg = lm(formula = Salary ~ .,
              data = dataset)

# Visualización del modelo lineal
# install.packages("ggplot2")
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$Level , y = dataset$Salary),
             color = "red") +
  geom_line(aes(x = dataset$Level, y = predict(lin_reg, newdata = dataset)),
            color = "blue") +
  ggtitle("Predicción lineal del suedlo en función del nivel del empleado") +
  xlab("Nivel del empleado") +
  ylab("Sueldo (en $)")


# Visualización del modelo polinómico
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
  geom_point(aes(x = dataset$Level , y = dataset$Salary),
             color = "red") +
  geom_line(aes(x = x_grid, y = predict(poly_reg, 
                                        newdata = data.frame(Level = x_grid,      #Aqui le llamamos a level, que es la predictora x_grid,transformada para que el gráfico no sean lineal rectas largas, y a las otras columnas igual pero elevado a los coeficientes correspondientes.
                                                             Level2 = x_grid^2,
                                                             Level3 = x_grid^3,
                                                             Level4 = x_grid^4))),
            color = "blue") +
  ggtitle("Predicción polinómica del suedlo en función del nivel del empleado") +
  xlab("Nivel del empleado") +
  ylab("Sueldo (en $)")

# Predicción de nuevos resultados con Regresión Lineal
y_pred = predict(lin_reg, newdata = data.frame(Level = 6.5)) #Como solo quiero predecir este valor pongo este código. "Level" es el nombre de la variable independiente.

# Predicción de nuevos resultados con Regresión Polinómica
y_pred_poly = predict(poly_reg, newdata = data.frame(Level = 6.5,
                                                Level2 = 6.5^2,
                                                Level3 = 6.5^3,
                                                Level4 = 6.5^4))


