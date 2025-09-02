CREATE SCHEMA IF NOT EXISTS scheduling_weather;
SET search_path TO scheduling_weather;


-- TABLA 249: APPOINTMENT_TYPES
-- Define los tipos de citas disponibles.
CREATE TABLE scheduling_weather.appointment_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(30),
    priority_level INTEGER,
    estimated_duration_hours DECIMAL(4,2),
    required_skills VARCHAR(500),
    requires_equipment BOOLEAN DEFAULT FALSE,
    allows_overlap BOOLEAN DEFAULT FALSE,
    buffer_time_before VARCHAR(20),
    buffer_time_after VARCHAR(20),
    is_billable BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Índices para optimización
CREATE INDEX idx_appointment_types_category ON scheduling_weather.appointment_types (category);
CREATE INDEX idx_appointment_types_priority ON scheduling_weather.appointment_types (priority_level);

-- TABLA 250: APPOINTMENTS
-- Tabla principal para citas programadas.
CREATE TABLE scheduling_weather.appointments (
    id SERIAL PRIMARY KEY,
    appointment_type_id INTEGER NOT NULL,
    customer_project_id INTEGER,
    customer_job_id INTEGER,
    property_id INTEGER,
    customer_contact_id INTEGER,
    title VARCHAR(200),
    description TEXT,
    appointment_date DATE,
    start_time TIME,
    end_time TIME,
    estimated_duration_hours DECIMAL(4,2),
    priority VARCHAR(20),
    status VARCHAR(30) DEFAULT 'SCHEDULED',
    confirmation_method VARCHAR(20),
    customer_confirmed BOOLEAN DEFAULT FALSE,
    customer_confirmed_at TIMESTAMP,
    special_instructions TEXT,
    access_instructions TEXT,
    created_by_contact_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_appointments_type FOREIGN KEY (appointment_type_id) REFERENCES scheduling_weather.appointment_types(id),
    CONSTRAINT fk_appointments_project FOREIGN KEY (customer_project_id) REFERENCES base_foundation.customer_projects(id),
    CONSTRAINT fk_appointments_job FOREIGN KEY (customer_job_id) REFERENCES base_foundation.customer_jobs(id),
    CONSTRAINT fk_appointments_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id),
    CONSTRAINT fk_appointments_customer FOREIGN KEY (customer_contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_appointments_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_appointments_date_time ON scheduling_weather.appointments (appointment_date, start_time);
CREATE INDEX idx_appointments_customer ON scheduling_weather.appointments (customer_contact_id);
CREATE INDEX idx_appointments_property ON scheduling_weather.appointments (property_id);
CREATE INDEX idx_appointments_status ON scheduling_weather.appointments (status);

-- TABLA 251: APPOINTMENT_ATTENDEES
-- Asigna técnicos o empleados a una cita.
CREATE TABLE scheduling_weather.appointment_attendees (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL,
    contact_id INTEGER NOT NULL,
    role VARCHAR(30),
    is_primary BOOLEAN DEFAULT FALSE,
    estimated_arrival_time TIME,
    actual_arrival_time TIME,
    departure_time TIME,
    billable_hours DECIMAL(4,2),
    billable_rate_override DECIMAL(8,2),
    assignment_status VARCHAR(20) DEFAULT 'ASSIGNED',
    assigned_at TIMESTAMP,
    responded_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_attendees_appointment FOREIGN KEY (appointment_id) REFERENCES scheduling_weather.appointments(id),
    CONSTRAINT fk_attendees_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id)
);

-- Restricción única para el técnico principal
CREATE UNIQUE INDEX idx_one_primary_attendee ON scheduling_weather.appointment_attendees(appointment_id) WHERE is_primary = TRUE;

-- Índices para optimización
CREATE INDEX idx_attendees_appointment ON scheduling_weather.appointment_attendees (appointment_id);
CREATE INDEX idx_attendees_contact ON scheduling_weather.appointment_attendees (contact_id);
CREATE INDEX idx_attendees_date_status ON scheduling_weather.appointment_attendees (assignment_status, assigned_at);

-- TABLA 252: APPOINTMENT_EQUIPMENT
-- Gestiona el equipo necesario para una cita.
CREATE TABLE scheduling_weather.appointment_equipment (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL,
    equipment_type VARCHAR(50),
    equipment_identifier VARCHAR(50),
    quantity_required INTEGER,
    pickup_time TIME,
    return_time TIME,
    assignment_status VARCHAR(20) DEFAULT 'RESERVED',
    assigned_to_contact_id INTEGER,
    pickup_location VARCHAR(100),
    return_location VARCHAR(100),
    condition_notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(equipment_identifier, appointment_id),
    CONSTRAINT fk_equipment_appointment FOREIGN KEY (appointment_id) REFERENCES scheduling_weather.appointments(id),
    CONSTRAINT fk_equipment_contact FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_appointment_equipment_type ON scheduling_weather.appointment_equipment (equipment_type);
CREATE INDEX idx_appointment_equipment_status ON scheduling_weather.appointment_equipment (assignment_status);
CREATE INDEX idx_appointment_equipment_contact ON scheduling_weather.appointment_equipment (assigned_to_contact_id);

-- TABLA 253: APPOINTMENT_CONFLICTS
-- Registra los conflictos de programación.
CREATE TABLE scheduling_weather.appointment_conflicts (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL,
    conflicting_appointment_id INTEGER,
    conflict_type VARCHAR(30),
    conflict_severity VARCHAR(20),
    conflict_description TEXT,
    resolution_action VARCHAR(30),
    is_resolved BOOLEAN DEFAULT FALSE,
    resolved_by_contact_id INTEGER,
    detected_at TIMESTAMP,
    resolved_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_conflicts_appointment FOREIGN KEY (appointment_id) REFERENCES scheduling_weather.appointments(id),
    CONSTRAINT fk_conflicts_conflicting_appointment FOREIGN KEY (conflicting_appointment_id) REFERENCES scheduling_weather.appointments(id),
    CONSTRAINT fk_conflicts_resolver FOREIGN KEY (resolved_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_conflicts_appointment ON scheduling_weather.appointment_conflicts (appointment_id);
CREATE INDEX idx_conflicts_unresolved ON scheduling_weather.appointment_conflicts (is_resolved, detected_at);
CREATE INDEX idx_conflicts_type ON scheduling_weather.appointment_conflicts (conflict_type);

-- TABLA 254: APPOINTMENT_HISTORY
-- Rastrea todos los cambios en las citas.
CREATE TABLE scheduling_weather.appointment_history (
    id SERIAL PRIMARY KEY,
    appointment_id INTEGER NOT NULL,
    change_type VARCHAR(30),
    previous_value TEXT,
    new_value TEXT,
    change_reason VARCHAR(200),
    changed_by_contact_id INTEGER,
    change_timestamp TIMESTAMP,
    is_customer_notified BOOLEAN DEFAULT FALSE,
    notification_method VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_history_appointment FOREIGN KEY (appointment_id) REFERENCES scheduling_weather.appointments(id),
    CONSTRAINT fk_history_changer FOREIGN KEY (changed_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_history_appointment ON scheduling_weather.appointment_history (appointment_id);
CREATE INDEX idx_history_timestamp ON scheduling_weather.appointment_history (change_timestamp);
CREATE INDEX idx_history_change_type ON scheduling_weather.appointment_history (change_type);

-- TABLA 255: TECHNICIAN_SKILLS
-- Almacena las habilidades y certificaciones de los técnicos.
CREATE TABLE scheduling_weather.technician_skills (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    skill_name VARCHAR(50) NOT NULL,
    skill_level VARCHAR(20),
    certification_number VARCHAR(50),
    certification_authority VARCHAR(100),
    certification_date DATE,
    expiration_date DATE,
    is_verified BOOLEAN DEFAULT FALSE,
    verified_by_contact_id INTEGER,
    verification_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(contact_id, skill_name),
    CONSTRAINT fk_skills_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_skills_verifier FOREIGN KEY (verified_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_skills_contact ON scheduling_weather.technician_skills (contact_id);
CREATE INDEX idx_skills_name ON scheduling_weather.technician_skills (skill_name);
CREATE INDEX idx_skills_level ON scheduling_weather.technician_skills (skill_level);
CREATE INDEX idx_skills_expiration ON scheduling_weather.technician_skills (expiration_date);

-- TABLA 256: TECHNICIAN_AVAILABILITY
-- Configura la disponibilidad de los técnicos.
CREATE TABLE scheduling_weather.technician_availability (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    day_of_week VARCHAR(10),
    start_time TIME,
    end_time TIME,
    is_available BOOLEAN DEFAULT TRUE,
    max_appointments_per_day INTEGER,
    max_travel_distance_miles DECIMAL(6,2),
    preferred_appointment_types VARCHAR(200),
    overtime_willing BOOLEAN DEFAULT FALSE,
    emergency_available BOOLEAN DEFAULT FALSE,
    effective_start_date DATE,
    effective_end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(contact_id, day_of_week, effective_start_date),
    CONSTRAINT fk_availability_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_availability_contact ON scheduling_weather.technician_availability (contact_id);
CREATE INDEX idx_availability_day ON scheduling_weather.technician_availability (day_of_week);
CREATE INDEX idx_availability_active ON scheduling_weather.technician_availability (is_active, effective_start_date);

-- TABLA 257: TECHNICIAN_LOCATIONS
-- Rastrea las ubicaciones de los técnicos en tiempo real.
CREATE TABLE scheduling_weather.technician_locations (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL,
    location_type VARCHAR(20),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    address VARCHAR(255),
    location_timestamp TIMESTAMP,
    accuracy_meters DECIMAL(8,2),
    speed_mph DECIMAL(6,2),
    heading_degrees DECIMAL(6,2),
    battery_level_percent INTEGER,
    is_on_duty BOOLEAN DEFAULT TRUE,
    current_appointment_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_locations_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_locations_appointment FOREIGN KEY (current_appointment_id) REFERENCES scheduling_weather.appointments(id)
);

-- Índices para optimización
CREATE INDEX idx_locations_contact ON scheduling_weather.technician_locations (contact_id);
CREATE INDEX idx_locations_timestamp ON scheduling_weather.technician_locations (location_timestamp);
CREATE INDEX idx_locations_type ON scheduling_weather.technician_locations (location_type);
CREATE INDEX idx_locations_coords ON scheduling_weather.technician_locations (latitude, longitude);

-- TABLA 258: ROUTE_OPTIMIZATIONS
-- Almacena las rutas optimizadas para los técnicos.
CREATE TABLE scheduling_weather.route_optimizations (
    id SERIAL PRIMARY KEY,
    technician_contact_id INTEGER NOT NULL,
    route_date DATE,
    optimized_sequence VARCHAR(1000),
    total_travel_time_hours DECIMAL(4,2),
    total_drive_distance_miles DECIMAL(6,2),
    optimization_algorithm VARCHAR(30),
    start_location_lat DECIMAL(10,8),
    start_location_lng DECIMAL(11,8),
    end_location_lat DECIMAL(10,8),
    end_location_lng DECIMAL(11,8),
    calculated_at TIMESTAMP,
    is_active_route BOOLEAN DEFAULT FALSE,
    route_status VARCHAR(20) DEFAULT 'OPTIMIZED',
    fuel_cost_estimate DECIMAL(8,2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_routes_technician FOREIGN KEY (technician_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Restricción única para la ruta activa
CREATE UNIQUE INDEX idx_one_active_route ON scheduling_weather.route_optimizations(technician_contact_id, route_date) WHERE is_active_route = TRUE;

-- Índices para optimización
CREATE INDEX idx_routes_technician_date ON scheduling_weather.route_optimizations (technician_contact_id, route_date);
CREATE INDEX idx_routes_active ON scheduling_weather.route_optimizations (is_active_route);
CREATE INDEX idx_routes_status ON scheduling_weather.route_optimizations (route_status);

-- TABLA 259: TRAVEL_TIME_CACHE
-- Almacena tiempos de viaje calculados para su re-utilización.
CREATE TABLE scheduling_weather.travel_time_cache (
    id SERIAL PRIMARY KEY,
    origin_latitude DECIMAL(10,8),
    origin_longitude DECIMAL(11,8),
    destination_latitude DECIMAL(10,8),
    destination_longitude DECIMAL(11,8),
    travel_time_minutes DECIMAL(6,2),
    travel_distance_miles DECIMAL(8,2),
    traffic_condition VARCHAR(20),
    time_of_day TIME,
    day_type VARCHAR(20),
    api_source VARCHAR(20),
    cache_timestamp TIMESTAMP,
    cache_expires_at TIMESTAMP,
    is_valid BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(origin_latitude, origin_longitude, destination_latitude, destination_longitude, time_of_day, day_type)
);

-- Índices para optimización
CREATE INDEX idx_travel_cache_origin ON scheduling_weather.travel_time_cache (origin_latitude, origin_longitude);
CREATE INDEX idx_travel_cache_destination ON scheduling_weather.travel_time_cache (destination_latitude, destination_longitude);
CREATE INDEX idx_travel_cache_expiry ON scheduling_weather.travel_time_cache (cache_expires_at);

-- TABLA 260: WEATHER_FORECASTS
-- Almacena pronósticos meteorológicos por ubicación.
CREATE TABLE scheduling_weather.weather_forecasts (
    id SERIAL PRIMARY KEY,
    property_id INTEGER,
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    forecast_date DATE,
    forecast_time TIME,
    temperature_high_f DECIMAL(5,2),
    temperature_low_f DECIMAL(5,2),
    current_temperature_f DECIMAL(5,2),
    rain_probability_percent DECIMAL(5,2),
    wind_speed_mph DECIMAL(5,2),
    wind_direction VARCHAR(5),
    conditions VARCHAR(20),
    humidity_percent DECIMAL(5,2),
    uv_index DECIMAL(3,1),
    api_source VARCHAR(20),
    raw_api_response JSON,
    fetched_at TIMESTAMP,
    is_suitable_for_roof_work BOOLEAN,
    is_suitable_for_exterior_work BOOLEAN,
    is_suitable_for_equipment_setup BOOLEAN,
    weather_risk_score DECIMAL(3,1),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(property_id, forecast_date, forecast_time),
    CONSTRAINT fk_weather_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id)
);

-- Índices para optimización
CREATE INDEX idx_weather_property_date ON scheduling_weather.weather_forecasts (property_id, forecast_date);
CREATE INDEX idx_weather_suitable_roof ON scheduling_weather.weather_forecasts (is_suitable_for_roof_work);
CREATE INDEX idx_weather_risk_score ON scheduling_weather.weather_forecasts (weather_risk_score);

-- TABLA 261: WEATHER_ALERTS
-- Registra alertas meteorológicas para áreas afectadas.
CREATE TABLE scheduling_weather.weather_alerts (
    id SERIAL PRIMARY KEY,
    alert_type VARCHAR(30),
    severity_level VARCHAR(20),
    affected_zip_codes VARCHAR(500),
    alert_start_time TIMESTAMP,
    alert_end_time TIMESTAMP,
    alert_description TEXT,
    recommended_actions TEXT,
    auto_reschedule_enabled BOOLEAN DEFAULT FALSE,
    notification_sent BOOLEAN DEFAULT FALSE,
    appointments_affected_count INTEGER,
    api_source VARCHAR(20),
    alert_id_external VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(alert_id_external, api_source)
);

-- Índices para optimización
CREATE INDEX idx_weather_alerts_time ON scheduling_weather.weather_alerts (alert_start_time, alert_end_time);
CREATE INDEX idx_weather_alerts_severity ON scheduling_weather.weather_alerts (severity_level);
CREATE INDEX idx_weather_alerts_active ON scheduling_weather.weather_alerts (alert_end_time) WHERE alert_end_time > NOW();

-- TABLA 262: WEATHER_IMPACT_RULES
-- Define las reglas de negocio basadas en el clima.
CREATE TABLE scheduling_weather.weather_impact_rules (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(100),
    appointment_type_id INTEGER,
    weather_condition VARCHAR(30),
    threshold_value DECIMAL(8,2),
    threshold_operator VARCHAR(10),
    recommended_action VARCHAR(30),
    auto_apply BOOLEAN DEFAULT FALSE,
    requires_approval BOOLEAN DEFAULT TRUE,
    notification_template VARCHAR(200),
    is_active BOOLEAN DEFAULT TRUE,
    priority_order INTEGER,
    effective_start_date DATE,
    effective_end_date DATE,
    created_by_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(appointment_type_id, weather_condition, threshold_value),
    CONSTRAINT fk_rules_appointment_type FOREIGN KEY (appointment_type_id) REFERENCES scheduling_weather.appointment_types(id),
    CONSTRAINT fk_rules_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_weather_rules_active ON scheduling_weather.weather_impact_rules (is_active, priority_order);
CREATE INDEX idx_weather_rules_type ON scheduling_weather.weather_impact_rules (appointment_type_id);
CREATE INDEX idx_weather_rules_condition ON scheduling_weather.weather_impact_rules (weather_condition);


