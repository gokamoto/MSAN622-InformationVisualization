library(jsonlite)
library(zoo)

setwd("~/Google Drive/USF/Spring2/InformationVisualization/MSAN622-InformationVisualization/HW3")

month = seq(from=as.Date("1969-01-01"), to=as.Date("1984-12-01"), by="month")

data = data.frame(Seatbelts)
data$month = month

json <- toJSON(
  data,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

cat(json, file = "seatbelts.json")
