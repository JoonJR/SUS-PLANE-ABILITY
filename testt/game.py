import string, random
from airport import Airport
from goal import Goal
import config

class Game:

    def __init__(self, id, loc, consumption, player=None):
        self.status = {}
        self.location = []
        self.goals = []

        if id==0:
            # new game
            # Create new game id
            letters = string.ascii_lowercase + string.ascii_uppercase + string.digits

            self.status = {
                "id" : ''.join(random.choice(letters)for i in range(20)),
                "name" : player,
                "co2" : {
                    "consumed" : config.co2_initial,
                    "budget" : config.co2_budget
                },
                "dice" :0,
                "collected_countries" : config.collected_countries,
                "previous_location" : ""
            }



            self.location.append(Airport(loc, True))
            sql = "INSERT INTO Game VALUES ('" + self.status["id"] + "', " + str(self.status["co2"]["consumed"])
            sql += ", " + str(self.status["co2"]["budget"]) + ", '" + self.status["name"] + "', '" + loc
            sql += "', " + str(self.status["dice"]) + ", " + str(self.status["collected_countries"]) + ")"
            print(sql)
            cur = config.conn.cursor()
            cur.execute(sql)
       

        else:
            #update consumption and budget
            ran = random.randint(1,6)
            sql2 = ""
            print("dice is " + str(ran))
            dice2 = int(consumption) * 2
            dice5 = int(consumption) / 2
            dice6 = int(consumption) - int(consumption)
           
            if ran == 1:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + consumption + ", co2_budget = co2_budget - " + consumption + ", dice = " + str(ran) + " WHERE id='" + id + "'"
            if ran == 2:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + str(dice2) + ", co2_budget = co2_budget - " + str(dice2) + ", dice = " + str(ran) + " WHERE id='" + id + "'"
            if ran == 3:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + consumption + ", co2_budget = co2_budget - " + consumption + ", dice = " + str(ran) + " WHERE id='" + id + "'"
            if ran == 4:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + consumption + ", co2_budget = co2_budget - " + consumption + ", dice = " + str(ran) + " WHERE id='" + id + "'"
            if ran == 5:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + str(dice5) + ", co2_budget = co2_budget - " + str(dice5) + ", dice = " + str(ran) + " WHERE id='" + id + "'"
            if ran == 6:
                sql2 = "UPDATE Game SET co2_consumed = co2_consumed + " + str(dice6) + ", co2_budget = co2_budget - " + str(dice6) + ", dice = " + str(ran) + " WHERE id='" + id + "'"

            print(sql2)
            print(consumption)
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
                print(self.status)
                # old location in DB currently not used
                apt = Airport(loc, True)
                self.location.append(apt)
                self.set_location(apt)

            else:
                print("************** PELIÄ EI LÖYDY! ***************")

        # read game's goals
        self.fetch_goal_info()






    def set_location(self, sijainti):
        #self.location = sijainti
        sql = "UPDATE Game SET location='" + sijainti.ident + "' WHERE id='" + self.status["id"] + "'"
        print(sql)
        cur = config.conn.cursor()
        cur.execute(sql)
        #config.conn.commit()
        #self.loc = sijainti.ident


    def fetch_goal_info(self):

        sql = "SELECT * FROM (SELECT Goal.id, Goal.name, Goal.description, Goal.icon, goalreached.gameid, "
        sql += "Goal.target, Goal.target_minvalue, Goal.target_maxvalue, Goal.target_text "
        sql += "FROM Goal INNER JOIN goalreached ON Goal.id = goalreached.goalid "
        sql += "WHERE goalreached.gameid = '" + self.status["id"] + "' "
        sql += "UNION SELECT Goal.id, Goal.name, Goal.description, Goal.icon, NULL, "
        sql += "Goal.target, Goal.target_minvalue, Goal.target_maxvalue, Goal.target_text "
        sql += "FROM Goal WHERE Goal.id NOT IN ("
        sql += "SELECT Goal.id FROM Goal INNER JOIN goalreached ON Goal.id = goalreached.goalid "
        sql += "WHERE goalreached.gameid = '" + self.status["id"] + "')) AS t ORDER BY t.id;"

        # print(sql)
        cur = config.conn.cursor()
        cur.execute(sql)
        res = cur.fetchall()
        for a in res:
            if a[4]==self.status["id"]:
                is_reached = True
            else:
                is_reached = False
            goal = Goal(a[0], a[1], a[2], a[3], is_reached, a[5], a[6], a[7], a[8])
            self.goals.append(goal)
        return
