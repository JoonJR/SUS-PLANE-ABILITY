import random
import config
from weather import Weather
from geopy import distance
import mysql.connector
from country_facts import Facts


class Airport:
    # lisätty data, jottei tartte jokaista lentokenttää hakea erikseen
    def __init__(self, ident, active=False, data=None):
        self.ident = ident
        self.active = active

        # vältetään kauhiaa määrää hakuja
        if data is None:
            # find airport from DB
            sql = "SELECT ident, name, latitude_deg, longitude_deg, iso_country FROM Airport WHERE ident='" + ident + "'"
            # print(sql)
            cur = config.conn.cursor()
            cur.execute(sql)
            res = cur.fetchall()
            if len(res) == 1:
                # game found
                self.ident = res[0][0]
                self.name = res[0][1]
                self.latitude = float(res[0][2])
                self.longitude = float(res[0][3])
                self.iso_country = res[0][4]
                # print(self.ident)
        else:
            self.name = data['name']
            self.latitude = float(data['latitude'])
            self.longitude = float(data['longitude'])

    


    def find_nearby_airports(self):
        # print("Testing geopy...")
        # self.distanceTo(1, 2)
        lista = []
        # haetaan kaikki tiedot kerralla
        sql = "SELECT ident, name, latitude_deg, longitude_deg FROM Airport WHERE latitude_deg BETWEEN "
        sql += str(self.latitude - config.max_lat_dist) + " AND " + str(self.latitude + config.max_lat_dist)
        sql += " AND longitude_deg BETWEEN "
        sql += str(self.longitude - config.max_lon_dist) + " AND " + str(self.longitude + config.max_lon_dist)
        # print(sql)
        cur = config.conn.cursor()
        cur.execute(sql)
        res = cur.fetchall()
        for r in res:
            if r[0] != self.ident:
                # lisätty data, jottei jokaista kenttää tartte hakea
                # uudestaan konstruktorissa
                data = {'name': r[1], 'latitude': r[2], 'longitude': r[3]}
                # print(data)
                nearby_apt = Airport(r[0], False, data)
                nearby_apt.distance = self.distanceTo(nearby_apt)
                if nearby_apt.distance <= config.max_distance:
                    lista.append(nearby_apt)
                    nearby_apt.co2_consumption = self.co2_consumption(nearby_apt.distance)
                    #print (lista)
        return lista

    def fetchWeather(self, game):
        self.weather = Weather(self, game)
        return

    def fetchData(self, game):
        self.country_data = Facts(self, game)
        return


    def distanceTo(self, target):

        coords_1 = (self.latitude, self.longitude)
        coords_2 = (target.latitude, target.longitude)
        dist = distance.distance(coords_1, coords_2).km
        return int(dist)

    def co2_consumption(self, km):
        consumption = config.co2_per_flight + km * config.co2_per_km
        return consumption

    # def country_data(self):
    #     iso_code = self.iso_code
    #     self.facts = Facts(self, iso_code)
    #     return



