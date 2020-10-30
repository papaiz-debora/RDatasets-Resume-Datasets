#!/usr/bin/env RScript

#DESAFIO 3
install.packages("rjson")
library(rjson)
library(ggplot2)
library(tidyr)

dir <- getwd()
setwd(dir)

#BAIXAR DADOS PELA URL
url <- 'https://api.github.com/search/repositories?q=language:python&sort=starts'
path <- "repositorio_git.json"
download.file(url, path)

rep <- fromJSON(file = "repositorio_git.json")
items <- rep[["items"]]

id <- sapply(items, '[[', 1)
name <- sapply(items, '[[', 3)
star_count <- sapply(items, '[[', "stargazers_count")

df<- data.frame(id,name,star_count)

#IMPORTAR RESULTADOS SALVOS DO DESAFIO 2
mycsv <- "/stargazersCount_repositorios.csv"
df2 <- read.csv(mycsv)

#ESTATISTICA DESCRITIVA 
summary(df)

#BOXPLOT
ggplot(df, aes( y=star_count)) + 
  geom_boxplot() +
  coord_flip()+
  xlab("Repositório GitHub") +
  theme(legend.position="none") +
  ylab("Stargazers Count")

#OBSERVAR DISTRIBUIÇÃO DOS DADOS COM HISTOGRAMA PARA SELECIONAR LISTAS DE REPOSITORIOS
hist(df$star_count)

#LISTA DOS REPOSITÓRIOS QUE ESTAO PROXIMAS AO NUMERO MAXIMO DE STARGAZERS COUNT (POP_ALTA), PROXIMAS A MEDIA DOS COUNTS (POP_MEDIA) E PRÓXIMAS A MEDIANA DOS COUNTS (POP_MEDIANA)

pop_alta <- subset(df, df$star_count >= 80000 )
write.table(pop_alta$name, "Numero_max_estrelas.txt")

pop_media <- subset(df, df$star_count <= 80000 & df$star_count >=45000)
write.table(pop_media$name, "Numero_medio_estrelas.txt")

pop_mediana <- subset(df, df$star_count <= 45000)
write.table(pop_mediana$name, "Numero_mediano_estrelas.txt")



