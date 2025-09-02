CREATE SCHEMA IF NOT EXISTS emails_enterprise;
SET search_path TO emails_enterprise;


-- TABLA 263: EMAIL_PROVIDERS
-- Configuración de proveedores de email (Gmail, Outlook, etc.).
CREATE TABLE emails_enterprise.email_providers (
    id SERIAL PRIMARY KEY,
    provider_name VARCHAR(50) NOT NULL UNIQUE,
    provider_type VARCHAR(20) NOT NULL,
    api_endpoint VARCHAR(255),
    authentication_type VARCHAR(20) NOT NULL,
    supports_push_notifications BOOLEAN DEFAULT TRUE,
    supports_threading BOOLEAN DEFAULT TRUE,
    configuration JSON,
    rate_limit_per_minute INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Índices para optimización
CREATE INDEX idx_email_providers_type ON emails_enterprise.email_providers (provider_type);
CREATE INDEX idx_email_providers_active ON emails_enterprise.email_providers (is_active);

-- TABLA 264: EMAIL_ACCOUNTS
-- Cuentas de email de la organización.
CREATE TABLE emails_enterprise.email_accounts (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER,
    contact_id INTEGER,
    email_provider_id INTEGER NOT NULL,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    account_name VARCHAR(100),
    account_type VARCHAR(20),
    smtp_server VARCHAR(100),
    smtp_port INTEGER,
    imap_server VARCHAR(100),
    imap_port INTEGER,
    username VARCHAR(100),
    password_encrypted VARCHAR(255),
    oauth_token_encrypted VARCHAR(255),
    oauth_refresh_token_encrypted VARCHAR(255),
    sync_status VARCHAR(20) DEFAULT 'PAUSED',
    last_sync_at TIMESTAMP,
    sync_interval_minutes INTEGER DEFAULT 15,
    auto_assign_enabled BOOLEAN DEFAULT FALSE,
    is_primary BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_email_accounts_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_email_accounts_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_email_accounts_provider FOREIGN KEY (email_provider_id) REFERENCES emails_enterprise.email_providers(id)
);

-- Restricción única para la cuenta principal de un contacto
CREATE UNIQUE INDEX idx_one_primary_account ON emails_enterprise.email_accounts (contact_id) WHERE is_primary = TRUE;

-- Índices para optimización
CREATE INDEX idx_email_accounts_org_status ON emails_enterprise.email_accounts (organization_id, sync_status);
CREATE INDEX idx_email_accounts_contact_primary ON emails_enterprise.email_accounts (contact_id, is_primary);
CREATE INDEX idx_email_accounts_last_sync ON emails_enterprise.email_accounts (last_sync_at);

-- TABLA 265: EMAIL_FOLDERS
-- Estructura de carpetas para las cuentas de email.
CREATE TABLE emails_enterprise.email_folders (
    id SERIAL PRIMARY KEY,
    email_account_id INTEGER NOT NULL,
    folder_name VARCHAR(100) NOT NULL,
    folder_type VARCHAR(20),
    external_folder_id VARCHAR(100),
    parent_folder_id INTEGER,
    folder_path VARCHAR(255),
    message_count INTEGER DEFAULT 0,
    unread_count INTEGER DEFAULT 0,
    last_sync_at TIMESTAMP,
    sync_enabled BOOLEAN DEFAULT TRUE,
    is_system_folder BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(email_account_id, external_folder_id),
    CONSTRAINT fk_email_folders_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id) ON DELETE CASCADE,
    CONSTRAINT fk_email_folders_parent FOREIGN KEY (parent_folder_id) REFERENCES emails_enterprise.email_folders(id)
);

-- Índices para optimización
CREATE INDEX idx_email_folders_account_type ON emails_enterprise.email_folders (email_account_id, folder_type);
CREATE INDEX idx_email_folders_parent ON emails_enterprise.email_folders (parent_folder_id);
CREATE INDEX idx_email_folders_sync ON emails_enterprise.email_folders (sync_enabled);

-- TABLA 266: EMAIL_MESSAGES
-- Almacena los emails importados.
CREATE TABLE emails_enterprise.email_messages (
    id SERIAL PRIMARY KEY,
    email_account_id INTEGER NOT NULL,
    email_folder_id INTEGER,
    message_id VARCHAR(255) NOT NULL,
    thread_id VARCHAR(255),
    subject VARCHAR(500),
    body_text TEXT,
    body_html TEXT,
    from_address VARCHAR(255),
    from_name VARCHAR(255),
    to_addresses JSON,
    cc_addresses JSON,
    bcc_addresses JSON,
    reply_to_address VARCHAR(255),
    sent_at TIMESTAMP,
    received_at TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    is_starred BOOLEAN DEFAULT FALSE,
    is_important BOOLEAN DEFAULT FALSE,
    priority_level VARCHAR(10) DEFAULT 'NORMAL',
    context_type VARCHAR(30),
    context_id INTEGER,
    assigned_to_contact_id INTEGER,
    has_attachments BOOLEAN DEFAULT FALSE,
    attachment_count INTEGER DEFAULT 0,
    metadata JSON,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(email_account_id, message_id),
    CONSTRAINT fk_email_messages_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id),
    CONSTRAINT fk_email_messages_folder FOREIGN KEY (email_folder_id) REFERENCES emails_enterprise.email_folders(id),
    CONSTRAINT fk_email_messages_assignee FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_email_messages_thread ON emails_enterprise.email_messages (email_account_id, thread_id);
CREATE INDEX idx_email_messages_context ON emails_enterprise.email_messages (context_type, context_id);
CREATE INDEX idx_email_messages_assignee ON emails_enterprise.email_messages (assigned_to_contact_id);
CREATE INDEX idx_email_messages_sent ON emails_enterprise.email_messages (sent_at DESC);
CREATE INDEX idx_email_messages_read_received ON emails_enterprise.email_messages (is_read, received_at DESC);

-- TABLA 267: EMAIL_ATTACHMENTS
-- Archivos adjuntos de los emails.
CREATE TABLE emails_enterprise.email_attachments (
    id SERIAL PRIMARY KEY,
    email_message_id INTEGER NOT NULL,
    attachment_name VARCHAR(255) NOT NULL,
    file_url VARCHAR(500),
    s3_key VARCHAR(500),
    s3_bucket VARCHAR(100),
    mime_type VARCHAR(100),
    file_size INTEGER,
    attachment_id VARCHAR(255),
    is_inline BOOLEAN DEFAULT FALSE,
    content_id VARCHAR(255),
    download_status VARCHAR(20) DEFAULT 'PENDING',
    virus_scan_status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(email_message_id, attachment_id),
    CONSTRAINT fk_email_attachments_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id) ON DELETE CASCADE
);

-- Índices para optimización
CREATE INDEX idx_email_attachments_message ON emails_enterprise.email_attachments (email_message_id);
CREATE INDEX idx_email_attachments_download ON emails_enterprise.email_attachments (download_status);
CREATE INDEX idx_email_attachments_size ON emails_enterprise.email_attachments (file_size);

-- TABLA 268: EMAIL_RECIPIENTS
-- Detalle de los destinatarios por email.
CREATE TABLE emails_enterprise.email_recipients (
    id SERIAL PRIMARY KEY,
    email_message_id INTEGER NOT NULL,
    contact_id INTEGER,
    email_address VARCHAR(255) NOT NULL,
    display_name VARCHAR(255),
    recipient_type VARCHAR(5) NOT NULL,
    delivery_status VARCHAR(20) DEFAULT 'PENDING',
    read_status VARCHAR(20) DEFAULT 'UNKNOWN',
    delivered_at TIMESTAMP,
    read_at TIMESTAMP,
    bounce_reason VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(email_message_id, email_address, recipient_type),
    CONSTRAINT fk_email_recipients_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id) ON DELETE CASCADE,
    CONSTRAINT fk_email_recipients_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_email_recipients_message_type ON emails_enterprise.email_recipients (email_message_id, recipient_type);
CREATE INDEX idx_email_recipients_contact ON emails_enterprise.email_recipients (contact_id);
CREATE INDEX idx_email_recipients_delivery ON emails_enterprise.email_recipients (delivery_status);

-- TABLA 269: EMAIL_TEMPLATES
-- Plantillas reutilizables para correos electrónicos.
CREATE TABLE emails_enterprise.email_templates (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    created_by_contact_id INTEGER,
    template_name VARCHAR(100) NOT NULL,
    template_category VARCHAR(30),
    template_subcategory VARCHAR(50),
    subject_line VARCHAR(500),
    body_html TEXT,
    body_text TEXT,
    variables_schema JSON,
    default_variables JSON,
    usage_context VARCHAR(50),
    is_system_template BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    usage_count INTEGER DEFAULT 0,
    last_used_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, template_name),
    CONSTRAINT fk_email_templates_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_email_templates_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_email_templates_org_category ON emails_enterprise.email_templates (organization_id, template_category);
CREATE INDEX idx_email_templates_context ON emails_enterprise.email_templates (usage_context);
CREATE INDEX idx_email_templates_active_usage ON emails_enterprise.email_templates (is_active, usage_count DESC);

-- TABLA 270: EMAIL_TEMPLATE_VARIABLES
-- Variables disponibles para las plantillas.
CREATE TABLE emails_enterprise.email_template_variables (
    id SERIAL PRIMARY KEY,
    variable_name VARCHAR(50) NOT NULL UNIQUE,
    variable_category VARCHAR(30),
    data_type VARCHAR(20),
    data_source_table VARCHAR(50),
    data_source_field VARCHAR(50),
    format_template VARCHAR(100),
    description VARCHAR(255),
    is_required BOOLEAN DEFAULT FALSE,
    default_value VARCHAR(255),
    is_system_variable BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Índices para optimización
CREATE INDEX idx_template_variables_category ON emails_enterprise.email_template_variables (variable_category);
CREATE INDEX idx_template_variables_source_table ON emails_enterprise.email_template_variables (data_source_table);
CREATE INDEX idx_template_variables_system ON emails_enterprise.email_template_variables (is_system_variable);

-- TABLA 271: EMAIL_AUTOMATED_RESPONSES
-- Reglas de auto-respuesta.
CREATE TABLE emails_enterprise.email_automated_responses (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    email_account_id INTEGER,
    rule_name VARCHAR(100) NOT NULL UNIQUE,
    trigger_conditions JSON,
    email_template_id INTEGER NOT NULL,
    response_delay_minutes INTEGER DEFAULT 0,
    active_hours_start TIME,
    active_hours_end TIME,
    active_days VARCHAR(20) DEFAULT 'MON-FRI',
    max_responses_per_thread INTEGER DEFAULT 1,
    is_out_of_office BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_automated_responses_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_automated_responses_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id),
    CONSTRAINT fk_automated_responses_template FOREIGN KEY (email_template_id) REFERENCES emails_enterprise.email_templates(id)
);

-- Índices para optimización
CREATE INDEX idx_automated_responses_account_active ON emails_enterprise.email_automated_responses (email_account_id, is_active);
CREATE INDEX idx_automated_responses_out_of_office ON emails_enterprise.email_automated_responses (is_out_of_office);

-- TABLA 272: EMAIL_CAMPAIGNS
-- Campañas de email masivas.
CREATE TABLE emails_enterprise.email_campaigns (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    created_by_contact_id INTEGER,
    campaign_name VARCHAR(100) NOT NULL,
    campaign_type VARCHAR(30),
    email_template_id INTEGER NOT NULL,
    target_audience_criteria JSON,
    scheduled_send_at TIMESTAMP,
    send_status VARCHAR(20) DEFAULT 'DRAFT',
    total_recipients INTEGER DEFAULT 0,
    emails_sent INTEGER DEFAULT 0,
    emails_delivered INTEGER DEFAULT 0,
    emails_opened INTEGER DEFAULT 0,
    emails_clicked INTEGER DEFAULT 0,
    bounce_count INTEGER DEFAULT 0,
    unsubscribe_count INTEGER DEFAULT 0,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, campaign_name),
    CONSTRAINT fk_email_campaigns_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_email_campaigns_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_email_campaigns_template FOREIGN KEY (email_template_id) REFERENCES emails_enterprise.email_templates(id)
);

-- Índices para optimización
CREATE INDEX idx_email_campaigns_org_status ON emails_enterprise.email_campaigns (organization_id, send_status);
CREATE INDEX idx_email_campaigns_scheduled ON emails_enterprise.email_campaigns (scheduled_send_at);
CREATE INDEX idx_email_campaigns_type ON emails_enterprise.email_campaigns (campaign_type);

-- TABLA 273: EMAIL_ASSIGNMENTS
-- Asignaciones de emails a empleados.
CREATE TABLE emails_enterprise.email_assignments (
    id SERIAL PRIMARY KEY,
    email_message_id INTEGER NOT NULL,
    assigned_to_contact_id INTEGER NOT NULL,
    assigned_by_contact_id INTEGER,
    assignment_type VARCHAR(20),
    assignment_reason VARCHAR(255),
    priority_level VARCHAR(10) DEFAULT 'NORMAL',
    due_date TIMESTAMP,
    status VARCHAR(20) DEFAULT 'PENDING',
    response_required BOOLEAN DEFAULT TRUE,
    completed_at TIMESTAMP,
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(email_message_id, assigned_to_contact_id),
    CONSTRAINT fk_email_assignments_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id),
    CONSTRAINT fk_email_assignments_assignee FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_email_assignments_assigner FOREIGN KEY (assigned_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_email_assignments_assignee_status ON emails_enterprise.email_assignments (assigned_to_contact_id, status);
CREATE INDEX idx_email_assignments_due_date_status ON emails_enterprise.email_assignments (due_date, status);
CREATE INDEX idx_email_assignments_priority ON emails_enterprise.email_assignments (priority_level);

-- TABLA 274: EMAIL_THREADS
-- Hilos de conversación de emails.
CREATE TABLE emails_enterprise.email_threads (
    id SERIAL PRIMARY KEY,
    thread_id VARCHAR(255) NOT NULL UNIQUE,
    organization_id INTEGER,
    subject_line VARCHAR(500),
    context_type VARCHAR(30),
    context_id INTEGER,
    participants JSON,
    message_count INTEGER DEFAULT 0,
    last_message_at TIMESTAMP,
    last_activity_contact_id INTEGER,
    is_archived BOOLEAN DEFAULT FALSE,
    is_important BOOLEAN DEFAULT FALSE,
    assigned_to_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_email_threads_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_email_threads_last_contact FOREIGN KEY (last_activity_contact_id) REFERENCES base_foundation.contacts(id),
    CONSTRAINT fk_email_threads_assignee FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_email_threads_context ON emails_enterprise.email_threads (context_type, context_id);
CREATE INDEX idx_email_threads_assignee ON emails_enterprise.email_threads (assigned_to_contact_id, is_archived);
CREATE INDEX idx_email_threads_last_message ON emails_enterprise.email_threads (last_message_at DESC);

-- TABLA 275: EMAIL_LABELS
-- Etiquetas personalizadas para organizar emails.
CREATE TABLE emails_enterprise.email_labels (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    label_name VARCHAR(50) NOT NULL,
    label_color VARCHAR(7),
    label_category VARCHAR(30),
    description VARCHAR(255),
    is_system_label BOOLEAN DEFAULT FALSE,
    created_by_contact_id INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, label_name),
    CONSTRAINT fk_email_labels_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_email_labels_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_email_labels_org_category ON emails_enterprise.email_labels (organization_id, label_category);
CREATE INDEX idx_email_labels_system ON emails_enterprise.email_labels (is_system_label);

-- TABLA 276: EMAIL_TRACKING_PIXELS
-- Rastrea las aperturas de emails.
CREATE TABLE emails_enterprise.email_tracking_pixels (
    id SERIAL PRIMARY KEY,
    email_message_id INTEGER NOT NULL,
    recipient_email VARCHAR(255) NOT NULL,
    tracking_token VARCHAR(255),
    pixel_url VARCHAR(500),
    opened_at TIMESTAMP,
    open_count INTEGER DEFAULT 0,
    device_info VARCHAR(255),
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    CONSTRAINT fk_tracking_pixels_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id)
);

-- Índices para optimización
CREATE INDEX idx_tracking_pixels_message ON emails_enterprise.email_tracking_pixels (email_message_id);
CREATE INDEX idx_tracking_pixels_token ON emails_enterprise.email_tracking_pixels (tracking_token);
CREATE INDEX idx_tracking_pixels_opened ON emails_enterprise.email_tracking_pixels (opened_at);

-- TABLA 277: EMAIL_LINK_CLICKS
-- Rastrea los clics en enlaces de emails.
CREATE TABLE emails_enterprise.email_link_clicks (
    id SERIAL PRIMARY KEY,
    email_message_id INTEGER NOT NULL,
    recipient_email VARCHAR(255) NOT NULL,
    original_url TEXT,
    clicked_url TEXT,
    click_timestamp TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    device_info VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Índices para optimización
CREATE INDEX idx_link_clicks_message ON emails_enterprise.email_link_clicks (email_message_id);
CREATE INDEX idx_link_clicks_recipient ON emails_enterprise.email_link_clicks (recipient_email);
CREATE INDEX idx_link_clicks_timestamp ON emails_enterprise.email_link_clicks (click_timestamp);

-- TABLA 278: EMAIL_DELIVERY_STATUS
-- Estado de entrega de emails a nivel de destinatario.
CREATE TABLE emails_enterprise.email_delivery_status (
    id SERIAL PRIMARY KEY,
    email_message_id INTEGER NOT NULL,
    recipient_email VARCHAR(255) NOT NULL,
    delivery_status VARCHAR(20) DEFAULT 'PENDING',
    status_details TEXT,
    delivery_timestamp TIMESTAMP,
    bounce_type VARCHAR(30),
    bounce_reason TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(email_message_id, recipient_email)
);

-- Índices para optimización
CREATE INDEX idx_delivery_status_message ON emails_enterprise.email_delivery_status (email_message_id);
CREATE INDEX idx_delivery_status_status ON emails_enterprise.email_delivery_status (delivery_status);
CREATE INDEX idx_delivery_status_timestamp ON emails_enterprise.email_delivery_status (delivery_timestamp);

-- TABLA 279: EMAIL_PERFORMANCE_METRICS
-- Métricas de rendimiento de emails por día.
CREATE TABLE emails_enterprise.email_performance_metrics (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    email_account_id INTEGER,
    contact_id INTEGER,
    metric_date DATE NOT NULL,
    emails_sent INTEGER DEFAULT 0,
    emails_received INTEGER DEFAULT 0,
    emails_opened INTEGER DEFAULT 0,
    replies_sent INTEGER DEFAULT 0,
    assigned_count INTEGER DEFAULT 0,
    completed_assignments INTEGER DEFAULT 0,
    average_response_time_minutes DECIMAL(6,2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, email_account_id, contact_id, metric_date),
    CONSTRAINT fk_metrics_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id),
    CONSTRAINT fk_metrics_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id),
    CONSTRAINT fk_metrics_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id)
);

-- Índices para optimización
CREATE INDEX idx_metrics_org_date ON emails_enterprise.email_performance_metrics (organization_id, metric_date DESC);
CREATE INDEX idx_metrics_account_date ON emails_enterprise.email_performance_metrics (email_account_id, metric_date DESC);
CREATE INDEX idx_metrics_contact_date ON emails_enterprise.email_performance_metrics (contact_id, metric_date DESC);

