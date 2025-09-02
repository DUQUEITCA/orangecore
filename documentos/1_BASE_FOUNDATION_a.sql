
-- PARTE 1: Creación del esquema y tablas esenciales de base_foundation
-- Estas tablas son requeridas por el esquema de finanzas_bookkeeping,
-- por lo que se crean aquí para evitar errores de dependencia.

-- TODO O NADA
BEGIN;
-- Nota: Ya existe el esquema de base_foundation
-- CREATE SCHEMA IF NOT EXISTS base_foundation;

-- TABLA: ORGANIZATIONS
BEGIN;
CREATE TABLE base_foundation.organizations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    industry VARCHAR(100),
    website VARCHAR(255),
    logo_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
COMMIT;

-- TABLA: CONTACTS
CREATE TABLE base_foundation.contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    full_name VARCHAR(201) GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    organization_id INT,
    job_title VARCHAR(100),
    contact_status VARCHAR(50) NOT NULL,
    lead_status VARCHAR(50),
    lead_source VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- FALTANTE --
-- TABLA: CUSTOMER_PROJECTS (La tabla que faltaba)

CREATE TABLE base_foundation.customer_projects (
    id SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    project_name VARCHAR(255) NOT NULL,
    project_description TEXT,
    project_status VARCHAR(50) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(12,2),
    actual_cost DECIMAL(12,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: INVOICES
-- FALTANTE --
CREATE TABLE base_foundation.invoices (
    id SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    customer_contact_id INT,
    customer_project_id INT,
    invoice_number VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE,
    amount DECIMAL(12,2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    paid_at TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PROCESSED_PAYMENTS
-- FALTANTE --
CREATE TABLE base_foundation.processed_payments (
    id SERIAL PRIMARY KEY,
    organization_id INT NOT NULL,
    invoice_id INT,
    payment_processor_id VARCHAR(100) UNIQUE,
    amount DECIMAL(12,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(20) NOT NULL,
    transaction_fees DECIMAL(8,2),
    net_amount DECIMAL(12,2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Claves foráneas para las tablas de base_foundation
ALTER TABLE base_foundation.contacts ADD CONSTRAINT fk_contacts_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);

-- FALTANTE --
ALTER TABLE base_foundation.customer_projects ADD CONSTRAINT fk_projects_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);

-- FALTANTE --
ALTER TABLE base_foundation.invoices ADD CONSTRAINT fk_invoices_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
-- FALTANTE --
ALTER TABLE base_foundation.invoices ADD CONSTRAINT fk_invoices_customer_contact FOREIGN KEY (customer_contact_id) REFERENCES base_foundation.contacts(id);
-- FALTANTE --
ALTER TABLE base_foundation.invoices ADD CONSTRAINT fk_invoices_customer_project FOREIGN KEY (customer_project_id) REFERENCES base_foundation.customer_projects(id);
-- FALTANTE --
ALTER TABLE base_foundation.processed_payments ADD CONSTRAINT fk_processed_payments_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
-- FALTANTE --
ALTER TABLE base_foundation.processed_payments ADD CONSTRAINT fk_processed_payments_invoice FOREIGN KEY (invoice_id) REFERENCES base_foundation.invoices(id);

COMMIT;
