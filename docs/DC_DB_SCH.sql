CREATE TABLE users (
    id       INT PRIMARY KEY AUTO_INCREMENT,
    login    VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role     ENUM('PATIENT', 'DOCTOR', 'ADMIN') NOT NULL
);

CREATE TABLE patients (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    user_id    INT NOT NULL UNIQUE,
    fio        VARCHAR(100),
    phone      VARCHAR(20),
    birth_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE doctors (
    id             INT PRIMARY KEY AUTO_INCREMENT,
    user_id        INT NOT NULL UNIQUE,
    fio            VARCHAR(100),
    specialization VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE medical_records (
    id         INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id  INT NOT NULL,
    diagnosis  TEXT,
    visit_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id)  REFERENCES doctors(id)
);

CREATE TABLE appointments (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    patient_id  INT NOT NULL,
    doctor_id   INT NOT NULL,
    appt_date   DATETIME NOT NULL,
    status      ENUM('BOOKED', 'CANCELLED',
                     'PATIENT_CAME', 'DOCTOR_CAME', 'DONE')
                DEFAULT 'BOOKED',
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id)  REFERENCES doctors(id)
);