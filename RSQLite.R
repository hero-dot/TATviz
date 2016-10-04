#TODO:
# - Prepare the data types for extracting it to the database
# - 


install.packages("RSQLite")
library(RSQLite)
test.data <- read.csv("test_data.csv")
con <- dbConnect(RSQLite::SQLite(), ":memory:")

dbWriteTable(con, "test_data", test.data)

# query
rs <- dbSendQuery(con, "select * from test_data")
d1 <- fetch(rs, n=10)
dbHasCompleted(rs)
d2 <- fetch(rs, n = -1)
dbHasCompleted(rs)
dbClearResult(rs)
dbListTables(con)

# List All Tables in the database
dbListTables(con)

dbDataType(con, test.data$res)
dbDataType(con, Sys.Date())
dbDataType(con, Sys.time())
dbDataType(con, Sys.time()- as.POSIXct(Sys.Date()))
raw(10)

# Disconnect the database
dbDisconnect(con)
