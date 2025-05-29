# Install dependencies
pip install -r requirements.txt

# Start service (in separate terminal)
python main.py

# Start web UI 
python -m taipy run webui/app.py

# Stop service
Ctrl+C in both terminals