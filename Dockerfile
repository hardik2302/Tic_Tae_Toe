# Use the official Python image as the base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the local files into the container
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Run the Tic-Tac-Toe application
CMD ["python", "main.py"]
