import sys
import os
import datetime
from PyQt5.QtWidgets import QApplication, QMainWindow, QPushButton, QListWidget, QVBoxLayout, QWidget, QLineEdit, QCheckBox, QLabel
from PyQt5.QtMultimedia import QAudioRecorder, QAudioEncoderSettings, QMultimedia, QMediaPlayer, QMediaContent
from PyQt5.QtCore import QUrl

class OrganizerWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle("Organizer")
        self.setGeometry(300, 300, 300, 500)

        # Создание кнопки записи
        self.recordButton = QPushButton("Record", self)
        self.recordButton.setGeometry(100, 70, 100, 40)
        self.recordButton.clicked.connect(self.startRecording)

        # Создание поля для именования записи
        self.nameEdit = QLineEdit(self)
        self.nameEdit.setGeometry(50, 120, 200, 30)

        # Создание флажка для выбора связывания файла
        self.linkCheckBox = QCheckBox("Link File", self)
        self.linkCheckBox.setGeometry(50, 160, 100, 30)

        # Создание поля метки для отображения связанной заметки
        self.label = QLabel("Label:", self)
        self.label.setGeometry(50, 200, 200, 30)

        # Создание окна отображения записей
        self.recordListWidget = QListWidget(self)
        self.recordListWidget.setGeometry(50, 240, 200, 200)

        # Создание кнопки прослушивания записи
        self.playButton = QPushButton("Play", self)
        self.playButton.setGeometry(50, 450, 100, 40)
        self.playButton.clicked.connect(self.playSelectedRecord)

        # Создание кнопки остановки записи
        self.stopButton = QPushButton("Stop", self)
        self.stopButton.setGeometry(150, 450, 100, 40)
        self.stopButton.clicked.connect(self.stopRecording)

    def startRecording(self):
        # Создание объекта записи аудио
        self.recorder = QAudioRecorder()

        # Создание настроек кодирования
        settings = QAudioEncoderSettings()
        settings.setCodec("audio/pcm")
        settings.setQuality(QMultimedia.HighQuality)

        # Установка настроек кодирования
        self.recorder.setEncodingSettings(settings)

        # Создание пути и имени файла для записи
        currentDateTime = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
        filePath = os.path.join(os.getcwd(), "recordings", f"recording_{currentDateTime}.wav")

        # Установка пути файла для записи
        self.recorder.setOutputLocation(QUrl.fromLocalFile(filePath))

        # Запуск записи
        self.recorder.record()

    def stopRecording(self):
        # Остановка записи
        self.recorder.stop()

        # Получение выбранной записи
        selectedRecord = self.recorder.outputLocation().toLocalFile()

        # Получение названия записи из поля именования
        name = self.nameEdit.text()

        # Создание связанной заметки
        linkNote = ""
        if self.linkCheckBox.isChecked():
            linkNote = f"Linked to: {name}"

        # Добавление записи в список
        self.recordListWidget.addItem(f"{name} - {selectedRecord} - {linkNote}")

    def playSelectedRecord(self):
        # Получение выбранной записи
        selectedRecord = self.recordListWidget.currentItem().text().split(" - ")[1]

        # Создание объекта проигрывателя
        self.player = QMediaPlayer()
        self.player.setMedia(QMediaContent(QUrl.fromLocalFile(selectedRecord)))

        # Запуск проигрывания
        self.player.play()

    def closeEvent(self, event):
        # Завершение записи при закрытии окна
        if hasattr(self, "recorder"):
            self.recorder.stop()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = OrganizerWindow()
    window.show()

    # Создание папки "recordings", если она не существует
    os.makedirs(os.path.join(os.getcwd(), "recordings"), exist_ok=True)

    sys.exit(app.exec_())
