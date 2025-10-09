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

def create_player(name, start_airport):
    cursor = conn.cursor()
    sql = "INSERT INTO player (name, location) VALUES(%s, %s)"
    cursor.execute(sql, (name, start_airport["ident"]))
    cursor.close()

def create_game(player, start_airport, end_airport):
    cursor = conn.cursor()
    sql = "INSERT INTO game (player_ID, start_airport, end_airport, is_over, co2_consumed, points) VALUES(%s, %s, %s, %s, %s, %s)"
    cursor.execute(sql, (player["ID"], start_airport["ident"], end_airport["ident"], 0, 0, 0))
    cursor.close()

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
    cursor.close()

    set_airport_visited(airport)


def calculate_co2(player, airport):
    cursor = conn.cursor()
    sql ="select latitude_deg, longitude_deg, name from airport where ident = %s"
    cursor.execute(sql,(airport, ))
    destination_point = cursor.fetchone()

    destination_coords = (destination_point[0], destination_point[1])
    sql_player_airport = "select latitude_deg, longitude_deg from airport where ident = %s"
    cursor.execute(sql_player_airport, (player['location'],))
    player_coords = cursor.fetchone()
    cursor.close()

    km = distance.distance(destination_coords, player_coords).km

    co2_price = km * 0.20
    return int(co2_price)

def select_continent():
    sql = "select distinct continent from airport where continent is not null"
    cursor = conn.cursor()
    cursor.execute(sql)
    continent = [row[0] for row in cursor.fetchall()]
    cursor.close()

    chosen_continent = random.choice(continent)
    return chosen_continent

def select_random_airport():
    sql = "SELECT * FROM chosen_airports WHERE visited = 0 ORDER BY RAND() LIMIT 1"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql)
    airport = cursor.fetchone()
    cursor.close()
    return airport

# kun voitat pelin katsoo pelaajan lokaation
def is_game_over_location(player, game):
    pass

def add_points(game, amount):
    total = game["points"] + amount
    sql = ("UPDATE game SET Points = %s where ID = %s")
    cursor = conn.cursor()
    cursor.execute(sql, (total, game["ID"]))

def remove_points(game):
    x = game["co2_consumed"] * 0.05
    new_points = game["points"] - x
    if new_points <= 0:
        new_points = 0

    cursor = conn.cursor()
    sql = "UPDATE game SET points = %s WHERE ID = %s"
    cursor.execute(sql, (new_points, game["ID"]))
    cursor.close()
    

def set_airport_visited(airport):
    sql = "UPDATE chosen_airports SET visited = 1 WHERE ident = %s"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql, (airport,))
    cursor.close()

def get_player():
    cursor = conn.cursor(dictionary=True)
    sql = "select * from player order by id desc limit 1"
    cursor.execute(sql)
    player = cursor.fetchone()
    cursor.close()
    return player

def get_game():
    cursor = conn.cursor(dictionary=True)
    sql = "select * from game order by id desc limit 1"
    cursor.execute(sql)
    game = cursor.fetchone()
    cursor.close()
    return game

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
        SELECT * FROM task WHERE level = 2 ORDER BY RAND() LIMIT 10
    )
    UNION ALL
    (
        SELECT * FROM task WHERE level = 3 ORDER BY RAND() LIMIT 10
    )
    """

    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql_select_tasks)
    tasks = cursor.fetchall()

    sql_update_chosen_tasks = "INSERT INTO chosen_tasks(player_ID, task_ID, answered) VALUES(%s, %s, 0)"
    for task in tasks:
        cursor.execute(sql_update_chosen_tasks, (player["ID"], task["ID"]))
    cursor.close()

def setup_game(player_name):
    delete_old_airports()
    delete_old_tasks()
    select_game_airports(select_continent())
    start_airport = select_random_airport()
    end_airport = select_random_airport()

    while(start_airport == end_airport):
        end_airport = select_random_airport()

    create_player(player_name, start_airport)
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
        sql_name = "SELECT airport.ident AS ident, airport.type AS airport, country.name AS country FROM airport JOIN country ON airport.iso_country = country.iso_country WHERE airport.ident = %s;"
        cursor.execute(sql_name, (airport["ident"],))
        result = cursor.fetchone()
        result["co2"] = calculate_co2(player, airport["ident"])
        choice.append(result)

    return choice

def get_airport_name(airport_ident):
    sql = "SELECT type FROM airport WHERE ident = %s"
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql, (airport_ident,))
    name = cursor.fetchone()
    return name["type"]
    
def print_info_table(player, game):
    player_location = get_airport_name(player["location"])
    end_location = get_airport_name(game["end_airport"])
    print("----------------------------------------------------------------------------------------------------")
    print(f'|Sijainti: {player_location} Pisteet: {game["points"]} Maali: {end_location} co2 päästöt: {game["co2_consumed"]}          |')
    print("----------------------------------------------------------------------------------------------------")

def update_game_state(game):
    cursor = conn.cursor()
    sql = "UPDATE game SET is_over = 1 WHERE ID = %s"
    cursor.execute(sql, (game["ID"],))

def get_task():
    sql = """
    SELECT task.ID, task.question, answer.choice, answer.is_correct, task.points
    FROM (
        SELECT chosen_tasks.task_ID
        FROM chosen_tasks
        INNER JOIN task ON chosen_tasks.task_ID = task.ID
        WHERE chosen_tasks.answered = 0
        ORDER BY RAND()
        LIMIT 1
        ) AS random_task
    INNER JOIN task ON random_task.task_ID = task.ID
    INNER JOIN task_choices ON task.ID = task_choices.task_ID
    INNER JOIN answer ON task_choices.answer_ID = answer.ID
    ORDER BY answer.ID;
    """
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql)
    result = cursor.fetchall()
    formatted_task = {
        "ID": result[0]["ID"],
        "question": result[0]["question"],
        "points": result[0]["points"],
        "choice_1": {
            "ID": 1,
            "answer": result[0]["choice"],
            "is_correct": result[0]["is_correct"]
        },
        "choice_2": {
            "ID": 2,
            "answer": result[1]["choice"],
            "is_correct": result[1]["is_correct"]
        },
        "choice_3": {
            "ID": 3,
            "answer": result[2]["choice"],
            "is_correct": result[2]["is_correct"]
        },
    }
    return formatted_task

def add_co2(game, co2_price):
    total = game["co2_consumed"] + co2_price
    print("total::::", game["co2_consumed"])
    sql = "UPDATE game SET co2_consumed = %s WHERE ID = %s"
    cursor = conn.cursor()
    cursor.execute(sql, (total, game["ID"]))
    cursor.close()
    
def handle_task_answer(task, game):
    answer = int(input(f"{task['question']}\n[1] {task['choice_1']['answer']} \n[2] {task['choice_2']['answer']}\n[3] {task['choice_3']['answer']}\n"))
    if answer == task["choice_1"]["ID"]:
        set_task_answered(task)
        if task["choice_1"]["is_correct"]:
            add_points(game, task["points"])
            return True
    elif answer == task["choice_2"]["ID"]:
        set_task_answered(task)
        if task["choice_2"]["is_correct"]:
            add_points(game, task["points"])
            return True
    elif answer == task["choice_3"]["ID"]:
        set_task_answered(task)
        if task["choice_3"]["is_correct"]:
            add_points(game, task["points"])
            return True
    else:
        handle_task_answer(task)

def set_task_answered(task):
    sql = ("UPDATE chosen_tasks SET answered = 1 WHERE task_ID = %s")
    cursor = conn.cursor()
    cursor.execute(sql, (task["ID"],))

def main():
    menu_choice = int(input("[1] Uusi peli\n[2] Jatka peliä\n"))
    if menu_choice == 1:
        player_name = input("pelaajan nimi")

        setup_game(player_name)
        print("Tervetuloa Amazing Race tietovisa-peliin!")
    elif menu_choice == 2:
        print("pelin jatke")
        pass

    else:
        print("peli sulkeutuu")

    game = get_game()
    while(not game['is_over']):
        game = get_game()
        player = get_player()
        airport_choices = get_airport_choices(player)

        if player["location"] == game["end_airport"]:
            update_game_state(game)
            remove_points(game)
            print_info_table(player, get_game())
            return
        
        print_info_table(player, game)
        
        for i, airport in enumerate(airport_choices):
             print(f"[{i+1}] Kohde: {airport['airport']} Maa: {airport['country']} Hinta: {airport['co2']} CO2")
        
        player_choice = int(input("Valitse lentokentän numero 1-5: "))
        match player_choice:
            case 1:
                move_player(player, airport_choices[0]['ident'])
                add_co2(game, airport_choices[0]["co2"])
                task = get_task()
                answer = handle_task_answer(task, game)
                if answer:
                    print("vastasit Oikein")
                else:
                    print("vastasit väärin")
                    #katsoo onko vastaus oikein
                    #jos oikein päivitä pelaajan pisteet
                    #laita kysymys answrered 1
            case 2:
                move_player(player, airport_choices[1]['ident'])
                add_co2(game, airport_choices[1]["co2"])
                task = get_task()
                answer = handle_task_answer(task, game)
                if answer:
                    print("vastasit Oikein")
                else:
                    print("vastasit väärin")
                    #katsoo onko vastaus oikein
                    #jos oikein päivitä pelaajan pisteet
                    #laita kysymys answrered 1
            case 3:
                move_player(player, airport_choices[2]['ident'])
                add_co2(game, airport_choices[2]["co2"])
                print(airport_choices[2]["co2"])
                task = get_task()
                answer = handle_task_answer(task, game)
                if answer:
                    print("vastasit Oikein")
                else:
                    print("vastasit väärin")
                    #katsoo onko vastaus oikein
                    #jos oikein päivitä pelaajan pisteet
                    #laita kysymys answrered 1
            case 4:
                move_player(player, airport_choices[3]['ident'])
                add_co2(game, airport_choices[3]["co2"])
                task = get_task()
                answer = handle_task_answer(task, game)
                if answer:
                    print("vastasit Oikein")
                else:
                    print("vastasit väärin")
            case 5:
                move_player(player, airport_choices[4]['ident'])
                add_co2(game, airport["co2"])
                add_co2(game, airport_choices[4]["co2"])
                task = get_task()
                answer = handle_task_answer(task, game)
                if answer:
                    print("vastasit Oikein")
                else:
                    print("vastasit väärin")
                    #katsoo onko vastaus oikein
                    #jos oikein päivitä pelaajan pisteet
                    #laita kysymys answrered 1
            case _:
                return
    print("main")


main()

print("Peli Loppu")