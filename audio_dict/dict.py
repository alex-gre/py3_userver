import sys
import os
import datetime
from PyQt5.QtWidgets import QApplication, QMainWindow, QPushButton
from PyQt5.QtMultimedia import QAudioRecorder, QAudioEncoderSettings, QMultimedia
from PyQt5.QtCore import QUrl

class OrganizerWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle("Organizer")
        self.setGeometry(300, 300, 300, 200)

        self.recordButton = QPushButton("Record", self)
        self.recordButton.setGeometry(100, 70, 100, 40)
        self.recordButton.clicked.connect(self.startRecording)

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

    def closeEvent(self, event):
        # Завершение записи при закрытии окна
        if hasattr(self, "recorder"):
            self.recorder.stop()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = OrganizerWindow()
    window.show()
    sys.exit(app.exec_())
