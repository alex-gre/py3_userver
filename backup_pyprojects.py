import os
import time

# dirs my works python
# Backup PyProgects
# Example on Windows:
# 1) PycharmProject
#source = ['C:\\Users\\User\\PycharmProject']
# 2) MyPractic
#source = ['C:\\Users\\User\\AppData\\Local\\Programs\\Python\\Python38\\MyPractic']
# 3) work
source = ['G:\\WORK\\WORK_PY']

# main backup directory
target_dir = 'G:\\BackupWin7_64\\backup_python38'

#  The files are backed up into a zip file.
#  The name of the zip archive is the current date and time

target = target_dir + os.sep + \
         time.strftime('%Y%m%d%H%M%S') + '.zip'

# Create target directory if it is not present
if not os.path.exists(target_dir):
    os.mkdir(target_dir)  # make directory

# 5. We use the zip command to put the files in a zip archive
zip_command = 'zip -r {0} {1}'.format(target,' '.join(source))

# Run the backup
print('Zip command is:')
print(zip_command)
print('Running:')
if os.system(zip_command) == 0:
    print('Successful backup to', target)
else:
    print('Backup FAILED')
