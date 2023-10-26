import os
from google.cloud import pubsub_v1
from google.cloud import bigquery

def insert_rows(data):
    table_id = bigquery.Table.from_string(os.getenv('PROJECT_DATASET_PROFILE'))
    rows_to_insert = [ data ]
    client = bigquery.Client()

    errors = client.insert_rows_json(table_id, rows_to_insert)  # Make an API request.
    if errors == []:
        print("New rows have been added.")
    else:
        print("Encountered errors while inserting rows: {}".format(errors))

def callback(message):
    insert_rows(message.data)
    message.ack()

if os.path.exists('.env'):
    from dotenv import load_dotenv, find_dotenv
    load_dotenv(find_dotenv())

topic_name = 'projects/{project_id}/topics/{topic}'.format(
    project_id=os.getenv('GOOGLE_CLOUD_PROJECT'),
    topic=os.getenv('MY_TOPIC_NAME'), )

subscription_name = 'projects/{project_id}/subscriptions/{sub}'.format(
    project_id=os.getenv('GOOGLE_CLOUD_PROJECT'),
    sub=os.getenv('MY_SUBSCRIPTION_NAME'), )

with pubsub_v1.SubscriberClient() as subscriber:
    subscriber.create_subscription(
        name=subscription_name, topic=topic_name)
    future = subscriber.subscribe(subscription_name, callback)