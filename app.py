from flask import Flask, request, render_template, redirect, url_for
import firebase_admin
from firebase_admin import firestore
from google.cloud import pubsub_v1
import os

app = Flask(__name__)

# Initialize Firestore & Pub/Sub (works automatically on Cloud Run)
firebase_admin.initialize_app()
db = firestore.client()
publisher = pubsub_v1.PublisherClient()

PROJECT_ID = os.getenv("PROJECT_ID", "smart-processor-489814-r7")  # Change if needed
TOPIC_ID = "event-registrations"
topic_path = publisher.topic_path(PROJECT_ID, TOPIC_ID)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        name = request.form.get('name')
        event = request.form.get('event')
        
        # Save to Firestore
        db.collection('registrations').add({
            'name': name,
            'event': event,
            'timestamp': firestore.SERVER_TIMESTAMP
        })
        print(f"Saved registration to Firestore: {name} for {event}")
        
        # Publish to Pub/Sub
        
        message = f"🎟️ New registration: {name} for {event}".encode('utf-8')
        publisher.publish(topic_path, data=message)
        print(f"Published message to {TOPIC_ID}: {message.decode('utf-8')}")
        
        return render_template('index.html', success=True, name=name, event=event)
    
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=False)