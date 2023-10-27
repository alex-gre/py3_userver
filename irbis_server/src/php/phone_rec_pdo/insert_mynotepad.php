<?php

if (isset($_POST['name']) && isset($_POST['phone']) && isset($_POST['text'])){
    // Переменные с формы
    $name = $_POST['name'];
    $phone = $_POST['phone'];
    $text = $_POST['text'];
    
    // Параметры для подключения
    $db_host = "localhost"; 
    $db_user = "root"; // Логин БД
    $db_password = "qwerty"; // Пароль БД
    $db_base = 'mydb'; // Имя БД
    $db_table = "mynotepad"; // Имя Таблицы БД
    
    try {
        // Подключение к базе данных
        $db = new PDO("mysql:host=$db_host;dbname=$db_base", $db_user, $db_password);
        // Устанавливаем корректную кодировку
        $db->exec("set names utf8");// latin only
        // Собираем данные для запроса
        $data = array( 'name' => $name,'phone' => $phone, 'text' => $text ); 
        // Подготавливаем SQL-запрос
        $query = $db->prepare("INSERT INTO $db_table (name,phone,text) values (:name,:phone,:text)");
        // Выполняем запрос с данными
        $query->execute($data);
        // Запишим в переменую, что запрос отрабтал
        $result = true;
    } catch (PDOException $e) {
        // Если есть ошибка соединения или выполнения запроса, выводим её
        print "Ошибка!: " . $e->getMessage() . "<br/>";
    }
    
    if ($result) {
    	echo "Успех. Информация занесена в базу данных";
    }
}

?>