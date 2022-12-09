import requests
from dotenv import load_dotenv
load_dotenv()


class Facts:
    def __init__(self, location, game):
        request = "https://restcountries.com/v2/alpha/" + str(location.iso_country)
        response = requests.get(request)
        json_response = response.json()
        self.country = json_response["name"]
        self.capital = json_response["capital"]
        self.language = json_response["languages"][0]["name"]
        self.flag = json_response["flags"]['png']
        self.population = json_response["population"]
        self.currency = json_response["currencies"][0]["name"]

