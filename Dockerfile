FROM python:3.11.3-slim-buster
WORKDIR /app
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY ./api  /app/api
COPY ./demo /app/demo
COPY ./manage.py /app
COPY ./.env /app
RUN python manage.py makemigrations
RUN python manage.py migrate
RUN useradd --system --no-create-home nagato
RUN chown -R nagato:nagato /app
USER nagato
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
