from flask import Flask, request, jsonify
import psycopg2
import time
import random
import os

application = Flask(__name__)

DB_HOSTNAME=os.environ.get('DB_HOSTNAME')
DB_USERNAME=os.environ.get('DB_USERNAME')
DB_PASSWORD=os.environ.get('DB_PASSWORD')

def slow_process_to_calculate_availability(provider, name):
    time.sleep(5)
    return random.choice(['HIGH', 'MEDIUM', 'LOW'])


@application.route('/hardware/')
def hardware():
    try:
        connection = psycopg2.connect(user = DB_USERNAME,
                                      password = DB_PASSWORD,
                                      host = DB_HOSTNAME,
                                      port = "5432",
                                      database = "rescale")

        cursor = connection.cursor()

        cursor.execute('SELECT * from hardware')

        statuses = [
            {
                'provider': row[1],
                'name': row[2],
                'availability': slow_process_to_calculate_availability(
                    row[1],
                    row[2]
                ),
            }
            for row in cursor.fetchall()
        ]

        return jsonify(statuses)

    except (Exception, psycopg2.Error) as error :
        print ("Error while connecting to PostgreSQL", error)

    finally:
        #closing database connection.
        if(connection):
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")


@application.route('/health_check')
def health_check():
  return jsonify({ "status": 'up' })


if __name__ == "__main__":
    application.run(host='0.0.0.0', port=5001)
