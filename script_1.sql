--------Actividad 1--------

CREATE TABLE students (
    id BIGINT IDENTITY(1000,1) PRIMARY KEY,
    id_carrer CHAR(4),
    lastname VARCHAR(50) NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    birthday DATETIME CONSTRAINT CHK_birthday CHECK (birthday <= GETDATE()),
    email VARCHAR(50) NOT NULL UNIQUE,
    telephone VARCHAR(50) NULL
);


CREATE TABLE carrers (
    id CHAR(4) PRIMARY KEY,
    name VARCHAR (50) NOT NULL,
    created_at DATETIME CONSTRAINT CHK_created_at_carrers CHECK (created_at <= GETDATE()),
	email VARCHAR (50) NOT NULL UNIQUE
);


CREATE TABLE modules (
    id CHAR(4) PRIMARY KEY,
    id_carrer CHAR(4),
    created_at DATETIME CONSTRAINT CHK_created_at_module CHECK (created_at <= GETDATE()),
	name VARCHAR (50) NOT NULL,
	hour_load INT CHECK (hour_load > 0),
);

ALTER TABLE students
ADD CONSTRAINT FK_id_student_carrer
FOREIGN KEY ( id_carrer ) REFERENCES carrers ( id )


ALTER TABLE modules
ADD CONSTRAINT FK_id_modules_carrer
FOREIGN KEY ( id_carrer ) REFERENCES carrers ( id )
