# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory to /app
WORKDIR /app

# Copy only the necessary files into the container
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


# Create a directory for checkpoints
RUN mkdir checkpoints

# Download the model checkpoint
RUN wget -O ./checkpoints/inswapper_128.onnx https://huggingface.co/ashleykleynhans/inswapper/resolve/main/inswapper_128.onnx

# Install Git LFS and clone the repository
RUN apt-get update && apt-get install -y git-lfs
RUN git lfs install
RUN git clone https://huggingface.co/spaces/sczhou/CodeFormer

# Make port 80 available to the world outside this container
EXPOSE 80

# Run app.py when the container launches
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:5000"]
