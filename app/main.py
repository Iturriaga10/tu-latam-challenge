import os
from flask import Flask
from google.cloud import bigquery

if os.path.exists('.env'):
    from dotenv import load_dotenv, find_dotenv
    load_dotenv(find_dotenv())


app = Flask(__name__)
client = bigquery.Client()

@app.route("/")
def happyendpoint():

    QUERY = (  "SELECT name FROM `bigquery-public-data.usa_names.usa_1910_2013` "
                "WHERE state = 'TX' "
                "LIMIT 100")
    
    query_job = client.query(QUERY)  
    rows = query_job.result()  
    for row in rows:
        result = row.name

    return {'data': result}
