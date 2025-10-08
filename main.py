import mysql.connector
import random
from geopy import distance

conn = mysql.connector.connect(
    host='mysql.metropolia.fi',
    port=3306,
    database='karimbe',
    user='karimbe',
    password='MetropoliaPass',
    autocommit=True
)

def create_player(name, starting_points, start_airport):
    cursor = conn.cursor()
    sql = "INSERT INTO player (name, points, location) VALUES(%s, %s, %s)"
    cursor.execute(sql, (name, starting_points, start_airport["ident"]))
    cursor.close()

def create_game(player, start_airport, end_airport):
    cursor = conn.cursor()
    sql = "INSERT INTO game (player_ID, start_airport, end_airport, is_over) VALUES(%s, %s, %s, %s)"
    cursor.execute(sql, (player["ID"], start_airport["ident"], end_airport["ident"], 0))

def select_game_airports(continent):
    sql_select = "SELECT ident FROM airport WHERE continent = %s AND name != 'closed' LIMIT 30"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql_select, (continent,))

    chosen_airports = cursor.fetchall()
    sql_update = "INSERT INTO chosen_airports(ident, special, visited) VALUES(%s, %s, %s)"
    for airport in chosen_airports:
        cursor.execute(sql_update, (airport["ident"], 0, 0))

    cursor.close()

def special_airport():
    cursor = conn.cursor(dictionary=True)
    sql = "select ident from chosen_airports"
    cursor.execute(sql)
    airports = cursor.fetchall()
    s_airport = random.choice(airports)
    special = 1  if s_airport == airports else 0
    sql_update = "update chosen_airports set special = %s where ident = %s"
    cursor.execute(sql_update,(1,s_airport["ident"]) )

def move_player(player, airport):
   cursor = conn.cursor()
   sql = "update player set location = %s where id = %s"
   cursor.execute(sql, (airport,player["ID"]))
   cursor.fetchone()

def calculate_price(player, airport):
    cursor = conn.cursor()
    sql ="select latitude_deg, longitude_deg, name from airport where ident = %s"
    cursor.execute(sql,(airport, ))

    destination_point = cursor.fetchone()
    airport_type = destination_point[2]
    destination_coords = (destination_point[0], destination_point[1])

    sql_player_airport = "select latitude_deg, longitude_deg from airport where ident = %s"
    cursor.execute(sql_player_airport, (player['location'],))
    player_coords = cursor.fetchone()

    km = distance.distance(destination_coords, player_coords).km

    price = km * 0.01
    if airport_type == "large_airport":
        price *= 2
    return int(price)

def select_continent():
    sql = "select distinct continent from airport where continent is not null"
    cursor = conn.cursor()
    cursor.execute(sql)
    continent = [row[0] for row in cursor.fetchall()]
    cursor.close()

    chosen_continent = random.choice(continent)
    return chosen_continent

def set_end_position():
    sql = "SELECT * FROM chosen_airports"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql)
    all_airports = cursor.fetchall()
    cursor.close()
    end_airport = random.choice(all_airports)
    return end_airport

def set_start_position():
    sql = "SELECT * FROM chosen_airports"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql)
    all_airports = cursor.fetchall()
    starting_airport = random.choice(all_airports)

    return starting_airport

# kun voitat pelin laskee pelaajaan pisteet
def is_game_over_points(player):
    pass

# kun voitat pelin katsoo pelaajan lokaation
def is_game_over_location(player):
    pass

def add_points(player, amount):
    total = player["points"] + amount
    sql = ("UPDATE player SET Points = %s where ID = %s")
    cursor = conn.cursor()
    cursor.execute(sql, (total, player["ID"]))

def remove_points(player, amount):
    total = player["points"] - amount
    sql = "UPDATE player SET Points = %s where ID = %s"
    cursor = conn.cursor()
    cursor.execute(sql, (total, player["ID"]))


def set_airport_visited(airport):
    sql = "UPDATE chosen_airports SET visited = 1 WHERE ident = %s"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql, (airport['ident'],))
    cursor.close()
    
def get_player():
    cursor = conn.cursor(dictionary=True)
    sql = "select * from player order by id desc limit 1"
    cursor.execute(sql)
    player = cursor.fetchone()
    cursor.close()
    return player

def delete_old_airports():
    sql = "DELETE FROM chosen_airports"
    cursor = conn.cursor()
    cursor.execute(sql)
    cursor.close()

def delete_old_tasks():
    sql = "DELETE FROM chosen_tasks"
    cursor = conn.cursor()
    cursor.execute(sql)
    cursor.close()

def select_game_tasks(player):
    sql_select_tasks = """
    (
        SELECT * FROM task WHERE level = 1 ORDER BY RAND() LIMIT 10
    )
    UNION ALL
    (
        SELECT * FROM task WHERE level = 1 ORDER BY RAND() LIMIT 10
    )
    UNION ALL
    (
        SELECT * FROM task WHERE level = 1 ORDER BY RAND() LIMIT 10
    )
    """
    
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql_select_tasks)
    tasks = cursor.fetchall()
    
    sql_update_chosen_tasks = "INSERT INTO chosen_tasks(player_ID, task_ID, answered) VALUES(%s, %s, 0)"
    for task in tasks:
        cursor.execute(sql_update_chosen_tasks, (player["ID"], task["ID"]))

def setup_game(player_name):
    delete_old_airports()
    delete_old_tasks()
    select_game_airports(select_continent())
    start_airport = set_start_position()
    end_airport = set_end_position()
    while(start_airport == end_airport):
        end_airport = set_end_position()

    create_player(player_name, 1000, start_airport)
    player = get_player()
    select_game_tasks(player)

    create_game(player, start_airport, end_airport)
    return player

def get_airport_choices(player,):
    sql = "SELECT ident FROM chosen_airports WHERE visited = 0 ORDER BY RAND() LIMIT 5"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql)
    results = cursor.fetchall()

    choice = []
    for airport in results:
        sql_name = "SELECT airport.type, country.name FROM airport JOIN country ON airport.iso_country = country.iso_country WHERE airport.ident = %s;"
        cursor.execute(sql_name, (airport["ident"],))
        result = cursor.fetchone()
        result["price"] = calculate_price(player, airport["ident"])
        choice.append(result)

    return choice
    






def main():
    # assign player on starting location
    # set starting location visisted
    # set ending location
    # ELSE GO TO OLD GAME
    print(get_airport_choices(get_player()))


    print("main")


main()