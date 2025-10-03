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
    print(chosen_continent)
    pass

def set_end_position():
    pass

def set_start_position():
    pass

def is_game_over_points():
    pass

def is_game_over_location():
    pass

def add_points():
    pass

def remove_points():

    pass

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
    pass


def get_player():
   cursor = conn.cursor(dictionary=True)
   sql = "select * from player order by id desc limit 1"
   cursor.execute(sql,)
   player = cursor.fetchone()
   print(player['ID'])
   return player





def main():
    print("main")
    get_player()

main()