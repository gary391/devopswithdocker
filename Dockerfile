# Start from the ubuntu image
FROM ubuntu:20.04

# Use /usr/src/app as our workdir. The following instructions will be executed in this location.
WORKDIR /usr/src/app

# Install curl into that image 
RUN sh -c 'apt-get update && apt-get -y install curl'

# Copy the hello.sh file from this location to /usr/src/app/ creating /usr/src/app/curler.sh.
COPY curler-v2.sh .

# Execute a command with `/bin/sh -c` prefix.
RUN touch additional.txt

# When running Docker run the command will be ./curler.sh
ENTRYPOINT ["./curler-v2.sh"]
