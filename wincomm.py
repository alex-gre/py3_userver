# -*- coding: utf-8 -*-
import os, systemin 
def clear_disk():
    print ('===============')
    print ('CLEAR DISK: ')
    os.system("cleanmgr")
    print('OK')
    
def comp_manager():
    print ('===============')
    print ('COMPUTER MANAGER: ')
    os.system("compmgmt.msc")
    print('OK')
    
def services():
    print ('===============')
    print ('SERVICES: ')
    os.system("services.msc")
    print('OK')
    
def show_ipconfig():
    print('IPCONFIG ALL') 
    os.system("ipconfig -all")
    
def show_task_mgr():
    print('Task maneger')
    os.system("taskmgr")

def show_tree():
    os.system("tree")  
    

def create_system_info_textfile():
    systemin.write_info()      
    




