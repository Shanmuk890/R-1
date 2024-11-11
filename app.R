library(plumber)

#* Add two numbers
#* @param a The first number
#* @param b The second number
#* @get /add
function(a = 0, b = 0) {
  result <- as.numeric(a) + as.numeric(b)
  list(result = result)
}

#* Enable Swagger UI at the /swagger endpoint
#* @plumber
function(pr) {
  pr %>%
    pr_set_api_spec('/swagger.json') %>%  # Swagger spec available at /swagger.json
    pr_set_api_spec("/swagger")  # Swagger UI path
}

# Start the API (Plumber automatically serves Swagger UI)
