import sys
import os
import datetime
from PyQt5.QtWidgets import QApplication, QMainWindow, QPushButton, QListWidget, QVBoxLayout, QWidget
from PyQt5.QtMultimedia import QAudioRecorder, QAudioEncoderSettings, QMultimedia, QMediaPlayer, QMediaContent
from PyQt5.QtCore import QUrl

class OrganizerWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle("Organizer")
        self.setGeometry(300, 300, 300, 600)

        # Создание кнопки записи
        self.recordButton = QPushButton("Record", self)
        self.recordButton.setGeometry(100, 70, 100, 40)
        self.recordButton.clicked.connect(self.startRecording)

        # Создание окна отображения записей
        self.recordListWidget = QListWidget(self)
        self.recordListWidget.setGeometry(50, 130, 200, 350)

        # Создание кнопки прослушивания записи
        self.playButton = QPushButton("Play", self)
        self.playButton.setGeometry(100, 500, 100, 40)
        self.playButton.clicked.connect(self.playSelectedRecord)

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

    def loadRecordings(self):
        # Загрузка записей из папки "recordings"
        recordingsPath = os.path.join(os.getcwd(), "recordings")
        recordings = os.listdir(recordingsPath)

        # Очистка списка записей
        self.recordListWidget.clear()

        # Добавление записей в список
        for recording in recordings:
            self.recordListWidget.addItem(recording)

    def playSelectedRecord(self):
        # Получение выбранной записи
        selectedRecord = self.recordListWidget.currentItem().text()

        # Создание пути файла для прослушивания
        filePath = os.path.join(os.getcwd(), "recordings", selectedRecord)

        # Создание объекта проигрывателя
        self.player = QMediaPlayer()
        self.player.setMedia(QMediaContent(QUrl.fromLocalFile(filePath)))

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

    # Загрузка записей при запуске программы
    window.loadRecordings()

    sys.exit(app.exec_())
