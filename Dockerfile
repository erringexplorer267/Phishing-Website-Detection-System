# 1. Use an official Python base image
FROM python:3.11-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy dependencies and install them first (for fast caching)
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy the rest of the application files, including:
#    - app.py (the main application)
#    - index.html (the HTML file for your Flask app)
#    - All .pkl model files
COPY . .

# 5. Inform Docker that the container will listen on port 8000
EXPOSE 8000

# 6. Define the command to run the application using Gunicorn
# 'app:app' assumes your Flask application instance is named 'app' in 'app.py'
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]