# HTTP APP

This app use python and flask. Is designed to retrieve information from BigTable and expose it via REST API.

## Prerequisites 
1. `virtualenv` installed.
2. python3 installed.
3. Docker installed.

## How to run it locally

1. Create the venv

```sh
python -m venv </path/to/new/virtual/environment>
```

2. Activate venv
```sh
source </path/to/new/virtual/environment>/bin/activate 
```

3. Install Requirements
```sh
pip install -r requirements.txt
```

4. Create the .env file
    
    1. Create the file
    
    ```sh
    touch .env 
    ```
    
    2. Add credentials
    ```
    GOOGLE_CLOUD_PROJECT = "<GCP Project>"
    MY_TOPIC_NAME = "<PubSub Topic Name>"
    PROJECT_DATASET_PROFILE =  "<BigTable Profile>"
    ```

5. Run the app

```sh
flask --app main run
```

6. Happy coding !!


## How to run it using Docker

1. Build

```sh
docker build -t app:latest .
```

2. Run

```sh
docker run -p 5000:5000 app:latest
```

## How to deploy it

Crate a PR to main, once is approved for 2 members of the team, you are being able to merge it. Once is merged, the [app](../.github/workflows/app.yml) pipeline is going to be triggered. If you have further doubts, questions or errors ping us. Happy to help !  

> Note: Don't forget to Squash and merge, and delete your branch. Help us to keep clean our repos. 

#### Next steps
1. Test performance in a real scenario.