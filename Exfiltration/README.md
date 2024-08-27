# User Instructions

# 1. **Google Cloud Setup**:
- Ensure you have a Google Cloud project set up and a Google Cloud Storage bucket created.
- Replace `GCS_BUCKET_NAME` with the name of your GCS bucket.

# 2. **Service Account Key**:
- Go to the Google Cloud Console.
- Navigate to "IAM & Admin" > "Service Accounts".
- Find or create a service account with access to your GCS bucket.
- Click "Create Key" and choose JSON format.
- Download the JSON file and place it on your system.
- Update the `SERVICE_ACCOUNT_KEY_PATH` variable with the path to your service account JSON file.

# 3. **Data to be Exfiltrated**:
- Update `DATA_TO_EXFILTRATE` with the data you wish to upload and process.
- This could be dynamic data in a real-world scenario.

# 4. **Running the Script**:
- Install the required libraries: `pip install google-cloud-storage`.
- Run the script using Python: `python3 your_script_name.py`.
- The script will upload data to the GCS bucket and automatically retrieve, decode, and decompress the most recent file uploaded to the bucket.
