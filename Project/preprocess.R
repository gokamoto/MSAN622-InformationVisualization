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

just2015_muni = subset(just2015, Category=="MUNI Feedback")

just2015_muni$Request.Type2 = ""
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Commendation"] = "Commendation"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Conduct_Discourteous_Insensitive_Inappropriate_Conduct"] = "Inappropriate Conduct"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Conduct_Inattentiveness_Negligence"] = "Negligence"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Conduct_Unsafe_Operation"] = "Unsafe Operation"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Services_Criminal_Activity"] = "Criminal Activity"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Services_Miscellaneous"] = "Miscellaneous"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Services_Service_Delivery_Facilities"] = "Delivery Facilities"
just2015_muni$Request.Type2[just2015_muni$Request.Type=="MUNI - Services_Service_Planning"] = "Service Planning"

json <- toJSON(
  just2015_muni,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

cat(json, file="sf311_just2015_muni.json")
