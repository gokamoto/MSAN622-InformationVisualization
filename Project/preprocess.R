library(jsonlite)

data <- read.csv("~/Downloads/Case_Data_from_San_Francisco_311__SF311_.csv", stringsAsFactors=FALSE)

data$Opened_date = strptime(data$Opened, "%m/%d/%Y %I:%M:%S %p")
data$year = as.numeric(substr(data$Opened, 7, 10))

since2014 = subset(data, year>=2014)
since2014 = subset(since2014, select=-c(year, Opened_date, Media.URL))

just2015 = subset(data, year>=2015)
just2015 = subset(just2015, select=-c(year, Opened_date, Media.URL))

json <- toJSON(
  just2015,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

cat(json, file="sf311_just2015.json")
