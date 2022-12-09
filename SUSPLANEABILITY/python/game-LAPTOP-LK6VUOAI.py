from flask import Flask
from flask_cors import CORS
import mysql.connector

import config
from airport import Airport




app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

db_connection = mysql.connector.connect(
    host='127.0.0.1',
    port=3306,
    database='flight_game',
    user='root',
    password='root',
    autocommit=True
)

app.config['JSON_SORT_KEYS'] = False


# def fetch_airport_names_by_icao_code(icao):
#     sql  = "SELECT ID,ident,name,municipality,latitude_deg,longitude_deg FROM airport"
#     sql += " WHERE ident='" + icao + "'"
#     db_cursor = db_connection.cursor()
#     db_cursor.execute(sql)
#     query_result = db_cursor.fetchall()
#     if db_cursor.rowcount > 0:
#         for row in query_result:        # get only the first match
#             return row[2], row[3], row[4], row[5]

#     return "", "", "", ""

# @app.route('/airport/<icao>')      # decorator
# def airport(icao):
#     name, location, latitude, longitude = fetch_airport_names_by_icao_code(icao)
#     response = {
#      "ICAO": icao,
#         "Name": name,
#         "Location": location,
#         "Lat": latitude,
#         "Long": longitude
#     }
#     return response

# def fetch_airports():
#     list_of_airports = []
#     sql = "SELECT ident,name,municipality, latitude_deg, longitude_deg FROM airport"
#     db_cursor = db_connection.cursor()
#     db_cursor.execute(sql)
#     res = db_cursor.fetchall()
#     list = []
#     for r in res:

#         data = {r[0], r[1], r[2], r[3], r[4]}
#         list.append(data)

#     print(list)
#     return list
#     return "", "", "", "", ""

@app.route('/airports')      # decorator
def airports():
    sql = "SELECT ident,name, latitude_deg, longitude_deg FROM airport"
    db_cursor = db_connection.cursor()
    db_cursor.execute(sql)
    res = db_cursor.fetchall()
    airports_list = []
    list = []
    status = {
        'status': {
            "id": "",
            "name": "Karin",
            "dice": 1,
            "countries": 1,
            "co2":{
                "consumed": 0,
                "budget": 10000
            },
            "previous_location": ""
        },
        "location": []

    }
    airports_list.append(status)
    print(status['location'])
    for r in res:

        response = {
            "ident": r[0],
            "active": False,
            "name": r[1],
            "latitude": r[2],
            "longitude": r[3],
            "distance" : 0,
            'co2_consumption' : 0
        }
        status['location'].append(response)
        #airports_list.append(response)
        airports_list[0]["active"] = True  # just to test
    return airports_list


def find_nearby_airports(self):
        lista = []

        sql = "SELECT ident,name,municipality,latitude_deg,longitude_deg FROM airport"
        cur = config.conn.cursor()
        cur.execute(sql)
        res = cur.fetchall()
        for r in res:
            if r[0] != self.ident:
                data = {'name': r[1], 'latitude': r[2], 'longitude': r[3]}
                print(data)
                nearby_apt = Airport(r[0], False, data)
                nearby_apt.distance = self.distanceTo(nearby_apt)
                if nearby_apt.distance <= config.max_distance:
                    lista.append(nearby_apt)
                    nearby_apt.co2_consumption = self.co2_consumption(nearby_apt.distance)
        return lista

if __name__ == '__main__':
    app.run(use_reloader=True, host='127.0.0.1', port=5000)