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