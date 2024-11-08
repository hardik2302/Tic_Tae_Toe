# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install Tkinter and other dependencies
RUN apt-get update && apt-get install -y \
    python3-tk \
    libx11-dev \
    && apt-get clean


# Copy the current directory contents into the container at /app
COPY . /app

# Install required Python packages (if any)
RUN pip install --no-cache-dir numpy

# Make port 9099 available to the world outside this container (optional, not needed for Tkinter-based app)
EXPOSE 9099

# Run the Tic-Tac-Toe application
CMD ["python", "main.py"]
