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

# Make port available to the world outside this container
EXPOSE ${PORT:-5000}

# Define environment variable
ENV PORT=${PORT:-5000}


# Define the command to run your application
CMD ["hypercorn", "main:app", "--bind", "0.0.0.0:${PORT:-5000}"]
# CMD ["hypercorn", "main:app", "--bind", "[::]:$PORT"]
