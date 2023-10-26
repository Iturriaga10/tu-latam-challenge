FROM python:3.11-alpine

WORKDIR /app
COPY . .

RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt
RUN export GOOGLE_APPLICATION_CREDENTIALS="creds.json"

CMD ["python", "main.py"]

