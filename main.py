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

sql = 'SELECT * FROM task'
cursor = conn.cursor()
cursor.execute(sql)
x = cursor.fetchall()

print(x)

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
