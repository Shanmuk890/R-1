library(plumber)
library(swagger)

#* Add two numbers
#* @param a The first number
#* @param b The second number
#* @get /add
function(a = 0, b = 0) {
  result <- as.numeric(a) + as.numeric(b)
  list(result = result)
}

#* Serve the Swagger UI at /swagger
#* @plumber
function(pr) {
  # Set up Swagger JSON specification
  pr %>%
    pr_set_api_spec("/swagger.json") %>%  # Swagger JSON spec at /swagger.json
    pr_set_api_spec("/swagger")  # Swagger UI available at /swagger
}

# Start the Plumber API on port 8000
pr <- plumber$new()

# Define the /swagger endpoint to serve Swagger UI
pr$handle("GET", "/swagger", function(req, res) {
  res$setHeader("Content-Type", "text/html")
  res$write(swagger::swagger_ui())  # Serve Swagger UI at /swagger
})

# Run the Plumber API on port 8000
pr$run(host = "0.0.0.0", port = 8000)
