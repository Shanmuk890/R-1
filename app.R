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

#* Swagger UI path
#* @plumber
function(pr) {
  tryCatch({
    pr %>%
      pr_set_api_spec("/swagger.json") %>%  # Swagger JSON spec at /swagger.json
      pr_set_api_spec("/swagger")  # Swagger UI at /swagger
  }, error = function(e) {
    cat("Error setting up Swagger UI: ", e$message, "\n")
    stop("Error setting up Swagger UI!")
  })
}

# Serve Swagger UI explicitly using 'swagger' package
swagger_ui <- function(req, res) {
  tryCatch({
    res$setHeader("Content-Type", "text/html")
    res$write(swagger::swagger_ui())  # Serve Swagger UI at /swagger
  }, error = function(e) {
    cat("Error serving Swagger UI: ", e$message, "\n")
    res$status <- 500
    res$body <- "Error serving Swagger UI"
  })
}

# Initialize Plumber API
pr <- plumber$new()

# Define the /swagger endpoint to serve Swagger UI
pr$handle("GET", "/swagger", swagger_ui)

# Start the API on port 8000
tryCatch({
  pr$run(host = "0.0.0.0", port = 8000)
}, error = function(e) {
  cat("Error starting Plumber API: ", e$message, "\n")
})
