![hpo](https://github.com/obdrystish/chop/assets/120009426/5496f86d-f5b6-4316-8c55-86c560113ce7)

**Типовые запросы:**
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
