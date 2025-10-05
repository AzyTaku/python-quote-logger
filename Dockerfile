FROM python:3.11-alpine

WORKDIR /app

COPY quote_logger.py .

CMD ["python", "quote_logger.py"]
