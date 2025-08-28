-- PARTE 1: Creacin del esquema y tablas con PKs y restricciones de columna
-- ==================================================================================================================================================================
-- TODO O NADA
BEGIN;

-- Creamos el esquema si an no existe
CREATE SCHEMA IF NOT EXISTS base_foundation;

-- Establecemos el path de bsqueda para no tener que prefijar cada tabla
SET search_path TO base_foundation;

-- TABLA: LEAD_STATUSES
-- Mdulo: CRM Y LEADS
CREATE TABLE base_foundation.lead_statuses (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER,
    status_name VARCHAR(50) NOT NULL,
    status_order INTEGER,
    status_color VARCHAR(7),
    is_final_status BOOLEAN DEFAULT FALSE,
    conversion_probability DECIMAL(5, 2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, status_name)
);

-- TABLA: LEAD_SOURCES
-- Mdulo: CRM Y LEADS
CREATE TABLE base_foundation.lead_sources (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER,
    source_name VARCHAR(100) NOT NULL,
    source_category VARCHAR(50),
    cost_per_lead DECIMAL(8, 2),
    conversion_rate DECIMAL(5, 2),
    is_active BOOLEAN DEFAULT TRUE,
    tracking_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, source_name)
);

-- TABLA: ORGANIZATIONS
-- Mdulo: ORGANIZACIONES
CREATE TABLE base_foundation.organizations (
    id SERIAL PRIMARY KEY,
    parent_id INTEGER,
    name VARCHAR(100) NOT NULL,
    organization_type VARCHAR(50),
    address_line_1 VARCHAR(255),
    address_line_2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    industry VARCHAR(100),
    tax_id VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: ROLE_TYPES
-- Mdulo: ROLES Y PERMISOS
CREATE TABLE base_foundation.role_types (
    id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    permissions_json JSONB,
    is_system_role BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: CONTACTS
-- Mdulo: CONTACTOS Y PERSONAS
CREATE TABLE base_foundation.contacts (
    id SERIAL PRIMARY KEY,
    is_company BOOLEAN DEFAULT FALSE,
    name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    full_name VARCHAR(200),
    lead_status_id INTEGER,
    lead_source_id INTEGER,
    assigned_salesperson_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    created_by VARCHAR(50),
    updated_at TIMESTAMP DEFAULT NOW(),
    updated_by VARCHAR(50)
);

-- TABLA: PERSONS
-- Mdulo: CONTACTOS Y PERSONAS
CREATE TABLE base_foundation.persons (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL UNIQUE,
    gender VARCHAR(30),
    birth_date DATE,
    tax_id VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: COMPANIES
-- Mdulo: CONTACTOS Y PERSONAS
CREATE TABLE base_foundation.companies (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL UNIQUE,
    company_name VARCHAR(200),
    founded_date DATE,
    tax_id VARCHAR(20),
    legal_entity_type VARCHAR(50),
    industry VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PHONES
-- Mdulo: CONTACTOS Y PERSONAS
CREATE TABLE base_foundation.phones (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    country_code VARCHAR(10),
    phone_number VARCHAR(20) NOT NULL,
    extension VARCHAR(10),
    is_main BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(country_code, phone_number, extension)
);

-- TABLA: EMAILS
-- Mdulo: CONTACTOS Y PERSONAS
CREATE TABLE base_foundation.emails (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    is_main BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: AVATARS
-- Mdulo: CONTACTOS Y PERSONAS
CREATE TABLE base_foundation.avatars (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    url VARCHAR(500) NOT NULL UNIQUE,
    file_name VARCHAR(255),
    file_size INTEGER,
    mime_type VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: ORGANIZATION_SETTINGS
-- Mdulo: ORGANIZACIONES
CREATE TABLE base_foundation.organization_settings (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    setting_key VARCHAR(100) NOT NULL,
    setting_value TEXT,
    setting_type VARCHAR(50),
    description TEXT,
    is_encrypted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, setting_key)
);

-- TABLA: ORGANIZATION_INTEGRATIONS
-- Mdulo: ORGANIZACIONES
CREATE TABLE base_foundation.organization_integrations (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    integration_type VARCHAR(50) NOT NULL,
    api_key VARCHAR(255),
    api_secret VARCHAR(255),
    config_json JSONB,
    is_active BOOLEAN DEFAULT TRUE,
    last_sync_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, integration_type)
);

-- TABLA: ROLES
-- Mdulo: ROLES Y PERMISOS
CREATE TABLE base_foundation.roles (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    role_type_id INTEGER NOT NULL,
    role_name VARCHAR(100) NOT NULL,
    custom_permissions_json JSONB,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, role_name)
);

-- TABLA: CONTACT_ORGANIZATION_ROLES
-- Mdulo: ROLES Y PERMISOS
CREATE TABLE base_foundation.contact_organization_roles (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    organization_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    assigned_at TIMESTAMP DEFAULT NOW(),
    assigned_by_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(contact_id, organization_id, role_id)
);

-- TABLA: USERS
-- Mdulo: USUARIOS Y AUTENTICACIN
CREATE TABLE base_foundation.users (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_email_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMP,
    failed_login_attempts INTEGER DEFAULT 0,
    account_locked_until TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PASSWORD_RESET_TOKENS
-- Mdulo: USUARIOS Y AUTENTICACIN
CREATE TABLE base_foundation.password_reset_tokens (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    expires_at TIMESTAMP,
    used_at TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: USER_SESSIONS
-- Mdulo: USUARIOS Y AUTENTICACIN
CREATE TABLE base_foundation.user_sessions (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    session_token VARCHAR(255) NOT NULL UNIQUE,
    ip_address VARCHAR(45),
    user_agent TEXT,
    expires_at TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    last_activity_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PROPERTIES
-- Mdulo: PROPIEDADES
CREATE TABLE base_foundation.properties (
    id SERIAL PRIMARY KEY,
    place_id VARCHAR(255) UNIQUE,
    address_line_1 VARCHAR(255),
    address_line_2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    country VARCHAR(50),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    property_type VARCHAR(50),
    year_built INTEGER,
    square_footage INTEGER,
    lot_size DECIMAL(10, 2),
    bedrooms INTEGER,
    bathrooms DECIMAL(3, 1),
    stories INTEGER,
    roof_material VARCHAR(50),
    roof_age INTEGER,
    construction_type VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PROPERTY_IMAGES
-- Mdulo: PROPIEDADES
CREATE TABLE base_foundation.property_images (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL,
    image_url VARCHAR(500),
    image_type VARCHAR(50),
    description TEXT,
    taken_at TIMESTAMP,
    taken_by_contact_id INTEGER,
    file_size INTEGER,
    mime_type VARCHAR(100),
    is_primary BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PROPERTY_NOTES
-- Mdulo: PROPIEDADES
CREATE TABLE base_foundation.property_notes (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL,
    note_text TEXT,
    note_type VARCHAR(50),
    is_important BOOLEAN DEFAULT FALSE,
    is_visible_to_customer BOOLEAN DEFAULT FALSE,
    created_by_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PROPERTY_BATCH_DATA
-- Mdulo: PROPIEDADES
CREATE TABLE base_foundation.property_batch_data (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL,
    owner_name VARCHAR(200),
    owner_mailing_address VARCHAR(500),
    assessed_value DECIMAL(12, 2),
    market_value DECIMAL(12, 2),
    tax_amount DECIMAL(10, 2),
    deed_date DATE,
    sales_price DECIMAL(12, 2),
    sales_date DATE,
    mortgage_amount DECIMAL(12, 2),
    mortgage_lender VARCHAR(200),
    property_use_code VARCHAR(20),
    last_updated_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PROPERTY_VISITS
-- Mdulo: CRM Y LEADS
CREATE TABLE base_foundation.property_visits (
    id SERIAL PRIMARY KEY,
    property_id INTEGER NOT NULL,
    contact_id INTEGER NOT NULL,
    sales_rep_id INTEGER NOT NULL,
    visit_type VARCHAR(50),
    visit_date TIMESTAMP,
    visit_duration_minutes INTEGER,
    outcome VARCHAR(50),
    notes TEXT,
    gps_latitude DECIMAL(10, 8),
    gps_longitude DECIMAL(11, 8),
    weather_conditions VARCHAR(100),
    follow_up_date DATE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: EMPLOYEE_PERSONAL_INFO
-- Mdulo: HR COMPLETO
CREATE TABLE base_foundation.employee_personal_info (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL UNIQUE,
    employee_id VARCHAR(20) NOT NULL UNIQUE,
    hire_date DATE,
    employment_status VARCHAR(30),
    employment_type VARCHAR(30),
    department VARCHAR(100),
    job_title VARCHAR(100),
    manager_contact_id INTEGER,
    work_location VARCHAR(255),
    marital_status VARCHAR(20),
    number_of_dependents INTEGER DEFAULT 0,
    veteran_status BOOLEAN DEFAULT FALSE,
    disability_status VARCHAR(50),
    preferred_language VARCHAR(30),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: EMPLOYEE_EMERGENCY_CONTACTS
-- Mdulo: HR COMPLETO
CREATE TABLE base_foundation.employee_emergency_contacts (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    emergency_contact_name VARCHAR(100),
    relationship VARCHAR(50),
    phone_primary VARCHAR(20),
    phone_secondary VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(500),
    is_primary BOOLEAN DEFAULT FALSE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: EMPLOYEE_BANKING_INFO
-- Mdulo: HR COMPLETO
CREATE TABLE base_foundation.employee_banking_info (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL UNIQUE,
    account_type VARCHAR(20),
    bank_name VARCHAR(100),
    routing_number VARCHAR(20),
    account_number VARCHAR(50),
    account_holder_name VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    verification_status VARCHAR(20),
    verified_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: EMPLOYEE_DOCUMENTS
-- Mdulo: HR COMPLETO
CREATE TABLE base_foundation.employee_documents (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    document_type VARCHAR(50),
    document_name VARCHAR(255),
    file_url VARCHAR(500),
    file_name VARCHAR(255),
    file_size INTEGER,
    mime_type VARCHAR(100),
    expiration_date DATE,
    is_required BOOLEAN DEFAULT FALSE,
    approval_status VARCHAR(20),
    approved_by_contact_id INTEGER,
    approved_at TIMESTAMP,
    uploaded_by_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: PAYROLL_RECORDS
-- Mdulo: HR COMPLETO
CREATE TABLE base_foundation.payroll_records (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    pay_period_start DATE,
    pay_period_end DATE,
    pay_date DATE,
    gross_pay DECIMAL(10, 2),
    regular_hours DECIMAL(6, 2),
    overtime_hours DECIMAL(6, 2),
    regular_rate DECIMAL(8, 2),
    overtime_rate DECIMAL(8, 2),
    commission_amount DECIMAL(10, 2),
    bonus_amount DECIMAL(10, 2),
    total_deductions DECIMAL(10, 2),
    net_pay DECIMAL(10, 2),
    pay_method VARCHAR(20),
    payroll_batch_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(contact_id, pay_period_start, pay_period_end)
);

-- TABLA: PAYROLL_DEDUCTIONS
-- Mdulo: HR COMPLETO
CREATE TABLE base_foundation.payroll_deductions (
    id SERIAL PRIMARY KEY,
    payroll_record_id INTEGER NOT NULL,
    deduction_type VARCHAR(50),
    deduction_name VARCHAR(100),
    deduction_amount DECIMAL(8, 2),
    is_pre_tax BOOLEAN DEFAULT FALSE,
    employer_contribution DECIMAL(8, 2)
);

-- PARTE 2: Agregar las claves forneas (FKs)
-- ==================================================================================================================================================================

ALTER TABLE base_foundation.lead_statuses ADD CONSTRAINT fk_lead_statuses_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.lead_sources ADD CONSTRAINT fk_lead_sources_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.organizations ADD CONSTRAINT fk_organizations_parent FOREIGN KEY (parent_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.contacts ADD CONSTRAINT fk_contacts_lead_status FOREIGN KEY (lead_status_id) REFERENCES base_foundation.lead_statuses(id);
ALTER TABLE base_foundation.contacts ADD CONSTRAINT fk_contacts_lead_source FOREIGN KEY (lead_source_id) REFERENCES base_foundation.lead_sources(id);
ALTER TABLE base_foundation.contacts ADD CONSTRAINT fk_contacts_assigned_salesperson FOREIGN KEY (assigned_salesperson_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.persons ADD CONSTRAINT fk_persons_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.companies ADD CONSTRAINT fk_companies_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.phones ADD CONSTRAINT fk_phones_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.emails ADD CONSTRAINT fk_emails_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.avatars ADD CONSTRAINT fk_avatars_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.organization_settings ADD CONSTRAINT fk_org_settings_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.organization_integrations ADD CONSTRAINT fk_org_integrations_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.roles ADD CONSTRAINT fk_roles_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.roles ADD CONSTRAINT fk_roles_role_type FOREIGN KEY (role_type_id) REFERENCES base_foundation.role_types(id);
ALTER TABLE base_foundation.contact_organization_roles ADD CONSTRAINT fk_contact_org_roles_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.contact_organization_roles ADD CONSTRAINT fk_contact_org_roles_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.contact_organization_roles ADD CONSTRAINT fk_contact_org_roles_role FOREIGN KEY (role_id) REFERENCES base_foundation.roles(id);
ALTER TABLE base_foundation.contact_organization_roles ADD CONSTRAINT fk_contact_org_roles_assigned_by_contact FOREIGN KEY (assigned_by_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.users ADD CONSTRAINT fk_users_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.password_reset_tokens ADD CONSTRAINT fk_password_tokens_user FOREIGN KEY (user_id) REFERENCES base_foundation.users(id);
ALTER TABLE base_foundation.user_sessions ADD CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES base_foundation.users(id);
ALTER TABLE base_foundation.property_images ADD CONSTRAINT fk_property_images_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);
ALTER TABLE base_foundation.property_images ADD CONSTRAINT fk_property_images_contact FOREIGN KEY (taken_by_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.property_notes ADD CONSTRAINT fk_property_notes_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);
ALTER TABLE base_foundation.property_notes ADD CONSTRAINT fk_property_notes_contact FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.property_batch_data ADD CONSTRAINT fk_batch_data_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);
ALTER TABLE base_foundation.property_visits ADD CONSTRAINT fk_visits_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);
ALTER TABLE base_foundation.property_visits ADD CONSTRAINT fk_visits_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.property_visits ADD CONSTRAINT fk_visits_sales_rep FOREIGN KEY (sales_rep_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_personal_info ADD CONSTRAINT fk_employee_info_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_personal_info ADD CONSTRAINT fk_employee_info_manager FOREIGN KEY (manager_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_emergency_contacts ADD CONSTRAINT fk_emergency_contacts_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_banking_info ADD CONSTRAINT fk_banking_info_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_documents ADD CONSTRAINT fk_employee_docs_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_documents ADD CONSTRAINT fk_employee_docs_approver FOREIGN KEY (approved_by_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.employee_documents ADD CONSTRAINT fk_employee_docs_uploader FOREIGN KEY (uploaded_by_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.payroll_records ADD CONSTRAINT fk_payroll_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.payroll_deductions ADD CONSTRAINT fk_payroll_deductions_record FOREIGN KEY (payroll_record_id) REFERENCES base_foundation.payroll_records(id);


-- PARTE 3: Creacin de ndices para optimizacin de bsquedas
-- ==================================================================================================================================================================

-- ndices para la tabla contacts
CREATE INDEX idx_contacts_full_name ON base_foundation.contacts (full_name);
CREATE INDEX idx_contacts_salesperson ON base_foundation.contacts (assigned_salesperson_id);
CREATE INDEX idx_contacts_company_flag ON base_foundation.contacts (is_company);

-- ndices para la tabla persons
CREATE INDEX idx_persons_birth_date ON base_foundation.persons (birth_date);
CREATE INDEX idx_persons_tax_id ON base_foundation.persons (tax_id);

-- ndices para la tabla companies
CREATE INDEX idx_companies_industry ON base_foundation.companies (industry);
CREATE INDEX idx_companies_entity_type ON base_foundation.companies (legal_entity_type);

-- ndices para la tabla phones
CREATE INDEX idx_phones_contact ON base_foundation.phones (contact_id);
CREATE INDEX idx_phones_main ON base_foundation.phones (is_main);

-- ndices para la tabla emails
CREATE INDEX idx_emails_contact ON base_foundation.emails (contact_id);
CREATE INDEX idx_emails_verified ON base_foundation.emails (is_verified);

-- ndices para la tabla avatars
CREATE INDEX idx_avatars_contact ON base_foundation.avatars (contact_id);
CREATE INDEX idx_avatars_active ON base_foundation.avatars (is_active);

-- ndices para la tabla organizations
CREATE INDEX idx_orgs_parent ON base_foundation.organizations (parent_id);
CREATE INDEX idx_orgs_type ON base_foundation.organizations (organization_type);
CREATE INDEX idx_orgs_industry ON base_foundation.organizations (industry);

-- ndices para la tabla organization_settings
CREATE INDEX idx_org_settings_key ON base_foundation.organization_settings (setting_key);
CREATE INDEX idx_org_settings_encrypted ON base_foundation.organization_settings (is_encrypted);

-- ndices para la tabla organization_integrations
CREATE INDEX idx_org_integrations_type ON base_foundation.organization_integrations (integration_type);
CREATE INDEX idx_org_integrations_active ON base_foundation.organization_integrations (is_active);

-- ndices para la tabla role_types
CREATE INDEX idx_role_types_system ON base_foundation.role_types (is_system_role);
CREATE INDEX idx_role_types_name ON base_foundation.role_types (role_name);

-- ndices para la tabla roles
CREATE INDEX idx_roles_org ON base_foundation.roles (organization_id);
CREATE INDEX idx_roles_type ON base_foundation.roles (role_type_id);

-- ndices para la tabla contact_organization_roles
CREATE INDEX idx_contact_org_roles_contact ON base_foundation.contact_organization_roles (contact_id);
CREATE INDEX idx_contact_org_roles_org ON base_foundation.contact_organization_roles (organization_id);
CREATE INDEX idx_contact_org_roles_active ON base_foundation.contact_organization_roles (is_active);

-- ndices para la tabla users
CREATE INDEX idx_users_username ON base_foundation.users (username);
CREATE INDEX idx_users_email ON base_foundation.users (email);
CREATE INDEX idx_users_active ON base_foundation.users (is_active);

-- ndices para la tabla password_reset_tokens
CREATE INDEX idx_password_tokens_user ON base_foundation.password_reset_tokens (user_id);
CREATE INDEX idx_password_tokens_expires ON base_foundation.password_reset_tokens (expires_at);

-- ndices para la tabla user_sessions
CREATE INDEX idx_sessions_user ON base_foundation.user_sessions (user_id);
CREATE INDEX idx_sessions_token ON base_foundation.user_sessions (session_token);
CREATE INDEX idx_sessions_expires ON base_foundation.user_sessions (expires_at);

-- ndices para la tabla properties
CREATE INDEX idx_properties_coordinates ON base_foundation.properties (latitude, longitude);
CREATE INDEX idx_properties_type ON base_foundation.properties (property_type);
CREATE INDEX idx_properties_city_state ON base_foundation.properties (city, state);

-- ndices para la tabla property_images
CREATE INDEX idx_property_images_property ON base_foundation.property_images (property_id);
CREATE INDEX idx_property_images_type ON base_foundation.property_images (image_type);
CREATE INDEX idx_property_images_primary ON base_foundation.property_images (is_primary);

-- ndices para la tabla property_notes
CREATE INDEX idx_property_notes_property ON base_foundation.property_notes (property_id);
CREATE INDEX idx_property_notes_type ON base_foundation.property_notes (note_type);
CREATE INDEX idx_property_notes_important ON base_foundation.property_notes (is_important);

-- ndices para la tabla property_batch_data
CREATE INDEX idx_batch_data_property ON base_foundation.property_batch_data (property_id);
CREATE INDEX idx_batch_data_owner ON base_foundation.property_batch_data (owner_name);
CREATE INDEX idx_batch_data_value ON base_foundation.property_batch_data (assessed_value, market_value);

-- ndices para la tabla property_visits
CREATE INDEX idx_visits_property ON base_foundation.property_visits (property_id);
CREATE INDEX idx_visits_sales_rep ON base_foundation.property_visits (sales_rep_id);
CREATE INDEX idx_visits_date ON base_foundation.property_visits (visit_date);

-- ndices para la tabla employee_personal_info
CREATE INDEX idx_employee_info_status ON base_foundation.employee_personal_info (employment_status);
CREATE INDEX idx_employee_info_department ON base_foundation.employee_personal_info (department);
CREATE INDEX idx_employee_info_manager ON base_foundation.employee_personal_info (manager_contact_id);

-- ndices para la tabla employee_emergency_contacts
CREATE INDEX idx_emergency_contacts_employee ON base_foundation.employee_emergency_contacts (contact_id);
CREATE INDEX idx_emergency_contacts_primary ON base_foundation.employee_emergency_contacts (is_primary);

-- ndices para la tabla employee_banking_info
CREATE INDEX idx_banking_info_employee ON base_foundation.employee_banking_info (contact_id);
CREATE INDEX idx_banking_info_verified ON base_foundation.employee_banking_info (verification_status);

-- ndices para la tabla employee_documents
CREATE INDEX idx_employee_docs_employee ON base_foundation.employee_documents (contact_id);
CREATE INDEX idx_employee_docs_type ON base_foundation.employee_documents (document_type);
CREATE INDEX idx_employee_docs_expiration ON base_foundation.employee_documents (expiration_date);

-- ndices para la tabla payroll_records
CREATE INDEX idx_payroll_employee ON base_foundation.payroll_records (contact_id);
CREATE INDEX idx_payroll_period ON base_foundation.payroll_records (pay_period_start, pay_period_end);
CREATE INDEX idx_payroll_pay_date ON base_foundation.payroll_records (pay_date);




-- TABLA: AUDIT_LOG
-- Mdulo: AUDITORA Y TRAZABILIDAD
CREATE TABLE base_foundation.audit_log (
    id BIGSERIAL PRIMARY KEY,
    organization_id INTEGER,
    entity_name VARCHAR(100) NOT NULL,
    entity_id VARCHAR(50) NOT NULL,
    operation_type VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    changed_by_contact_id INTEGER,
    changed_by_user_id INTEGER,
    client_ip_address VARCHAR(45),
    user_agent TEXT,
    old_values JSONB,
    new_values JSONB,
    changed_fields JSONB,
    reason VARCHAR(255),
    session_id VARCHAR(255),
    request_id VARCHAR(100),
    transaction_id VARCHAR(100),
    severity_level VARCHAR(20),
    is_sensitive_data BOOLEAN DEFAULT FALSE,
    compliance_flags JSONB,
    retention_until DATE,
    additional_context JSONB
);

-- Agregar relaciones y llaves forneas (FKs)
ALTER TABLE base_foundation.audit_log ADD CONSTRAINT fk_audit_log_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);
ALTER TABLE base_foundation.audit_log ADD CONSTRAINT fk_audit_log_contact FOREIGN KEY (changed_by_contact_id) REFERENCES base_foundation.contacts(id);
ALTER TABLE base_foundation.audit_log ADD CONSTRAINT fk_audit_log_user FOREIGN KEY (changed_by_user_id) REFERENCES base_foundation.users(id);

-- Creacin de ndices para optimizacin de bsquedas
CREATE INDEX idx_audit_log_org ON base_foundation.audit_log (organization_id);
CREATE INDEX idx_audit_log_entity ON base_foundation.audit_log (entity_name, entity_id);
CREATE INDEX idx_audit_log_operation ON base_foundation.audit_log (operation_type);
CREATE INDEX idx_audit_log_created_at ON base_foundation.audit_log (created_at);


COMMIT;

-- Ejecutar con desde psql, una vez conectdo a orangecore_db

-- \i "C:/Users/duque/OneDrive/Documents/Henry Duque/Orangecore/documentos/1_BASE_FOUNDATION.sql"