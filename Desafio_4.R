#!/usr/bin/env RScript
  
#DESAFIO 4
library(ggplot2)

dir <- getwd()
setwd(dir)

#BAIXAR OS DADOS
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
path <- "iris.csv"
download.file(url,path)
iris <- read.csv("iris.csv")
head(iris)
colnames_iris <- c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width', 'Species')
colnames(iris) <- colnames_iris

#RESUMO DESCRITIVO DAS ESTATISTICAS
sum_iris <- summary(iris)

#BOXPLOT DOS TAMANHOS DE PETALAS POR ESPECIE
Petal_l <- iris[,c(3,5)]

ggplot(Petal_l, aes(x=Species, y=Petal.Length, fill=Species)) + 
  geom_boxplot() +
  xlab("class") +
  theme(legend.position="none") +
  xlab("")

#BOXPLOT DOS TAMANHOS DE SEPALAS POR ESPECIE
Sepal_l <- iris[,c(1,5)]

ggplot(Sepal_l, aes(x=Species, y=Sepal.Length, fill=Species)) + 
  geom_boxplot() +
  xlab("class") +
  theme(legend.position="none") +
  xlab("")

#CORRELACAO ENTRE TAMANO DE SEPALAS E PETALAS POR ESPECIE
setosa <- subset(iris, grepl("setosa", iris$Species))
setosa <- setosa[,c(1,3)]
corr_setosa <- cor(setosa)
round(corr_setosa, 3)

versicolor <- subset(iris, grepl("versicolor", iris$Species))
versicolor <- versicolor[,c(1,3)]
corr_versicolor <- cor(versicolor)
round(corr_versicolor,3)

virginica <- subset(iris, grepl("virginica", iris$Species))
virginica <- virginica[,c(1,3)]
corr_virginica <- cor(virginica)
round(corr_virginica, 3)
