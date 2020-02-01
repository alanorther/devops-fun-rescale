FROM python

EXPOSE 5000

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
RUN apt-get update && apt-get install -y apt-utils sqlite3

CMD ["./startup.sh"]

