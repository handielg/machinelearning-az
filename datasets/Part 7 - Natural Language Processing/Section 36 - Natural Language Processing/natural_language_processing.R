# Natural Language Processing

# Importar el data set
dataset_original = read.delim("Restaurant_Reviews.tsv", quote = '',
                     stringsAsFactors = FALSE) #stringsAsFactors = FALSE para que no convierta el texto en factores.

# Limpieza de textos
# install.packages("tm")
#install.packages("SnowballC")
library(tm) #tm = text mining.
library(SnowballC)
corpus = VCorpus(VectorSource(dataset_original$Review)) #convertimos la fuente del texto en vectores, es la columna 1.Y creamos el objeto corpus, que podemos revisar.
corpus = tm_map(corpus, content_transformer(tolower)) #convertimos todas las palabras a minúsculas, para minimizar el numero de columnas de la matriz Sparce.
# Consultar el primer elemento del corpus
# as.character(corpus[[1]]) #vemos la transformacion a minusculas.
corpus = tm_map(corpus, removeNumbers) #Removemos los números.
corpus = tm_map(corpus, removePunctuation) #Removemos los signos.
corpus = tm_map(corpus, removeWords, stopwords(kind = "en"))
corpus = tm_map(corpus, stemDocument)
corpus = tm_map(corpus, stripWhitespace)

# Crear el modelo Bag of Words
dtm = DocumentTermMatrix(corpus)
dtm = removeSparseTerms(dtm, 0.999) #Nos quedamos con el 99.9 % de palabras más frecuentes.Debemos revisar por si eliminamos muchas palabras.

dataset = as.data.frame(as.matrix(dtm)) #Convertimos a dataframe la matriz dispersa.
dataset$Liked = dataset_original$Liked #Añadimos la columna de datos dependiente.

# Codificar la variable de clasificación como factor
dataset$Liked = factor(dataset$Liked, levels = c(0,1))

# Dividir los datos en conjunto de entrenamiento y conjunto de test
# install.packages("caTools")
library(caTools)
set.seed(123)
split = sample.split(dataset$Liked, SplitRatio = 0.80)
training_set = subset(dataset, split == TRUE)
testing_set = subset(dataset, split == FALSE)

# Ajustar el Random Forest con el conjunto de entrenamiento.
#install.packages("randomForest")
library(randomForest)
classifier = randomForest(x = training_set[,-692],
                          y = training_set$Liked,
                          ntree = 10)

# Predicción de los resultados con el conjunto de testing
y_pred = predict(classifier, newdata = testing_set[,-692])

# Crear la matriz de confusión
cm = table(testing_set[, 692], y_pred)


