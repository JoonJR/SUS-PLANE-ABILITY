import requests

apikey = "b7157b235660aa160ba7b57fbfd3c4e2"

request = "https://api.openweathermap.org/data/2.5/weather?lat=" + \
          str(40.07080078125) + "&lon=" + str(-74.93360137939453) + "&appid=" + apikey
vastaus = requests.get(request).json()
print(vastaus)