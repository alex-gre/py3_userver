import wincomm


def menu():

	print("""
	          1 - Computer Manager 
	          2 - Clear Disk
	          3 - Show Services
	          4 - Show all ipconfig
	          5 - Show taskmaneger
	          6 - Show tree
	          7 - Create 'system_info.txt'
	                                            
		   """)

menu()
i=0
i=int(input('select menu: '))
if (i==1):
     wincomm.comp_manager()	 
elif (i==2):
     wincomm.clear_disk()         
elif (i==3):
     wincomm.services()
elif (i==4):
	wincomm.show_ipconfig()	 
elif (i==5):
	wincomm.show_task_mgr()
elif (i==6):
	wincomm.show_tree()
elif (i==7):
	wincomm.create_system_info_textfile()	
else :
   print("Error command")

              
