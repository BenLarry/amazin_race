import mysql.connector
import random
conn = mysql.connector.connect(
        host='mysql.metropolia.fi',
        port=3306,
        database='karimbe',
        user='karimbe',
        password='MetropoliaPass',
        autocommit=True
    )

def add_player(name, starting_points=1000):

    cursor = conn.cursor()
    cursor.execute("select ident from chosen_airports")
    airports = cursor.fetchall()
    starting_location = random.choice(airports)[0]

    sql = "insert into player (name, points, location) VALUES(%s, %s, %s)"
    cursor.execute(sql, (name, starting_points, starting_location))
    conn.commit()

    player_id = cursor.lastrowid
    print(f"Pelaajan nimi: {name}, ID: {player_id}, lokaatio on: {starting_location}")

    cursor.close()
    conn.close()

    return player_id, starting_location


# valitaan maanosa
def game_airports():
    cursor = conn.cursor()
    cursor.execute("select distinct continent from airport where continent is not null")
    continents = [row[0] for row in cursor.fetchall()]
    print(continents)


    chosen_continent = random.choice(continents)
    print(f"Valittu maanosa: {chosen_continent}")

#valitaan sieltä 30 lentokentän ident
    cursor.execute('''
    select ident
    from airport
    where continent = %s
    limit 30
    ''',(chosen_continent,))



    chosen_airports = [row[0] for row in cursor.fetchall()]
    print(f"valitut lentokentät ovat: {chosen_airports}")

    special_ident = random.choice(chosen_airports)


# jos valitun lentokentän ident on sama kuin special_ident --> lentokenttä on special
    for ident in chosen_airports:
        special = 1 if ident == special_ident else 0
        cursor.execute('''
        insert into chosen_airports (ident, special, visited)
        values(%s, %s, 0)
        ''',(ident, special))

    conn.commit()

def move_player():
    pass

def select_continent():
    cursor = conn.cursor()
    cursor.execute("select distinct continent from airport where continent is not null")
    continent = [row[0] for row in cursor.fetchall()]

    chosen_continent = random.choice(continent)
    pass

def set_end_position():
    sql = "SELECT * FROM chosen_airports"
    cursor = conn.cursor()
    cursor.execute(sql)
    all_airports = cursor.fetchall()
    end_airport = random.choice(all_airports)[0]
    print(end_airport)

    return end_airport

def set_start_position():
    sql = "SELECT * FROM chosen_airports"
    cursor = conn.cursor()
    cursor.execute(sql)
    all_airports = cursor.fetchall()
    starting_airport = random.choice(all_airports)[0]
    print(starting_airport)

    return starting_airport


def check_if_location_same(start, end):
    while start == end:
        end = set_end_position()
    return False



def is_game_over_points():
    pass

def is_game_over_location():
    pass

def add_points():
    pass

def remove_points():
    pass

def set_airport_visited():
    pass

def main():
    print("main")


main()