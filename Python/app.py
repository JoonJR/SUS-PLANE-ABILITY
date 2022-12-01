import json
import os

import mysql.connector
from dotenv import load_dotenv
from flask import Flask, request
from flask_cors import CORS

import config
from game import Game


from flask import Flask
from flask_cors import CORS
import mysql.connector

import config
from airport import Airport




app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

config.conn = mysql.connector.connect(
    host='127.0.0.1',
    port=3306,
    database='flight_game',
    user='root',
    password='root',
    autocommit=True
)

app.config['JSON_SORT_KEYS'] = False
def fly(id, dest, consumption=0, player=None):
    if id==0:
        game = Game(0, dest, consumption, player)
    else:
        game = Game(id, dest, consumption)
    game.location[0].fetchWeather(game)
    nearby = game.location[0].find_nearby_airports()
    for a in nearby:
        game.location.append(a)
    json_data = json.dumps(game, default=lambda o: o.__dict__, indent=4)
    return json_data


# http://127.0.0.1:5000/flyto?game=fEC7n0loeL95awIxgY7M&dest=EFHK&consumption=123
@app.route('/flyto')
def flyto():
    args = request.args
    id = args.get("game")
    dest = args.get("dest")
    consumption = args.get("consumption")
    json_data = fly(id, dest, consumption)
    print("*** Called flyto endpoint ***")
    return json_data


# http://127.0.0.1:5000/newgame?player=Vesa&loc=EFHK
@app.route('/newgame')
def newgame():
    args = request.args
    player = args.get("player")
    dest = args.get("loc")
    json_data = fly(0, dest, 0, player)
    return json_data


@app.route('/airports>')  # decorator
def airports():
    sql = "SELECT ident,name, latitude_deg, longitude_deg FROM airport"
    db_cursor = config.conn.cursor()
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

if __name__ == '__main__':
    app.run(use_reloader=True, host='127.0.0.1', port=5000)
