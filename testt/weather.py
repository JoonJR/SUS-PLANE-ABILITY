import requests
import config
import os

from dotenv import load_dotenv
load_dotenv()

class Weather:

    def kelvin_to_celsius(self, kelvin):
        return int (kelvin - 273.15)

    def __init__(self, location, game):
        apikey = os.environ.get('API_KEY')

        request = "https://api.openweathermap.org/data/2.5/weather?lat=" + \
                 str(location.latitude) + "&lon=" + str(location.longitude) + "&appid=" + apikey
        response = requests.get(request).json()
        self.main = response["weather"][0]["main"]
        self.description = response["weather"][0]["description"]
        self.icon = "https://openweathermap.org/img/wn/" + response["weather"][0]["icon"] + ".png"
        self.temp = self.kelvin_to_celsius(response["main"]["temp"])
        self.humidity = response["main"]["humidity"]
        self.wind = {
            "speed": response["wind"]["speed"],
            "deg": response["wind"]["deg"]
        }
