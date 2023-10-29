from PyQt5.QtWidgets import *


class Example(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle('Example')
        self.setCentralWidget(QLabel('<font size="100">Hello, <b>USER</b>!</font>'))


if __name__ == '__main__':
    app = QApplication([])

    password, ok = QInputDialog.getText(None, 'Auth', 'Input password:', QLineEdit.Password)
    if not ok:
        QMessageBox.warning(None, 'Warning', 'Need input password!')
        quit()

    if password != 'wadmin':
        QMessageBox.warning(None, 'Warning', 'Invalid password!')
        quit()

    w = Example()
    w.show()

    app.exec_()