# Use the official Python image as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the local files into the container
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Expose port 9099 for the application
EXPOSE 9099

# Run the Tic-Tac-Toe application
CMD ["python", "main.py"]
