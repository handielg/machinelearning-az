# Clusterting Jerárquico

# Importar los datos del centro comercial
dataset = read.csv("Mall_Customers.csv")
X = dataset[, 4:5]

# Utilizar el dendrograma para encontrar el número óptimo de clusters
dendrogram = hclust(dist(X, method = "euclidean"), 
                    method = "ward.D")
plot(dendrogram,
     main = "Dendrograma",
     xlab = "Clientes del centro comercial",
     ylab = "Distancia Euclidea")

# Ajustar el clustering jerárquico a nuestro dataset
hc = hclust(dist(X, method = "euclidean"), 
                    method = "ward.D")
y_hc = cutree(hc, k=5) #La función cutree es para cortar el árbol o dendograma ala altura que queremos.Cuando ejecutamos nos da el valor de a que cluster pertenece cada observación.
y_hc
# Visualizar los clusters
#install.packages("cluster")
library(cluster)
clusplot(X, 
         y_hc,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = "Clustering de clientes",
         xlab = "Ingresos anuales",
         ylab = "Puntuación (1-100)"
)
