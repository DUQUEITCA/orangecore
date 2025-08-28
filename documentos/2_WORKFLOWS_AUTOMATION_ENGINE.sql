-- PARTE 1: Creación del esquema y tablas con PKs y restricciones de columna
-- ==================================================================================================================================================================
-- TODO O NADA
BEGIN;

-- Creamos el esquema si aún no existe
CREATE SCHEMA IF NOT EXISTS workflows_automation_engine;

-- Establecemos el path de búsqueda para no tener que prefijar cada tabla
SET search_path TO workflows_automation_engine;

-- TABLA 76: WORKFLOW_DEFINITIONS
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.workflow_definitions (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER,
    workflow_name VARCHAR(100) NOT NULL,
    workflow_description TEXT,
    workflow_category VARCHAR(50),
    trigger_type VARCHAR(30),
    trigger_config JSON,
    is_active BOOLEAN DEFAULT TRUE,
    is_system_workflow BOOLEAN DEFAULT FALSE,
    execution_priority INTEGER,
    max_concurrent_executions INTEGER,
    timeout_minutes INTEGER,
    created_by_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, workflow_name)
);

-- TABLA 77: WORKFLOW_STEPS
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.workflow_steps (
    id SERIAL PRIMARY KEY,
    workflow_definition_id INTEGER NOT NULL,
    step_name VARCHAR(100),
    step_order INTEGER,
    step_type VARCHAR(50),
    step_config JSON,
    parent_step_id INTEGER,
    condition_expression TEXT,
    ai_model_id INTEGER,
    retry_strategy VARCHAR(30),
    max_retries INTEGER DEFAULT 3,
    timeout_minutes INTEGER,
    is_parallel BOOLEAN DEFAULT FALSE,
    success_criteria JSON,
    failure_handling VARCHAR(30),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(workflow_definition_id, step_order)
);

-- TABLA 78: WORKFLOW_EXECUTIONS
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.workflow_executions (
    id SERIAL PRIMARY KEY,
    workflow_definition_id INTEGER NOT NULL,
    execution_key VARCHAR(100),
    context_table VARCHAR(50),
    context_id INTEGER,
    triggered_by VARCHAR(30),
    triggered_by_contact_id INTEGER,
    execution_status VARCHAR(30),
    current_step_id INTEGER,
    execution_data JSON,
    ai_optimization_applied BOOLEAN DEFAULT FALSE,
    performance_metrics JSON,
    error_details JSON,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    estimated_completion_at TIMESTAMP,
    total_duration_minutes DECIMAL(8,2),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(execution_key)
);

-- TABLA 79: WORKFLOW_VARIABLES
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.workflow_variables (
    id SERIAL PRIMARY KEY,
    workflow_execution_id INTEGER NOT NULL,
    variable_name VARCHAR(100),
    variable_type VARCHAR(20),
    variable_value TEXT,
    variable_scope VARCHAR(20),
    is_input BOOLEAN DEFAULT FALSE,
    is_output BOOLEAN DEFAULT FALSE,
    is_ai_generated BOOLEAN DEFAULT FALSE,
    ai_confidence_score DECIMAL(5,2),
    source_step_id INTEGER,
    encryption_required BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(workflow_execution_id, variable_name)
);

-- TABLA 80: WORKFLOW_SCHEDULES
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.workflow_schedules (
    id SERIAL PRIMARY KEY,
    workflow_definition_id INTEGER NOT NULL,
    schedule_name VARCHAR(100),
    schedule_type VARCHAR(20),
    cron_expression VARCHAR(100),
    interval_minutes INTEGER,
    ai_optimization_enabled BOOLEAN DEFAULT FALSE,
    optimal_execution_times JSON,
    timezone VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    next_execution_at TIMESTAMP,
    last_execution_at TIMESTAMP,
    total_scheduled_executions INTEGER DEFAULT 0,
    max_executions INTEGER,
    performance_metrics JSON,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA 81: WORKFLOW_TEMPLATES
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.workflow_templates (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER,
    template_name VARCHAR(100),
    template_category VARCHAR(50),
    template_description TEXT,
    industry_specific BOOLEAN DEFAULT FALSE,
    template_config JSON,
    usage_count INTEGER DEFAULT 0,
    success_rate DECIMAL(5,2),
    ai_recommendation_score DECIMAL(5,2),
    customization_complexity VARCHAR(20),
    estimated_setup_time_minutes INTEGER,
    estimated_roi_percentage DECIMAL(5,2),
    created_by_contact_id INTEGER,
    is_public BOOLEAN DEFAULT FALSE,
    rating_average DECIMAL(3,2),
    total_ratings INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA 82: BUSINESS_RULES
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.business_rules (
    id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    rule_name VARCHAR(100) NOT NULL,
    rule_category VARCHAR(50),
    rule_type VARCHAR(30),
    rule_expression TEXT,
    ai_enhanced BOOLEAN DEFAULT FALSE,
    rule_priority INTEGER,
    applies_to_table VARCHAR(50),
    applies_to_conditions JSON,
    action_on_true VARCHAR(100),
    action_on_false VARCHAR(100),
    related_workflow_id INTEGER,
    success_rate DECIMAL(5,2),
    false_positive_rate DECIMAL(5,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_by_contact_id INTEGER,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(organization_id, rule_name)
);

-- TABLA 83: RULE_CONDITIONS
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.rule_conditions (
    id SERIAL PRIMARY KEY,
    business_rule_id INTEGER NOT NULL,
    condition_order INTEGER,
    condition_type VARCHAR(30),
    field_name VARCHAR(50),
    operator VARCHAR(20),
    expected_value VARCHAR(255),
    ai_model_id INTEGER,
    weight DECIMAL(5,2),
    logical_operator VARCHAR(10),
    external_api_config JSON,
    calculation_formula TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- TABLA 84: RULE_EXECUTIONS
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.rule_executions (
    id SERIAL PRIMARY KEY,
    business_rule_id INTEGER NOT NULL,
    context_table VARCHAR(50),
    context_id INTEGER,
    rule_result BOOLEAN,
    ai_confidence_score DECIMAL(5,2),
    execution_details JSON,
    action_taken VARCHAR(100),
    execution_time_ms DECIMAL(8,2),
    ai_override_applied BOOLEAN DEFAULT FALSE,
    human_feedback VARCHAR(20),
    error_message TEXT,
    workflow_execution_id INTEGER,
    executed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- TABLA 85: RULE_ACTIONS
-- Módulo: WORKFLOWS & AUTOMATION ENGINE + AI
CREATE TABLE workflows_automation_engine.rule_actions (
    id SERIAL PRIMARY KEY,
    business_rule_id INTEGER NOT NULL,
    action_order INTEGER,
    action_type VARCHAR(50),
    action_config JSON,
    ai_optimized_parameters JSON,
    success_rate DECIMAL(5,2),
    conditions_for_execution JSON,
    retry_on_failure BOOLEAN DEFAULT FALSE,
    max_retries INTEGER DEFAULT 0,
    is_async BOOLEAN DEFAULT FALSE,
    timeout_seconds INTEGER,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- PARTE 2: Definición de Claves Foráneas
-- ==================================================================================================================================================================

-- FKs para WORKFLOW_DEFINITIONS
ALTER TABLE workflows_automation_engine.workflow_definitions
ADD CONSTRAINT fk_workflow_definitions_organization
FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);

ALTER TABLE workflows_automation_engine.workflow_definitions
ADD CONSTRAINT fk_workflow_definitions_created_by_contact
FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);

-- FKs para WORKFLOW_STEPS
ALTER TABLE workflows_automation_engine.workflow_steps
ADD CONSTRAINT fk_workflow_steps_definition
FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);

ALTER TABLE workflows_automation_engine.workflow_steps
ADD CONSTRAINT fk_workflow_steps_parent_step
FOREIGN KEY (parent_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);

-- FKs para WORKFLOW_EXECUTIONS
ALTER TABLE workflows_automation_engine.workflow_executions
ADD CONSTRAINT fk_workflow_executions_definition
FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);

ALTER TABLE workflows_automation_engine.workflow_executions
ADD CONSTRAINT fk_workflow_executions_triggered_by_contact
FOREIGN KEY (triggered_by_contact_id) REFERENCES base_foundation.contacts(id);

ALTER TABLE workflows_automation_engine.workflow_executions
ADD CONSTRAINT fk_workflow_executions_current_step
FOREIGN KEY (current_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);

-- FKs para WORKFLOW_VARIABLES
ALTER TABLE workflows_automation_engine.workflow_variables
ADD CONSTRAINT fk_workflow_variables_execution
FOREIGN KEY (workflow_execution_id) REFERENCES workflows_automation_engine.workflow_executions(id);

ALTER TABLE workflows_automation_engine.workflow_variables
ADD CONSTRAINT fk_workflow_variables_source_step
FOREIGN KEY (source_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);

-- FKs para WORKFLOW_SCHEDULES
ALTER TABLE workflows_automation_engine.workflow_schedules
ADD CONSTRAINT fk_workflow_schedules_definition
FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);

-- FKs para WORKFLOW_TEMPLATES
ALTER TABLE workflows_automation_engine.workflow_templates
ADD CONSTRAINT fk_workflow_templates_organization
FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);

ALTER TABLE workflows_automation_engine.workflow_templates
ADD CONSTRAINT fk_workflow_templates_created_by_contact
FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);

-- FKs para BUSINESS_RULES
ALTER TABLE workflows_automation_engine.business_rules
ADD CONSTRAINT fk_business_rules_organization
FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);

ALTER TABLE workflows_automation_engine.business_rules
ADD CONSTRAINT fk_business_rules_related_workflow
FOREIGN KEY (related_workflow_id) REFERENCES workflows_automation_engine.workflow_definitions(id);

ALTER TABLE workflows_automation_engine.business_rules
ADD CONSTRAINT fk_business_rules_created_by_contact
FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);

-- FKs para RULE_CONDITIONS
ALTER TABLE workflows_automation_engine.rule_conditions
ADD CONSTRAINT fk_rule_conditions_business_rule
FOREIGN KEY (business_rule_id) REFERENCES workflows_automation_engine.business_rules(id);

-- FKs para RULE_EXECUTIONS
ALTER TABLE workflows_automation_engine.rule_executions
ADD CONSTRAINT fk_rule_executions_business_rule
FOREIGN KEY (business_rule_id) REFERENCES workflows_automation_engine.business_rules(id);

ALTER TABLE workflows_automation_engine.rule_executions
ADD CONSTRAINT fk_rule_executions_workflow_execution
FOREIGN KEY (workflow_execution_id) REFERENCES workflows_automation_engine.workflow_executions(id);

-- FKs para RULE_ACTIONS
ALTER TABLE workflows_automation_engine.rule_actions
ADD CONSTRAINT fk_rule_actions_business_rule
FOREIGN KEY (business_rule_id) REFERENCES workflows_automation_engine.business_rules(id);

-- PARTE 3: Creación de Índices
-- ==================================================================================================================================================================

-- Índices para WORKFLOW_DEFINITIONS
CREATE INDEX idx_workflow_definitions_org_active ON workflows_automation_engine.workflow_definitions (organization_id, is_active);
CREATE INDEX idx_workflow_definitions_category ON workflows_automation_engine.workflow_definitions (workflow_category);
CREATE INDEX idx_workflow_definitions_trigger_type ON workflows_automation_engine.workflow_definitions (trigger_type);

-- Índices para WORKFLOW_STEPS
CREATE INDEX idx_workflow_steps_def_order ON workflows_automation_engine.workflow_steps (workflow_definition_id, step_order);
CREATE INDEX idx_workflow_steps_type ON workflows_automation_engine.workflow_steps (step_type);
-- Nota: La referencia a ML_MODELS no está en el archivo adjunto, por lo que no se crea el índice.

-- Índices para WORKFLOW_EXECUTIONS
CREATE INDEX idx_workflow_executions_def_status ON workflows_automation_engine.workflow_executions (workflow_definition_id, execution_status);
CREATE INDEX idx_workflow_executions_context ON workflows_automation_engine.workflow_executions (context_table, context_id);
CREATE INDEX idx_workflow_executions_status_started ON workflows_automation_engine.workflow_executions (execution_status, started_at);

-- Índices para WORKFLOW_VARIABLES
CREATE INDEX idx_workflow_variables_exec_scope ON workflows_automation_engine.workflow_variables (workflow_execution_id, variable_scope);
CREATE INDEX idx_workflow_variables_ai_gen ON workflows_automation_engine.workflow_variables (is_ai_generated);
CREATE INDEX idx_workflow_variables_type ON workflows_automation_engine.workflow_variables (variable_type);

-- Índices para WORKFLOW_SCHEDULES
CREATE INDEX idx_workflow_schedules_next_active ON workflows_automation_engine.workflow_schedules (next_execution_at, is_active);
CREATE INDEX idx_workflow_schedules_def ON workflows_automation_engine.workflow_schedules (workflow_definition_id);
CREATE INDEX idx_workflow_schedules_type ON workflows_automation_engine.workflow_schedules (schedule_type);

-- Índices para WORKFLOW_TEMPLATES
CREATE INDEX idx_workflow_templates_cat_ai ON workflows_automation_engine.workflow_templates (template_category, ai_recommendation_score);
CREATE INDEX idx_workflow_templates_industry_public ON workflows_automation_engine.workflow_templates (industry_specific, is_public);
CREATE INDEX idx_workflow_templates_usage_success ON workflows_automation_engine.workflow_templates (usage_count, success_rate);

-- Índices para BUSINESS_RULES
CREATE INDEX idx_business_rules_org_active ON workflows_automation_engine.business_rules (organization_id, is_active);
CREATE INDEX idx_business_rules_applies_to ON workflows_automation_engine.business_rules (applies_to_table);
CREATE INDEX idx_business_rules_priority ON workflows_automation_engine.business_rules (rule_priority);

-- Índices para RULE_CONDITIONS
CREATE INDEX idx_rule_conditions_rule_order ON workflows_automation_engine.rule_conditions (business_rule_id, condition_order);
CREATE INDEX idx_rule_conditions_type ON workflows_automation_engine.rule_conditions (condition_type);
-- Nota: La referencia a ML_MODELS no está en el archivo adjunto, por lo que no se crea el índice.

-- Índices para RULE_EXECUTIONS
CREATE INDEX idx_rule_executions_rule_executed ON workflows_automation_engine.rule_executions (business_rule_id, executed_at);
CREATE INDEX idx_rule_executions_context ON workflows_automation_engine.rule_executions (context_table, context_id);
CREATE INDEX idx_rule_executions_result_confidence ON workflows_automation_engine.rule_executions (rule_result, ai_confidence_score);

-- Índices para RULE_ACTIONS
CREATE INDEX idx_rule_actions_rule_order ON workflows_automation_engine.rule_actions (business_rule_id, action_order);
CREATE INDEX idx_rule_actions_type ON workflows_automation_engine.rule_actions (action_type);
CREATE INDEX idx_rule_actions_success_rate ON workflows_automation_engine.rule_actions (success_rate);


COMMIT;