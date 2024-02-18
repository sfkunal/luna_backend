# Use an official Python runtime as a parent image
FROM python:3.11.5

# Set the working directory in the container to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install system-level dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libasound2-dev \
    portaudio19-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Install pyaudio
RUN pip install pyaudio


# Define the command to run your application
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
