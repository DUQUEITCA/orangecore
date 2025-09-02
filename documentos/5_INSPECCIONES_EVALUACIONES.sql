SET search_path TO base_foundation;

CREATE TABLE base_foundation.customer_projects (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER,
    project_name VARCHAR(200) NOT NULL,
    project_status VARCHAR(30) NOT NULL DEFAULT 'IN_PROGRESS',
    client_contact_id INTEGER,
    address VARCHAR(255),
    city VARCHAR(100),
    zip_code VARCHAR(20),
    start_date DATE,
    end_date DATE,
    estimated_cost DECIMAL(12, 2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_customer_projects_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_customer_projects_client FOREIGN KEY (client_contact_id) REFERENCES base_foundation.contacts(id)
);


CREATE SCHEMA IF NOT EXISTS inspecciones_evaluaciones;
SET search_path TO inspecciones_evaluaciones;

-- TABLA: IICRC_STANDARDS [cite: 2, 3]
CREATE TABLE inspecciones_evaluaciones.iicrc_standards (
    id SERIAL PRIMARY KEY,
    standard_code VARCHAR(10) UNIQUE NOT NULL,
    standard_name VARCHAR(100) NOT NULL,
    description TEXT,
    applicable_damage_types VARCHAR(100),
    requirements JSON,
    procedures JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: INSPECTION_TYPES [cite: 1, 2]
CREATE TABLE inspecciones_evaluaciones.inspection_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    description TEXT,
    iicrc_standard_id INTEGER,
    required_fields JSON,
    optional_fields JSON,
    requires_equipment_readings BOOLEAN DEFAULT FALSE,
    requires_moisture_mapping BOOLEAN DEFAULT FALSE,
    requires_content_inventory BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(name, category),
    CONSTRAINT fk_inspection_types_standard FOREIGN KEY (iicrc_standard_id) REFERENCES inspecciones_evaluaciones.iicrc_standards(id)
);

-- TABLA: DAMAGE_TYPES [cite: 8, 9]
CREATE TABLE inspecciones_evaluaciones.damage_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(30),
    description TEXT,
    severity_scale VARCHAR(50),
    assessment_criteria JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: WATER_DAMAGE_CATEGORIES [cite: 11, 12]
CREATE TABLE inspecciones_evaluaciones.water_damage_categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(20) NOT NULL,
    category_level VARCHAR(10) UNIQUE NOT NULL,
    description TEXT,
    source_description VARCHAR(255),
    safety_requirements JSON,
    drying_procedures JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: EQUIPMENT_TYPES [cite: 12, 13]
CREATE TABLE inspecciones_evaluaciones.equipment_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,
    description TEXT,
    manufacturer VARCHAR(50),
    model_number VARCHAR(50),
    specifications JSON,
    reading_units VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(name, category)
);

-- TABLA: CONTENT_CATEGORIES [cite: 21, 22]
CREATE TABLE inspecciones_evaluaciones.content_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    requires_detailed_photos BOOLEAN DEFAULT FALSE,
    typical_salvage_rate_percent DECIMAL(5,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA: SERVICE_CATEGORIES [cite: 36, 37]
CREATE TABLE inspecciones_evaluaciones.service_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    category_type VARCHAR(30),
    description TEXT,
    typical_duration_days INTEGER,
    requires_certification BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- 
-- TABLA: INSPECTIONS [cite: 4, 5, 6]
CREATE TABLE inspecciones_evaluaciones.inspections (
    id SERIAL PRIMARY KEY,
    customer_project_id INTEGER,
    inspection_type_id INTEGER NOT NULL,
    iicrc_standard_id INTEGER,
    inspector_contact_id INTEGER,
    inspection_status VARCHAR(30) DEFAULT 'Scheduled',
    inspection_date DATE,
    start_time TIME,
    end_time TIME,
    general_notes TEXT,
    weather_conditions JSON,
    safety_concerns VARCHAR(255),
    requires_follow_up BOOLEAN DEFAULT FALSE,
    follow_up_date DATE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_inspections_project FOREIGN KEY (customer_project_id) REFERENCES base_foundation.customer_projects(id),
    CONSTRAINT fk_inspections_type FOREIGN KEY (inspection_type_id) REFERENCES inspecciones_evaluaciones.inspection_types(id),
    CONSTRAINT fk_inspections_standard FOREIGN KEY (iicrc_standard_id) REFERENCES inspecciones_evaluaciones.iicrc_standards(id),
    CONSTRAINT fk_inspections_inspector FOREIGN KEY (inspector_contact_id) REFERENCES base_foundation.contacts(id)
);

-- TABLA: INSPECTION_AREAS [cite: 6, 7, 8]
CREATE TABLE inspecciones_evaluaciones.inspection_areas (
    id SERIAL PRIMARY KEY,
    inspection_id INTEGER NOT NULL,
    area_name VARCHAR(100),
    area_type VARCHAR(50),
    location_description VARCHAR(255),
    area_measurements JSON,
    access_restrictions VARCHAR(255),
    area_notes TEXT,
    order_sequence INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_inspection_areas_inspection FOREIGN KEY (inspection_id) REFERENCES inspecciones_evaluaciones.inspections(id)
);