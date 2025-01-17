#!/bin/bash

# Array of environments to deploy to
environments=("dev" "staging" "prod")

# Deployment paths or commands for each environment (example paths)
declare -A deploy_commands
deploy_commands=(
  ["dev"]="docker-compose -f docker-compose.dev.yml up -d"
  ["staging"]="docker-compose -f docker-compose.staging.yml up -d"
  ["prod"]="docker-compose -f docker-compose.prod.yml up -d"
)

# Git pull the latest code
echo "Pulling latest code from repository..."
git pull origin main

# Build the application (optional, based on your build system)
echo "Building the application..."
docker build -t myapp:latest .

# Loop through each environment and deploy
for env in "${environments[@]}"; do
  echo "Deploying to $env environment..."

  # Execute the respective deploy command
  if [[ -z "${deploy_commands[$env]}" ]]; then
    echo "No deploy command found for $env. Skipping..."
    continue
  fi

  # Run the deployment command for the environment
  ${deploy_commands[$env]}

  if [ $? -eq 0 ]; then
    echo "Deployment to $env successful!"
  else
    echo "Deployment to $env failed!"
    exit 1
  fi

  # Optional: Notify via Slack or Teams (you can add a webhook or use curl to post to Slack)
  # curl -X POST -H 'Content-type: application/json' --data '{"text":"Deployment to '$env' completed!"}' https://hooks.slack.com/services/XXXXXXX/XXXXXXX/XXXXXXX
done

echo "Deployment pipeline completed."
