import docker
from docker.errors import APIError, ImageNotFound, ContainerError

# Create a Docker client from environment variables
try:
    client = docker.from_env()
except Exception as e:
    print(f"Failed to initialize Docker client: {e}")
    exit(1)

# Ask the user for the image name
image_name = input("Enter the Docker image name: ")

try:
    # Pull the image from Docker Hub
    print(f"Pulling the image '{image_name}'...")
    client.images.pull(image_name)
    print("Image pulled successfully.")

    # Run a container from the pulled image in detached mode
    container = client.containers.run(image_name, detach=True)
    print(f"Container '{container.short_id}' is running.")

except ImageNotFound:
    print(f"Error: Docker image '{image_name}' not found.")
except ContainerError as ce:
    print(f"Error while running the container: {ce}")
except APIError as ae:
    print(f"Docker API error: {ae.explanation}")
except Exception as e:
    print(f"Unexpected error: {e}")
