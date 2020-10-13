[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/googlecolab/colabtools/blob/master/notebooks/colab-github-demo.ipynb)


#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Mar  1 12:07:43 2019

@author: handiel
"""

# Regresión Lineal Simple

# Cómo importar las librerías
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.linear_model import LinearRegression #para descargar el modelo lineal simple que vamos a usar.


# Importar el data set
dataset = pd.read_csv('Dataset.csv')
X = dataset.iloc[:, :-1].values #selecionamos la variable independiente.Todas menos la última, por eso -1.
y = dataset.iloc[:, 1].values #seleccionamos la variable dependiente. En este caso la segunda columna, la número 1.


# Dividir el data set en conjunto de entrenamiento y conjunto de testing
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 1/3, random_state = 0) #definimos 1/3 para que sea 66 % entrenamiento y 33 % test. Y creamos 4 variables nuevas.


# Escalado de variables. No aplica en este algoritmo.
"""
from sklearn.preprocessing import StandardScaler
sc_X = StandardScaler()
X_train = sc_X.fit_transform(X_train)
X_test = sc_X.transform(X_test)
"""

# Crear modelo de Regresión Lienal Simple con el conjunto de entrenamiento
regression = LinearRegression()
regression.fit(X_train, y_train) #le pasamos al modelo la X de entrenamiento y la y de entrenamiento. El método fit se utiliza para ajustar la regresión lineal, y acepta 2 parámetros, los dos que les pasamos, X_train y y_train.

# Predecir el conjunto de test
y_pred = regression.predict(X_test) #predecimos la variable dependiente con X_test. X_test solo contiene la primer columna.

# Visualizar los resultados de entrenamiento
plt.scatter(X_train, y_train, color = "red") #Graficamos los puntos correspondientes al conjunto de entrenamiento.
plt.plot(X_train, regression.predict(X_train), color = "blue") #Graficamos la línea de la ecuación obtenida en el entrenamiento.
plt.title("Título del Gráfico (Conjunto de Entrenamiento)")
plt.xlabel("Etiqueta eje x")
plt.ylabel("Etiqueta eje y")
plt.show()

# Visualizar los resultados de test
plt.scatter(X_test, y_test, color = "red") #Graficamos los puntos (scatter) de la variable independiente y la variable dependiente predicha por el modelo de regresión.
plt.plot(X_train, regression.predict(X_train), color = "blue") #Dibujamos la misma línea anterior para ver como se ajustan los puntos predichos.
plt.title("Título del Gráfico (Conjunto de Testing)")
plt.xlabel("Etiqueta eje x")
plt.ylabel("Etiqueta eje y")
plt.show()
