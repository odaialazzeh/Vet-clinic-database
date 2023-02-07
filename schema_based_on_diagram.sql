
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

-- many-to-many relationship:
CREATE TABLE medical_histories_treatments (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   medical_histories_id INT NOT NULL REFERENCES medical_histories(id) ON UPDATE CASCADE ON DELETE CASCADE,
   treatments_id INT NOT NULL REFERENCES treatments(id) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE TABLE invoice_items (
   id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   unit_price decimal NOT NULL,
   quantity INT NOT NULL,
   total_price decimal NOT NULL,
   invoice_id INT NOT NULL REFERENCES invoices(id) ON UPDATE CASCADE ON DELETE CASCADE,
   treatment_id INT NOT NULL REFERENCES treatments(id) ON UPDATE CASCADE ON DELETE CASCADE,
);

CREATE INDEX patient_id_index ON medical_histories(patient_id ASC);
CREATE INDEX medical_history_id_index ON invoices(medical_history_id ASC);
CREATE INDEX medical_histories_id_index ON medical_histories_treatments(medical_histories_id ASC);
CREATE INDEX treatments_id_index ON medical_histories_treatments(treatments_id ASC);
CREATE INDEX invoice_id_index ON invoice_items(invoice_id ASC);
CREATE INDEX treatment_id_index ON invoice_items(treatment_id ASC);
