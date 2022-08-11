install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")

library(DBI)
library(RMySQL)
library(RMySQL)
library(ggplot2)
library(dplyr)


MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)


dbListFields(MyDataBase, 'CountryLanguage')

tb<-dbListFields(MyDataBase, 'CountryLanguage')


DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")

class(DataDB)
head(DataDB)

spanish <- dbGetQuery(MyDataBase, "select * from CountryLanguage where Language='Spanish' ")

class(spanish)
head(spanish)

porc<-sum(spanish$Percentage)

mean(spanish$Percentage)



x <- (spanish$Percentage)
y <- (spanish$CountryCode)

x

SP <- DataDB %>% filter(Language == "Spanish")
SP.df <- as.data.frame(SP) 

SP.df %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
