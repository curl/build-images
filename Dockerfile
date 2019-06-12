# Specify the base image to build from as a --build-arg.
ARG BASE_IMAGE
FROM $BASE_IMAGE

# The docker build process is noninteractive
ARG DEBIAN_FRONTEND=noninteractive

# The container user is root.
ENV USER=root

# Run the install process using the provided script (chosen using --build-arg)
ARG DOCKER_SCRIPT
COPY docker_scripts/ /scripts/
RUN /scripts/${DOCKER_SCRIPT}
