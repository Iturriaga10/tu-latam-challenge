# HTTP APP

This app uses Python and Flask. It is designed to retrieve information from BigTable and expose it via REST API.

## Prerequisites 
1. `virtualenv` installed.
2. Python3 installed.
3. Docker installed.

## How to run the HTTP APP locally

1. Create the venv

```sh
python -m venv </path/to/new/virtual/environment>
```

2. Activate venv
```sh
source </path/to/new/virtual/environment>/bin/activate 
```

3. Install requirements
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
    PROJECT_DATASET_PROFILE =  "<BigTable Profile>"
    ```

5. Run the app

```sh
flask --app main run
```

6. Happy coding!


## How to run the HTTP APP using Docker

1. Build

```sh
docker build -t app:latest .
```

2. Run

```sh
docker run -p 5000:5000 app:latest
```

## How to deploy the HTTP APP

Create a PR to main. Once it is approved for 2 members of the team, you are able to merge it. Once it is merged, the [pubsubapp](../.github/workflows/pubsubapp.yml) pipeline is going to be triggered. If you have further doubts, questions or errors, ping us. We are happy to help!  

> Note: Don't forget to Squash and merge, and delete your branch. Help us to keep our repos clean. 

#### Next steps
1. Implement WSGI
2. Test performance in a real scenario.