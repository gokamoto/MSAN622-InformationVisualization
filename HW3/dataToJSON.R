library(jsonlite)

setwd("~/Google Drive/USF/Spring2/InformationVisualization/MSAN622-InformationVisualization/HW3")
data = as.data.frame(Seatbelts)

json <- toJSON(
  data,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

cat(json, file = "seatbelts.json")