library(ggmap)
library(stringr)
library(jsonlite)

# Remove last non-US value from precip dataset
values <- head(precip, -1)

# Get the city names
cities <- names(values)

# Some need fixing to be geocoded correctly
cities[cities == "Columbia"] <- "Columbia, SC"
cities[cities == "Seattle Tacoma"] <- "Seattle, WA"
cities[cities == "Minneapolis/St Paul"] <- "Minneapolis, MN"

# Use ggmap to geocode the city names to GPS coordinates
# Beware you are rate limited how many times you can run this!
coords <- geocode(cities, output = "latlona")

# Capitalization function from ?toupper
capitalize <- function(s) {
  cap <- function(s) {
    paste(toupper(substring(s, 1, 1)),
                  substring(s, 2),
                  sep = "",
                  collapse = " ")
  }

  sapply(strsplit(s, split = " "), cap)
}

# Split address component into parts
address <- strsplit(as.character(coords$address), ", ", fixed = TRUE)
address <- t(data.frame(address, stringsAsFactors = FALSE))

# Extract state abbrevation from address
cities <- unname(address[, 1])
cities <- capitalize(cities)

states <- unname(address[, 2])
states <- toupper(states)

# Plop everything into a nice data frame
df <- data.frame(
  city   = cities,
  state  = states,
  lat    = coords$lat,
  lon    = coords$lon,
  precip = values,
  stringsAsFactors = FALSE,
  row.names = NULL
)

# Convert to JSON format
json <- toJSON(
  df,
  dataframe = "rows",
  factor = "string",
  pretty = TRUE
)

# Output JSON to file
cat(json, file = "usprecip.json")
