import organizerdb

def menu():
    print("""
        1 - Input contacts organizer.db
        2 - View select contacts 
        3 - Delete all contacts   
    """)
menu()

i = int(input('select menu: '))
if (i==1):
    organizerdb.input_contacts_base()

elif (i==2):
    organizerdb.View()

elif (i==3):
    organizerdb.Clear()

else : print('error')
