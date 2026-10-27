-- ============================================================
-- Droopy's Clinic - database (SQLite)
-- ============================================================

PRAGMA foreign_keys = ON;

-- ---------- Users: login + role (PATIENT / DOCTOR / ADMIN) ----------
CREATE TABLE users (
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    login    TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role     TEXT NOT NULL CHECK (role IN ('PATIENT', 'DOCTOR', 'ADMIN'))
);

-- ---------- Patients ----------
CREATE TABLE patients (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id    INTEGER NOT NULL UNIQUE,
    fio        TEXT,
    phone      TEXT,
    birth_date TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- ---------- Doctors ----------
CREATE TABLE doctors (
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id        INTEGER NOT NULL UNIQUE,
    fio            TEXT,
    specialization TEXT,
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- ---------- Medical records ----------
CREATE TABLE medical_records (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    doctor_id  INTEGER NOT NULL,
    diagnosis  TEXT,
    visit_date TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (patient_id) REFERENCES patients (id),
    FOREIGN KEY (doctor_id)  REFERENCES doctors (id)
);

-- ---------- Appointments ----------
CREATE TABLE appointments (
    id         INTEGER PRIMARY KEY AUTOINCREMENT,
    patient_id INTEGER NOT NULL,
    doctor_id  INTEGER NOT NULL,
    appt_date  TEXT NOT NULL,
    status     TEXT DEFAULT 'BOOKED'
               CHECK (status IN ('BOOKED', 'CANCELLED',
                                 'PATIENT_CAME', 'DOCTOR_CAME', 'DONE')),
    FOREIGN KEY (patient_id) REFERENCES patients (id),
    FOREIGN KEY (doctor_id)  REFERENCES doctors (id)
);

-- ============================================================
-- Sample data
-- ============================================================

INSERT INTO users (login, password, role) VALUES
    ('admin',    'admin',   'ADMIN'),
    ('Grandfather',   'therotconsumes',    'DOCTOR'),
    ('Droopy',   'sheshere',    'DOCTOR'),
    ('Serg',    'dumb',    'PATIENT'),
    ('Goose',   '616',    'PATIENT');

INSERT INTO doctors (user_id, fio, specialization) VALUES
    (2, 'Nurgle', 'Therapist'),
    (3, 'Pandora D.', 'Surgeon');

INSERT INTO patients (user_id, fio, phone, birth_date) VALUES
    (4, 'Dubov S.A.', '+79444444444', '2007-10-23'),
    (5, 'Goosebumps',   '+79666666666', '1978-11-18');

INSERT INTO medical_records (patient_id, doctor_id, diagnosis) VALUES
    (1, 1, 'Paranoid schizophrenia'),
    (1, 2, 'Necrosis'),
    (2, 1, 'Bone cancer, (skull), stage 4');

INSERT INTO appointments (patient_id, doctor_id, appt_date, status) VALUES
    (1, 1, '2026-10-22 09:00', 'BOOKED'),
    (2, 2, '2026-10-22 10:30', 'BOOKED'),
    (1, 2, '2026-10-15 14:00', 'DONE');