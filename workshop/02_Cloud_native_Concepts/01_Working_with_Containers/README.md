# Working with Container Images and Containers

In this lab you'll learn how to create a container image and how to run a container based on this image. During this activity you will pull an image from a global container registry to get hands-on experience with container registries in general.

## Step 1: View the Dockerfile

1. View the `Dockerfile` using an editor.

    ```bash
    (bastion)$ cd acl-docs/workshop/02_Cloud_native_Concepts/01_Working_with_Containers/
    (bastion)$ vi Dockerfile
    ```

1. The `Dockerfile` should look like this:

    ```bash
    FROM alpine:latest
    COPY . /app
    WORKDIR /app
    RUN apk add --no-cache wget
    ENTRYPOINT [ "sh" ]
    CMD ["hello_world.sh"]
    ```

## Step 2. Build and Tag a Container Image

1. Build the container image (`-t` specifies the repository and a tag). The `$USER` variable will tag the image with your username.

    ```bash
    (bastion)$ docker build -t acl/hello-world:$USER .
    ```

1. List all container images on your local machine.

    ```bash
    (bastion)$ docker images
    ```

1. (optional) Set another tag.

    ```bash
    (bastion)$ docker tag acl/hello-world:$USER acl/hello-world:$USER-stable
    ```

1. List all container images on your local machine.

    ```bash
    (bastion)$ docker images
    ```

## Step 3. Run a Container

1. Run the container based on a container image.

    ```bash
    (bastion)$ docker run acl/hello-world:$USER-stable
    ```
