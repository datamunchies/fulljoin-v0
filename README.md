# fulljoin-v0
## Enjoy slow sundays

This repository is currently set to private. Only shared by 2 users. This is a test repo for us to experiment with some ideas.

**To interact with this repo:**  
(optional, but best practice if we are to add dependencies to requirements.txt) 

Create a virtual environment

```bash
python3 -m venv venv
```

Activate it

```bash
source venv/bin/activate
```

Upgrade pip

```bash
pip install --upgrade pip
```

**Note**   
Currently requirements.txt file is empty, once dependencies will be added we can install them via:

```bash
pip install -r requirements.txt
```

## Running dbt in docker

To run dbt in docker you will need access to `slowsunday/fulljoin` repo in dockerhub registry. The repo is essentially a test repo with the latest image tag of this repository.

Steps:

Log-in to dockerhub registry:
```bash
docker login -u "username" -p "password"
```
Build a docker image:
```bash
docker build .
```

Run docker:
```bash
docker run slowsunday/fulljoin
```

The output of the last command will be visible in the terminal as stdout where ```dbt --help``` prompt will appear listing commands as the `ENTRYPOINT` command in `Dockerfile` is set to `["dbt"]`. So the command that will instantly be initiated is `"dbt"` when ```docker run slowsunday/fulljoin``` is executed. Need to change this behaviour to run `zsh` for regular zshell terminal to be open in order to interact with dbt.