import mysql.connector
import random


def add_player(name, starting_points=1000):
    conn = mysql.connector.connect(
        host='127.0.0.1',
        port=3306,
        database='flight_game',
        user='Alex',
        password='MasaRektaa69',
        autocommit=True
    )

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

