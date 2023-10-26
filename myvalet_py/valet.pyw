import sys
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout, QLabel, QLineEdit, QPushButton, QMessageBox, QTableWidget, QTableWidgetItem
from PyQt5.QtCore import Qt
from cryptography.fernet import Fernet
import json
import os

class PasswordManagerApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Менеджер паролей")
        self.setGeometry(100, 100, 500, 300)
        
        # Создание виджетов
        self.website_label = QLabel("Веб-сайт:")
        self.website_input = QLineEdit()
        
        self.username_label = QLabel("Имя пользователя:")
        self.username_input = QLineEdit()
        
        self.password_label = QLabel("Пароль:")
        self.password_input = QLineEdit()
        self.password_input.setEchoMode(QLineEdit.Password)
        
        self.add_button = QPushButton("Добавить")
        self.add_button.clicked.connect(self.add_password)
        
        self.password_table = QTableWidget()
        self.password_table.setColumnCount(3)
        self.password_table.setHorizontalHeaderLabels(["Веб-сайт", "Имя пользователя","passw"])
        
        self.load_passwords()
        
        # Создание главного виджета и размещение на нем остальных виджетов
        self.central_widget = QWidget()
        self.setCentralWidget(self.central_widget)
        
        layout = QVBoxLayout()
        form_layout = QHBoxLayout()
        
        form_layout.addWidget(self.website_label)
        form_layout.addWidget(self.website_input)
        
        form_layout.addWidget(self.username_label)
        form_layout.addWidget(self.username_input)
        
        form_layout.addWidget(self.password_label)
        form_layout.addWidget(self.password_input)
        
        form_layout.addWidget(self.add_button)
        
        layout.addLayout(form_layout)
        layout.addWidget(self.password_table)
        
        self.central_widget.setLayout(layout)
    
    def add_password(self):
        website = self.website_input.text()
        username = self.username_input.text()
        password = self.password_input.text()
        
        if website and username and password:
            self.save_password(website, username, password)
            self.website_input.clear()
            self.username_input.clear()
            self.password_input.clear()
            self.load_passwords()
    
    def load_passwords(self):
        self.password_table.setRowCount(0)
        
        if os.path.exists("file.d"):
            with open("file.d", "r") as file:
                encrypted_data = file.read()
            
            if encrypted_data:
                key = self.load_key()
                f = Fernet(key)
                decrypted_data = f.decrypt(bytes(encrypted_data, 'utf-8')).decode('utf-8')
                passwords = json.loads(decrypted_data)
                
                for row_num, (website, username, password) in enumerate(passwords):
                    self.password_table.insertRow(row_num)
                    self.password_table.setItem(row_num, 0, QTableWidgetItem(website))
                    self.password_table.setItem(row_num, 1, QTableWidgetItem(username))
                    self.password_table.setItem(row_num, 2, QTableWidgetItem(password))
    
    def save_password(self, website, username, password):
        key = self.load_key()
        f = Fernet(key)
        
        if os.path.exists("file.d"):
            with open("file.d", "r") as file:
                encrypted_data = file.read()
            
            if encrypted_data:
                decrypted_data = f.decrypt(bytes(encrypted_data, 'utf-8')).decode('utf-8')
                passwords = json.loads(decrypted_data)
            else:
                passwords = []
        else:
            passwords = []
        
        passwords.append([website, username, password])
        encrypted_data = f.encrypt(bytes(json.dumps(passwords), 'utf-8')).decode('utf-8')
        
        with open("file.d", "w") as file:
            file.write(encrypted_data)
    
    def load_key(self):
        if os.path.exists("key.key"):
            with open("key.key", "rb") as file:
                key = file.read()
        else:
            key = Fernet.generate_key()
            with open("key.key", "wb") as file:
                file.write(key)
        
        return key

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = PasswordManagerApp()
    window.show()
    sys.exit(app.exec_())
