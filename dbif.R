install.packages("RSQLite")
library(RSQLite)

connectDB <- function(dbName)
{
  driv <- dbDriver("SQLite")
  con <- dbConnect(driv, dbname=dbName)
  
}

connection <- connectDB("test.db")
