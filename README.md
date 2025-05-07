# Personal Docker Setups

This repo is designed to keep my development environments consistent across multiple machines.

## Setup

1. Ensure Docker is correctly setup on base machine
  - Install Docker and docker-compose through package manager
  - Allow Docker to be run without sudo
    1. run `sudo groupadd docker`
    2. run `sudo gpasswd -a $USER docker`
    3. log out/in user to activate changes
2. Navigate to desired Docker directory
3. Run `create-env.sh` script
4. Start container with `start.sh` script
  - Existing containers may need to be stopped/removed (this can be checked with `docker ps`)
3. Run `docker exec -it CONTAINER_NAME_HERE /bin/bash`
