CREATE TABLE Clients (
client_id INT AUTO_INCREMENT PRIMARY KEY,
client_name VARCHAR(255),
client_contact VARCHAR(255)
);

CREATE TABLE Employees (
employee_id INT AUTO_INCREMENT PRIMARY KEY,
employee_name VARCHAR(255),
employee_position VARCHAR(255)
);

CREATE TABLE Patrols (
patrol_id INT AUTO_INCREMENT PRIMARY KEY,
patrol_name VARCHAR(255)
);

CREATE TABLE Locations (
location_id INT AUTO_INCREMENT PRIMARY KEY,
location_name VARCHAR(255)
);

CREATE TABLE Incidents (
incident_id INT AUTO_INCREMENT PRIMARY KEY,
incident_type VARCHAR(255),
incident_description TEXT,
location_id INT,
patrol_id INT,
client_id INT,
employee_id INT,
FOREIGN KEY (location_id) REFERENCES Locations(location_id),
FOREIGN KEY (patrol_id) REFERENCES Patrols(patrol_id),
FOREIGN KEY (client_id) REFERENCES Clients(client_id),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);