import platform
import psutil
def write_info():
  # Получаем системную информацию
	system_info = {
	    "Операционная система": platform.system(),
	    "Версия операционной системы": platform.release(),
	    "Архитектура": platform.machine(),
	    "Имя компьютера": platform.node(),
	    "Процессор": platform.processor(),
	    "Количество ядер процессора": psutil.cpu_count(),
	    "Общий объем физической памяти": psutil.virtual_memory().total,
	    "Свободная память": psutil.virtual_memory().available,
	    "Общий объем виртуальной памяти": psutil.swap_memory().total,
	    "Свободное место на жестком диске": psutil.disk_usage('/').free
	}
  #Открываем файл для записи

	file = open("system_info.txt", "w")

	# Записываем информацию в файл
	for key, value in system_info.items():
	    file.write(key + ": " + str(value) + "\n")

	# Закрываем файл
	file.close()

	print("Информация успешно записана в файл system_info.txt")
	