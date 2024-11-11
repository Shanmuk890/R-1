library(plumber)

#* Add two numbers
#* @param a The first number
#* @param b The second number
#* @get /add
function(a = 0, b = 0) {
  result <- as.numeric(a) + as.numeric(b)
  list(result = result)
}

#* Swagger UI documentation
#* @plumber
function(pr) {
  pr %>%
    pr_set_api_spec('/swagger')  # Enable Swagger UI
}

#* To view Swagger UI in Cloud Run, navigate to /swagger
