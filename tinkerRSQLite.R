#install.packages("RSQLite")

library(RSQLite)
driv <- dbDriver("SQLite")
con <- dbConnect(driv, dbname="test.db")

dbListTables(con)
rs <- dbSendQuery(con, "select * from traffic")

d1 <- fetch(rs, n=10)
dbHasCompleted(rs)
d2 <- fetch(rs, n = -1)
dbHasCompleted(rs)
dbClearResult(rs)


rs <- dbSendQuery(con, "select * from traffic")
d3 <- fetch(rs)
dbDisconnect(con)

driv <- dbDriver("SQLite")
con <- dbConnect(driv, dbname="Datenverkehr.db")
dbListTables(con)
rs <- dbSendQuery(con, "select * from traffic")
d3 <- fetch(rs, n=-1)
d4 <- fetch(rs)
dbClearResult(rs)
rs <- dbSendQuery(con, "select * from interfaces")
fetch(rs)
dbClearResult(rs)
rs <- dbSendQuery(con, "select * from sqlite_sequence")
fetch(rs)

# Or a chunk at a time
res <- dbSendQuery(con, "SELECT * FROM traffic")
while(!dbHasCompleted(res)){
  chunk <- dbFetch(res)
  print(nrow(chunk))
}
# Clear the result
dbClearResult(res)
