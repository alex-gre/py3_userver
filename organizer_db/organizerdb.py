import sqlite3

def input_contacts_base():
	# connect database
    conn = sqlite3.connect("organizer.db")
    cursor = conn.cursor()
	#create table and save schema
    cursor.execute('CREATE TABLE IF NOT EXISTS phone_book(id INTEGER PRIMARY KEY AUTOINCREMENT,\
         name VARCHAR(35) NOT NULL, n_phone VARCHAR(14) NOT NULL, info VARCHAR(125))')
    conn.commit()

    #input data console
    name = input('Введите ФИО: ')
    n_phone = input('Введите номер телефона: ')
    info = input('Доп информация 125 символов: ')


    cursor.execute('INSERT INTO phone_book (name,n_phone,info) VALUES (?,?,?)',(name,n_phone,info))
    #зафиксировать транзакцию
    conn.commit()

    cursor.close()
    conn.close()

def View():
    conn = sqlite3.connect("organizer.db")
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM phone_book")
    rows = cursor.fetchall()
    for row in rows:
        print(row) # it print all records in the database

    conn.close()

def Clear():
    conn = sqlite3.connect("organizer.db")
    cursor = conn.cursor()
    cursor.execute("DELETE FROM phone_book")
    conn.commit()
    cursor.close()
    conn.close()

