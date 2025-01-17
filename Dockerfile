# Use the official Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . /app

# Install dependencies
RUN pip install flask

# Set the default environment variable
ENV APP_ENV=Development

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
