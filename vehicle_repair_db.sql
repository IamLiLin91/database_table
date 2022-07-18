DROP DATABASE IF EXISTS Vehicle_Repair_Company;
CREATE DATABASE IF NOT EXISTS Vehicle_Repair_Company;
USE Vehicle_Repair_Company;

/* Delete the tables if they already exist */
DROP TABLE IF EXISTS center;
DROP TABLE IF EXISTS problem;
DROP TABLE IF EXISTS service_ticket;
DROP TABLE IF EXISTS repair_bay;
DROP TABLE IF EXISTS vehicle;
DROP TABLE IF EXISTS admin_grp;
DROP TABLE IF EXISTS mechanics;
DROP TABLE IF EXISTS employee;

CREATE TABLE employee
(
    employee_id VARCHAR(9), 
    name CHAR(20), 
    salary numeric(8,2),
    PRIMARY KEY(employee_id)
    );

CREATE TABLE mechanics
(
    mechanics_id VARCHAR(9), 
    mech_rank VARCHAR(20),
    PRIMARY KEY(mechanics_id),
    FOREIGN KEY(mechanics_id) REFERENCES employee(employee_id)
    ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE admin_grp
(
    admin_id VARCHAR(9), 
    job_title VARCHAR(10),
    PRIMARY KEY(admin_id),
    FOREIGN KEY(admin_id) REFERENCES employee(employee_id)
    ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE vehicle
(
    vehicle_id CHAR(8) UNIQUE, 
    year numeric(4,0), 
    model CHAR(8),
    make CHAR(15),
    PRIMARY KEY(vehicle_id)
    );

CREATE TABLE repair_bay
(
    slot_id CHAR(4), 
    repair_bay_id CHAR(5) UNIQUE,
    work_done_record VARCHAR(200),
    mechanics_id VARCHAR(9),
    date_of_repairs TIMESTAMP,
    invoice_number CHAR(10),
    PRIMARY KEY(slot_id),
    FOREIGN KEY(mechanics_id) REFERENCES mechanics(mechanics_id)
    ON DELETE CASCADE ON UPDATE CASCADE
    );

CREATE TABLE service_ticket
(
    ticket_id INT AUTO_INCREMENT, 
    date_of_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    vehicle_id CHAR(8),
    repair_bay_id CHAR(5),
    PRIMARY KEY(ticket_id),
    FOREIGN KEY(vehicle_id) REFERENCES vehicle(vehicle_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(repair_bay_id) REFERENCES repair_bay(repair_bay_id)
    ON DELETE CASCADE ON UPDATE CASCADE
    );
CREATE TABLE problem
(
    id INT, 
    prob_description TEXT, 
    hrs_to_fix DECIMAL(8,2),
    PRIMARY KEY(id),
    FOREIGN KEY(id) REFERENCES service_ticket(ticket_id)
    ON DELETE CASCADE ON UPDATE CASCADE
    );
CREATE TABLE center
(
    center_id CHAR(3), 
    address CHAR(90), 
    hourly_rate DECIMAL(5,2),
    employee_id VARCHAR(9),
    service_ticket_id INT,
    repair_id CHAR(5),
    PRIMARY KEY(center_id),
    FOREIGN KEY(repair_id) REFERENCES repair_bay(repair_bay_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(employee_id) REFERENCES employee(employee_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(service_ticket_id) REFERENCES service_ticket(ticket_id)
    ON DELETE CASCADE ON UPDATE CASCADE
    );
