FROM python:3.11-slim

WORKDIR /cronjob

# Copiamos los scripts y cron principal
COPY crontab.txt .
COPY requirements.txt .
COPY script1/ ./script1/
COPY script2/ ./script2/
COPY install_script_requirements.sh .

# Instalamos lo global del cronjob
RUN apt-get update && apt-get install -y cron && \
    pip install --no-cache-dir -r requirements.txt && \
    bash install_script_requirements.sh && \
    crontab crontab.txt

CMD ["cron", "-f"]
