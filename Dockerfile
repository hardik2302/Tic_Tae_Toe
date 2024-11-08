# Use the official Python image as the base image
FROM python:3.9-slim

# Install Tkinter dependencies
RUN apt-get update && apt-get install -y \
    libtk8.6 \
    tk \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the local files into the container
COPY . /app

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose the port the app will run on
EXPOSE 9099

# Run the Tic-Tac-Toe application
CMD ["python", "main.py"]
