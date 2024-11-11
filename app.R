library(plumber)

#* Add two numbers
#* @param a The first number
#* @param b The second number
#* @get /add
function(a = 0, b = 0) {
  result <- as.numeric(a) + as.numeric(b)
  list(result = result)
}

#* Set up Swagger spec and UI
#* @plumber
function(pr) {
  pr %>%
    pr_set_api_spec("/swagger.json") %>%  # Swagger JSON spec at /swagger.json
    pr_set_api_spec("/swagger")  # Swagger UI at /swagger
}

# Start the Plumber API on port 8000
pr <- plumber$new()

# Run the Plumber API on port 8000
pr$run(host = "0.0.0.0", port = 8000)
