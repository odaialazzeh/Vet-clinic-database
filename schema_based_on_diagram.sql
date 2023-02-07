
CREATE TABLE patients (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   name VARCHAR(100) NOT NULL,
   date_of_birth date NOT NULL
);


CREATE TABLE medical_histories (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   admitted_at timestamp NOT NULL,
   patient_id INT NOT NULL  REFERENCES patients(id) ON UPDATE CASCADE ON DELETE CASCADE,
   status VARCHAR(100) NOT NULL
);


CREATE TABLE invoices (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   total_amount decimal NOT NULL,
   generated_at timestamp NOT NULL,
   payed_at timestamp NOT NULL,
   medical_history_id INT NOT NULL REFERENCES medical_histories(id) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE treatments (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   type VARCHAR(100) NOT NULL,
   name VARCHAR(100) NOT NULL
);






