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


def create_player(name, starting_points=1000):
    cursor = conn.cursor()
    starting_location = set_start_position()

    sql = "INSERT INTO player (name, points, location) VALUES(%s, %s, %s)"
    cursor.execute(sql, (name, starting_points, starting_location["ident"]))
    conn.commit()

    player_id = cursor.lastrowid
    cursor.close()

    return player_id, starting_location


def select_game_airports(continent):
    sql_select = "SELECT ident FROM airport WHERE continent = %s AND name != 'closed' LIMIT 30"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql_select, (continent,))

    chosen_airports = cursor.fetchall()
    sql_update = "INSERT INTO chosen_airports(ident, special, visited) VALUES(%s, %s, %s)"
    for airport in chosen_airports:
        cursor.execute(sql_update, (airport['ident'], 0, 0))

    cursor.close()

def special_airport():
    cursor = conn.cursor(dictionary=True)
    sql = "select ident from chosen_airports"
    cursor.execute(sql)
    airports = cursor.fetchall()
    s_airport = random.choice(airports)
    special = 1  if s_airport == airports else 0
    sql_update = "update chosen_airports set special = %s where ident = %s"
    cursor.execute(sql_update,(1,s_airport['ident']) )

def move_player(player, airport):
   cursor = conn.cursor()
   sql = "update player set location = %s where id = %s"
   cursor.execute(sql, (airport,player['ID']))
   cursor.fetchone()








def calculate_price():
    cursor = conn.cursor()
    sql ="select latitude_deg, longitude_deg from airport where ident = %s"
    cursor.execute(sql,(airport, ))
    x = cursor.fetchone()

    sql_player_airport = "select latitude_deg, longitude_deg from airport where ident = %s"
    cursor.execute(sql_player_airport, (player['Location'],))
    y = cursor.fetchone()

    km = distance.distance(x, y).km

    price = km * 0.01
    print(km)
    return price

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
    print(starting_airport)

    return starting_airport


def check_if_location_same(start, end):
    while start == end:
        end = set_end_position()
    return False

# kun voitat pelin laskee pelaajaan pisteet
def is_game_over_points():
    pass

# kun voitat pelin katsoo pelaajan lokaation
def is_game_over_location():
    pass


def add_points(player, amount):
    total = player[2] + amount
    sql = ("UPDATE player SET Points = %s where ID = %s")
    cursor = conn.cursor()
    cursor.execute(sql, (total, player[0]))
    player = cursor.fetchall()
    return player


def remove_points(player, amount):
    total = player[2] - amount
    sql = "UPDATE player SET Points = %s where ID = %s"
    cursor = conn.cursor()
    cursor.execute(sql, (total, player[0]))
    player = cursor.fetchall()
    return player


def set_airport_visited():
    cursor = conn.cursor()
    sql = "select ident from chosen_airports"
    cursor.execute(sql)
    idents = [row[0] for row in cursor.fetchall()]

    sql = "select location from player"
    cursor.execute(sql)
    location = cursor.fetchone()[0]
    print(location)

    for ident in idents:
        visited = 1 if ident == location else 0
        cursor.execute('''
                update chosen_airports
                set visited = %s
                where ident = %s
                ''', (visited, ident))
        conn.commit()


def get_player():
    cursor = conn.cursor(dictionary=True)
    sql = "select * from player order by id desc limit 1"
    cursor.execute(sql)
    player = cursor.fetchone()
    return player


def delete_old_airports():
    sql = "DELETE FROM chosen_airports"
    cursor = conn.cursor()
    cursor.execute(sql)


def delete_old_tasks():
    sql = "DELETE FROM chosen_tasks"
    cursor = conn.cursor()
    cursor.execute(sql)


def setup_game(player_name):
    delete_old_airports()
    delete_old_tasks()
    select_game_airports(select_continent())
    # function to choose questions for game
    create_player(player_name)


def main():
    # CHECK IF OLD GAME IS STILL GOING ON

    # IF OLD GAME DONE SETUP A NEW GAME
    # 1. drop old chosen_airports
    # 2. drop old chosen_questions
    # 3. choose new continent
    # 4. choose the 30 new airports THAT ARE NOT CLOSED
    # 5. choose new 90 questions
    # 6. create a player
    # 7. set starting location
    # assign player on starting location
    # set starting location visisted
    # set ending location
    # ELSE GO TO OLD GAME

    player = get_player()
    calculate_price(player, '5WA6')
    print("main")


main()