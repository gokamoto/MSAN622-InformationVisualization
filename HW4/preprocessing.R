setwd("/Users/griffin/Google Drive/USF/Spring2/InformationVisualization/")

movies = movies
movies2 = subset(movies, !is.na(budget))
movies2$mpaa = as.character(movies2$mpaa)
movies2$mpaa[movies2$mpaa == ""] = "Missing"

write.csv(movies2, file="movies.csv", row.names=TRUE)

movies3 = subset(movies2, select=c(title, length, budget, rating, mpaa))

write.csv(movies3, file="moviesSubset.csv", row.names=FALSE)
