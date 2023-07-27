####Q: Why do we need to run `docker container run -d` using a `-d` flag ?

When you run a container with the docker container run command, by default, it runs in the foreground. This means that the container's output is directly attached to your current terminal, and it can block the input, making it appear as if the command line has frozen.

In your example, when you ran the command:
```
$ docker container run -d nginx
  c7749cf989f61353c1d433466d9ed6c45458291106e8131391af972c287fb0e5
```
You used the -d flag, which stands for "detached." This flag starts the container in the background, so it doesn't attach its input/output to your terminal. The long string (c7749cf989f61353c1d433466d9ed6c45458291106e8131391af972c287fb0e5) is the unique ID of the container that Docker generated.

After running the container with the -d flag, you won't see any output from the container in your current terminal. However, the container is running in the background, and you can verify that it's running using the command:

```
$ docker container ls
  CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
  c7749cf989f6        nginx               "nginx -g 'daemon of…"   35 seconds ago      Up 34 seconds       80/tcp              blissful_wright

```

The output shows that the container with the ID c7749cf989f6 is running, and its status is "Up" for 34 seconds. It is running the nginx image with the command "nginx -g 'daemon off;'", and it is listening on port 80.

If you want to interact with a running container in the foreground (i.e., attach the container's input/output to your terminal), you can use the docker container attach command. For example:

```
$ docker container attach c7749cf989f6

```

Remember to replace c7749cf989f6 with the actual ID of your container. If you want to exit the container when it's running in the foreground, you can use the standard keyboard shortcut Ctrl + C. However, this will stop the container as well. If you want to keep the container running in the background but detach from it, you can use the escape sequence Ctrl + P, Ctrl + Q.

So, in summary, if you want to avoid the command line appearing to freeze after pulling and starting a container, use the -d flag to run it in detached mode and observe its status with docker container ls from another terminal.

---
###Most used commands

| command                               | explain                                 | shorthand     |
| ------------------------------------- | --------------------------------------- | ------------- |
| docker image ls                       | Lists all images                        | docker images |
| docker image rm `<image>`           | Removes an image                        | docker rmi    |
| docker image pull `<image>`         | Pulls image from a docker registry      | docker pull   |
| docker container ls -a                | Lists all containers                    | docker ps -a  |
| docker container run `<image>`      | Runs a container from an image          | docker run    |
| docker container rm `<container>`   | Removes a container                     | docker rm     |
| docker container stop `<container>` | Stops a container                       | docker stop   |
| docker container exec `<container>` | Executes a command inside the container | docker exec   |

---
Q: How to keep a docker container running ?

https://www.baeldung.com/ops/running-docker-containers-indefinitely#:~:text=The%20simplest%20way%20to%20keep,a%20command%20that%20never%20ends.&text=We%20can%20use%20never%2Dending,in%20the%20docker%20run%20command

`docker run -d -t ubuntu`

---
Q: What to do if you are getting this error ?
`
docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.
See 'docker run --help'.`

A: If you are using mac, make sure you have the docker.app running 

---

####EXERCISE 1.3: SECRET MESSAGE
```
Now that we've warmed up it's time to get inside a container while it's running!

Image devopsdockeruh/simple-web-service:ubuntu will start a container that outputs logs into a file. Go inside the container and use tail -f ./text.log to follow the logs. Every 10 seconds the clock will send you a "secret message".

Submit the secret message and command(s) given as your answer.
```
#### EXERCISE 1.3: SECRET MESSAGE - Solution and notes
```
`docker run devopsdockeruh/simple-web-service:ubuntu` --> this command will run the container

% docker exec -it lucid_pare bash
root@ab884e2764d5:/usr/src/app# tail -f ./text.log
2023-07-27 15:17:41 +0000 UTC
2023-07-27 15:17:43 +0000 UTC
Secret message is: 'You can find the source code here: https://github.com/docker-hy'
2023-07-27 15:17:45 +0000 UTC
```
---
#### EXERCISE 1.4: MISSING DEPENDENCIES


Start a Ubuntu image with the process sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'

If you're on Windows, you'll want to switch the ' and " around: sh -c "while true; do echo 'Input website:'; read website; echo 'Searching..'; sleep 1; curl http://$website; done".

You will notice that a few things required for proper execution are missing. Be sure to remind yourself which flags to use so that the container actually waits for input.

Note also that curl is NOT installed in the container yet. You will have to install it from inside of the container.

Test inputting helsinki.fi into the application. It should respond with something like
```
<html>
  <head>
    <title>301 Moved Permanently</title>
  </head>

  <body>
    <h1>Moved Permanently</h1>
    <p>The document has moved <a href="http://www.helsinki.fi/">here</a>.</p>
  </body>
</html>
```
This time return the command you used to start process and the command(s) you used to fix the ensuing problems.

Hint for installing the missing dependencies you could start a new process with docker exec.

This exercise has multiple solutions, if the curl for helsinki.fi works then it's done. Can you figure out other (smart) solutions?

#### Solution 1.4
```
docker ps

docker exec -it missing-depend sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; echo $website; curl http://$website; done'\n

docker run -d -it --name missing-depend ubuntu sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'\n\n

docker run -it ubuntu sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'\n\n

docker exec -it frosty_golick sh -c 'apt-get update && apt-get -y install curl'

docker exec -it frosty_golick sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'

```