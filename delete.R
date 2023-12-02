library(RMariaDB)

password <- "@EJwM0bK)hlG"
port <- 3306
host <- "MSQ-UNP-1"
dbuser <- "s-audioblast"
dbname <- "audioblast"

db <- dbConnect(RMariaDB::MariaDB(),
	user=dbuser,
	password=password,
	host=host,
	dbname=dbname,
	port=port
)

d <- read.csv("recordings-aao-error.csv")
colnames(d) <- c("source", "id","Title","taxon","file","author","post_date","size","size_raw","type","NonSpecimen","Date","Time","Duration")
for (i in 1:nrow(d)) {
    sql <- paste0("DELETE FROM `recordings` WHERE `source` = '",
    d$source[[i]],
    "' AND `id` = '",
    d$id[[i]],
    "';"
    )
    print(sql)
    tryCatch(
        dbExecute(db, sql),
        error = function(e) {
            print(e)
        }
    )
}

dbDisconnect(db)