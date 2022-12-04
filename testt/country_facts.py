import requests
import json
import config
import os


class Facts:
    def __init__(self, iso_code):
    
        iso_code = self.iso_code
        request = "https://restcountries.com/v2/alpha/" + str(iso_code)
        response = requests.get(request)
        if response.status_code==200:
            json_response = response.json()
            # print(json.dumps(json_response, indent=2))
            country = json_response["name"]
            capitall = json_response["capital"]
            language = json_response["languages"][0]["name"]
            # flag = json_response["flags"][1]
            population = json_response["population"]
            currency = json_response["currencies"][0]["name"]

    # works but i have no idea where to put it yet
