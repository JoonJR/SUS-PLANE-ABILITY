import string, random
from airport import Airport
import config


icao_list = ["AD-ALV", 'LATI', 'LOWW',"LQSA", 'EBBR', 'LBSF','UMMS', 'LSZB', 'LKPR', 'EDDB', 'EKCH', 'EETN', 'LEMD', 
        'EFHK', 'EKVG', 'LFPG', 'EGLL', 'EGJB', 'LXGB', 'LGAV', 'LDZA', 'LHBP','EIDW','EGNS','BIRK','LIRF','EGJJ',
        'LSXB','EYVI','ELLX','EVRA','LNMC','LUKK','LYPG','LWSK','LMML','EHAM','ENGM','EPWA','LPPT','LROP','LYBE','UUDD',
        'ESSA','LJLJ','LZIB','LIKD','UKKK','VA-0001','BKPR']
visited_places =[]

class Game:

    def __init__(self, id, loc, consumption, player=None):
        self.status = {}
        self.location = []
        

        if id==0:
            # new game
            icao_list.extend(visited_places) #fills up the first list again with previously removed locations
            visited_places.clear() 
            letters = string.ascii_lowercase + string.ascii_uppercase + string.digits

            self.status = {
                "id" : ''.join(random.choice(letters)for i in range(20)),
                "name" : player,
                "co2" : {
                    "consumed" : config.co2_initial,
                    "budget" : config.co2_budget
                },
                "dice" :0,
                "collected_countries" : 1,
                "previous_location" : ""
            }
                
            starting_point = self.random_location() # random starting location
            self.location.append(Airport(starting_point, True))
            visited_places.append(starting_point) #appends already visited countries
            icao_list.remove(starting_point)

            sql = "INSERT INTO Game VALUES ('" + self.status["id"] + "', " + str(self.status["co2"]["consumed"])
            sql += ", " + str(self.status["co2"]["budget"]) + ", '" + self.status["name"] + "', '" + loc
            sql += "', " + str(self.status["dice"]) + ", " + str(self.status["collected_countries"]) + ")"
            print("start game sql " + sql)
            cur = config.conn.cursor()
            cur.execute(sql)
       

        else:
            #update consumption, dice and budget
            ran = random.randint(1,6)
            sql2 = ""
            dice2 = int(consumption) * 2
            dice5 = int(consumption) / 2
            dice6 = int(consumption) - int(consumption)

            ##prevents from collecting previous visited country
            if loc in icao_list:
                country = 1
                sql3 = "UPDATE Game SET collected_countries = collected_countries +" + str(country) + " WHERE id='" + id + "'"
                cur3 = config.conn.cursor()
                cur3.execute(sql3)
                visited_places.append(loc)
                icao_list.remove(loc)
            else:
                sql3 = "UPDATE Game SET collected_countries = collected_countries" + " WHERE id='" + id + "'"
                cur3 = config.conn.cursor()
                cur3.execute(sql3)
        
            if ran == 1:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + consumption + ", co2_budget = co2_budget - " + consumption + ", dice = " + str(ran)  + " WHERE id='" + id + "'"
            if ran == 2:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + str(dice2) + ", co2_budget = co2_budget - " + str(dice2) + ", dice = " + str(ran)  + " WHERE id='" + id + "'"
            if ran == 3:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + consumption + ", co2_budget = co2_budget - " + consumption + ", dice = " + str(ran)  + " WHERE id='" + id + "'"
            if ran == 4:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + consumption + ", co2_budget = co2_budget - " + consumption + ", dice = " + str(ran) +  " WHERE id='" + id + "'"
            if ran == 5:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + str(dice5) + ", co2_budget = co2_budget - " + str(dice5) + ", dice = " + str(ran) + " WHERE id='" + id + "'"
            if ran == 6:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + str(dice6) + ", co2_budget = co2_budget - " + str(dice6) + ", dice = " + str(ran) + " WHERE id='" + id + "'"

            print("updates sql2 " + sql2)
            cur2 = config.conn.cursor()
            cur2.execute(sql2)
            # find game from DB
            sql = "SELECT id, co2_consumed, co2_budget, location, screen_name, dice, collected_countries FROM Game WHERE id='" + id + "'"
            print(sql)
            cur = config.conn.cursor()
            cur.execute(sql)
            res = cur.fetchall()
            if len(res) == 1:
                # game found
                self.status = {
                    "id": res[0][0],
                    "name": res[0][4],
                    "co2": {
                        "consumed": res[0][1],
                        "budget": res[0][2]
                    },
                    "dice": res[0][5],
                    "collected_countries": res[0][6],
                    "previous_location" : res[0][3]
                }

                if ran == 4: # dice 4, plane returns back 
                    dice4location = Airport(self.status['previous_location'], True)
                    self.location.append(dice4location)
                    self.set_location(dice4location)
                
                elif ran == 3: # dice 3, random destination 
                    random_loc = self.random_location()
                    dice3location = Airport(random_loc, True)
                    self.location.append(dice3location)
                    self.set_location(dice3location)
                else:
                    print(self.status)
                    apt = Airport(loc, True)
                    self.location.append(apt)
                    self.set_location(apt)
            else:
                print("game is not found!")


    def set_location(self, location):
        sql = "UPDATE Game SET location='" + location.ident + "' WHERE id='" + self.status["id"] + "'"
        cur = config.conn.cursor()
        cur.execute(sql)
   
    def random_location(self): #used for the start and dice3
        sql4 = "SELECT ident FROM airport ORDER BY RAND() LIMIT 1"
        cursor = config.conn.cursor()
        cursor.execute(sql4)
        result = cursor.fetchall()
        if cursor.rowcount > 0:
            for row in result:
                return row[0]

