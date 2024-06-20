![hpo](https://github.com/obdrystish/chop/assets/120009426/5496f86d-f5b6-4316-8c55-86c560113ce7)

### Типовые запросы:
### 1. Получение списка всех клиентов:
```sql
SELECT * FROM clients;
```

### 2. Получение информации об инцидентах с описанием их расположения:
```sql
SELECT i.incident_type, i.incident_description, l.location_name
FROM incidents i
JOIN locations l ON i.location_id = l.location_id;
```

### 3. Получение информации о сотрудниках и патрулях, с которыми они связаны:
```sql
SELECT e.employee_name, p.patrol_name
FROM employees e
JOIN patrols_has_employees pe ON e.employee_id = pe.employees_employee_id
JOIN patrols p ON pe.patrols_patrol_id = p.patrol_id;
```

### 4. Подсчет количества инцидентов, связанных с каждым клиентом:
```sql
SELECT c.client_name, COUNT(*) AS total_incidents
FROM incidents i
JOIN clients c ON i.client_id = c.client_id
GROUP BY c.client_name;
```

### 5. Получение списка инцидентов, где тип инцидента - "Vandalism":
```sql
SELECT *
FROM incidents
WHERE incident_type = 'Vandalism';
```

### Хранимая процедура:
```
CALL CheckPatrolsSentToIncidents();
```
Эта процедура проверяет, был ли хотя бы один патруль отправлен на инцидент.

### Представление 
```
SELECT * FROM IncidentDetails;
```
В данном представлении IncidentDetails мы объединяем данные из таблиц incidents, clients, employees, locations и patrols, чтобы предоставить информацию о деталях инцидентов в одном удобном представлении.

### Функция
```
SELECT CountSentPatrols() AS SentPatrolsCount;
```
Подсчитывает общее количество отправленных патрулей

ехнические требования
Для запуска этой базы данных вам понадобится следующее:

Установленный и запущенный сервер MySQL.
MySQL Workbench или любой другой клиент MySQL для выполнения SQL-скриптов.
Импортировать предоставленный SQL-скрипт для создания схемы базы данных и заполнения ее тестовыми данными.
Установка и настройка
1. Клонируйте этот репозиторий на ваш компьютер.

2. Установите сервер MySQL, если еще не установлен.

3. Откройте MySQL Workbench и подключитесь к вашему серверу MySQL.

4. Откройте предоставленный SQL-скрипт в MySQL Workbench.

5. Выполните скрипт для создания схемы базы данных и заполнения ее тестовыми данными.

6. Теперь вы можете выполнять запросы к базе данных для работы с ней.
