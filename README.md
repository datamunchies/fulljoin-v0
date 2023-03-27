# fulljoin-v0
**Enjoy slow sundays**

## **Whats inside**

This repository is architectured following microservices logic. There is a direcory `src` that contains 2 sub-directories:  

`clickhouse`  
`dbt` 

The `clickhouse` directory contains the following:  
`Dockerfile` - a blueprint to install clickhouse   
`docker_related_config` - a configuration file necessary for configuring clickhouse server, user settings     
`entrypoint` - the entrypoint to run when docker container runs  
`manifests` - this folder holds infrastructure code for provisioning and deploying clickhouse server on Kubernetes. Currently it is set to run on minikube (locally).

The `dbt` directory contains the following:  
`Dockerfile` - a blueprint to install dbt-core, dbt-clickhouse and dbt-bigquery adapters  
`dbt_project` - a dbt specific config file   
`profiles.yml` - a dbt profiles file to connect to clickhouse  
`manifests` - this folder holds infrastructure code for provisioning and deploying dbt service on Kubernetes (minikube)  
A standard set of directories related to dbt, like models, tests, macros, etc.

## **Prerequisites**

In order to run this on your machine, you will need to clone this repository, and open it in your prefered code editor, in this case vscode.

You will also need:

`docker` 
[Download here](https://www.docker.com/products/docker-desktop/)  

`k9s` [Download here](https://k9scli.io/topics/install/)

After you install docker you need to log-in, the log-in details **will be provided for you separately.**  

To log-in to docker:
```bash
docker login -u username -p password
```

Once you have logged in, you need to navigate to docker app and enable Kubernetes.

You can do this by clicking on the docker icon, settings, Kubernetes, enable Kubernetes, click apply and restart.
![image info](/utils/assets/Screenshot%202023-03-27%20at%2019.31.55.png)

Next you need to start minikube, you can do this with the from inside vscode root directory (fulljoin-v0) with the following command:

```bash
minikube start
```

Now we want to build `clickhouse` and `dbt` docker images and apply respective configurations to them.

Navigate to `clickhouse` directory:
 
```bash
cd /src/clickhouse
``` 

Build the `clickhouse` docker image.

```bash
docker build .
```

Apply configurations:
```bash
kubectl apply -f ./manifests
```

Navigate to `dbt` directory:
```bash
cd ../dbt
```

Build the `dbt` docker image:
```bash
docker build .
```

Apply configurations:
```bash
kubectl apply -f ./manifests
```

To preview the running services run:
```bash
k9s
```

If you did everything correctly you should see 2 running services as in the image bellow:
![image info](/utils/assets/Screenshot%202023-03-27%20at%2019.48.15.png)

To interact with this interface you can use arrows, `up`, `down`, `enter`, `esc`.

To get inside of one of the services you can navigate with arrow keys and simply hit `s` key on your keyboard. This will bring up the shell of the service.  

If you entered `clickhouse` service shell, you can then start a clickhouse service as following:

```bash
clickhouse-start
```
Open another termnial window (external or in vscode) enter:
```bash
k9s
```
You will be brought back to the service interface, this time navigate to `dbt` service with arrrow keys and hit `s` on your keyboard to enter `dbt` service shell.

Once inside `dbt` service shell you can initiate your project and test the connection with the following commands:
```bash
dbt init
```

To test connection:
```bash
dbt debug
```

You should see [Ok Test Connection] in the prompt.
Once you stopped interacting with the services you can exit them with `ctrl+c` and `ctrl+d`  

Make sure to run `minikube stop` to close open ports and shut down running services once you are done developing. 