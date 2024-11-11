# Use the official R image
FROM rocker/r-ver:4.2.2

# Install system dependencies and Plumber
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c('plumber', 'swagger', 'jsonlite'))"

# Set the working directory to /app
WORKDIR /app

# Copy the app.R file into the container
COPY app.R /app

# Expose port 8000 for Cloud Run
EXPOSE 8000

# Start the Plumber API
CMD ["R", "-e", "pr <- plumber::plumb('/app/app.R'); pr$run(host='0.0.0.0', port=8000)"]
