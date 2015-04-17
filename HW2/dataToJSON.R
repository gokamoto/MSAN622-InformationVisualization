library(jsonlite)

setwd("~/Google Drive/USF/Spring2/InformationVisualization/MSAN622-InformationVisualization/HW2")

df <- data.frame(
  state.name,
  state.abb,
  state.x77,
  state.region,
  state.division,
  row.names = NULL
)

names(df) = c("name", "abb", "population", "income", "illiteracy", 
              "lifeExp", "murder", "hs", "frost", "area", "region", "division")

json <- toJSON(
  df,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

cat(json, file = "state.x77.json")

names(df) = c("State Name", "State Abbreviation", "Population", "Income", 
              "Illiteracy Rate", "Life Expectancy", "Murders per 100k", 
              "High School Grad Rate", "Days Below Freezing", "Area", 
              "Region", "Division")

json <- toJSON(
  df,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

cat(json, file = "state.x77.prettynames.json")
