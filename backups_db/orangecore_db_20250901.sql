--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: base_foundation; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA base_foundation;


ALTER SCHEMA base_foundation OWNER TO postgres;

--
-- Name: chat_enterprise_agora; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA chat_enterprise_agora;


ALTER SCHEMA chat_enterprise_agora OWNER TO postgres;

--
-- Name: documentos_file_management; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA documentos_file_management;


ALTER SCHEMA documentos_file_management OWNER TO postgres;

--
-- Name: emails_enterprise; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA emails_enterprise;


ALTER SCHEMA emails_enterprise OWNER TO postgres;

--
-- Name: finanzas_bookkeeping; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA finanzas_bookkeeping;


ALTER SCHEMA finanzas_bookkeeping OWNER TO postgres;

--
-- Name: inspecciones_evaluaciones; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA inspecciones_evaluaciones;


ALTER SCHEMA inspecciones_evaluaciones OWNER TO postgres;

--
-- Name: notas_comunicacion; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA notas_comunicacion;


ALTER SCHEMA notas_comunicacion OWNER TO postgres;

--
-- Name: notifications_system_enterprise; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA notifications_system_enterprise;


ALTER SCHEMA notifications_system_enterprise OWNER TO postgres;

--
-- Name: reports_business_intelligence; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA reports_business_intelligence;


ALTER SCHEMA reports_business_intelligence OWNER TO postgres;

--
-- Name: scheduling_weather; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA scheduling_weather;


ALTER SCHEMA scheduling_weather OWNER TO postgres;

--
-- Name: task_management; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA task_management;


ALTER SCHEMA task_management OWNER TO postgres;

--
-- Name: workflows_automation_engine; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA workflows_automation_engine;


ALTER SCHEMA workflows_automation_engine OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.audit_log (
    id bigint NOT NULL,
    organization_id integer,
    entity_name character varying(100) NOT NULL,
    entity_id character varying(50) NOT NULL,
    operation_type character varying(10) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    changed_by_contact_id integer,
    changed_by_user_id integer,
    client_ip_address character varying(45),
    user_agent text,
    old_values jsonb,
    new_values jsonb,
    changed_fields jsonb,
    reason character varying(255),
    session_id character varying(255),
    request_id character varying(100),
    transaction_id character varying(100),
    severity_level character varying(20),
    is_sensitive_data boolean DEFAULT false,
    compliance_flags jsonb,
    retention_until date,
    additional_context jsonb
);


ALTER TABLE base_foundation.audit_log OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.audit_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.audit_log_id_seq OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.audit_log_id_seq OWNED BY base_foundation.audit_log.id;


--
-- Name: avatars; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.avatars (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    url character varying(500) NOT NULL,
    file_name character varying(255),
    file_size integer,
    mime_type character varying(100),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.avatars OWNER TO postgres;

--
-- Name: avatars_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.avatars_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.avatars_id_seq OWNER TO postgres;

--
-- Name: avatars_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.avatars_id_seq OWNED BY base_foundation.avatars.id;


--
-- Name: companies; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.companies (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    company_name character varying(200),
    founded_date date,
    tax_id character varying(20),
    legal_entity_type character varying(50),
    industry character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.companies OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.companies_id_seq OWNER TO postgres;

--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.companies_id_seq OWNED BY base_foundation.companies.id;


--
-- Name: contact_organization_roles; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.contact_organization_roles (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    organization_id integer NOT NULL,
    role_id integer NOT NULL,
    is_active boolean DEFAULT true,
    assigned_at timestamp without time zone DEFAULT now(),
    assigned_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.contact_organization_roles OWNER TO postgres;

--
-- Name: contact_organization_roles_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.contact_organization_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.contact_organization_roles_id_seq OWNER TO postgres;

--
-- Name: contact_organization_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.contact_organization_roles_id_seq OWNED BY base_foundation.contact_organization_roles.id;


--
-- Name: contacts; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.contacts (
    id integer NOT NULL,
    is_company boolean DEFAULT false,
    name character varying(100) NOT NULL,
    last_name character varying(100),
    full_name character varying(200),
    lead_status_id integer,
    lead_source_id integer,
    assigned_salesperson_id integer,
    created_at timestamp without time zone DEFAULT now(),
    created_by character varying(50),
    updated_at timestamp without time zone DEFAULT now(),
    updated_by character varying(50)
);


ALTER TABLE base_foundation.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.contacts_id_seq OWNED BY base_foundation.contacts.id;


--
-- Name: customer_projects; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.customer_projects (
    id integer NOT NULL,
    organization_id integer,
    project_name character varying(200) NOT NULL,
    project_status character varying(30) DEFAULT 'IN_PROGRESS'::character varying NOT NULL,
    client_contact_id integer,
    address character varying(255),
    city character varying(100),
    zip_code character varying(20),
    start_date date,
    end_date date,
    estimated_cost numeric(12,2),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.customer_projects OWNER TO postgres;

--
-- Name: customer_projects_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.customer_projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.customer_projects_id_seq OWNER TO postgres;

--
-- Name: customer_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.customer_projects_id_seq OWNED BY base_foundation.customer_projects.id;


--
-- Name: emails; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.emails (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    email character varying(100) NOT NULL,
    is_main boolean DEFAULT false,
    is_verified boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.emails OWNER TO postgres;

--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.emails_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.emails_id_seq OWNER TO postgres;

--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.emails_id_seq OWNED BY base_foundation.emails.id;


--
-- Name: employee_banking_info; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.employee_banking_info (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    account_type character varying(20),
    bank_name character varying(100),
    routing_number character varying(20),
    account_number character varying(50),
    account_holder_name character varying(100),
    is_active boolean DEFAULT true,
    verification_status character varying(20),
    verified_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.employee_banking_info OWNER TO postgres;

--
-- Name: employee_banking_info_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.employee_banking_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.employee_banking_info_id_seq OWNER TO postgres;

--
-- Name: employee_banking_info_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.employee_banking_info_id_seq OWNED BY base_foundation.employee_banking_info.id;


--
-- Name: employee_documents; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.employee_documents (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    document_type character varying(50),
    document_name character varying(255),
    file_url character varying(500),
    file_name character varying(255),
    file_size integer,
    mime_type character varying(100),
    expiration_date date,
    is_required boolean DEFAULT false,
    approval_status character varying(20),
    approved_by_contact_id integer,
    approved_at timestamp without time zone,
    uploaded_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.employee_documents OWNER TO postgres;

--
-- Name: employee_documents_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.employee_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.employee_documents_id_seq OWNER TO postgres;

--
-- Name: employee_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.employee_documents_id_seq OWNED BY base_foundation.employee_documents.id;


--
-- Name: employee_emergency_contacts; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.employee_emergency_contacts (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    emergency_contact_name character varying(100),
    relationship character varying(50),
    phone_primary character varying(20),
    phone_secondary character varying(20),
    email character varying(100),
    address character varying(500),
    is_primary boolean DEFAULT false,
    notes text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.employee_emergency_contacts OWNER TO postgres;

--
-- Name: employee_emergency_contacts_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.employee_emergency_contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.employee_emergency_contacts_id_seq OWNER TO postgres;

--
-- Name: employee_emergency_contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.employee_emergency_contacts_id_seq OWNED BY base_foundation.employee_emergency_contacts.id;


--
-- Name: employee_personal_info; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.employee_personal_info (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    employee_id character varying(20) NOT NULL,
    hire_date date,
    employment_status character varying(30),
    employment_type character varying(30),
    department character varying(100),
    job_title character varying(100),
    manager_contact_id integer,
    work_location character varying(255),
    marital_status character varying(20),
    number_of_dependents integer DEFAULT 0,
    veteran_status boolean DEFAULT false,
    disability_status character varying(50),
    preferred_language character varying(30),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.employee_personal_info OWNER TO postgres;

--
-- Name: employee_personal_info_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.employee_personal_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.employee_personal_info_id_seq OWNER TO postgres;

--
-- Name: employee_personal_info_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.employee_personal_info_id_seq OWNED BY base_foundation.employee_personal_info.id;


--
-- Name: lead_sources; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.lead_sources (
    id integer NOT NULL,
    organization_id integer,
    source_name character varying(100) NOT NULL,
    source_category character varying(50),
    cost_per_lead numeric(8,2),
    conversion_rate numeric(5,2),
    is_active boolean DEFAULT true,
    tracking_url character varying(500),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.lead_sources OWNER TO postgres;

--
-- Name: lead_sources_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.lead_sources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.lead_sources_id_seq OWNER TO postgres;

--
-- Name: lead_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.lead_sources_id_seq OWNED BY base_foundation.lead_sources.id;


--
-- Name: lead_statuses; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.lead_statuses (
    id integer NOT NULL,
    organization_id integer,
    status_name character varying(50) NOT NULL,
    status_order integer,
    status_color character varying(7),
    is_final_status boolean DEFAULT false,
    conversion_probability numeric(5,2),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.lead_statuses OWNER TO postgres;

--
-- Name: lead_statuses_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.lead_statuses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.lead_statuses_id_seq OWNER TO postgres;

--
-- Name: lead_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.lead_statuses_id_seq OWNED BY base_foundation.lead_statuses.id;


--
-- Name: organization_integrations; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.organization_integrations (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    integration_type character varying(50) NOT NULL,
    api_key character varying(255),
    api_secret character varying(255),
    config_json jsonb,
    is_active boolean DEFAULT true,
    last_sync_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.organization_integrations OWNER TO postgres;

--
-- Name: organization_integrations_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.organization_integrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.organization_integrations_id_seq OWNER TO postgres;

--
-- Name: organization_integrations_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.organization_integrations_id_seq OWNED BY base_foundation.organization_integrations.id;


--
-- Name: organization_settings; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.organization_settings (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value text,
    setting_type character varying(50),
    description text,
    is_encrypted boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.organization_settings OWNER TO postgres;

--
-- Name: organization_settings_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.organization_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.organization_settings_id_seq OWNER TO postgres;

--
-- Name: organization_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.organization_settings_id_seq OWNED BY base_foundation.organization_settings.id;


--
-- Name: organizations; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.organizations (
    id integer NOT NULL,
    parent_id integer,
    name character varying(100) NOT NULL,
    organization_type character varying(50),
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    city character varying(100),
    state character varying(50),
    zip_code character varying(20),
    country character varying(50),
    phone character varying(20),
    email character varying(100),
    website character varying(255),
    industry character varying(100),
    tax_id character varying(50),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.organizations OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.organizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.organizations_id_seq OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.organizations_id_seq OWNED BY base_foundation.organizations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.password_reset_tokens (
    id integer NOT NULL,
    user_id integer NOT NULL,
    token character varying(255) NOT NULL,
    expires_at timestamp without time zone,
    used_at timestamp without time zone,
    ip_address character varying(45),
    user_agent text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.password_reset_tokens OWNER TO postgres;

--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.password_reset_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.password_reset_tokens_id_seq OWNER TO postgres;

--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.password_reset_tokens_id_seq OWNED BY base_foundation.password_reset_tokens.id;


--
-- Name: payroll_deductions; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.payroll_deductions (
    id integer NOT NULL,
    payroll_record_id integer NOT NULL,
    deduction_type character varying(50),
    deduction_name character varying(100),
    deduction_amount numeric(8,2),
    is_pre_tax boolean DEFAULT false,
    employer_contribution numeric(8,2)
);


ALTER TABLE base_foundation.payroll_deductions OWNER TO postgres;

--
-- Name: payroll_deductions_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.payroll_deductions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.payroll_deductions_id_seq OWNER TO postgres;

--
-- Name: payroll_deductions_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.payroll_deductions_id_seq OWNED BY base_foundation.payroll_deductions.id;


--
-- Name: payroll_records; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.payroll_records (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    pay_period_start date,
    pay_period_end date,
    pay_date date,
    gross_pay numeric(10,2),
    regular_hours numeric(6,2),
    overtime_hours numeric(6,2),
    regular_rate numeric(8,2),
    overtime_rate numeric(8,2),
    commission_amount numeric(10,2),
    bonus_amount numeric(10,2),
    total_deductions numeric(10,2),
    net_pay numeric(10,2),
    pay_method character varying(20),
    payroll_batch_id character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.payroll_records OWNER TO postgres;

--
-- Name: payroll_records_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.payroll_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.payroll_records_id_seq OWNER TO postgres;

--
-- Name: payroll_records_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.payroll_records_id_seq OWNED BY base_foundation.payroll_records.id;


--
-- Name: persons; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.persons (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    gender character varying(30),
    birth_date date,
    tax_id character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.persons OWNER TO postgres;

--
-- Name: persons_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.persons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.persons_id_seq OWNER TO postgres;

--
-- Name: persons_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.persons_id_seq OWNED BY base_foundation.persons.id;


--
-- Name: phones; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.phones (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    country_code character varying(10),
    phone_number character varying(20) NOT NULL,
    extension character varying(10),
    is_main boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.phones OWNER TO postgres;

--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.phones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.phones_id_seq OWNER TO postgres;

--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.phones_id_seq OWNED BY base_foundation.phones.id;


--
-- Name: properties; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.properties (
    id integer NOT NULL,
    place_id character varying(255),
    address_line_1 character varying(255),
    address_line_2 character varying(255),
    city character varying(100),
    state character varying(50),
    zip_code character varying(20),
    country character varying(50),
    latitude numeric(10,8),
    longitude numeric(11,8),
    property_type character varying(50),
    year_built integer,
    square_footage integer,
    lot_size numeric(10,2),
    bedrooms integer,
    bathrooms numeric(3,1),
    stories integer,
    roof_material character varying(50),
    roof_age integer,
    construction_type character varying(50),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.properties OWNER TO postgres;

--
-- Name: properties_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.properties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.properties_id_seq OWNER TO postgres;

--
-- Name: properties_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.properties_id_seq OWNED BY base_foundation.properties.id;


--
-- Name: property_batch_data; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.property_batch_data (
    id integer NOT NULL,
    property_id integer NOT NULL,
    owner_name character varying(200),
    owner_mailing_address character varying(500),
    assessed_value numeric(12,2),
    market_value numeric(12,2),
    tax_amount numeric(10,2),
    deed_date date,
    sales_price numeric(12,2),
    sales_date date,
    mortgage_amount numeric(12,2),
    mortgage_lender character varying(200),
    property_use_code character varying(20),
    last_updated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.property_batch_data OWNER TO postgres;

--
-- Name: property_batch_data_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.property_batch_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.property_batch_data_id_seq OWNER TO postgres;

--
-- Name: property_batch_data_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.property_batch_data_id_seq OWNED BY base_foundation.property_batch_data.id;


--
-- Name: property_images; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.property_images (
    id integer NOT NULL,
    property_id integer NOT NULL,
    image_url character varying(500),
    image_type character varying(50),
    description text,
    taken_at timestamp without time zone,
    taken_by_contact_id integer,
    file_size integer,
    mime_type character varying(100),
    is_primary boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.property_images OWNER TO postgres;

--
-- Name: property_images_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.property_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.property_images_id_seq OWNER TO postgres;

--
-- Name: property_images_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.property_images_id_seq OWNED BY base_foundation.property_images.id;


--
-- Name: property_notes; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.property_notes (
    id integer NOT NULL,
    property_id integer NOT NULL,
    note_text text,
    note_type character varying(50),
    is_important boolean DEFAULT false,
    is_visible_to_customer boolean DEFAULT false,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.property_notes OWNER TO postgres;

--
-- Name: property_notes_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.property_notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.property_notes_id_seq OWNER TO postgres;

--
-- Name: property_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.property_notes_id_seq OWNED BY base_foundation.property_notes.id;


--
-- Name: property_visits; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.property_visits (
    id integer NOT NULL,
    property_id integer NOT NULL,
    contact_id integer NOT NULL,
    sales_rep_id integer NOT NULL,
    visit_type character varying(50),
    visit_date timestamp without time zone,
    visit_duration_minutes integer,
    outcome character varying(50),
    notes text,
    gps_latitude numeric(10,8),
    gps_longitude numeric(11,8),
    weather_conditions character varying(100),
    follow_up_date date,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.property_visits OWNER TO postgres;

--
-- Name: property_visits_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.property_visits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.property_visits_id_seq OWNER TO postgres;

--
-- Name: property_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.property_visits_id_seq OWNED BY base_foundation.property_visits.id;


--
-- Name: role_types; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.role_types (
    id integer NOT NULL,
    role_name character varying(50) NOT NULL,
    description text,
    permissions_json jsonb,
    is_system_role boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.role_types OWNER TO postgres;

--
-- Name: role_types_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.role_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.role_types_id_seq OWNER TO postgres;

--
-- Name: role_types_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.role_types_id_seq OWNED BY base_foundation.role_types.id;


--
-- Name: roles; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.roles (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    role_type_id integer NOT NULL,
    role_name character varying(100) NOT NULL,
    custom_permissions_json jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.roles_id_seq OWNED BY base_foundation.roles.id;


--
-- Name: user_sessions; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.user_sessions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    session_token character varying(255) NOT NULL,
    ip_address character varying(45),
    user_agent text,
    expires_at timestamp without time zone,
    is_active boolean DEFAULT true,
    last_activity_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.user_sessions OWNER TO postgres;

--
-- Name: user_sessions_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.user_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.user_sessions_id_seq OWNER TO postgres;

--
-- Name: user_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.user_sessions_id_seq OWNED BY base_foundation.user_sessions.id;


--
-- Name: users; Type: TABLE; Schema: base_foundation; Owner: postgres
--

CREATE TABLE base_foundation.users (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    is_email_verified boolean DEFAULT false,
    is_active boolean DEFAULT true,
    last_login_at timestamp without time zone,
    failed_login_attempts integer DEFAULT 0,
    account_locked_until timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE base_foundation.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: base_foundation; Owner: postgres
--

CREATE SEQUENCE base_foundation.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE base_foundation.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: base_foundation; Owner: postgres
--

ALTER SEQUENCE base_foundation.users_id_seq OWNED BY base_foundation.users.id;


--
-- Name: ai_agent_conversations; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.ai_agent_conversations (
    id integer NOT NULL,
    ai_agent_id integer NOT NULL,
    chat_channel_id integer,
    user_contact_id integer NOT NULL,
    conversation_start_message_id integer,
    conversation_status character varying(20),
    conversation_topic character varying(100),
    context_data json,
    user_satisfaction_score numeric(3,2),
    resolution_type character varying(30),
    escalated_to_contact_id integer,
    total_messages integer DEFAULT 0,
    ai_response_time_avg numeric(6,2),
    started_at timestamp without time zone DEFAULT now(),
    ended_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.ai_agent_conversations OWNER TO postgres;

--
-- Name: ai_agent_conversations_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.ai_agent_conversations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.ai_agent_conversations_id_seq OWNER TO postgres;

--
-- Name: ai_agent_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.ai_agent_conversations_id_seq OWNED BY chat_enterprise_agora.ai_agent_conversations.id;


--
-- Name: ai_agent_training_sessions; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.ai_agent_training_sessions (
    id integer NOT NULL,
    ai_agent_id integer NOT NULL,
    training_type character varying(30),
    training_data json,
    training_source character varying(50),
    conversation_id integer,
    feedback_type character varying(30),
    feedback_details text,
    trainer_contact_id integer,
    training_effectiveness numeric(5,2),
    applied_at timestamp without time zone,
    model_version_before character varying(50),
    model_version_after character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.ai_agent_training_sessions OWNER TO postgres;

--
-- Name: ai_agent_training_sessions_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.ai_agent_training_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.ai_agent_training_sessions_id_seq OWNER TO postgres;

--
-- Name: ai_agent_training_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.ai_agent_training_sessions_id_seq OWNED BY chat_enterprise_agora.ai_agent_training_sessions.id;


--
-- Name: ai_chat_agents; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.ai_chat_agents (
    id integer NOT NULL,
    agent_name character varying(100) NOT NULL,
    agent_type character varying(30),
    organization_id integer,
    personality_config json,
    capabilities json,
    training_data_source character varying(100),
    language_support json,
    response_style character varying(50),
    confidence_threshold numeric(5,2),
    is_active boolean DEFAULT true,
    learning_enabled boolean DEFAULT true,
    max_context_messages integer DEFAULT 50,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.ai_chat_agents OWNER TO postgres;

--
-- Name: ai_chat_agents_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.ai_chat_agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.ai_chat_agents_id_seq OWNER TO postgres;

--
-- Name: ai_chat_agents_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.ai_chat_agents_id_seq OWNED BY chat_enterprise_agora.ai_chat_agents.id;


--
-- Name: chat_attachments; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_attachments (
    id integer NOT NULL,
    chat_message_id integer NOT NULL,
    file_name character varying(255),
    file_url character varying(500),
    file_type character varying(50),
    file_size_bytes bigint,
    mime_type character varying(100),
    thumbnail_url character varying(500),
    is_encrypted boolean DEFAULT false,
    encryption_key character varying(255),
    upload_status character varying(20) DEFAULT 'PENDING'::character varying,
    virus_scan_status character varying(20) DEFAULT 'PENDING'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_attachments OWNER TO postgres;

--
-- Name: chat_attachments_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_attachments_id_seq OWNER TO postgres;

--
-- Name: chat_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_attachments_id_seq OWNED BY chat_enterprise_agora.chat_attachments.id;


--
-- Name: chat_channel_members; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_channel_members (
    id integer NOT NULL,
    chat_channel_id integer NOT NULL,
    contact_id integer NOT NULL,
    member_role character varying(20),
    can_add_members boolean DEFAULT false,
    can_delete_messages boolean DEFAULT false,
    can_moderate boolean DEFAULT false,
    is_muted boolean DEFAULT false,
    joined_at timestamp without time zone,
    last_read_at timestamp without time zone,
    is_active boolean DEFAULT true,
    notification_level character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_channel_members OWNER TO postgres;

--
-- Name: chat_channel_members_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_channel_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_channel_members_id_seq OWNER TO postgres;

--
-- Name: chat_channel_members_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_channel_members_id_seq OWNED BY chat_enterprise_agora.chat_channel_members.id;


--
-- Name: chat_channel_types; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_channel_types (
    id integer NOT NULL,
    type_name character varying(50) NOT NULL,
    display_name character varying(100),
    description text,
    default_permissions json,
    max_members integer,
    supports_ai_agents boolean DEFAULT false,
    supports_video_calls boolean DEFAULT true,
    is_system_type boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_channel_types OWNER TO postgres;

--
-- Name: chat_channel_types_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_channel_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_channel_types_id_seq OWNER TO postgres;

--
-- Name: chat_channel_types_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_channel_types_id_seq OWNED BY chat_enterprise_agora.chat_channel_types.id;


--
-- Name: chat_channels; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_channels (
    id integer NOT NULL,
    organization_id integer,
    channel_name character varying(100) NOT NULL,
    channel_type character varying(20) NOT NULL,
    description text,
    created_by_contact_id integer,
    is_archived boolean DEFAULT false,
    channel_avatar_url character varying(500),
    channel_settings json,
    ai_agent_enabled boolean DEFAULT false,
    ai_agent_type character varying(30),
    signalr_group_id character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_channels OWNER TO postgres;

--
-- Name: chat_channels_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_channels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_channels_id_seq OWNER TO postgres;

--
-- Name: chat_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_channels_id_seq OWNED BY chat_enterprise_agora.chat_channels.id;


--
-- Name: chat_mentions; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_mentions (
    id integer NOT NULL,
    chat_message_id integer NOT NULL,
    mentioned_contact_id integer NOT NULL,
    mention_type character varying(20),
    mention_text character varying(100),
    notification_sent boolean DEFAULT false,
    notification_read boolean DEFAULT false,
    read_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_mentions OWNER TO postgres;

--
-- Name: chat_mentions_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_mentions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_mentions_id_seq OWNER TO postgres;

--
-- Name: chat_mentions_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_mentions_id_seq OWNED BY chat_enterprise_agora.chat_mentions.id;


--
-- Name: chat_message_reactions; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_message_reactions (
    id integer NOT NULL,
    chat_message_id integer NOT NULL,
    contact_id integer NOT NULL,
    reaction_type character varying(50) NOT NULL,
    emoji_code character varying(20),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_message_reactions OWNER TO postgres;

--
-- Name: chat_message_reactions_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_message_reactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_message_reactions_id_seq OWNER TO postgres;

--
-- Name: chat_message_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_message_reactions_id_seq OWNED BY chat_enterprise_agora.chat_message_reactions.id;


--
-- Name: chat_message_threads; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_message_threads (
    id integer NOT NULL,
    parent_message_id integer NOT NULL,
    thread_message_id integer NOT NULL,
    thread_level integer DEFAULT 1,
    thread_position integer,
    is_thread_starter boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_message_threads OWNER TO postgres;

--
-- Name: chat_message_threads_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_message_threads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_message_threads_id_seq OWNER TO postgres;

--
-- Name: chat_message_threads_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_message_threads_id_seq OWNED BY chat_enterprise_agora.chat_message_threads.id;


--
-- Name: chat_messages; Type: TABLE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE TABLE chat_enterprise_agora.chat_messages (
    id integer NOT NULL,
    chat_channel_id integer NOT NULL,
    sender_contact_id integer,
    sender_type character varying(20),
    message_type character varying(30),
    message_content text,
    original_language character varying(5),
    translated_content json,
    voice_note_url character varying(500),
    voice_transcript text,
    voice_duration_seconds numeric(6,2),
    replied_to_message_id integer,
    is_edited boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    edited_at timestamp without time zone,
    deleted_at timestamp without time zone,
    ai_confidence numeric(5,2),
    signalr_message_id character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE chat_enterprise_agora.chat_messages OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE SEQUENCE chat_enterprise_agora.chat_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE chat_enterprise_agora.chat_messages_id_seq OWNER TO postgres;

--
-- Name: chat_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER SEQUENCE chat_enterprise_agora.chat_messages_id_seq OWNED BY chat_enterprise_agora.chat_messages.id;


--
-- Name: document_access_log; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_access_log (
    id integer NOT NULL,
    document_id integer NOT NULL,
    accessed_by_contact_id integer,
    access_type character varying(20) NOT NULL,
    access_method character varying(30),
    ip_address character varying(45),
    user_agent character varying(500),
    session_id character varying(255),
    share_token character varying(255),
    access_granted boolean DEFAULT true,
    denial_reason character varying(255),
    accessed_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_access_log OWNER TO postgres;

--
-- Name: document_access_log_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_access_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_access_log_id_seq OWNER TO postgres;

--
-- Name: document_access_log_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_access_log_id_seq OWNED BY documentos_file_management.document_access_log.id;


--
-- Name: document_folder_assignments; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_folder_assignments (
    id integer NOT NULL,
    document_id integer NOT NULL,
    folder_id integer NOT NULL,
    assigned_by_contact_id integer,
    assignment_reason character varying(100),
    is_primary_location boolean DEFAULT true,
    assigned_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_folder_assignments OWNER TO postgres;

--
-- Name: document_folder_assignments_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_folder_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_folder_assignments_id_seq OWNER TO postgres;

--
-- Name: document_folder_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_folder_assignments_id_seq OWNED BY documentos_file_management.document_folder_assignments.id;


--
-- Name: document_folders; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_folders (
    id integer NOT NULL,
    organization_id integer,
    parent_folder_id integer,
    folder_name character varying(100) NOT NULL,
    folder_path character varying(500) NOT NULL,
    folder_type character varying(30),
    related_entity_type character varying(30),
    related_entity_id integer,
    is_system_folder boolean DEFAULT false,
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_folders OWNER TO postgres;

--
-- Name: document_folders_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_folders_id_seq OWNER TO postgres;

--
-- Name: document_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_folders_id_seq OWNED BY documentos_file_management.document_folders.id;


--
-- Name: document_ocr_results; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_ocr_results (
    id integer NOT NULL,
    document_id integer NOT NULL,
    ocr_provider character varying(30) NOT NULL,
    extracted_text text,
    confidence_score numeric(5,2),
    processing_status character varying(20) DEFAULT 'Processing'::character varying NOT NULL,
    structured_data json,
    key_value_pairs json,
    processing_time_ms integer,
    error_message text,
    processed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_ocr_results OWNER TO postgres;

--
-- Name: document_ocr_results_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_ocr_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_ocr_results_id_seq OWNER TO postgres;

--
-- Name: document_ocr_results_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_ocr_results_id_seq OWNED BY documentos_file_management.document_ocr_results.id;


--
-- Name: document_permissions; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_permissions (
    id integer NOT NULL,
    document_id integer NOT NULL,
    grantee_type character varying(20) NOT NULL,
    grantee_id integer NOT NULL,
    permission_level character varying(20) NOT NULL,
    granted_by_contact_id integer,
    granted_at timestamp without time zone DEFAULT now(),
    expires_at timestamp without time zone,
    is_inherited boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_permissions OWNER TO postgres;

--
-- Name: document_permissions_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_permissions_id_seq OWNER TO postgres;

--
-- Name: document_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_permissions_id_seq OWNED BY documentos_file_management.document_permissions.id;


--
-- Name: document_reviews; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_reviews (
    id integer NOT NULL,
    document_id integer NOT NULL,
    reviewer_contact_id integer,
    review_type character varying(30) NOT NULL,
    review_status character varying(20) DEFAULT 'Pending'::character varying,
    priority_level character varying(20) DEFAULT 'Medium'::character varying,
    due_date date,
    review_comments text,
    approved_at timestamp without time zone,
    rejected_at timestamp without time zone,
    rejection_reason text,
    assigned_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_reviews OWNER TO postgres;

--
-- Name: document_reviews_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_reviews_id_seq OWNER TO postgres;

--
-- Name: document_reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_reviews_id_seq OWNED BY documentos_file_management.document_reviews.id;


--
-- Name: document_shares; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_shares (
    id integer NOT NULL,
    document_id integer NOT NULL,
    shared_by_contact_id integer,
    share_type character varying(20) NOT NULL,
    share_token character varying(255) NOT NULL,
    recipient_email character varying(255),
    access_level character varying(20),
    requires_password boolean DEFAULT false,
    password_hash character varying(255),
    expires_at timestamp without time zone,
    max_downloads integer,
    download_count integer DEFAULT 0,
    last_accessed_at timestamp without time zone,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_shares OWNER TO postgres;

--
-- Name: document_shares_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_shares_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_shares_id_seq OWNER TO postgres;

--
-- Name: document_shares_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_shares_id_seq OWNED BY documentos_file_management.document_shares.id;


--
-- Name: document_tags; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_tags (
    id integer NOT NULL,
    document_id integer NOT NULL,
    tag_name character varying(50) NOT NULL,
    tag_category character varying(30),
    tag_color character varying(7),
    created_by_contact_id integer,
    is_system_tag boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_tags OWNER TO postgres;

--
-- Name: document_tags_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_tags_id_seq OWNER TO postgres;

--
-- Name: document_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_tags_id_seq OWNED BY documentos_file_management.document_tags.id;


--
-- Name: document_types; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category character varying(30) NOT NULL,
    description text,
    requires_approval boolean DEFAULT false,
    retention_days integer,
    allowed_file_types character varying(255),
    max_file_size_mb integer,
    is_confidential boolean DEFAULT false,
    auto_ocr_enabled boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_types OWNER TO postgres;

--
-- Name: document_types_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_types_id_seq OWNER TO postgres;

--
-- Name: document_types_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_types_id_seq OWNED BY documentos_file_management.document_types.id;


--
-- Name: document_versions; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.document_versions (
    id integer NOT NULL,
    document_id integer NOT NULL,
    version_number character varying(10) NOT NULL,
    version_description character varying(255),
    file_path character varying(500) NOT NULL,
    s3_key character varying(500) NOT NULL,
    file_size_bytes bigint,
    file_hash character varying(64),
    created_by_contact_id integer NOT NULL,
    is_current_version boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.document_versions OWNER TO postgres;

--
-- Name: document_versions_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.document_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.document_versions_id_seq OWNER TO postgres;

--
-- Name: document_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.document_versions_id_seq OWNED BY documentos_file_management.document_versions.id;


--
-- Name: documents; Type: TABLE; Schema: documentos_file_management; Owner: postgres
--

CREATE TABLE documentos_file_management.documents (
    id integer NOT NULL,
    document_type_id integer NOT NULL,
    organization_id integer NOT NULL,
    related_entity_type character varying(30),
    related_entity_id integer,
    file_name character varying(255) NOT NULL,
    file_path character varying(500) NOT NULL,
    s3_key character varying(500) NOT NULL,
    file_size_bytes bigint,
    mime_type character varying(100),
    file_hash character varying(64),
    upload_source character varying(30),
    uploaded_by_contact_id integer NOT NULL,
    upload_timestamp timestamp without time zone NOT NULL,
    is_confidential boolean DEFAULT false,
    expires_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE documentos_file_management.documents OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: documentos_file_management; Owner: postgres
--

CREATE SEQUENCE documentos_file_management.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE documentos_file_management.documents_id_seq OWNER TO postgres;

--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: documentos_file_management; Owner: postgres
--

ALTER SEQUENCE documentos_file_management.documents_id_seq OWNED BY documentos_file_management.documents.id;


--
-- Name: email_accounts; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_accounts (
    id integer NOT NULL,
    organization_id integer,
    contact_id integer,
    email_provider_id integer NOT NULL,
    email_address character varying(255) NOT NULL,
    account_name character varying(100),
    account_type character varying(20),
    smtp_server character varying(100),
    smtp_port integer,
    imap_server character varying(100),
    imap_port integer,
    username character varying(100),
    password_encrypted character varying(255),
    oauth_token_encrypted character varying(255),
    oauth_refresh_token_encrypted character varying(255),
    sync_status character varying(20) DEFAULT 'PAUSED'::character varying,
    last_sync_at timestamp without time zone,
    sync_interval_minutes integer DEFAULT 15,
    auto_assign_enabled boolean DEFAULT false,
    is_primary boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_accounts OWNER TO postgres;

--
-- Name: email_accounts_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_accounts_id_seq OWNER TO postgres;

--
-- Name: email_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_accounts_id_seq OWNED BY emails_enterprise.email_accounts.id;


--
-- Name: email_assignments; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_assignments (
    id integer NOT NULL,
    email_message_id integer NOT NULL,
    assigned_to_contact_id integer NOT NULL,
    assigned_by_contact_id integer,
    assignment_type character varying(20),
    assignment_reason character varying(255),
    priority_level character varying(10) DEFAULT 'NORMAL'::character varying,
    due_date timestamp without time zone,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    response_required boolean DEFAULT true,
    completed_at timestamp without time zone,
    notes text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_assignments OWNER TO postgres;

--
-- Name: email_assignments_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_assignments_id_seq OWNER TO postgres;

--
-- Name: email_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_assignments_id_seq OWNED BY emails_enterprise.email_assignments.id;


--
-- Name: email_attachments; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_attachments (
    id integer NOT NULL,
    email_message_id integer NOT NULL,
    attachment_name character varying(255) NOT NULL,
    file_url character varying(500),
    s3_key character varying(500),
    s3_bucket character varying(100),
    mime_type character varying(100),
    file_size integer,
    attachment_id character varying(255),
    is_inline boolean DEFAULT false,
    content_id character varying(255),
    download_status character varying(20) DEFAULT 'PENDING'::character varying,
    virus_scan_status character varying(20) DEFAULT 'PENDING'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_attachments OWNER TO postgres;

--
-- Name: email_attachments_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_attachments_id_seq OWNER TO postgres;

--
-- Name: email_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_attachments_id_seq OWNED BY emails_enterprise.email_attachments.id;


--
-- Name: email_automated_responses; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_automated_responses (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    email_account_id integer,
    rule_name character varying(100) NOT NULL,
    trigger_conditions json,
    email_template_id integer NOT NULL,
    response_delay_minutes integer DEFAULT 0,
    active_hours_start time without time zone,
    active_hours_end time without time zone,
    active_days character varying(20) DEFAULT 'MON-FRI'::character varying,
    max_responses_per_thread integer DEFAULT 1,
    is_out_of_office boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_automated_responses OWNER TO postgres;

--
-- Name: email_automated_responses_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_automated_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_automated_responses_id_seq OWNER TO postgres;

--
-- Name: email_automated_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_automated_responses_id_seq OWNED BY emails_enterprise.email_automated_responses.id;


--
-- Name: email_campaigns; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_campaigns (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    created_by_contact_id integer,
    campaign_name character varying(100) NOT NULL,
    campaign_type character varying(30),
    email_template_id integer NOT NULL,
    target_audience_criteria json,
    scheduled_send_at timestamp without time zone,
    send_status character varying(20) DEFAULT 'DRAFT'::character varying,
    total_recipients integer DEFAULT 0,
    emails_sent integer DEFAULT 0,
    emails_delivered integer DEFAULT 0,
    emails_opened integer DEFAULT 0,
    emails_clicked integer DEFAULT 0,
    bounce_count integer DEFAULT 0,
    unsubscribe_count integer DEFAULT 0,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_campaigns OWNER TO postgres;

--
-- Name: email_campaigns_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_campaigns_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_campaigns_id_seq OWNER TO postgres;

--
-- Name: email_campaigns_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_campaigns_id_seq OWNED BY emails_enterprise.email_campaigns.id;


--
-- Name: email_delivery_status; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_delivery_status (
    id integer NOT NULL,
    email_message_id integer NOT NULL,
    recipient_email character varying(255) NOT NULL,
    delivery_status character varying(20) DEFAULT 'PENDING'::character varying,
    status_details text,
    delivery_timestamp timestamp without time zone,
    bounce_type character varying(30),
    bounce_reason text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_delivery_status OWNER TO postgres;

--
-- Name: email_delivery_status_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_delivery_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_delivery_status_id_seq OWNER TO postgres;

--
-- Name: email_delivery_status_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_delivery_status_id_seq OWNED BY emails_enterprise.email_delivery_status.id;


--
-- Name: email_folders; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_folders (
    id integer NOT NULL,
    email_account_id integer NOT NULL,
    folder_name character varying(100) NOT NULL,
    folder_type character varying(20),
    external_folder_id character varying(100),
    parent_folder_id integer,
    folder_path character varying(255),
    message_count integer DEFAULT 0,
    unread_count integer DEFAULT 0,
    last_sync_at timestamp without time zone,
    sync_enabled boolean DEFAULT true,
    is_system_folder boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_folders OWNER TO postgres;

--
-- Name: email_folders_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_folders_id_seq OWNER TO postgres;

--
-- Name: email_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_folders_id_seq OWNED BY emails_enterprise.email_folders.id;


--
-- Name: email_labels; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_labels (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    label_name character varying(50) NOT NULL,
    label_color character varying(7),
    label_category character varying(30),
    description character varying(255),
    is_system_label boolean DEFAULT false,
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_labels OWNER TO postgres;

--
-- Name: email_labels_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_labels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_labels_id_seq OWNER TO postgres;

--
-- Name: email_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_labels_id_seq OWNED BY emails_enterprise.email_labels.id;


--
-- Name: email_link_clicks; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_link_clicks (
    id integer NOT NULL,
    email_message_id integer NOT NULL,
    recipient_email character varying(255) NOT NULL,
    original_url text,
    clicked_url text,
    click_timestamp timestamp without time zone,
    ip_address character varying(45),
    user_agent text,
    device_info character varying(255),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_link_clicks OWNER TO postgres;

--
-- Name: email_link_clicks_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_link_clicks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_link_clicks_id_seq OWNER TO postgres;

--
-- Name: email_link_clicks_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_link_clicks_id_seq OWNED BY emails_enterprise.email_link_clicks.id;


--
-- Name: email_messages; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_messages (
    id integer NOT NULL,
    email_account_id integer NOT NULL,
    email_folder_id integer,
    message_id character varying(255) NOT NULL,
    thread_id character varying(255),
    subject character varying(500),
    body_text text,
    body_html text,
    from_address character varying(255),
    from_name character varying(255),
    to_addresses json,
    cc_addresses json,
    bcc_addresses json,
    reply_to_address character varying(255),
    sent_at timestamp without time zone,
    received_at timestamp without time zone,
    is_read boolean DEFAULT false,
    is_starred boolean DEFAULT false,
    is_important boolean DEFAULT false,
    priority_level character varying(10) DEFAULT 'NORMAL'::character varying,
    context_type character varying(30),
    context_id integer,
    assigned_to_contact_id integer,
    has_attachments boolean DEFAULT false,
    attachment_count integer DEFAULT 0,
    metadata json,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_messages OWNER TO postgres;

--
-- Name: email_messages_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_messages_id_seq OWNER TO postgres;

--
-- Name: email_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_messages_id_seq OWNED BY emails_enterprise.email_messages.id;


--
-- Name: email_performance_metrics; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_performance_metrics (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    email_account_id integer,
    contact_id integer,
    metric_date date NOT NULL,
    emails_sent integer DEFAULT 0,
    emails_received integer DEFAULT 0,
    emails_opened integer DEFAULT 0,
    replies_sent integer DEFAULT 0,
    assigned_count integer DEFAULT 0,
    completed_assignments integer DEFAULT 0,
    average_response_time_minutes numeric(6,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_performance_metrics OWNER TO postgres;

--
-- Name: email_performance_metrics_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_performance_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_performance_metrics_id_seq OWNER TO postgres;

--
-- Name: email_performance_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_performance_metrics_id_seq OWNED BY emails_enterprise.email_performance_metrics.id;


--
-- Name: email_providers; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_providers (
    id integer NOT NULL,
    provider_name character varying(50) NOT NULL,
    provider_type character varying(20) NOT NULL,
    api_endpoint character varying(255),
    authentication_type character varying(20) NOT NULL,
    supports_push_notifications boolean DEFAULT true,
    supports_threading boolean DEFAULT true,
    configuration json,
    rate_limit_per_minute integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_providers OWNER TO postgres;

--
-- Name: email_providers_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_providers_id_seq OWNER TO postgres;

--
-- Name: email_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_providers_id_seq OWNED BY emails_enterprise.email_providers.id;


--
-- Name: email_recipients; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_recipients (
    id integer NOT NULL,
    email_message_id integer NOT NULL,
    contact_id integer,
    email_address character varying(255) NOT NULL,
    display_name character varying(255),
    recipient_type character varying(5) NOT NULL,
    delivery_status character varying(20) DEFAULT 'PENDING'::character varying,
    read_status character varying(20) DEFAULT 'UNKNOWN'::character varying,
    delivered_at timestamp without time zone,
    read_at timestamp without time zone,
    bounce_reason character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_recipients OWNER TO postgres;

--
-- Name: email_recipients_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_recipients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_recipients_id_seq OWNER TO postgres;

--
-- Name: email_recipients_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_recipients_id_seq OWNED BY emails_enterprise.email_recipients.id;


--
-- Name: email_template_variables; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_template_variables (
    id integer NOT NULL,
    variable_name character varying(50) NOT NULL,
    variable_category character varying(30),
    data_type character varying(20),
    data_source_table character varying(50),
    data_source_field character varying(50),
    format_template character varying(100),
    description character varying(255),
    is_required boolean DEFAULT false,
    default_value character varying(255),
    is_system_variable boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_template_variables OWNER TO postgres;

--
-- Name: email_template_variables_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_template_variables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_template_variables_id_seq OWNER TO postgres;

--
-- Name: email_template_variables_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_template_variables_id_seq OWNED BY emails_enterprise.email_template_variables.id;


--
-- Name: email_templates; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_templates (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    created_by_contact_id integer,
    template_name character varying(100) NOT NULL,
    template_category character varying(30),
    template_subcategory character varying(50),
    subject_line character varying(500),
    body_html text,
    body_text text,
    variables_schema json,
    default_variables json,
    usage_context character varying(50),
    is_system_template boolean DEFAULT false,
    is_active boolean DEFAULT true,
    usage_count integer DEFAULT 0,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_templates OWNER TO postgres;

--
-- Name: email_templates_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_templates_id_seq OWNER TO postgres;

--
-- Name: email_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_templates_id_seq OWNED BY emails_enterprise.email_templates.id;


--
-- Name: email_threads; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_threads (
    id integer NOT NULL,
    thread_id character varying(255) NOT NULL,
    organization_id integer,
    subject_line character varying(500),
    context_type character varying(30),
    context_id integer,
    participants json,
    message_count integer DEFAULT 0,
    last_message_at timestamp without time zone,
    last_activity_contact_id integer,
    is_archived boolean DEFAULT false,
    is_important boolean DEFAULT false,
    assigned_to_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_threads OWNER TO postgres;

--
-- Name: email_threads_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_threads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_threads_id_seq OWNER TO postgres;

--
-- Name: email_threads_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_threads_id_seq OWNED BY emails_enterprise.email_threads.id;


--
-- Name: email_tracking_pixels; Type: TABLE; Schema: emails_enterprise; Owner: postgres
--

CREATE TABLE emails_enterprise.email_tracking_pixels (
    id integer NOT NULL,
    email_message_id integer NOT NULL,
    recipient_email character varying(255) NOT NULL,
    tracking_token character varying(255),
    pixel_url character varying(500),
    opened_at timestamp without time zone,
    open_count integer DEFAULT 0,
    device_info character varying(255),
    ip_address character varying(45),
    user_agent text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE emails_enterprise.email_tracking_pixels OWNER TO postgres;

--
-- Name: email_tracking_pixels_id_seq; Type: SEQUENCE; Schema: emails_enterprise; Owner: postgres
--

CREATE SEQUENCE emails_enterprise.email_tracking_pixels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE emails_enterprise.email_tracking_pixels_id_seq OWNER TO postgres;

--
-- Name: email_tracking_pixels_id_seq; Type: SEQUENCE OWNED BY; Schema: emails_enterprise; Owner: postgres
--

ALTER SEQUENCE emails_enterprise.email_tracking_pixels_id_seq OWNED BY emails_enterprise.email_tracking_pixels.id;


--
-- Name: bank_accounts; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.bank_accounts (
    id integer NOT NULL,
    organization_id integer,
    account_name character varying(100) NOT NULL,
    account_type character varying(30),
    bank_name character varying(100),
    account_number character varying(50),
    routing_number character varying(20),
    plaid_account_id character varying(100),
    plaid_access_token character varying(255),
    current_balance numeric(12,2),
    available_balance numeric(12,2),
    last_sync_date timestamp without time zone,
    auto_sync_enabled boolean DEFAULT true,
    is_primary boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.bank_accounts OWNER TO postgres;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.bank_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.bank_accounts_id_seq OWNER TO postgres;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.bank_accounts_id_seq OWNED BY finanzas_bookkeeping.bank_accounts.id;


--
-- Name: bank_statements; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.bank_statements (
    id integer NOT NULL,
    bank_account_id integer NOT NULL,
    statement_month integer,
    statement_year integer,
    statement_start_date date,
    statement_end_date date,
    opening_balance numeric(12,2),
    closing_balance numeric(12,2),
    is_reconciled boolean DEFAULT false,
    reconciled_by_contact_id integer,
    reconciled_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.bank_statements OWNER TO postgres;

--
-- Name: bank_statements_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.bank_statements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.bank_statements_id_seq OWNER TO postgres;

--
-- Name: bank_statements_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.bank_statements_id_seq OWNED BY finanzas_bookkeeping.bank_statements.id;


--
-- Name: cash_accounts; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.cash_accounts (
    id integer NOT NULL,
    organization_id integer,
    account_name character varying(100) NOT NULL,
    current_balance numeric(10,2),
    location character varying(100),
    responsible_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.cash_accounts OWNER TO postgres;

--
-- Name: cash_accounts_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.cash_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.cash_accounts_id_seq OWNER TO postgres;

--
-- Name: cash_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.cash_accounts_id_seq OWNED BY finanzas_bookkeeping.cash_accounts.id;


--
-- Name: check_register; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.check_register (
    id integer NOT NULL,
    bank_account_id integer NOT NULL,
    check_number character varying(20),
    payee_name character varying(100),
    payee_contact_id integer,
    amount numeric(10,2),
    memo character varying(200),
    issue_date date,
    cleared_date date,
    status character varying(20),
    wallet_id integer,
    related_invoice_id integer,
    issued_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.check_register OWNER TO postgres;

--
-- Name: check_register_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.check_register_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.check_register_id_seq OWNER TO postgres;

--
-- Name: check_register_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.check_register_id_seq OWNED BY finanzas_bookkeeping.check_register.id;


--
-- Name: commission_calculations; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.commission_calculations (
    id integer NOT NULL,
    invoice_id integer,
    salesperson_contact_id integer,
    commission_percentage numeric(5,2),
    commission_amount numeric(10,2),
    calculation_base numeric(12,2),
    payment_status character varying(20),
    wallet_id integer,
    paid_via_check_id integer,
    calculated_at timestamp without time zone,
    paid_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.commission_calculations OWNER TO postgres;

--
-- Name: commission_calculations_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.commission_calculations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.commission_calculations_id_seq OWNER TO postgres;

--
-- Name: commission_calculations_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.commission_calculations_id_seq OWNED BY finanzas_bookkeeping.commission_calculations.id;


--
-- Name: invoice_payments; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.invoice_payments (
    id integer NOT NULL,
    invoice_id integer,
    payment_amount numeric(12,2),
    payment_date date,
    payment_method character varying(30),
    payment_reference character varying(100),
    bank_account_id integer,
    processed_payment_id integer,
    payment_processor_fee numeric(8,2),
    net_payment_amount numeric(12,2),
    notes text,
    processed_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.invoice_payments OWNER TO postgres;

--
-- Name: invoice_payments_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.invoice_payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.invoice_payments_id_seq OWNER TO postgres;

--
-- Name: invoice_payments_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.invoice_payments_id_seq OWNED BY finanzas_bookkeeping.invoice_payments.id;


--
-- Name: irs_categories; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.irs_categories (
    id integer NOT NULL,
    category_code character varying(20) NOT NULL,
    category_name character varying(100),
    irs_form_line character varying(50),
    description text,
    is_deductible boolean DEFAULT true,
    requires_documentation boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.irs_categories OWNER TO postgres;

--
-- Name: irs_categories_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.irs_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.irs_categories_id_seq OWNER TO postgres;

--
-- Name: irs_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.irs_categories_id_seq OWNED BY finanzas_bookkeeping.irs_categories.id;


--
-- Name: transaction_categories; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.transaction_categories (
    id integer NOT NULL,
    organization_id integer,
    category_name character varying(100) NOT NULL,
    parent_category_id integer,
    irs_category_id integer,
    icon_name character varying(50),
    color character varying(7),
    is_expense boolean DEFAULT true,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.transaction_categories OWNER TO postgres;

--
-- Name: transaction_categories_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.transaction_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.transaction_categories_id_seq OWNER TO postgres;

--
-- Name: transaction_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.transaction_categories_id_seq OWNED BY finanzas_bookkeeping.transaction_categories.id;


--
-- Name: virtual_wallets; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.virtual_wallets (
    id integer NOT NULL,
    organization_id integer,
    wallet_type_id integer,
    wallet_name character varying(100) NOT NULL,
    description text,
    current_balance numeric(12,2),
    allocated_budget numeric(12,2),
    responsible_contact_id integer,
    project_id integer,
    is_active boolean DEFAULT true,
    auto_allocate_rules json,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.virtual_wallets OWNER TO postgres;

--
-- Name: virtual_wallets_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.virtual_wallets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.virtual_wallets_id_seq OWNER TO postgres;

--
-- Name: virtual_wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.virtual_wallets_id_seq OWNED BY finanzas_bookkeeping.virtual_wallets.id;


--
-- Name: wallet_balances; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.wallet_balances (
    id integer NOT NULL,
    wallet_id integer NOT NULL,
    balance_date date NOT NULL,
    opening_balance numeric(12,2),
    total_debits numeric(12,2),
    total_credits numeric(12,2),
    closing_balance numeric(12,2),
    transaction_count integer,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.wallet_balances OWNER TO postgres;

--
-- Name: wallet_balances_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.wallet_balances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.wallet_balances_id_seq OWNER TO postgres;

--
-- Name: wallet_balances_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.wallet_balances_id_seq OWNED BY finanzas_bookkeeping.wallet_balances.id;


--
-- Name: wallet_types; Type: TABLE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE TABLE finanzas_bookkeeping.wallet_types (
    id integer NOT NULL,
    type_name character varying(50) NOT NULL,
    description text,
    default_rules json,
    icon_name character varying(50),
    is_system_type boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE finanzas_bookkeeping.wallet_types OWNER TO postgres;

--
-- Name: wallet_types_id_seq; Type: SEQUENCE; Schema: finanzas_bookkeeping; Owner: postgres
--

CREATE SEQUENCE finanzas_bookkeeping.wallet_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE finanzas_bookkeeping.wallet_types_id_seq OWNER TO postgres;

--
-- Name: wallet_types_id_seq; Type: SEQUENCE OWNED BY; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER SEQUENCE finanzas_bookkeeping.wallet_types_id_seq OWNED BY finanzas_bookkeeping.wallet_types.id;


--
-- Name: content_categories; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.content_categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    requires_detailed_photos boolean DEFAULT false,
    typical_salvage_rate_percent numeric(5,2),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.content_categories OWNER TO postgres;

--
-- Name: content_categories_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.content_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.content_categories_id_seq OWNER TO postgres;

--
-- Name: content_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.content_categories_id_seq OWNED BY inspecciones_evaluaciones.content_categories.id;


--
-- Name: damage_types; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.damage_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category character varying(30),
    description text,
    severity_scale character varying(50),
    assessment_criteria json,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.damage_types OWNER TO postgres;

--
-- Name: damage_types_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.damage_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.damage_types_id_seq OWNER TO postgres;

--
-- Name: damage_types_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.damage_types_id_seq OWNED BY inspecciones_evaluaciones.damage_types.id;


--
-- Name: equipment_types; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.equipment_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category character varying(30) NOT NULL,
    description text,
    manufacturer character varying(50),
    model_number character varying(50),
    specifications json,
    reading_units character varying(20),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.equipment_types OWNER TO postgres;

--
-- Name: equipment_types_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.equipment_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.equipment_types_id_seq OWNER TO postgres;

--
-- Name: equipment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.equipment_types_id_seq OWNED BY inspecciones_evaluaciones.equipment_types.id;


--
-- Name: iicrc_standards; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.iicrc_standards (
    id integer NOT NULL,
    standard_code character varying(10) NOT NULL,
    standard_name character varying(100) NOT NULL,
    description text,
    applicable_damage_types character varying(100),
    requirements json,
    procedures json,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.iicrc_standards OWNER TO postgres;

--
-- Name: iicrc_standards_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.iicrc_standards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.iicrc_standards_id_seq OWNER TO postgres;

--
-- Name: iicrc_standards_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.iicrc_standards_id_seq OWNED BY inspecciones_evaluaciones.iicrc_standards.id;


--
-- Name: inspection_areas; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.inspection_areas (
    id integer NOT NULL,
    inspection_id integer NOT NULL,
    area_name character varying(100),
    area_type character varying(50),
    location_description character varying(255),
    area_measurements json,
    access_restrictions character varying(255),
    area_notes text,
    order_sequence integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.inspection_areas OWNER TO postgres;

--
-- Name: inspection_areas_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.inspection_areas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.inspection_areas_id_seq OWNER TO postgres;

--
-- Name: inspection_areas_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.inspection_areas_id_seq OWNED BY inspecciones_evaluaciones.inspection_areas.id;


--
-- Name: inspection_types; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.inspection_types (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category character varying(30) NOT NULL,
    description text,
    iicrc_standard_id integer,
    required_fields json,
    optional_fields json,
    requires_equipment_readings boolean DEFAULT false,
    requires_moisture_mapping boolean DEFAULT false,
    requires_content_inventory boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.inspection_types OWNER TO postgres;

--
-- Name: inspection_types_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.inspection_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.inspection_types_id_seq OWNER TO postgres;

--
-- Name: inspection_types_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.inspection_types_id_seq OWNED BY inspecciones_evaluaciones.inspection_types.id;


--
-- Name: inspections; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.inspections (
    id integer NOT NULL,
    customer_project_id integer,
    inspection_type_id integer NOT NULL,
    iicrc_standard_id integer,
    inspector_contact_id integer,
    inspection_status character varying(30) DEFAULT 'Scheduled'::character varying,
    inspection_date date,
    start_time time without time zone,
    end_time time without time zone,
    general_notes text,
    weather_conditions json,
    safety_concerns character varying(255),
    requires_follow_up boolean DEFAULT false,
    follow_up_date date,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.inspections OWNER TO postgres;

--
-- Name: inspections_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.inspections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.inspections_id_seq OWNER TO postgres;

--
-- Name: inspections_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.inspections_id_seq OWNED BY inspecciones_evaluaciones.inspections.id;


--
-- Name: service_categories; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.service_categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    category_type character varying(30),
    description text,
    typical_duration_days integer,
    requires_certification boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.service_categories OWNER TO postgres;

--
-- Name: service_categories_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.service_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.service_categories_id_seq OWNER TO postgres;

--
-- Name: service_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.service_categories_id_seq OWNED BY inspecciones_evaluaciones.service_categories.id;


--
-- Name: water_damage_categories; Type: TABLE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE TABLE inspecciones_evaluaciones.water_damage_categories (
    id integer NOT NULL,
    category_name character varying(20) NOT NULL,
    category_level character varying(10) NOT NULL,
    description text,
    source_description character varying(255),
    safety_requirements json,
    drying_procedures json,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE inspecciones_evaluaciones.water_damage_categories OWNER TO postgres;

--
-- Name: water_damage_categories_id_seq; Type: SEQUENCE; Schema: inspecciones_evaluaciones; Owner: postgres
--

CREATE SEQUENCE inspecciones_evaluaciones.water_damage_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inspecciones_evaluaciones.water_damage_categories_id_seq OWNER TO postgres;

--
-- Name: water_damage_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER SEQUENCE inspecciones_evaluaciones.water_damage_categories_id_seq OWNED BY inspecciones_evaluaciones.water_damage_categories.id;


--
-- Name: note_attachments; Type: TABLE; Schema: notas_comunicacion; Owner: postgres
--

CREATE TABLE notas_comunicacion.note_attachments (
    id integer NOT NULL,
    note_id integer NOT NULL,
    document_id integer NOT NULL,
    attachment_type character varying(20) NOT NULL,
    attached_by_contact_id integer,
    attached_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notas_comunicacion.note_attachments OWNER TO postgres;

--
-- Name: note_attachments_id_seq; Type: SEQUENCE; Schema: notas_comunicacion; Owner: postgres
--

CREATE SEQUENCE notas_comunicacion.note_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notas_comunicacion.note_attachments_id_seq OWNER TO postgres;

--
-- Name: note_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: notas_comunicacion; Owner: postgres
--

ALTER SEQUENCE notas_comunicacion.note_attachments_id_seq OWNED BY notas_comunicacion.note_attachments.id;


--
-- Name: note_mentions; Type: TABLE; Schema: notas_comunicacion; Owner: postgres
--

CREATE TABLE notas_comunicacion.note_mentions (
    id integer NOT NULL,
    note_id integer NOT NULL,
    mentioned_contact_id integer NOT NULL,
    mentioned_at timestamp without time zone DEFAULT now(),
    is_notified boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notas_comunicacion.note_mentions OWNER TO postgres;

--
-- Name: note_mentions_id_seq; Type: SEQUENCE; Schema: notas_comunicacion; Owner: postgres
--

CREATE SEQUENCE notas_comunicacion.note_mentions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notas_comunicacion.note_mentions_id_seq OWNER TO postgres;

--
-- Name: note_mentions_id_seq; Type: SEQUENCE OWNED BY; Schema: notas_comunicacion; Owner: postgres
--

ALTER SEQUENCE notas_comunicacion.note_mentions_id_seq OWNED BY notas_comunicacion.note_mentions.id;


--
-- Name: note_notifications; Type: TABLE; Schema: notas_comunicacion; Owner: postgres
--

CREATE TABLE notas_comunicacion.note_notifications (
    id integer NOT NULL,
    note_id integer NOT NULL,
    recipient_contact_id integer NOT NULL,
    notification_type character varying(30) NOT NULL,
    is_read boolean DEFAULT false,
    signalr_connection_id character varying(100),
    read_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notas_comunicacion.note_notifications OWNER TO postgres;

--
-- Name: note_notifications_id_seq; Type: SEQUENCE; Schema: notas_comunicacion; Owner: postgres
--

CREATE SEQUENCE notas_comunicacion.note_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notas_comunicacion.note_notifications_id_seq OWNER TO postgres;

--
-- Name: note_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: notas_comunicacion; Owner: postgres
--

ALTER SEQUENCE notas_comunicacion.note_notifications_id_seq OWNED BY notas_comunicacion.note_notifications.id;


--
-- Name: note_reactions; Type: TABLE; Schema: notas_comunicacion; Owner: postgres
--

CREATE TABLE notas_comunicacion.note_reactions (
    id integer NOT NULL,
    note_id integer NOT NULL,
    reaction_type character varying(20) NOT NULL,
    reacted_by_contact_id integer NOT NULL,
    reacted_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notas_comunicacion.note_reactions OWNER TO postgres;

--
-- Name: note_reactions_id_seq; Type: SEQUENCE; Schema: notas_comunicacion; Owner: postgres
--

CREATE SEQUENCE notas_comunicacion.note_reactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notas_comunicacion.note_reactions_id_seq OWNER TO postgres;

--
-- Name: note_reactions_id_seq; Type: SEQUENCE OWNED BY; Schema: notas_comunicacion; Owner: postgres
--

ALTER SEQUENCE notas_comunicacion.note_reactions_id_seq OWNED BY notas_comunicacion.note_reactions.id;


--
-- Name: note_tags; Type: TABLE; Schema: notas_comunicacion; Owner: postgres
--

CREATE TABLE notas_comunicacion.note_tags (
    id integer NOT NULL,
    note_id integer NOT NULL,
    tag_name character varying(50) NOT NULL,
    tag_category character varying(30),
    tag_color character varying(7),
    created_by_contact_id integer,
    is_system_tag boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notas_comunicacion.note_tags OWNER TO postgres;

--
-- Name: note_tags_id_seq; Type: SEQUENCE; Schema: notas_comunicacion; Owner: postgres
--

CREATE SEQUENCE notas_comunicacion.note_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notas_comunicacion.note_tags_id_seq OWNER TO postgres;

--
-- Name: note_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: notas_comunicacion; Owner: postgres
--

ALTER SEQUENCE notas_comunicacion.note_tags_id_seq OWNED BY notas_comunicacion.note_tags.id;


--
-- Name: notes; Type: TABLE; Schema: notas_comunicacion; Owner: postgres
--

CREATE TABLE notas_comunicacion.notes (
    id integer NOT NULL,
    parent_note_id integer,
    note_type character varying(30) NOT NULL,
    context_id integer,
    context_table character varying(50) NOT NULL,
    note_content text NOT NULL,
    created_by_contact_id integer NOT NULL,
    is_private boolean DEFAULT false,
    has_replies boolean DEFAULT false,
    signalr_group_id character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notas_comunicacion.notes OWNER TO postgres;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: notas_comunicacion; Owner: postgres
--

CREATE SEQUENCE notas_comunicacion.notes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notas_comunicacion.notes_id_seq OWNER TO postgres;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: notas_comunicacion; Owner: postgres
--

ALTER SEQUENCE notas_comunicacion.notes_id_seq OWNED BY notas_comunicacion.notes.id;


--
-- Name: escalation_rules; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.escalation_rules (
    id integer NOT NULL,
    organization_id integer,
    escalation_name character varying(100) NOT NULL,
    notification_type_id integer NOT NULL,
    escalation_sequence json,
    trigger_delay_minutes integer DEFAULT 15,
    retry_interval_minutes integer,
    max_escalation_levels integer,
    recipient_type character varying(20),
    recipient_query text,
    notification_template_id integer,
    is_active boolean DEFAULT true,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.escalation_rules OWNER TO postgres;

--
-- Name: escalation_rules_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.escalation_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.escalation_rules_id_seq OWNER TO postgres;

--
-- Name: escalation_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.escalation_rules_id_seq OWNED BY notifications_system_enterprise.escalation_rules.id;


--
-- Name: notification_analytics; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_analytics (
    id integer NOT NULL,
    organization_id integer,
    metric_date date NOT NULL,
    metric_hour integer,
    channel_type character varying(20),
    notification_type_id integer,
    notifications_sent integer DEFAULT 0,
    notifications_delivered integer DEFAULT 0,
    delivery_rate numeric(5,2),
    notifications_opened integer DEFAULT 0,
    open_rate numeric(5,2),
    notifications_clicked integer DEFAULT 0,
    click_rate numeric(5,2),
    bounces_soft integer DEFAULT 0,
    bounces_hard integer DEFAULT 0,
    failures_total integer DEFAULT 0,
    failure_rate numeric(5,2),
    retries_count integer DEFAULT 0,
    retry_rate numeric(5,2),
    cost_total numeric(10,2),
    cost_per_message numeric(6,4),
    revenue_attributed numeric(12,2),
    roi_calculation numeric(8,2),
    customer_satisfaction_score numeric(3,2),
    escalation_count integer DEFAULT 0,
    business_impact_score numeric(5,2),
    ai_optimization_applied boolean DEFAULT false,
    calculated_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_analytics OWNER TO postgres;

--
-- Name: notification_analytics_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_analytics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_analytics_id_seq OWNER TO postgres;

--
-- Name: notification_analytics_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_analytics_id_seq OWNED BY notifications_system_enterprise.notification_analytics.id;


--
-- Name: notification_delivery_log; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_delivery_log (
    id integer NOT NULL,
    notification_queue_id integer NOT NULL,
    recipient_contact_id integer NOT NULL,
    channel_type character varying(20),
    delivery_status character varying(20),
    provider_name character varying(30),
    provider_message_id character varying(100),
    delivery_attempt integer DEFAULT 1,
    sent_at timestamp without time zone,
    delivered_at timestamp without time zone,
    opened_at timestamp without time zone,
    clicked_at timestamp without time zone,
    replied_at timestamp without time zone,
    acknowledged_at timestamp without time zone,
    cost numeric(6,4),
    processing_time_ms integer,
    delivery_time_minutes numeric(8,2),
    response_time_minutes numeric(8,2),
    personalized_content text,
    device_info json,
    location_data json,
    user_agent character varying(255),
    ip_address character varying(45),
    engagement_score numeric(3,2),
    retention_days integer DEFAULT 2555,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_delivery_log OWNER TO postgres;

--
-- Name: notification_delivery_log_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_delivery_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_delivery_log_id_seq OWNER TO postgres;

--
-- Name: notification_delivery_log_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_delivery_log_id_seq OWNED BY notifications_system_enterprise.notification_delivery_log.id;


--
-- Name: notification_failures; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_failures (
    id integer NOT NULL,
    notification_queue_id integer NOT NULL,
    channel_type character varying(20),
    failure_type character varying(30),
    error_code character varying(50),
    error_message text,
    failure_timestamp timestamp without time zone,
    is_permanent boolean DEFAULT false,
    retry_count integer DEFAULT 0,
    next_retry_at timestamp without time zone,
    auto_escalated boolean DEFAULT false,
    resolution_action character varying(50),
    resolved_at timestamp without time zone,
    resolved_by_contact_id integer,
    notes text,
    retention_days integer DEFAULT 2555,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_failures OWNER TO postgres;

--
-- Name: notification_failures_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_failures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_failures_id_seq OWNER TO postgres;

--
-- Name: notification_failures_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_failures_id_seq OWNED BY notifications_system_enterprise.notification_failures.id;


--
-- Name: notification_queue; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_queue (
    id integer NOT NULL,
    organization_id integer,
    notification_type_id integer,
    template_id integer,
    trigger_id integer,
    priority character varying(20) DEFAULT 'MEDIUM'::character varying,
    scheduled_for timestamp without time zone,
    channels json,
    content_variables json,
    recipient_count integer DEFAULT 1,
    context_type character varying(30),
    context_id integer,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    sent_at timestamp without time zone,
    delivery_confirmation_required boolean DEFAULT false,
    total_cost numeric(6,2),
    success_rate numeric(5,2),
    failure_reason character varying(100),
    retry_count integer DEFAULT 0,
    max_retries integer DEFAULT 3,
    next_retry_at timestamp without time zone,
    escalated_at timestamp without time zone,
    expires_at timestamp without time zone,
    business_impact_score numeric(5,2),
    signalr_group_id character varying(100),
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_queue OWNER TO postgres;

--
-- Name: notification_queue_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_queue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_queue_id_seq OWNER TO postgres;

--
-- Name: notification_queue_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_queue_id_seq OWNED BY notifications_system_enterprise.notification_queue.id;


--
-- Name: notification_recipients; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_recipients (
    id integer NOT NULL,
    notification_queue_id integer NOT NULL,
    recipient_contact_id integer NOT NULL,
    send_status character varying(20) DEFAULT 'PENDING'::character varying,
    retry_count integer DEFAULT 0,
    last_sent_at timestamp without time zone,
    is_acknowledged boolean DEFAULT false,
    acknowledged_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_recipients OWNER TO postgres;

--
-- Name: notification_recipients_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_recipients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_recipients_id_seq OWNER TO postgres;

--
-- Name: notification_recipients_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_recipients_id_seq OWNED BY notifications_system_enterprise.notification_recipients.id;


--
-- Name: notification_rules; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_rules (
    id integer NOT NULL,
    organization_id integer,
    rule_name character varying(100),
    rule_category character varying(30),
    rule_type character varying(20),
    conditions json,
    actions json,
    priority_adjustment integer DEFAULT 0,
    channel_modifications json,
    template_overrides json,
    suppression_rules json,
    ai_enhanced boolean DEFAULT false,
    success_metrics json,
    a_b_test_enabled boolean DEFAULT false,
    execution_order integer DEFAULT 100,
    is_global boolean DEFAULT false,
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_rules OWNER TO postgres;

--
-- Name: notification_rules_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_rules_id_seq OWNER TO postgres;

--
-- Name: notification_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_rules_id_seq OWNED BY notifications_system_enterprise.notification_rules.id;


--
-- Name: notification_templates; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_templates (
    id integer NOT NULL,
    notification_type_id integer NOT NULL,
    template_name character varying(100),
    channel_type character varying(20),
    subject_template character varying(200),
    content_template text,
    variables_schema json,
    language_code character varying(5) DEFAULT 'en'::character varying,
    is_html boolean DEFAULT false,
    personalization_level character varying(20) DEFAULT 'BASIC'::character varying,
    a_b_test_group character varying(10),
    rich_content json,
    action_buttons json,
    deep_link_url character varying(500),
    ai_optimization_enabled boolean DEFAULT false,
    ai_subject_variants json,
    ai_content_variants json,
    performance_score numeric(3,2),
    usage_count integer DEFAULT 0,
    last_used_at timestamp without time zone,
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_templates OWNER TO postgres;

--
-- Name: notification_templates_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_templates_id_seq OWNER TO postgres;

--
-- Name: notification_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_templates_id_seq OWNED BY notifications_system_enterprise.notification_templates.id;


--
-- Name: notification_triggers; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_triggers (
    id integer NOT NULL,
    organization_id integer,
    trigger_name character varying(100),
    trigger_type character varying(30),
    event_source character varying(50),
    event_conditions json,
    notification_type_id integer,
    target_audience character varying(30),
    recipient_query text,
    template_variables json,
    delay_minutes integer DEFAULT 0,
    is_repeatable boolean DEFAULT false,
    repeat_interval_hours integer,
    max_occurrences integer,
    priority_override character varying(20),
    channels_override json,
    active_hours_start time without time zone,
    active_hours_end time without time zone,
    timezone character varying(50),
    workflow_definition_id integer,
    workflow_step_id integer,
    auto_acknowledge_on_workflow_complete boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_triggers OWNER TO postgres;

--
-- Name: notification_triggers_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_triggers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_triggers_id_seq OWNER TO postgres;

--
-- Name: notification_triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_triggers_id_seq OWNED BY notifications_system_enterprise.notification_triggers.id;


--
-- Name: notification_types; Type: TABLE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE TABLE notifications_system_enterprise.notification_types (
    id integer NOT NULL,
    type_name character varying(50) NOT NULL,
    type_category character varying(30),
    display_name character varying(100),
    description text,
    default_channels json,
    requires_acknowledgment boolean DEFAULT false,
    max_retry_attempts integer DEFAULT 3,
    escalation_enabled boolean DEFAULT false,
    compliance_required boolean DEFAULT false,
    icon_name character varying(50),
    default_priority character varying(20) DEFAULT 'MEDIUM'::character varying,
    is_user_configurable boolean DEFAULT true,
    weather_dependent boolean DEFAULT false,
    business_hours_only boolean DEFAULT false,
    requires_site_supervisor boolean DEFAULT false,
    insurance_reportable boolean DEFAULT false,
    emergency_override_quiet_hours boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE notifications_system_enterprise.notification_types OWNER TO postgres;

--
-- Name: notification_types_id_seq; Type: SEQUENCE; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE SEQUENCE notifications_system_enterprise.notification_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE notifications_system_enterprise.notification_types_id_seq OWNER TO postgres;

--
-- Name: notification_types_id_seq; Type: SEQUENCE OWNED BY; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER SEQUENCE notifications_system_enterprise.notification_types_id_seq OWNED BY notifications_system_enterprise.notification_types.id;


--
-- Name: ai_data_preparation; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.ai_data_preparation (
    id integer NOT NULL,
    etl_job_id integer,
    task_type character varying(50),
    task_status character varying(20),
    input_data_sample json,
    output_data_sample json,
    ai_confidence numeric(5,2),
    notes text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.ai_data_preparation OWNER TO postgres;

--
-- Name: ai_data_preparation_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.ai_data_preparation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.ai_data_preparation_id_seq OWNER TO postgres;

--
-- Name: ai_data_preparation_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.ai_data_preparation_id_seq OWNED BY reports_business_intelligence.ai_data_preparation.id;


--
-- Name: ai_insight_log; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.ai_insight_log (
    id integer NOT NULL,
    insight_type character varying(50),
    insight_source_table character varying(100),
    insight_source_id integer,
    insight_content text,
    confidence_score numeric(5,2),
    is_actionable boolean DEFAULT false,
    action_taken boolean DEFAULT false,
    action_notes text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.ai_insight_log OWNER TO postgres;

--
-- Name: ai_insight_log_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.ai_insight_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.ai_insight_log_id_seq OWNER TO postgres;

--
-- Name: ai_insight_log_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.ai_insight_log_id_seq OWNED BY reports_business_intelligence.ai_insight_log.id;


--
-- Name: cache_reports; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.cache_reports (
    id integer NOT NULL,
    report_definition_id integer NOT NULL,
    cache_key character varying(255) NOT NULL,
    cached_data json,
    expires_at timestamp without time zone,
    file_size_bytes integer,
    access_count integer DEFAULT 0,
    last_accessed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.cache_reports OWNER TO postgres;

--
-- Name: cache_reports_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.cache_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.cache_reports_id_seq OWNER TO postgres;

--
-- Name: cache_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.cache_reports_id_seq OWNED BY reports_business_intelligence.cache_reports.id;


--
-- Name: dashboard_definitions; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.dashboard_definitions (
    id integer NOT NULL,
    organization_id integer,
    dashboard_name character varying(100) NOT NULL,
    dashboard_category character varying(50),
    target_audience character varying(30),
    layout_config json,
    filter_defaults json,
    is_public boolean DEFAULT false,
    is_template boolean DEFAULT false,
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.dashboard_definitions OWNER TO postgres;

--
-- Name: dashboard_definitions_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.dashboard_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.dashboard_definitions_id_seq OWNER TO postgres;

--
-- Name: dashboard_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.dashboard_definitions_id_seq OWNED BY reports_business_intelligence.dashboard_definitions.id;


--
-- Name: dashboard_performance_metrics; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.dashboard_performance_metrics (
    id integer NOT NULL,
    dashboard_definition_id integer NOT NULL,
    widget_id integer,
    load_time_ms integer,
    api_calls_count integer,
    data_transferred_kb integer,
    is_cached boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.dashboard_performance_metrics OWNER TO postgres;

--
-- Name: dashboard_performance_metrics_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.dashboard_performance_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.dashboard_performance_metrics_id_seq OWNER TO postgres;

--
-- Name: dashboard_performance_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.dashboard_performance_metrics_id_seq OWNED BY reports_business_intelligence.dashboard_performance_metrics.id;


--
-- Name: dashboard_permissions; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.dashboard_permissions (
    id integer NOT NULL,
    dashboard_definition_id integer NOT NULL,
    contact_id integer NOT NULL,
    permission_level character varying(20),
    can_edit boolean DEFAULT false,
    can_share boolean DEFAULT false,
    granted_by_contact_id integer,
    granted_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.dashboard_permissions OWNER TO postgres;

--
-- Name: dashboard_permissions_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.dashboard_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.dashboard_permissions_id_seq OWNER TO postgres;

--
-- Name: dashboard_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.dashboard_permissions_id_seq OWNED BY reports_business_intelligence.dashboard_permissions.id;


--
-- Name: dashboard_schedules; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.dashboard_schedules (
    id integer NOT NULL,
    dashboard_definition_id integer NOT NULL,
    schedule_name character varying(100),
    cron_expression character varying(50),
    timezone character varying(50),
    recipient_emails json,
    delivery_format character varying(20),
    is_active boolean DEFAULT true,
    next_execution_at timestamp without time zone,
    last_execution_at timestamp without time zone,
    total_scheduled_executions integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.dashboard_schedules OWNER TO postgres;

--
-- Name: dashboard_schedules_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.dashboard_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.dashboard_schedules_id_seq OWNER TO postgres;

--
-- Name: dashboard_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.dashboard_schedules_id_seq OWNED BY reports_business_intelligence.dashboard_schedules.id;


--
-- Name: dashboard_widgets; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.dashboard_widgets (
    id integer NOT NULL,
    dashboard_definition_id integer NOT NULL,
    widget_name character varying(100),
    widget_type character varying(30),
    widget_config json,
    data_source_config json,
    position_x integer,
    position_y integer,
    width integer,
    height integer,
    is_visible boolean DEFAULT true,
    refresh_interval_minutes integer DEFAULT 15,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.dashboard_widgets OWNER TO postgres;

--
-- Name: dashboard_widgets_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.dashboard_widgets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.dashboard_widgets_id_seq OWNER TO postgres;

--
-- Name: dashboard_widgets_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.dashboard_widgets_id_seq OWNED BY reports_business_intelligence.dashboard_widgets.id;


--
-- Name: data_dictionary; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.data_dictionary (
    id integer NOT NULL,
    table_id integer NOT NULL,
    column_name character varying(100) NOT NULL,
    data_type character varying(50),
    description text,
    business_definition text,
    is_metric boolean DEFAULT false,
    metric_formula text,
    data_owner_contact_id integer,
    is_pii boolean DEFAULT false,
    last_updated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.data_dictionary OWNER TO postgres;

--
-- Name: data_dictionary_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.data_dictionary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.data_dictionary_id_seq OWNER TO postgres;

--
-- Name: data_dictionary_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.data_dictionary_id_seq OWNED BY reports_business_intelligence.data_dictionary.id;


--
-- Name: data_quality_checks; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.data_quality_checks (
    id integer NOT NULL,
    etl_job_id integer,
    check_name character varying(100) NOT NULL,
    check_type character varying(50),
    check_description text,
    check_status character varying(20),
    check_results json,
    checked_table character varying(100),
    checked_column character varying(100),
    checked_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.data_quality_checks OWNER TO postgres;

--
-- Name: data_quality_checks_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.data_quality_checks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.data_quality_checks_id_seq OWNER TO postgres;

--
-- Name: data_quality_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.data_quality_checks_id_seq OWNED BY reports_business_intelligence.data_quality_checks.id;


--
-- Name: data_warehouse_tables; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.data_warehouse_tables (
    id integer NOT NULL,
    table_name character varying(100) NOT NULL,
    description text,
    source_system character varying(50),
    ingestion_frequency character varying(20),
    last_updated_at timestamp without time zone,
    row_count bigint,
    data_classification character varying(20),
    schema_definition json,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.data_warehouse_tables OWNER TO postgres;

--
-- Name: data_warehouse_tables_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.data_warehouse_tables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.data_warehouse_tables_id_seq OWNER TO postgres;

--
-- Name: data_warehouse_tables_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.data_warehouse_tables_id_seq OWNED BY reports_business_intelligence.data_warehouse_tables.id;


--
-- Name: etl_jobs; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.etl_jobs (
    id integer NOT NULL,
    job_name character varying(100) NOT NULL,
    job_description text,
    source_database character varying(50),
    source_table character varying(100),
    destination_table character varying(100) NOT NULL,
    transformation_script text,
    schedule_cron character varying(50),
    last_run_at timestamp without time zone,
    last_run_status character varying(20),
    is_active boolean DEFAULT true,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.etl_jobs OWNER TO postgres;

--
-- Name: etl_jobs_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.etl_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.etl_jobs_id_seq OWNER TO postgres;

--
-- Name: etl_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.etl_jobs_id_seq OWNED BY reports_business_intelligence.etl_jobs.id;


--
-- Name: kpi_alerts; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.kpi_alerts (
    id integer NOT NULL,
    kpi_definition_id integer NOT NULL,
    kpi_value_id integer NOT NULL,
    alert_type character varying(20),
    alert_message text,
    threshold_breached numeric(12,2),
    actual_value numeric(12,2),
    severity_level integer,
    notification_sent boolean DEFAULT false,
    acknowledged_by_contact_id integer,
    acknowledged_at timestamp without time zone,
    resolution_notes text,
    auto_resolved boolean DEFAULT false,
    resolved_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.kpi_alerts OWNER TO postgres;

--
-- Name: kpi_alerts_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.kpi_alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.kpi_alerts_id_seq OWNER TO postgres;

--
-- Name: kpi_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.kpi_alerts_id_seq OWNED BY reports_business_intelligence.kpi_alerts.id;


--
-- Name: kpi_benchmarks; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.kpi_benchmarks (
    id integer NOT NULL,
    organization_id integer,
    kpi_definition_id integer NOT NULL,
    benchmark_name character varying(100) NOT NULL,
    industry_segment character varying(100),
    benchmark_value numeric(12,2),
    benchmark_source character varying(100),
    publication_date date,
    notes text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.kpi_benchmarks OWNER TO postgres;

--
-- Name: kpi_benchmarks_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.kpi_benchmarks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.kpi_benchmarks_id_seq OWNER TO postgres;

--
-- Name: kpi_benchmarks_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.kpi_benchmarks_id_seq OWNED BY reports_business_intelligence.kpi_benchmarks.id;


--
-- Name: kpi_definitions; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.kpi_definitions (
    id integer NOT NULL,
    organization_id integer,
    kpi_name character varying(100) NOT NULL,
    kpi_category character varying(50),
    kpi_type character varying(30),
    calculation_formula text,
    data_sources json,
    calculation_frequency character varying(20),
    target_value numeric(12,2),
    warning_threshold numeric(12,2),
    critical_threshold numeric(12,2),
    trend_direction_preference character varying(10),
    benchmark_data json,
    is_visible_dashboard boolean DEFAULT true,
    chart_type character varying(20),
    unit_of_measure character varying(20),
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.kpi_definitions OWNER TO postgres;

--
-- Name: kpi_definitions_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.kpi_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.kpi_definitions_id_seq OWNER TO postgres;

--
-- Name: kpi_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.kpi_definitions_id_seq OWNED BY reports_business_intelligence.kpi_definitions.id;


--
-- Name: kpi_values; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.kpi_values (
    id integer NOT NULL,
    kpi_definition_id integer NOT NULL,
    calculation_date date,
    calculation_time time without time zone,
    calculated_value numeric(12,2),
    target_value numeric(12,2),
    variance_amount numeric(12,2),
    variance_percentage numeric(5,2),
    performance_status character varying(20),
    trend_direction character varying(10),
    contributing_factors json,
    drill_down_data json,
    confidence_score numeric(5,2),
    benchmark_comparison json,
    calculated_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.kpi_values OWNER TO postgres;

--
-- Name: kpi_values_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.kpi_values_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.kpi_values_id_seq OWNER TO postgres;

--
-- Name: kpi_values_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.kpi_values_id_seq OWNED BY reports_business_intelligence.kpi_values.id;


--
-- Name: performance_monitoring; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.performance_monitoring (
    id integer NOT NULL,
    metric_name character varying(100) NOT NULL,
    metric_value numeric(10,2),
    entity_type character varying(50),
    entity_id integer,
    timestamp_recorded timestamp without time zone DEFAULT now(),
    additional_data json,
    is_alert boolean DEFAULT false
);


ALTER TABLE reports_business_intelligence.performance_monitoring OWNER TO postgres;

--
-- Name: performance_monitoring_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.performance_monitoring_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.performance_monitoring_id_seq OWNER TO postgres;

--
-- Name: performance_monitoring_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.performance_monitoring_id_seq OWNED BY reports_business_intelligence.performance_monitoring.id;


--
-- Name: query_optimizations; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.query_optimizations (
    id integer NOT NULL,
    report_definition_id integer,
    kpi_definition_id integer,
    suggestion_type character varying(50),
    suggestion_details json,
    suggested_by_ai boolean DEFAULT true,
    is_applied boolean DEFAULT false,
    applied_at timestamp without time zone,
    performance_gain_percentage numeric(5,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.query_optimizations OWNER TO postgres;

--
-- Name: query_optimizations_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.query_optimizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.query_optimizations_id_seq OWNER TO postgres;

--
-- Name: query_optimizations_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.query_optimizations_id_seq OWNED BY reports_business_intelligence.query_optimizations.id;


--
-- Name: report_access_log; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.report_access_log (
    id integer NOT NULL,
    entity_type character varying(50),
    entity_id integer NOT NULL,
    contact_id integer NOT NULL,
    access_timestamp timestamp without time zone DEFAULT now(),
    action_type character varying(20),
    access_details json
);


ALTER TABLE reports_business_intelligence.report_access_log OWNER TO postgres;

--
-- Name: report_access_log_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.report_access_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.report_access_log_id_seq OWNER TO postgres;

--
-- Name: report_access_log_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.report_access_log_id_seq OWNED BY reports_business_intelligence.report_access_log.id;


--
-- Name: report_definitions; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.report_definitions (
    id integer NOT NULL,
    organization_id integer,
    report_name character varying(100) NOT NULL,
    report_category character varying(50),
    report_type character varying(30),
    report_description text,
    sql_query text,
    parameters_schema json,
    output_formats json,
    template_config json,
    data_sources json,
    estimated_execution_time integer,
    cache_duration_minutes integer DEFAULT 60,
    requires_approval boolean DEFAULT false,
    is_public boolean DEFAULT false,
    created_by_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.report_definitions OWNER TO postgres;

--
-- Name: report_definitions_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.report_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.report_definitions_id_seq OWNER TO postgres;

--
-- Name: report_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.report_definitions_id_seq OWNED BY reports_business_intelligence.report_definitions.id;


--
-- Name: report_executions; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.report_executions (
    id integer NOT NULL,
    report_definition_id integer NOT NULL,
    execution_type character varying(20),
    parameters_used json,
    execution_status character varying(20),
    output_url character varying(255),
    output_format character varying(20),
    total_records integer,
    execution_time_seconds numeric(8,2),
    error_message text,
    executed_by_contact_id integer,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.report_executions OWNER TO postgres;

--
-- Name: report_executions_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.report_executions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.report_executions_id_seq OWNER TO postgres;

--
-- Name: report_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.report_executions_id_seq OWNED BY reports_business_intelligence.report_executions.id;


--
-- Name: report_performance_metrics; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.report_performance_metrics (
    id integer NOT NULL,
    report_definition_id integer NOT NULL,
    execution_id integer NOT NULL,
    execution_time_ms integer,
    memory_usage_mb numeric(8,2),
    cpu_usage_percentage numeric(5,2),
    data_processed_mb bigint,
    query_plan_info json,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.report_performance_metrics OWNER TO postgres;

--
-- Name: report_performance_metrics_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.report_performance_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.report_performance_metrics_id_seq OWNER TO postgres;

--
-- Name: report_performance_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.report_performance_metrics_id_seq OWNED BY reports_business_intelligence.report_performance_metrics.id;


--
-- Name: report_permissions; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.report_permissions (
    id integer NOT NULL,
    report_definition_id integer NOT NULL,
    contact_id integer NOT NULL,
    permission_level character varying(20),
    can_execute boolean DEFAULT false,
    can_schedule boolean DEFAULT false,
    can_modify_parameters boolean DEFAULT false,
    granted_by_contact_id integer,
    granted_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.report_permissions OWNER TO postgres;

--
-- Name: report_permissions_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.report_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.report_permissions_id_seq OWNER TO postgres;

--
-- Name: report_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.report_permissions_id_seq OWNED BY reports_business_intelligence.report_permissions.id;


--
-- Name: report_schedules; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.report_schedules (
    id integer NOT NULL,
    report_definition_id integer NOT NULL,
    schedule_name character varying(100),
    cron_expression character varying(50),
    timezone character varying(50),
    recipient_emails json,
    delivery_format character varying(20),
    parameters json,
    is_active boolean DEFAULT true,
    next_execution_at timestamp without time zone,
    last_execution_at timestamp without time zone,
    total_scheduled_executions integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.report_schedules OWNER TO postgres;

--
-- Name: report_schedules_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.report_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.report_schedules_id_seq OWNER TO postgres;

--
-- Name: report_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.report_schedules_id_seq OWNED BY reports_business_intelligence.report_schedules.id;


--
-- Name: user_analytics; Type: TABLE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE TABLE reports_business_intelligence.user_analytics (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    organization_id integer,
    activity_type character varying(50),
    activity_details json,
    session_id character varying(100),
    device_info json,
    ip_address character varying(45),
    timestamp_recorded timestamp without time zone DEFAULT now()
);


ALTER TABLE reports_business_intelligence.user_analytics OWNER TO postgres;

--
-- Name: user_analytics_id_seq; Type: SEQUENCE; Schema: reports_business_intelligence; Owner: postgres
--

CREATE SEQUENCE reports_business_intelligence.user_analytics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE reports_business_intelligence.user_analytics_id_seq OWNER TO postgres;

--
-- Name: user_analytics_id_seq; Type: SEQUENCE OWNED BY; Schema: reports_business_intelligence; Owner: postgres
--

ALTER SEQUENCE reports_business_intelligence.user_analytics_id_seq OWNED BY reports_business_intelligence.user_analytics.id;


--
-- Name: appointment_types; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.appointment_types (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    category character varying(30),
    priority_level integer,
    estimated_duration_hours numeric(4,2),
    required_skills character varying(500),
    requires_equipment boolean DEFAULT false,
    allows_overlap boolean DEFAULT false,
    buffer_time_before character varying(20),
    buffer_time_after character varying(20),
    is_billable boolean DEFAULT true,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.appointment_types OWNER TO postgres;

--
-- Name: appointment_types_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.appointment_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.appointment_types_id_seq OWNER TO postgres;

--
-- Name: appointment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.appointment_types_id_seq OWNED BY scheduling_weather.appointment_types.id;


--
-- Name: route_optimizations; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.route_optimizations (
    id integer NOT NULL,
    technician_contact_id integer NOT NULL,
    route_date date,
    optimized_sequence character varying(1000),
    total_travel_time_hours numeric(4,2),
    total_drive_distance_miles numeric(6,2),
    optimization_algorithm character varying(30),
    start_location_lat numeric(10,8),
    start_location_lng numeric(11,8),
    end_location_lat numeric(10,8),
    end_location_lng numeric(11,8),
    calculated_at timestamp without time zone,
    is_active_route boolean DEFAULT false,
    route_status character varying(20) DEFAULT 'OPTIMIZED'::character varying,
    fuel_cost_estimate numeric(8,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.route_optimizations OWNER TO postgres;

--
-- Name: route_optimizations_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.route_optimizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.route_optimizations_id_seq OWNER TO postgres;

--
-- Name: route_optimizations_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.route_optimizations_id_seq OWNED BY scheduling_weather.route_optimizations.id;


--
-- Name: technician_availability; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.technician_availability (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    day_of_week character varying(10),
    start_time time without time zone,
    end_time time without time zone,
    is_available boolean DEFAULT true,
    max_appointments_per_day integer,
    max_travel_distance_miles numeric(6,2),
    preferred_appointment_types character varying(200),
    overtime_willing boolean DEFAULT false,
    emergency_available boolean DEFAULT false,
    effective_start_date date,
    effective_end_date date,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.technician_availability OWNER TO postgres;

--
-- Name: technician_availability_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.technician_availability_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.technician_availability_id_seq OWNER TO postgres;

--
-- Name: technician_availability_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.technician_availability_id_seq OWNED BY scheduling_weather.technician_availability.id;


--
-- Name: technician_skills; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.technician_skills (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    skill_name character varying(50) NOT NULL,
    skill_level character varying(20),
    certification_number character varying(50),
    certification_authority character varying(100),
    certification_date date,
    expiration_date date,
    is_verified boolean DEFAULT false,
    verified_by_contact_id integer,
    verification_date date,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.technician_skills OWNER TO postgres;

--
-- Name: technician_skills_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.technician_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.technician_skills_id_seq OWNER TO postgres;

--
-- Name: technician_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.technician_skills_id_seq OWNED BY scheduling_weather.technician_skills.id;


--
-- Name: travel_time_cache; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.travel_time_cache (
    id integer NOT NULL,
    origin_latitude numeric(10,8),
    origin_longitude numeric(11,8),
    destination_latitude numeric(10,8),
    destination_longitude numeric(11,8),
    travel_time_minutes numeric(6,2),
    travel_distance_miles numeric(8,2),
    traffic_condition character varying(20),
    time_of_day time without time zone,
    day_type character varying(20),
    api_source character varying(20),
    cache_timestamp timestamp without time zone,
    cache_expires_at timestamp without time zone,
    is_valid boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.travel_time_cache OWNER TO postgres;

--
-- Name: travel_time_cache_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.travel_time_cache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.travel_time_cache_id_seq OWNER TO postgres;

--
-- Name: travel_time_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.travel_time_cache_id_seq OWNED BY scheduling_weather.travel_time_cache.id;


--
-- Name: weather_alerts; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.weather_alerts (
    id integer NOT NULL,
    alert_type character varying(30),
    severity_level character varying(20),
    affected_zip_codes character varying(500),
    alert_start_time timestamp without time zone,
    alert_end_time timestamp without time zone,
    alert_description text,
    recommended_actions text,
    auto_reschedule_enabled boolean DEFAULT false,
    notification_sent boolean DEFAULT false,
    appointments_affected_count integer,
    api_source character varying(20),
    alert_id_external character varying(50),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.weather_alerts OWNER TO postgres;

--
-- Name: weather_alerts_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.weather_alerts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.weather_alerts_id_seq OWNER TO postgres;

--
-- Name: weather_alerts_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.weather_alerts_id_seq OWNED BY scheduling_weather.weather_alerts.id;


--
-- Name: weather_forecasts; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.weather_forecasts (
    id integer NOT NULL,
    property_id integer,
    latitude numeric(10,8),
    longitude numeric(11,8),
    forecast_date date,
    forecast_time time without time zone,
    temperature_high_f numeric(5,2),
    temperature_low_f numeric(5,2),
    current_temperature_f numeric(5,2),
    rain_probability_percent numeric(5,2),
    wind_speed_mph numeric(5,2),
    wind_direction character varying(5),
    conditions character varying(20),
    humidity_percent numeric(5,2),
    uv_index numeric(3,1),
    api_source character varying(20),
    raw_api_response json,
    fetched_at timestamp without time zone,
    is_suitable_for_roof_work boolean,
    is_suitable_for_exterior_work boolean,
    is_suitable_for_equipment_setup boolean,
    weather_risk_score numeric(3,1),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.weather_forecasts OWNER TO postgres;

--
-- Name: weather_forecasts_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.weather_forecasts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.weather_forecasts_id_seq OWNER TO postgres;

--
-- Name: weather_forecasts_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.weather_forecasts_id_seq OWNED BY scheduling_weather.weather_forecasts.id;


--
-- Name: weather_impact_rules; Type: TABLE; Schema: scheduling_weather; Owner: postgres
--

CREATE TABLE scheduling_weather.weather_impact_rules (
    id integer NOT NULL,
    rule_name character varying(100),
    appointment_type_id integer,
    weather_condition character varying(30),
    threshold_value numeric(8,2),
    threshold_operator character varying(10),
    recommended_action character varying(30),
    auto_apply boolean DEFAULT false,
    requires_approval boolean DEFAULT true,
    notification_template character varying(200),
    is_active boolean DEFAULT true,
    priority_order integer,
    effective_start_date date,
    effective_end_date date,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE scheduling_weather.weather_impact_rules OWNER TO postgres;

--
-- Name: weather_impact_rules_id_seq; Type: SEQUENCE; Schema: scheduling_weather; Owner: postgres
--

CREATE SEQUENCE scheduling_weather.weather_impact_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE scheduling_weather.weather_impact_rules_id_seq OWNER TO postgres;

--
-- Name: weather_impact_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: scheduling_weather; Owner: postgres
--

ALTER SEQUENCE scheduling_weather.weather_impact_rules_id_seq OWNED BY scheduling_weather.weather_impact_rules.id;


--
-- Name: common_tasks; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.common_tasks (
    id integer NOT NULL,
    organization_id integer,
    common_task_name character varying(100) NOT NULL,
    description text,
    task_category_id integer,
    priority character varying(10) DEFAULT 'NORMAL'::character varying,
    estimated_duration_hours numeric(6,2),
    is_system_template boolean DEFAULT false,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.common_tasks OWNER TO postgres;

--
-- Name: common_tasks_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.common_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.common_tasks_id_seq OWNER TO postgres;

--
-- Name: common_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.common_tasks_id_seq OWNED BY task_management.common_tasks.id;


--
-- Name: projects; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.projects (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    project_name character varying(100) NOT NULL,
    description text,
    start_date date,
    end_date date,
    status character varying(20) DEFAULT 'ACTIVE'::character varying,
    budget numeric(12,2),
    actual_cost numeric(12,2) DEFAULT 0,
    project_manager_contact_id integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.projects_id_seq OWNED BY task_management.projects.id;


--
-- Name: task_assignments; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_assignments (
    id integer NOT NULL,
    task_id integer NOT NULL,
    assigned_to_contact_id integer NOT NULL,
    is_primary_assignee boolean DEFAULT true,
    is_completed boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_assignments OWNER TO postgres;

--
-- Name: task_assignments_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_assignments_id_seq OWNER TO postgres;

--
-- Name: task_assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_assignments_id_seq OWNED BY task_management.task_assignments.id;


--
-- Name: task_attachments; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_attachments (
    id integer NOT NULL,
    task_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    file_type character varying(50),
    file_size_kb integer,
    file_path character varying(255) NOT NULL,
    uploaded_by_contact_id integer,
    uploaded_at timestamp without time zone DEFAULT now(),
    is_private boolean DEFAULT false
);


ALTER TABLE task_management.task_attachments OWNER TO postgres;

--
-- Name: task_attachments_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_attachments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_attachments_id_seq OWNER TO postgres;

--
-- Name: task_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_attachments_id_seq OWNED BY task_management.task_attachments.id;


--
-- Name: task_categories; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_categories (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    color character varying(7),
    icon character varying(50),
    is_system_category boolean DEFAULT false,
    parent_category_id integer,
    order_sequence integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_categories OWNER TO postgres;

--
-- Name: task_categories_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_categories_id_seq OWNER TO postgres;

--
-- Name: task_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_categories_id_seq OWNED BY task_management.task_categories.id;


--
-- Name: task_checklist_items; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_checklist_items (
    id integer NOT NULL,
    checklist_id integer NOT NULL,
    item_name character varying(200) NOT NULL,
    is_completed boolean DEFAULT false,
    order_sequence integer,
    completed_by_contact_id integer,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_checklist_items OWNER TO postgres;

--
-- Name: task_checklist_items_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_checklist_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_checklist_items_id_seq OWNER TO postgres;

--
-- Name: task_checklist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_checklist_items_id_seq OWNED BY task_management.task_checklist_items.id;


--
-- Name: task_checklists; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_checklists (
    id integer NOT NULL,
    task_id integer NOT NULL,
    checklist_name character varying(100) NOT NULL,
    is_completed boolean DEFAULT false,
    order_sequence integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_checklists OWNER TO postgres;

--
-- Name: task_checklists_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_checklists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_checklists_id_seq OWNER TO postgres;

--
-- Name: task_checklists_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_checklists_id_seq OWNED BY task_management.task_checklists.id;


--
-- Name: task_comments; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_comments (
    id integer NOT NULL,
    task_id integer NOT NULL,
    comment_text text NOT NULL,
    comment_by_contact_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_comments OWNER TO postgres;

--
-- Name: task_comments_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_comments_id_seq OWNER TO postgres;

--
-- Name: task_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_comments_id_seq OWNED BY task_management.task_comments.id;


--
-- Name: task_logs; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_logs (
    id integer NOT NULL,
    task_id integer NOT NULL,
    log_type character varying(20) NOT NULL,
    log_details text,
    changed_by_contact_id integer,
    old_value text,
    new_value text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_logs OWNER TO postgres;

--
-- Name: task_logs_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_logs_id_seq OWNER TO postgres;

--
-- Name: task_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_logs_id_seq OWNED BY task_management.task_logs.id;


--
-- Name: task_metrics; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_metrics (
    id integer NOT NULL,
    task_id integer NOT NULL,
    time_to_completion_minutes integer,
    reassignment_count integer DEFAULT 0,
    comment_count integer DEFAULT 0,
    attachment_count integer DEFAULT 0,
    checklist_completion_rate numeric(5,2),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_metrics OWNER TO postgres;

--
-- Name: task_metrics_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_metrics_id_seq OWNER TO postgres;

--
-- Name: task_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_metrics_id_seq OWNED BY task_management.task_metrics.id;


--
-- Name: task_performance_metrics; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.task_performance_metrics (
    id integer NOT NULL,
    contact_id integer NOT NULL,
    period_type character varying(10) NOT NULL,
    period_start_date date NOT NULL,
    period_end_date date NOT NULL,
    tasks_completed integer DEFAULT 0,
    tasks_completed_early integer DEFAULT 0,
    quality_points integer DEFAULT 0,
    collaboration_points integer DEFAULT 0,
    innovation_points integer DEFAULT 0,
    efficiency_points integer DEFAULT 0,
    total_score integer DEFAULT 0,
    rank_in_organization integer,
    achievements_unlocked json,
    streak_days integer DEFAULT 0,
    longest_streak integer DEFAULT 0,
    calculated_at timestamp without time zone DEFAULT now(),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.task_performance_metrics OWNER TO postgres;

--
-- Name: task_performance_metrics_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.task_performance_metrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.task_performance_metrics_id_seq OWNER TO postgres;

--
-- Name: task_performance_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.task_performance_metrics_id_seq OWNED BY task_management.task_performance_metrics.id;


--
-- Name: tasks; Type: TABLE; Schema: task_management; Owner: postgres
--

CREATE TABLE task_management.tasks (
    id integer NOT NULL,
    project_id integer,
    task_name character varying(200) NOT NULL,
    description text,
    task_category_id integer,
    status character varying(20) DEFAULT 'PENDING'::character varying,
    priority character varying(10) DEFAULT 'NORMAL'::character varying,
    due_date date,
    estimated_duration_hours numeric(6,2),
    actual_duration_hours numeric(6,2),
    assigned_to_contact_id integer,
    completed_at timestamp without time zone,
    is_recurring boolean DEFAULT false,
    recurring_config json,
    workflow_execution_id integer,
    is_private boolean DEFAULT false,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE task_management.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: task_management; Owner: postgres
--

CREATE SEQUENCE task_management.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE task_management.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: task_management; Owner: postgres
--

ALTER SEQUENCE task_management.tasks_id_seq OWNED BY task_management.tasks.id;


--
-- Name: business_rules; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.business_rules (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    rule_name character varying(100) NOT NULL,
    rule_category character varying(50),
    rule_type character varying(30),
    rule_expression text,
    ai_enhanced boolean DEFAULT false,
    rule_priority integer,
    applies_to_table character varying(50),
    applies_to_conditions json,
    action_on_true character varying(100),
    action_on_false character varying(100),
    related_workflow_id integer,
    success_rate numeric(5,2),
    false_positive_rate numeric(5,2),
    is_active boolean DEFAULT true,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.business_rules OWNER TO postgres;

--
-- Name: business_rules_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.business_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.business_rules_id_seq OWNER TO postgres;

--
-- Name: business_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.business_rules_id_seq OWNED BY workflows_automation_engine.business_rules.id;


--
-- Name: rule_actions; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.rule_actions (
    id integer NOT NULL,
    business_rule_id integer NOT NULL,
    action_order integer,
    action_type character varying(50),
    action_config json,
    ai_optimized_parameters json,
    success_rate numeric(5,2),
    conditions_for_execution json,
    retry_on_failure boolean DEFAULT false,
    max_retries integer DEFAULT 0,
    is_async boolean DEFAULT false,
    timeout_seconds integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.rule_actions OWNER TO postgres;

--
-- Name: rule_actions_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.rule_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.rule_actions_id_seq OWNER TO postgres;

--
-- Name: rule_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.rule_actions_id_seq OWNED BY workflows_automation_engine.rule_actions.id;


--
-- Name: rule_conditions; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.rule_conditions (
    id integer NOT NULL,
    business_rule_id integer NOT NULL,
    condition_order integer,
    condition_type character varying(30),
    field_name character varying(50),
    operator character varying(20),
    expected_value character varying(255),
    ai_model_id integer,
    weight numeric(5,2),
    logical_operator character varying(10),
    external_api_config json,
    calculation_formula text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.rule_conditions OWNER TO postgres;

--
-- Name: rule_conditions_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.rule_conditions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.rule_conditions_id_seq OWNER TO postgres;

--
-- Name: rule_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.rule_conditions_id_seq OWNED BY workflows_automation_engine.rule_conditions.id;


--
-- Name: rule_executions; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.rule_executions (
    id integer NOT NULL,
    business_rule_id integer NOT NULL,
    context_table character varying(50),
    context_id integer,
    rule_result boolean,
    ai_confidence_score numeric(5,2),
    execution_details json,
    action_taken character varying(100),
    execution_time_ms numeric(8,2),
    ai_override_applied boolean DEFAULT false,
    human_feedback character varying(20),
    error_message text,
    workflow_execution_id integer,
    executed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.rule_executions OWNER TO postgres;

--
-- Name: rule_executions_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.rule_executions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.rule_executions_id_seq OWNER TO postgres;

--
-- Name: rule_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.rule_executions_id_seq OWNED BY workflows_automation_engine.rule_executions.id;


--
-- Name: workflow_definitions; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.workflow_definitions (
    id integer NOT NULL,
    organization_id integer,
    workflow_name character varying(100) NOT NULL,
    workflow_description text,
    workflow_category character varying(50),
    trigger_type character varying(30),
    trigger_config json,
    is_active boolean DEFAULT true,
    is_system_workflow boolean DEFAULT false,
    execution_priority integer,
    max_concurrent_executions integer,
    timeout_minutes integer,
    created_by_contact_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.workflow_definitions OWNER TO postgres;

--
-- Name: workflow_definitions_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.workflow_definitions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.workflow_definitions_id_seq OWNER TO postgres;

--
-- Name: workflow_definitions_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.workflow_definitions_id_seq OWNED BY workflows_automation_engine.workflow_definitions.id;


--
-- Name: workflow_executions; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.workflow_executions (
    id integer NOT NULL,
    workflow_definition_id integer NOT NULL,
    execution_key character varying(100),
    context_table character varying(50),
    context_id integer,
    triggered_by character varying(30),
    triggered_by_contact_id integer,
    execution_status character varying(30),
    current_step_id integer,
    execution_data json,
    ai_optimization_applied boolean DEFAULT false,
    performance_metrics json,
    error_details json,
    started_at timestamp without time zone,
    completed_at timestamp without time zone,
    estimated_completion_at timestamp without time zone,
    total_duration_minutes numeric(8,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.workflow_executions OWNER TO postgres;

--
-- Name: workflow_executions_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.workflow_executions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.workflow_executions_id_seq OWNER TO postgres;

--
-- Name: workflow_executions_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.workflow_executions_id_seq OWNED BY workflows_automation_engine.workflow_executions.id;


--
-- Name: workflow_schedules; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.workflow_schedules (
    id integer NOT NULL,
    workflow_definition_id integer NOT NULL,
    schedule_name character varying(100),
    schedule_type character varying(20),
    cron_expression character varying(100),
    interval_minutes integer,
    ai_optimization_enabled boolean DEFAULT false,
    optimal_execution_times json,
    timezone character varying(50),
    is_active boolean DEFAULT true,
    next_execution_at timestamp without time zone,
    last_execution_at timestamp without time zone,
    total_scheduled_executions integer DEFAULT 0,
    max_executions integer,
    performance_metrics json,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.workflow_schedules OWNER TO postgres;

--
-- Name: workflow_schedules_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.workflow_schedules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.workflow_schedules_id_seq OWNER TO postgres;

--
-- Name: workflow_schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.workflow_schedules_id_seq OWNED BY workflows_automation_engine.workflow_schedules.id;


--
-- Name: workflow_steps; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.workflow_steps (
    id integer NOT NULL,
    workflow_definition_id integer NOT NULL,
    step_name character varying(100),
    step_order integer,
    step_type character varying(50),
    step_config json,
    parent_step_id integer,
    condition_expression text,
    ai_model_id integer,
    retry_strategy character varying(30),
    max_retries integer DEFAULT 3,
    timeout_minutes integer,
    is_parallel boolean DEFAULT false,
    success_criteria json,
    failure_handling character varying(30),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.workflow_steps OWNER TO postgres;

--
-- Name: workflow_steps_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.workflow_steps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.workflow_steps_id_seq OWNER TO postgres;

--
-- Name: workflow_steps_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.workflow_steps_id_seq OWNED BY workflows_automation_engine.workflow_steps.id;


--
-- Name: workflow_templates; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.workflow_templates (
    id integer NOT NULL,
    organization_id integer,
    template_name character varying(100),
    template_category character varying(50),
    template_description text,
    industry_specific boolean DEFAULT false,
    template_config json,
    usage_count integer DEFAULT 0,
    success_rate numeric(5,2),
    ai_recommendation_score numeric(5,2),
    customization_complexity character varying(20),
    estimated_setup_time_minutes integer,
    estimated_roi_percentage numeric(5,2),
    created_by_contact_id integer,
    is_public boolean DEFAULT false,
    rating_average numeric(3,2),
    total_ratings integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.workflow_templates OWNER TO postgres;

--
-- Name: workflow_templates_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.workflow_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.workflow_templates_id_seq OWNER TO postgres;

--
-- Name: workflow_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.workflow_templates_id_seq OWNED BY workflows_automation_engine.workflow_templates.id;


--
-- Name: workflow_variables; Type: TABLE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE TABLE workflows_automation_engine.workflow_variables (
    id integer NOT NULL,
    workflow_execution_id integer NOT NULL,
    variable_name character varying(100),
    variable_type character varying(20),
    variable_value text,
    variable_scope character varying(20),
    is_input boolean DEFAULT false,
    is_output boolean DEFAULT false,
    is_ai_generated boolean DEFAULT false,
    ai_confidence_score numeric(5,2),
    source_step_id integer,
    encryption_required boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE workflows_automation_engine.workflow_variables OWNER TO postgres;

--
-- Name: workflow_variables_id_seq; Type: SEQUENCE; Schema: workflows_automation_engine; Owner: postgres
--

CREATE SEQUENCE workflows_automation_engine.workflow_variables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE workflows_automation_engine.workflow_variables_id_seq OWNER TO postgres;

--
-- Name: workflow_variables_id_seq; Type: SEQUENCE OWNED BY; Schema: workflows_automation_engine; Owner: postgres
--

ALTER SEQUENCE workflows_automation_engine.workflow_variables_id_seq OWNED BY workflows_automation_engine.workflow_variables.id;


--
-- Name: audit_log id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.audit_log ALTER COLUMN id SET DEFAULT nextval('base_foundation.audit_log_id_seq'::regclass);


--
-- Name: avatars id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.avatars ALTER COLUMN id SET DEFAULT nextval('base_foundation.avatars_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.companies ALTER COLUMN id SET DEFAULT nextval('base_foundation.companies_id_seq'::regclass);


--
-- Name: contact_organization_roles id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles ALTER COLUMN id SET DEFAULT nextval('base_foundation.contact_organization_roles_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contacts ALTER COLUMN id SET DEFAULT nextval('base_foundation.contacts_id_seq'::regclass);


--
-- Name: customer_projects id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.customer_projects ALTER COLUMN id SET DEFAULT nextval('base_foundation.customer_projects_id_seq'::regclass);


--
-- Name: emails id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.emails ALTER COLUMN id SET DEFAULT nextval('base_foundation.emails_id_seq'::regclass);


--
-- Name: employee_banking_info id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_banking_info ALTER COLUMN id SET DEFAULT nextval('base_foundation.employee_banking_info_id_seq'::regclass);


--
-- Name: employee_documents id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_documents ALTER COLUMN id SET DEFAULT nextval('base_foundation.employee_documents_id_seq'::regclass);


--
-- Name: employee_emergency_contacts id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_emergency_contacts ALTER COLUMN id SET DEFAULT nextval('base_foundation.employee_emergency_contacts_id_seq'::regclass);


--
-- Name: employee_personal_info id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_personal_info ALTER COLUMN id SET DEFAULT nextval('base_foundation.employee_personal_info_id_seq'::regclass);


--
-- Name: lead_sources id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_sources ALTER COLUMN id SET DEFAULT nextval('base_foundation.lead_sources_id_seq'::regclass);


--
-- Name: lead_statuses id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_statuses ALTER COLUMN id SET DEFAULT nextval('base_foundation.lead_statuses_id_seq'::regclass);


--
-- Name: organization_integrations id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_integrations ALTER COLUMN id SET DEFAULT nextval('base_foundation.organization_integrations_id_seq'::regclass);


--
-- Name: organization_settings id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_settings ALTER COLUMN id SET DEFAULT nextval('base_foundation.organization_settings_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organizations ALTER COLUMN id SET DEFAULT nextval('base_foundation.organizations_id_seq'::regclass);


--
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('base_foundation.password_reset_tokens_id_seq'::regclass);


--
-- Name: payroll_deductions id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_deductions ALTER COLUMN id SET DEFAULT nextval('base_foundation.payroll_deductions_id_seq'::regclass);


--
-- Name: payroll_records id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_records ALTER COLUMN id SET DEFAULT nextval('base_foundation.payroll_records_id_seq'::regclass);


--
-- Name: persons id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.persons ALTER COLUMN id SET DEFAULT nextval('base_foundation.persons_id_seq'::regclass);


--
-- Name: phones id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.phones ALTER COLUMN id SET DEFAULT nextval('base_foundation.phones_id_seq'::regclass);


--
-- Name: properties id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.properties ALTER COLUMN id SET DEFAULT nextval('base_foundation.properties_id_seq'::regclass);


--
-- Name: property_batch_data id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_batch_data ALTER COLUMN id SET DEFAULT nextval('base_foundation.property_batch_data_id_seq'::regclass);


--
-- Name: property_images id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_images ALTER COLUMN id SET DEFAULT nextval('base_foundation.property_images_id_seq'::regclass);


--
-- Name: property_notes id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_notes ALTER COLUMN id SET DEFAULT nextval('base_foundation.property_notes_id_seq'::regclass);


--
-- Name: property_visits id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_visits ALTER COLUMN id SET DEFAULT nextval('base_foundation.property_visits_id_seq'::regclass);


--
-- Name: role_types id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.role_types ALTER COLUMN id SET DEFAULT nextval('base_foundation.role_types_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.roles ALTER COLUMN id SET DEFAULT nextval('base_foundation.roles_id_seq'::regclass);


--
-- Name: user_sessions id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.user_sessions ALTER COLUMN id SET DEFAULT nextval('base_foundation.user_sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.users ALTER COLUMN id SET DEFAULT nextval('base_foundation.users_id_seq'::regclass);


--
-- Name: ai_agent_conversations id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.ai_agent_conversations_id_seq'::regclass);


--
-- Name: ai_agent_training_sessions id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_training_sessions ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.ai_agent_training_sessions_id_seq'::regclass);


--
-- Name: ai_chat_agents id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_chat_agents ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.ai_chat_agents_id_seq'::regclass);


--
-- Name: chat_attachments id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_attachments ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_attachments_id_seq'::regclass);


--
-- Name: chat_channel_members id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_members ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_channel_members_id_seq'::regclass);


--
-- Name: chat_channel_types id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_types ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_channel_types_id_seq'::regclass);


--
-- Name: chat_channels id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channels ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_channels_id_seq'::regclass);


--
-- Name: chat_mentions id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_mentions ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_mentions_id_seq'::regclass);


--
-- Name: chat_message_reactions id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_reactions ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_message_reactions_id_seq'::regclass);


--
-- Name: chat_message_threads id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_threads ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_message_threads_id_seq'::regclass);


--
-- Name: chat_messages id; Type: DEFAULT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_messages ALTER COLUMN id SET DEFAULT nextval('chat_enterprise_agora.chat_messages_id_seq'::regclass);


--
-- Name: document_access_log id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_access_log ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_access_log_id_seq'::regclass);


--
-- Name: document_folder_assignments id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folder_assignments ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_folder_assignments_id_seq'::regclass);


--
-- Name: document_folders id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folders ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_folders_id_seq'::regclass);


--
-- Name: document_ocr_results id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_ocr_results ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_ocr_results_id_seq'::regclass);


--
-- Name: document_permissions id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_permissions ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_permissions_id_seq'::regclass);


--
-- Name: document_reviews id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_reviews ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_reviews_id_seq'::regclass);


--
-- Name: document_shares id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_shares ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_shares_id_seq'::regclass);


--
-- Name: document_tags id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_tags ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_tags_id_seq'::regclass);


--
-- Name: document_types id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_types ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_types_id_seq'::regclass);


--
-- Name: document_versions id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_versions ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.document_versions_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents ALTER COLUMN id SET DEFAULT nextval('documentos_file_management.documents_id_seq'::regclass);


--
-- Name: email_accounts id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_accounts ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_accounts_id_seq'::regclass);


--
-- Name: email_assignments id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_assignments ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_assignments_id_seq'::regclass);


--
-- Name: email_attachments id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_attachments ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_attachments_id_seq'::regclass);


--
-- Name: email_automated_responses id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_automated_responses ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_automated_responses_id_seq'::regclass);


--
-- Name: email_campaigns id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_campaigns ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_campaigns_id_seq'::regclass);


--
-- Name: email_delivery_status id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_delivery_status ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_delivery_status_id_seq'::regclass);


--
-- Name: email_folders id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_folders ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_folders_id_seq'::regclass);


--
-- Name: email_labels id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_labels ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_labels_id_seq'::regclass);


--
-- Name: email_link_clicks id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_link_clicks ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_link_clicks_id_seq'::regclass);


--
-- Name: email_messages id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_messages ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_messages_id_seq'::regclass);


--
-- Name: email_performance_metrics id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_performance_metrics ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_performance_metrics_id_seq'::regclass);


--
-- Name: email_providers id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_providers ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_providers_id_seq'::regclass);


--
-- Name: email_recipients id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_recipients ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_recipients_id_seq'::regclass);


--
-- Name: email_template_variables id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_template_variables ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_template_variables_id_seq'::regclass);


--
-- Name: email_templates id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_templates ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_templates_id_seq'::regclass);


--
-- Name: email_threads id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_threads ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_threads_id_seq'::regclass);


--
-- Name: email_tracking_pixels id; Type: DEFAULT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_tracking_pixels ALTER COLUMN id SET DEFAULT nextval('emails_enterprise.email_tracking_pixels_id_seq'::regclass);


--
-- Name: bank_accounts id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_accounts ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.bank_accounts_id_seq'::regclass);


--
-- Name: bank_statements id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_statements ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.bank_statements_id_seq'::regclass);


--
-- Name: cash_accounts id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.cash_accounts ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.cash_accounts_id_seq'::regclass);


--
-- Name: check_register id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.check_register_id_seq'::regclass);


--
-- Name: commission_calculations id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.commission_calculations ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.commission_calculations_id_seq'::regclass);


--
-- Name: invoice_payments id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.invoice_payments ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.invoice_payments_id_seq'::regclass);


--
-- Name: irs_categories id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.irs_categories ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.irs_categories_id_seq'::regclass);


--
-- Name: transaction_categories id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.transaction_categories ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.transaction_categories_id_seq'::regclass);


--
-- Name: virtual_wallets id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.virtual_wallets ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.virtual_wallets_id_seq'::regclass);


--
-- Name: wallet_balances id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_balances ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.wallet_balances_id_seq'::regclass);


--
-- Name: wallet_types id; Type: DEFAULT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_types ALTER COLUMN id SET DEFAULT nextval('finanzas_bookkeeping.wallet_types_id_seq'::regclass);


--
-- Name: content_categories id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.content_categories ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.content_categories_id_seq'::regclass);


--
-- Name: damage_types id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.damage_types ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.damage_types_id_seq'::regclass);


--
-- Name: equipment_types id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.equipment_types ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.equipment_types_id_seq'::regclass);


--
-- Name: iicrc_standards id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.iicrc_standards ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.iicrc_standards_id_seq'::regclass);


--
-- Name: inspection_areas id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_areas ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.inspection_areas_id_seq'::regclass);


--
-- Name: inspection_types id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_types ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.inspection_types_id_seq'::regclass);


--
-- Name: inspections id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspections ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.inspections_id_seq'::regclass);


--
-- Name: service_categories id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.service_categories ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.service_categories_id_seq'::regclass);


--
-- Name: water_damage_categories id; Type: DEFAULT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.water_damage_categories ALTER COLUMN id SET DEFAULT nextval('inspecciones_evaluaciones.water_damage_categories_id_seq'::regclass);


--
-- Name: note_attachments id; Type: DEFAULT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_attachments ALTER COLUMN id SET DEFAULT nextval('notas_comunicacion.note_attachments_id_seq'::regclass);


--
-- Name: note_mentions id; Type: DEFAULT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_mentions ALTER COLUMN id SET DEFAULT nextval('notas_comunicacion.note_mentions_id_seq'::regclass);


--
-- Name: note_notifications id; Type: DEFAULT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_notifications ALTER COLUMN id SET DEFAULT nextval('notas_comunicacion.note_notifications_id_seq'::regclass);


--
-- Name: note_reactions id; Type: DEFAULT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_reactions ALTER COLUMN id SET DEFAULT nextval('notas_comunicacion.note_reactions_id_seq'::regclass);


--
-- Name: note_tags id; Type: DEFAULT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_tags ALTER COLUMN id SET DEFAULT nextval('notas_comunicacion.note_tags_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.notes ALTER COLUMN id SET DEFAULT nextval('notas_comunicacion.notes_id_seq'::regclass);


--
-- Name: escalation_rules id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.escalation_rules ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.escalation_rules_id_seq'::regclass);


--
-- Name: notification_analytics id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_analytics ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_analytics_id_seq'::regclass);


--
-- Name: notification_delivery_log id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_delivery_log ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_delivery_log_id_seq'::regclass);


--
-- Name: notification_failures id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_failures ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_failures_id_seq'::regclass);


--
-- Name: notification_queue id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_queue_id_seq'::regclass);


--
-- Name: notification_recipients id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_recipients ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_recipients_id_seq'::regclass);


--
-- Name: notification_rules id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_rules ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_rules_id_seq'::regclass);


--
-- Name: notification_templates id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_templates ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_templates_id_seq'::regclass);


--
-- Name: notification_triggers id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_triggers_id_seq'::regclass);


--
-- Name: notification_types id; Type: DEFAULT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_types ALTER COLUMN id SET DEFAULT nextval('notifications_system_enterprise.notification_types_id_seq'::regclass);


--
-- Name: ai_data_preparation id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.ai_data_preparation ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.ai_data_preparation_id_seq'::regclass);


--
-- Name: ai_insight_log id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.ai_insight_log ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.ai_insight_log_id_seq'::regclass);


--
-- Name: cache_reports id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.cache_reports ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.cache_reports_id_seq'::regclass);


--
-- Name: dashboard_definitions id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_definitions ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.dashboard_definitions_id_seq'::regclass);


--
-- Name: dashboard_performance_metrics id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_performance_metrics ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.dashboard_performance_metrics_id_seq'::regclass);


--
-- Name: dashboard_permissions id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_permissions ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.dashboard_permissions_id_seq'::regclass);


--
-- Name: dashboard_schedules id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_schedules ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.dashboard_schedules_id_seq'::regclass);


--
-- Name: dashboard_widgets id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_widgets ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.dashboard_widgets_id_seq'::regclass);


--
-- Name: data_dictionary id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_dictionary ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.data_dictionary_id_seq'::regclass);


--
-- Name: data_quality_checks id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_quality_checks ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.data_quality_checks_id_seq'::regclass);


--
-- Name: data_warehouse_tables id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_warehouse_tables ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.data_warehouse_tables_id_seq'::regclass);


--
-- Name: etl_jobs id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.etl_jobs ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.etl_jobs_id_seq'::regclass);


--
-- Name: kpi_alerts id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_alerts ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.kpi_alerts_id_seq'::regclass);


--
-- Name: kpi_benchmarks id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_benchmarks ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.kpi_benchmarks_id_seq'::regclass);


--
-- Name: kpi_definitions id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_definitions ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.kpi_definitions_id_seq'::regclass);


--
-- Name: kpi_values id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_values ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.kpi_values_id_seq'::regclass);


--
-- Name: performance_monitoring id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.performance_monitoring ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.performance_monitoring_id_seq'::regclass);


--
-- Name: query_optimizations id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.query_optimizations ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.query_optimizations_id_seq'::regclass);


--
-- Name: report_access_log id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_access_log ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.report_access_log_id_seq'::regclass);


--
-- Name: report_definitions id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_definitions ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.report_definitions_id_seq'::regclass);


--
-- Name: report_executions id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_executions ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.report_executions_id_seq'::regclass);


--
-- Name: report_performance_metrics id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_performance_metrics ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.report_performance_metrics_id_seq'::regclass);


--
-- Name: report_permissions id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_permissions ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.report_permissions_id_seq'::regclass);


--
-- Name: report_schedules id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_schedules ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.report_schedules_id_seq'::regclass);


--
-- Name: user_analytics id; Type: DEFAULT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.user_analytics ALTER COLUMN id SET DEFAULT nextval('reports_business_intelligence.user_analytics_id_seq'::regclass);


--
-- Name: appointment_types id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.appointment_types ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.appointment_types_id_seq'::regclass);


--
-- Name: route_optimizations id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.route_optimizations ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.route_optimizations_id_seq'::regclass);


--
-- Name: technician_availability id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_availability ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.technician_availability_id_seq'::regclass);


--
-- Name: technician_skills id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_skills ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.technician_skills_id_seq'::regclass);


--
-- Name: travel_time_cache id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.travel_time_cache ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.travel_time_cache_id_seq'::regclass);


--
-- Name: weather_alerts id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_alerts ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.weather_alerts_id_seq'::regclass);


--
-- Name: weather_forecasts id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_forecasts ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.weather_forecasts_id_seq'::regclass);


--
-- Name: weather_impact_rules id; Type: DEFAULT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_impact_rules ALTER COLUMN id SET DEFAULT nextval('scheduling_weather.weather_impact_rules_id_seq'::regclass);


--
-- Name: common_tasks id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.common_tasks ALTER COLUMN id SET DEFAULT nextval('task_management.common_tasks_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.projects ALTER COLUMN id SET DEFAULT nextval('task_management.projects_id_seq'::regclass);


--
-- Name: task_assignments id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_assignments ALTER COLUMN id SET DEFAULT nextval('task_management.task_assignments_id_seq'::regclass);


--
-- Name: task_attachments id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_attachments ALTER COLUMN id SET DEFAULT nextval('task_management.task_attachments_id_seq'::regclass);


--
-- Name: task_categories id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_categories ALTER COLUMN id SET DEFAULT nextval('task_management.task_categories_id_seq'::regclass);


--
-- Name: task_checklist_items id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklist_items ALTER COLUMN id SET DEFAULT nextval('task_management.task_checklist_items_id_seq'::regclass);


--
-- Name: task_checklists id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklists ALTER COLUMN id SET DEFAULT nextval('task_management.task_checklists_id_seq'::regclass);


--
-- Name: task_comments id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_comments ALTER COLUMN id SET DEFAULT nextval('task_management.task_comments_id_seq'::regclass);


--
-- Name: task_logs id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_logs ALTER COLUMN id SET DEFAULT nextval('task_management.task_logs_id_seq'::regclass);


--
-- Name: task_metrics id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_metrics ALTER COLUMN id SET DEFAULT nextval('task_management.task_metrics_id_seq'::regclass);


--
-- Name: task_performance_metrics id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_performance_metrics ALTER COLUMN id SET DEFAULT nextval('task_management.task_performance_metrics_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks ALTER COLUMN id SET DEFAULT nextval('task_management.tasks_id_seq'::regclass);


--
-- Name: business_rules id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.business_rules ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.business_rules_id_seq'::regclass);


--
-- Name: rule_actions id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_actions ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.rule_actions_id_seq'::regclass);


--
-- Name: rule_conditions id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_conditions ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.rule_conditions_id_seq'::regclass);


--
-- Name: rule_executions id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_executions ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.rule_executions_id_seq'::regclass);


--
-- Name: workflow_definitions id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_definitions ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.workflow_definitions_id_seq'::regclass);


--
-- Name: workflow_executions id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_executions ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.workflow_executions_id_seq'::regclass);


--
-- Name: workflow_schedules id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_schedules ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.workflow_schedules_id_seq'::regclass);


--
-- Name: workflow_steps id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_steps ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.workflow_steps_id_seq'::regclass);


--
-- Name: workflow_templates id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_templates ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.workflow_templates_id_seq'::regclass);


--
-- Name: workflow_variables id; Type: DEFAULT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_variables ALTER COLUMN id SET DEFAULT nextval('workflows_automation_engine.workflow_variables_id_seq'::regclass);


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.audit_log (id, organization_id, entity_name, entity_id, operation_type, created_at, changed_by_contact_id, changed_by_user_id, client_ip_address, user_agent, old_values, new_values, changed_fields, reason, session_id, request_id, transaction_id, severity_level, is_sensitive_data, compliance_flags, retention_until, additional_context) FROM stdin;
\.


--
-- Data for Name: avatars; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.avatars (id, contact_id, url, file_name, file_size, mime_type, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.companies (id, contact_id, company_name, founded_date, tax_id, legal_entity_type, industry, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contact_organization_roles; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.contact_organization_roles (id, contact_id, organization_id, role_id, is_active, assigned_at, assigned_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.contacts (id, is_company, name, last_name, full_name, lead_status_id, lead_source_id, assigned_salesperson_id, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- Data for Name: customer_projects; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.customer_projects (id, organization_id, project_name, project_status, client_contact_id, address, city, zip_code, start_date, end_date, estimated_cost, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: emails; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.emails (id, contact_id, email, is_main, is_verified, created_at) FROM stdin;
\.


--
-- Data for Name: employee_banking_info; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.employee_banking_info (id, contact_id, account_type, bank_name, routing_number, account_number, account_holder_name, is_active, verification_status, verified_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: employee_documents; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.employee_documents (id, contact_id, document_type, document_name, file_url, file_name, file_size, mime_type, expiration_date, is_required, approval_status, approved_by_contact_id, approved_at, uploaded_by_contact_id, created_at) FROM stdin;
\.


--
-- Data for Name: employee_emergency_contacts; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.employee_emergency_contacts (id, contact_id, emergency_contact_name, relationship, phone_primary, phone_secondary, email, address, is_primary, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: employee_personal_info; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.employee_personal_info (id, contact_id, employee_id, hire_date, employment_status, employment_type, department, job_title, manager_contact_id, work_location, marital_status, number_of_dependents, veteran_status, disability_status, preferred_language, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lead_sources; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.lead_sources (id, organization_id, source_name, source_category, cost_per_lead, conversion_rate, is_active, tracking_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lead_statuses; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.lead_statuses (id, organization_id, status_name, status_order, status_color, is_final_status, conversion_probability, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: organization_integrations; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.organization_integrations (id, organization_id, integration_type, api_key, api_secret, config_json, is_active, last_sync_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: organization_settings; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.organization_settings (id, organization_id, setting_key, setting_value, setting_type, description, is_encrypted, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.organizations (id, parent_id, name, organization_type, address_line_1, address_line_2, city, state, zip_code, country, phone, email, website, industry, tax_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.password_reset_tokens (id, user_id, token, expires_at, used_at, ip_address, user_agent, created_at) FROM stdin;
\.


--
-- Data for Name: payroll_deductions; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.payroll_deductions (id, payroll_record_id, deduction_type, deduction_name, deduction_amount, is_pre_tax, employer_contribution) FROM stdin;
\.


--
-- Data for Name: payroll_records; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.payroll_records (id, contact_id, pay_period_start, pay_period_end, pay_date, gross_pay, regular_hours, overtime_hours, regular_rate, overtime_rate, commission_amount, bonus_amount, total_deductions, net_pay, pay_method, payroll_batch_id, created_at) FROM stdin;
\.


--
-- Data for Name: persons; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.persons (id, contact_id, gender, birth_date, tax_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: phones; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.phones (id, contact_id, country_code, phone_number, extension, is_main, created_at) FROM stdin;
\.


--
-- Data for Name: properties; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.properties (id, place_id, address_line_1, address_line_2, city, state, zip_code, country, latitude, longitude, property_type, year_built, square_footage, lot_size, bedrooms, bathrooms, stories, roof_material, roof_age, construction_type, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: property_batch_data; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.property_batch_data (id, property_id, owner_name, owner_mailing_address, assessed_value, market_value, tax_amount, deed_date, sales_price, sales_date, mortgage_amount, mortgage_lender, property_use_code, last_updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: property_images; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.property_images (id, property_id, image_url, image_type, description, taken_at, taken_by_contact_id, file_size, mime_type, is_primary, created_at) FROM stdin;
\.


--
-- Data for Name: property_notes; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.property_notes (id, property_id, note_text, note_type, is_important, is_visible_to_customer, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: property_visits; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.property_visits (id, property_id, contact_id, sales_rep_id, visit_type, visit_date, visit_duration_minutes, outcome, notes, gps_latitude, gps_longitude, weather_conditions, follow_up_date, created_at) FROM stdin;
\.


--
-- Data for Name: role_types; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.role_types (id, role_name, description, permissions_json, is_system_role, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.roles (id, organization_id, role_type_id, role_name, custom_permissions_json, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.user_sessions (id, user_id, session_token, ip_address, user_agent, expires_at, is_active, last_activity_at, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: base_foundation; Owner: postgres
--

COPY base_foundation.users (id, contact_id, username, email, password_hash, is_email_verified, is_active, last_login_at, failed_login_attempts, account_locked_until, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ai_agent_conversations; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.ai_agent_conversations (id, ai_agent_id, chat_channel_id, user_contact_id, conversation_start_message_id, conversation_status, conversation_topic, context_data, user_satisfaction_score, resolution_type, escalated_to_contact_id, total_messages, ai_response_time_avg, started_at, ended_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ai_agent_training_sessions; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.ai_agent_training_sessions (id, ai_agent_id, training_type, training_data, training_source, conversation_id, feedback_type, feedback_details, trainer_contact_id, training_effectiveness, applied_at, model_version_before, model_version_after, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ai_chat_agents; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.ai_chat_agents (id, agent_name, agent_type, organization_id, personality_config, capabilities, training_data_source, language_support, response_style, confidence_threshold, is_active, learning_enabled, max_context_messages, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_attachments; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_attachments (id, chat_message_id, file_name, file_url, file_type, file_size_bytes, mime_type, thumbnail_url, is_encrypted, encryption_key, upload_status, virus_scan_status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_channel_members; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_channel_members (id, chat_channel_id, contact_id, member_role, can_add_members, can_delete_messages, can_moderate, is_muted, joined_at, last_read_at, is_active, notification_level, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_channel_types; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_channel_types (id, type_name, display_name, description, default_permissions, max_members, supports_ai_agents, supports_video_calls, is_system_type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_channels; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_channels (id, organization_id, channel_name, channel_type, description, created_by_contact_id, is_archived, channel_avatar_url, channel_settings, ai_agent_enabled, ai_agent_type, signalr_group_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_mentions; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_mentions (id, chat_message_id, mentioned_contact_id, mention_type, mention_text, notification_sent, notification_read, read_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_message_reactions; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_message_reactions (id, chat_message_id, contact_id, reaction_type, emoji_code, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_message_threads; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_message_threads (id, parent_message_id, thread_message_id, thread_level, thread_position, is_thread_starter, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: chat_messages; Type: TABLE DATA; Schema: chat_enterprise_agora; Owner: postgres
--

COPY chat_enterprise_agora.chat_messages (id, chat_channel_id, sender_contact_id, sender_type, message_type, message_content, original_language, translated_content, voice_note_url, voice_transcript, voice_duration_seconds, replied_to_message_id, is_edited, is_deleted, edited_at, deleted_at, ai_confidence, signalr_message_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_access_log; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_access_log (id, document_id, accessed_by_contact_id, access_type, access_method, ip_address, user_agent, session_id, share_token, access_granted, denial_reason, accessed_at, created_at) FROM stdin;
\.


--
-- Data for Name: document_folder_assignments; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_folder_assignments (id, document_id, folder_id, assigned_by_contact_id, assignment_reason, is_primary_location, assigned_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_folders; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_folders (id, organization_id, parent_folder_id, folder_name, folder_path, folder_type, related_entity_type, related_entity_id, is_system_folder, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_ocr_results; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_ocr_results (id, document_id, ocr_provider, extracted_text, confidence_score, processing_status, structured_data, key_value_pairs, processing_time_ms, error_message, processed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_permissions; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_permissions (id, document_id, grantee_type, grantee_id, permission_level, granted_by_contact_id, granted_at, expires_at, is_inherited, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_reviews; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_reviews (id, document_id, reviewer_contact_id, review_type, review_status, priority_level, due_date, review_comments, approved_at, rejected_at, rejection_reason, assigned_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_shares; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_shares (id, document_id, shared_by_contact_id, share_type, share_token, recipient_email, access_level, requires_password, password_hash, expires_at, max_downloads, download_count, last_accessed_at, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_tags; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_tags (id, document_id, tag_name, tag_category, tag_color, created_by_contact_id, is_system_tag, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_types; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_types (id, name, category, description, requires_approval, retention_days, allowed_file_types, max_file_size_mb, is_confidential, auto_ocr_enabled, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: document_versions; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.document_versions (id, document_id, version_number, version_description, file_path, s3_key, file_size_bytes, file_hash, created_by_contact_id, is_current_version, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: documentos_file_management; Owner: postgres
--

COPY documentos_file_management.documents (id, document_type_id, organization_id, related_entity_type, related_entity_id, file_name, file_path, s3_key, file_size_bytes, mime_type, file_hash, upload_source, uploaded_by_contact_id, upload_timestamp, is_confidential, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_accounts; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_accounts (id, organization_id, contact_id, email_provider_id, email_address, account_name, account_type, smtp_server, smtp_port, imap_server, imap_port, username, password_encrypted, oauth_token_encrypted, oauth_refresh_token_encrypted, sync_status, last_sync_at, sync_interval_minutes, auto_assign_enabled, is_primary, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_assignments; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_assignments (id, email_message_id, assigned_to_contact_id, assigned_by_contact_id, assignment_type, assignment_reason, priority_level, due_date, status, response_required, completed_at, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_attachments; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_attachments (id, email_message_id, attachment_name, file_url, s3_key, s3_bucket, mime_type, file_size, attachment_id, is_inline, content_id, download_status, virus_scan_status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_automated_responses; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_automated_responses (id, organization_id, email_account_id, rule_name, trigger_conditions, email_template_id, response_delay_minutes, active_hours_start, active_hours_end, active_days, max_responses_per_thread, is_out_of_office, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_campaigns; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_campaigns (id, organization_id, created_by_contact_id, campaign_name, campaign_type, email_template_id, target_audience_criteria, scheduled_send_at, send_status, total_recipients, emails_sent, emails_delivered, emails_opened, emails_clicked, bounce_count, unsubscribe_count, started_at, completed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_delivery_status; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_delivery_status (id, email_message_id, recipient_email, delivery_status, status_details, delivery_timestamp, bounce_type, bounce_reason, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_folders; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_folders (id, email_account_id, folder_name, folder_type, external_folder_id, parent_folder_id, folder_path, message_count, unread_count, last_sync_at, sync_enabled, is_system_folder, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_labels; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_labels (id, organization_id, label_name, label_color, label_category, description, is_system_label, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_link_clicks; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_link_clicks (id, email_message_id, recipient_email, original_url, clicked_url, click_timestamp, ip_address, user_agent, device_info, created_at) FROM stdin;
\.


--
-- Data for Name: email_messages; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_messages (id, email_account_id, email_folder_id, message_id, thread_id, subject, body_text, body_html, from_address, from_name, to_addresses, cc_addresses, bcc_addresses, reply_to_address, sent_at, received_at, is_read, is_starred, is_important, priority_level, context_type, context_id, assigned_to_contact_id, has_attachments, attachment_count, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_performance_metrics; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_performance_metrics (id, organization_id, email_account_id, contact_id, metric_date, emails_sent, emails_received, emails_opened, replies_sent, assigned_count, completed_assignments, average_response_time_minutes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_providers; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_providers (id, provider_name, provider_type, api_endpoint, authentication_type, supports_push_notifications, supports_threading, configuration, rate_limit_per_minute, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_recipients; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_recipients (id, email_message_id, contact_id, email_address, display_name, recipient_type, delivery_status, read_status, delivered_at, read_at, bounce_reason, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_template_variables; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_template_variables (id, variable_name, variable_category, data_type, data_source_table, data_source_field, format_template, description, is_required, default_value, is_system_variable, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_templates; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_templates (id, organization_id, created_by_contact_id, template_name, template_category, template_subcategory, subject_line, body_html, body_text, variables_schema, default_variables, usage_context, is_system_template, is_active, usage_count, last_used_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_threads; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_threads (id, thread_id, organization_id, subject_line, context_type, context_id, participants, message_count, last_message_at, last_activity_contact_id, is_archived, is_important, assigned_to_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: email_tracking_pixels; Type: TABLE DATA; Schema: emails_enterprise; Owner: postgres
--

COPY emails_enterprise.email_tracking_pixels (id, email_message_id, recipient_email, tracking_token, pixel_url, opened_at, open_count, device_info, ip_address, user_agent, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bank_accounts; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.bank_accounts (id, organization_id, account_name, account_type, bank_name, account_number, routing_number, plaid_account_id, plaid_access_token, current_balance, available_balance, last_sync_date, auto_sync_enabled, is_primary, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: bank_statements; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.bank_statements (id, bank_account_id, statement_month, statement_year, statement_start_date, statement_end_date, opening_balance, closing_balance, is_reconciled, reconciled_by_contact_id, reconciled_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: cash_accounts; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.cash_accounts (id, organization_id, account_name, current_balance, location, responsible_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: check_register; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.check_register (id, bank_account_id, check_number, payee_name, payee_contact_id, amount, memo, issue_date, cleared_date, status, wallet_id, related_invoice_id, issued_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: commission_calculations; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.commission_calculations (id, invoice_id, salesperson_contact_id, commission_percentage, commission_amount, calculation_base, payment_status, wallet_id, paid_via_check_id, calculated_at, paid_at, created_at) FROM stdin;
\.


--
-- Data for Name: invoice_payments; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.invoice_payments (id, invoice_id, payment_amount, payment_date, payment_method, payment_reference, bank_account_id, processed_payment_id, payment_processor_fee, net_payment_amount, notes, processed_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: irs_categories; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.irs_categories (id, category_code, category_name, irs_form_line, description, is_deductible, requires_documentation, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: transaction_categories; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.transaction_categories (id, organization_id, category_name, parent_category_id, irs_category_id, icon_name, color, is_expense, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: virtual_wallets; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.virtual_wallets (id, organization_id, wallet_type_id, wallet_name, description, current_balance, allocated_budget, responsible_contact_id, project_id, is_active, auto_allocate_rules, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: wallet_balances; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.wallet_balances (id, wallet_id, balance_date, opening_balance, total_debits, total_credits, closing_balance, transaction_count, created_at) FROM stdin;
\.


--
-- Data for Name: wallet_types; Type: TABLE DATA; Schema: finanzas_bookkeeping; Owner: postgres
--

COPY finanzas_bookkeeping.wallet_types (id, type_name, description, default_rules, icon_name, is_system_type, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: content_categories; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.content_categories (id, name, description, requires_detailed_photos, typical_salvage_rate_percent, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: damage_types; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.damage_types (id, name, category, description, severity_scale, assessment_criteria, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: equipment_types; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.equipment_types (id, name, category, description, manufacturer, model_number, specifications, reading_units, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iicrc_standards; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.iicrc_standards (id, standard_code, standard_name, description, applicable_damage_types, requirements, procedures, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: inspection_areas; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.inspection_areas (id, inspection_id, area_name, area_type, location_description, area_measurements, access_restrictions, area_notes, order_sequence, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: inspection_types; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.inspection_types (id, name, category, description, iicrc_standard_id, required_fields, optional_fields, requires_equipment_readings, requires_moisture_mapping, requires_content_inventory, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: inspections; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.inspections (id, customer_project_id, inspection_type_id, iicrc_standard_id, inspector_contact_id, inspection_status, inspection_date, start_time, end_time, general_notes, weather_conditions, safety_concerns, requires_follow_up, follow_up_date, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: service_categories; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.service_categories (id, name, category_type, description, typical_duration_days, requires_certification, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: water_damage_categories; Type: TABLE DATA; Schema: inspecciones_evaluaciones; Owner: postgres
--

COPY inspecciones_evaluaciones.water_damage_categories (id, category_name, category_level, description, source_description, safety_requirements, drying_procedures, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: note_attachments; Type: TABLE DATA; Schema: notas_comunicacion; Owner: postgres
--

COPY notas_comunicacion.note_attachments (id, note_id, document_id, attachment_type, attached_by_contact_id, attached_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: note_mentions; Type: TABLE DATA; Schema: notas_comunicacion; Owner: postgres
--

COPY notas_comunicacion.note_mentions (id, note_id, mentioned_contact_id, mentioned_at, is_notified, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: note_notifications; Type: TABLE DATA; Schema: notas_comunicacion; Owner: postgres
--

COPY notas_comunicacion.note_notifications (id, note_id, recipient_contact_id, notification_type, is_read, signalr_connection_id, read_at, created_at) FROM stdin;
\.


--
-- Data for Name: note_reactions; Type: TABLE DATA; Schema: notas_comunicacion; Owner: postgres
--

COPY notas_comunicacion.note_reactions (id, note_id, reaction_type, reacted_by_contact_id, reacted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: note_tags; Type: TABLE DATA; Schema: notas_comunicacion; Owner: postgres
--

COPY notas_comunicacion.note_tags (id, note_id, tag_name, tag_category, tag_color, created_by_contact_id, is_system_tag, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notes; Type: TABLE DATA; Schema: notas_comunicacion; Owner: postgres
--

COPY notas_comunicacion.notes (id, parent_note_id, note_type, context_id, context_table, note_content, created_by_contact_id, is_private, has_replies, signalr_group_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: escalation_rules; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.escalation_rules (id, organization_id, escalation_name, notification_type_id, escalation_sequence, trigger_delay_minutes, retry_interval_minutes, max_escalation_levels, recipient_type, recipient_query, notification_template_id, is_active, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_analytics; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_analytics (id, organization_id, metric_date, metric_hour, channel_type, notification_type_id, notifications_sent, notifications_delivered, delivery_rate, notifications_opened, open_rate, notifications_clicked, click_rate, bounces_soft, bounces_hard, failures_total, failure_rate, retries_count, retry_rate, cost_total, cost_per_message, revenue_attributed, roi_calculation, customer_satisfaction_score, escalation_count, business_impact_score, ai_optimization_applied, calculated_at, created_at) FROM stdin;
\.


--
-- Data for Name: notification_delivery_log; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_delivery_log (id, notification_queue_id, recipient_contact_id, channel_type, delivery_status, provider_name, provider_message_id, delivery_attempt, sent_at, delivered_at, opened_at, clicked_at, replied_at, acknowledged_at, cost, processing_time_ms, delivery_time_minutes, response_time_minutes, personalized_content, device_info, location_data, user_agent, ip_address, engagement_score, retention_days, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_failures; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_failures (id, notification_queue_id, channel_type, failure_type, error_code, error_message, failure_timestamp, is_permanent, retry_count, next_retry_at, auto_escalated, resolution_action, resolved_at, resolved_by_contact_id, notes, retention_days, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_queue; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_queue (id, organization_id, notification_type_id, template_id, trigger_id, priority, scheduled_for, channels, content_variables, recipient_count, context_type, context_id, status, sent_at, delivery_confirmation_required, total_cost, success_rate, failure_reason, retry_count, max_retries, next_retry_at, escalated_at, expires_at, business_impact_score, signalr_group_id, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_recipients; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_recipients (id, notification_queue_id, recipient_contact_id, send_status, retry_count, last_sent_at, is_acknowledged, acknowledged_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_rules; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_rules (id, organization_id, rule_name, rule_category, rule_type, conditions, actions, priority_adjustment, channel_modifications, template_overrides, suppression_rules, ai_enhanced, success_metrics, a_b_test_enabled, execution_order, is_global, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_templates; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_templates (id, notification_type_id, template_name, channel_type, subject_template, content_template, variables_schema, language_code, is_html, personalization_level, a_b_test_group, rich_content, action_buttons, deep_link_url, ai_optimization_enabled, ai_subject_variants, ai_content_variants, performance_score, usage_count, last_used_at, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_triggers; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_triggers (id, organization_id, trigger_name, trigger_type, event_source, event_conditions, notification_type_id, target_audience, recipient_query, template_variables, delay_minutes, is_repeatable, repeat_interval_hours, max_occurrences, priority_override, channels_override, active_hours_start, active_hours_end, timezone, workflow_definition_id, workflow_step_id, auto_acknowledge_on_workflow_complete, is_active, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: notification_types; Type: TABLE DATA; Schema: notifications_system_enterprise; Owner: postgres
--

COPY notifications_system_enterprise.notification_types (id, type_name, type_category, display_name, description, default_channels, requires_acknowledgment, max_retry_attempts, escalation_enabled, compliance_required, icon_name, default_priority, is_user_configurable, weather_dependent, business_hours_only, requires_site_supervisor, insurance_reportable, emergency_override_quiet_hours, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ai_data_preparation; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.ai_data_preparation (id, etl_job_id, task_type, task_status, input_data_sample, output_data_sample, ai_confidence, notes, created_at) FROM stdin;
\.


--
-- Data for Name: ai_insight_log; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.ai_insight_log (id, insight_type, insight_source_table, insight_source_id, insight_content, confidence_score, is_actionable, action_taken, action_notes, created_at) FROM stdin;
\.


--
-- Data for Name: cache_reports; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.cache_reports (id, report_definition_id, cache_key, cached_data, expires_at, file_size_bytes, access_count, last_accessed_at, created_at) FROM stdin;
\.


--
-- Data for Name: dashboard_definitions; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.dashboard_definitions (id, organization_id, dashboard_name, dashboard_category, target_audience, layout_config, filter_defaults, is_public, is_template, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dashboard_performance_metrics; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.dashboard_performance_metrics (id, dashboard_definition_id, widget_id, load_time_ms, api_calls_count, data_transferred_kb, is_cached, created_at) FROM stdin;
\.


--
-- Data for Name: dashboard_permissions; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.dashboard_permissions (id, dashboard_definition_id, contact_id, permission_level, can_edit, can_share, granted_by_contact_id, granted_at, created_at) FROM stdin;
\.


--
-- Data for Name: dashboard_schedules; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.dashboard_schedules (id, dashboard_definition_id, schedule_name, cron_expression, timezone, recipient_emails, delivery_format, is_active, next_execution_at, last_execution_at, total_scheduled_executions, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: dashboard_widgets; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.dashboard_widgets (id, dashboard_definition_id, widget_name, widget_type, widget_config, data_source_config, position_x, position_y, width, height, is_visible, refresh_interval_minutes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: data_dictionary; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.data_dictionary (id, table_id, column_name, data_type, description, business_definition, is_metric, metric_formula, data_owner_contact_id, is_pii, last_updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: data_quality_checks; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.data_quality_checks (id, etl_job_id, check_name, check_type, check_description, check_status, check_results, checked_table, checked_column, checked_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: data_warehouse_tables; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.data_warehouse_tables (id, table_name, description, source_system, ingestion_frequency, last_updated_at, row_count, data_classification, schema_definition, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: etl_jobs; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.etl_jobs (id, job_name, job_description, source_database, source_table, destination_table, transformation_script, schedule_cron, last_run_at, last_run_status, is_active, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: kpi_alerts; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.kpi_alerts (id, kpi_definition_id, kpi_value_id, alert_type, alert_message, threshold_breached, actual_value, severity_level, notification_sent, acknowledged_by_contact_id, acknowledged_at, resolution_notes, auto_resolved, resolved_at, created_at) FROM stdin;
\.


--
-- Data for Name: kpi_benchmarks; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.kpi_benchmarks (id, organization_id, kpi_definition_id, benchmark_name, industry_segment, benchmark_value, benchmark_source, publication_date, notes, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: kpi_definitions; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.kpi_definitions (id, organization_id, kpi_name, kpi_category, kpi_type, calculation_formula, data_sources, calculation_frequency, target_value, warning_threshold, critical_threshold, trend_direction_preference, benchmark_data, is_visible_dashboard, chart_type, unit_of_measure, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: kpi_values; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.kpi_values (id, kpi_definition_id, calculation_date, calculation_time, calculated_value, target_value, variance_amount, variance_percentage, performance_status, trend_direction, contributing_factors, drill_down_data, confidence_score, benchmark_comparison, calculated_at, created_at) FROM stdin;
\.


--
-- Data for Name: performance_monitoring; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.performance_monitoring (id, metric_name, metric_value, entity_type, entity_id, timestamp_recorded, additional_data, is_alert) FROM stdin;
\.


--
-- Data for Name: query_optimizations; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.query_optimizations (id, report_definition_id, kpi_definition_id, suggestion_type, suggestion_details, suggested_by_ai, is_applied, applied_at, performance_gain_percentage, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: report_access_log; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.report_access_log (id, entity_type, entity_id, contact_id, access_timestamp, action_type, access_details) FROM stdin;
\.


--
-- Data for Name: report_definitions; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.report_definitions (id, organization_id, report_name, report_category, report_type, report_description, sql_query, parameters_schema, output_formats, template_config, data_sources, estimated_execution_time, cache_duration_minutes, requires_approval, is_public, created_by_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: report_executions; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.report_executions (id, report_definition_id, execution_type, parameters_used, execution_status, output_url, output_format, total_records, execution_time_seconds, error_message, executed_by_contact_id, started_at, completed_at, created_at) FROM stdin;
\.


--
-- Data for Name: report_performance_metrics; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.report_performance_metrics (id, report_definition_id, execution_id, execution_time_ms, memory_usage_mb, cpu_usage_percentage, data_processed_mb, query_plan_info, created_at) FROM stdin;
\.


--
-- Data for Name: report_permissions; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.report_permissions (id, report_definition_id, contact_id, permission_level, can_execute, can_schedule, can_modify_parameters, granted_by_contact_id, granted_at, created_at) FROM stdin;
\.


--
-- Data for Name: report_schedules; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.report_schedules (id, report_definition_id, schedule_name, cron_expression, timezone, recipient_emails, delivery_format, parameters, is_active, next_execution_at, last_execution_at, total_scheduled_executions, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: user_analytics; Type: TABLE DATA; Schema: reports_business_intelligence; Owner: postgres
--

COPY reports_business_intelligence.user_analytics (id, contact_id, organization_id, activity_type, activity_details, session_id, device_info, ip_address, timestamp_recorded) FROM stdin;
\.


--
-- Data for Name: appointment_types; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.appointment_types (id, name, category, priority_level, estimated_duration_hours, required_skills, requires_equipment, allows_overlap, buffer_time_before, buffer_time_after, is_billable, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: route_optimizations; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.route_optimizations (id, technician_contact_id, route_date, optimized_sequence, total_travel_time_hours, total_drive_distance_miles, optimization_algorithm, start_location_lat, start_location_lng, end_location_lat, end_location_lng, calculated_at, is_active_route, route_status, fuel_cost_estimate, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: technician_availability; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.technician_availability (id, contact_id, day_of_week, start_time, end_time, is_available, max_appointments_per_day, max_travel_distance_miles, preferred_appointment_types, overtime_willing, emergency_available, effective_start_date, effective_end_date, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: technician_skills; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.technician_skills (id, contact_id, skill_name, skill_level, certification_number, certification_authority, certification_date, expiration_date, is_verified, verified_by_contact_id, verification_date, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: travel_time_cache; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.travel_time_cache (id, origin_latitude, origin_longitude, destination_latitude, destination_longitude, travel_time_minutes, travel_distance_miles, traffic_condition, time_of_day, day_type, api_source, cache_timestamp, cache_expires_at, is_valid, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: weather_alerts; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.weather_alerts (id, alert_type, severity_level, affected_zip_codes, alert_start_time, alert_end_time, alert_description, recommended_actions, auto_reschedule_enabled, notification_sent, appointments_affected_count, api_source, alert_id_external, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: weather_forecasts; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.weather_forecasts (id, property_id, latitude, longitude, forecast_date, forecast_time, temperature_high_f, temperature_low_f, current_temperature_f, rain_probability_percent, wind_speed_mph, wind_direction, conditions, humidity_percent, uv_index, api_source, raw_api_response, fetched_at, is_suitable_for_roof_work, is_suitable_for_exterior_work, is_suitable_for_equipment_setup, weather_risk_score, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: weather_impact_rules; Type: TABLE DATA; Schema: scheduling_weather; Owner: postgres
--

COPY scheduling_weather.weather_impact_rules (id, rule_name, appointment_type_id, weather_condition, threshold_value, threshold_operator, recommended_action, auto_apply, requires_approval, notification_template, is_active, priority_order, effective_start_date, effective_end_date, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: common_tasks; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.common_tasks (id, organization_id, common_task_name, description, task_category_id, priority, estimated_duration_hours, is_system_template, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.projects (id, organization_id, project_name, description, start_date, end_date, status, budget, actual_cost, project_manager_contact_id, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_assignments; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_assignments (id, task_id, assigned_to_contact_id, is_primary_assignee, is_completed, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_attachments; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_attachments (id, task_id, file_name, file_type, file_size_kb, file_path, uploaded_by_contact_id, uploaded_at, is_private) FROM stdin;
\.


--
-- Data for Name: task_categories; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_categories (id, name, description, color, icon, is_system_category, parent_category_id, order_sequence, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_checklist_items; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_checklist_items (id, checklist_id, item_name, is_completed, order_sequence, completed_by_contact_id, completed_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_checklists; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_checklists (id, task_id, checklist_name, is_completed, order_sequence, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_comments; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_comments (id, task_id, comment_text, comment_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: task_logs; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_logs (id, task_id, log_type, log_details, changed_by_contact_id, old_value, new_value, created_at) FROM stdin;
\.


--
-- Data for Name: task_metrics; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_metrics (id, task_id, time_to_completion_minutes, reassignment_count, comment_count, attachment_count, checklist_completion_rate, created_at) FROM stdin;
\.


--
-- Data for Name: task_performance_metrics; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.task_performance_metrics (id, contact_id, period_type, period_start_date, period_end_date, tasks_completed, tasks_completed_early, quality_points, collaboration_points, innovation_points, efficiency_points, total_score, rank_in_organization, achievements_unlocked, streak_days, longest_streak, calculated_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: task_management; Owner: postgres
--

COPY task_management.tasks (id, project_id, task_name, description, task_category_id, status, priority, due_date, estimated_duration_hours, actual_duration_hours, assigned_to_contact_id, completed_at, is_recurring, recurring_config, workflow_execution_id, is_private, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: business_rules; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.business_rules (id, organization_id, rule_name, rule_category, rule_type, rule_expression, ai_enhanced, rule_priority, applies_to_table, applies_to_conditions, action_on_true, action_on_false, related_workflow_id, success_rate, false_positive_rate, is_active, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rule_actions; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.rule_actions (id, business_rule_id, action_order, action_type, action_config, ai_optimized_parameters, success_rate, conditions_for_execution, retry_on_failure, max_retries, is_async, timeout_seconds, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rule_conditions; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.rule_conditions (id, business_rule_id, condition_order, condition_type, field_name, operator, expected_value, ai_model_id, weight, logical_operator, external_api_config, calculation_formula, is_active, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: rule_executions; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.rule_executions (id, business_rule_id, context_table, context_id, rule_result, ai_confidence_score, execution_details, action_taken, execution_time_ms, ai_override_applied, human_feedback, error_message, workflow_execution_id, executed_at, created_at) FROM stdin;
\.


--
-- Data for Name: workflow_definitions; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.workflow_definitions (id, organization_id, workflow_name, workflow_description, workflow_category, trigger_type, trigger_config, is_active, is_system_workflow, execution_priority, max_concurrent_executions, timeout_minutes, created_by_contact_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workflow_executions; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.workflow_executions (id, workflow_definition_id, execution_key, context_table, context_id, triggered_by, triggered_by_contact_id, execution_status, current_step_id, execution_data, ai_optimization_applied, performance_metrics, error_details, started_at, completed_at, estimated_completion_at, total_duration_minutes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workflow_schedules; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.workflow_schedules (id, workflow_definition_id, schedule_name, schedule_type, cron_expression, interval_minutes, ai_optimization_enabled, optimal_execution_times, timezone, is_active, next_execution_at, last_execution_at, total_scheduled_executions, max_executions, performance_metrics, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workflow_steps; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.workflow_steps (id, workflow_definition_id, step_name, step_order, step_type, step_config, parent_step_id, condition_expression, ai_model_id, retry_strategy, max_retries, timeout_minutes, is_parallel, success_criteria, failure_handling, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workflow_templates; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.workflow_templates (id, organization_id, template_name, template_category, template_description, industry_specific, template_config, usage_count, success_rate, ai_recommendation_score, customization_complexity, estimated_setup_time_minutes, estimated_roi_percentage, created_by_contact_id, is_public, rating_average, total_ratings, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workflow_variables; Type: TABLE DATA; Schema: workflows_automation_engine; Owner: postgres
--

COPY workflows_automation_engine.workflow_variables (id, workflow_execution_id, variable_name, variable_type, variable_value, variable_scope, is_input, is_output, is_ai_generated, ai_confidence_score, source_step_id, encryption_required, created_at, updated_at) FROM stdin;
\.


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.audit_log_id_seq', 1, false);


--
-- Name: avatars_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.avatars_id_seq', 1, false);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.companies_id_seq', 1, false);


--
-- Name: contact_organization_roles_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.contact_organization_roles_id_seq', 1, false);


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.contacts_id_seq', 1, false);


--
-- Name: customer_projects_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.customer_projects_id_seq', 1, false);


--
-- Name: emails_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.emails_id_seq', 1, false);


--
-- Name: employee_banking_info_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.employee_banking_info_id_seq', 1, false);


--
-- Name: employee_documents_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.employee_documents_id_seq', 1, false);


--
-- Name: employee_emergency_contacts_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.employee_emergency_contacts_id_seq', 1, false);


--
-- Name: employee_personal_info_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.employee_personal_info_id_seq', 1, false);


--
-- Name: lead_sources_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.lead_sources_id_seq', 1, false);


--
-- Name: lead_statuses_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.lead_statuses_id_seq', 1, false);


--
-- Name: organization_integrations_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.organization_integrations_id_seq', 1, false);


--
-- Name: organization_settings_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.organization_settings_id_seq', 1, false);


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.organizations_id_seq', 1, false);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.password_reset_tokens_id_seq', 1, false);


--
-- Name: payroll_deductions_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.payroll_deductions_id_seq', 1, false);


--
-- Name: payroll_records_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.payroll_records_id_seq', 1, false);


--
-- Name: persons_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.persons_id_seq', 1, false);


--
-- Name: phones_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.phones_id_seq', 1, false);


--
-- Name: properties_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.properties_id_seq', 1, false);


--
-- Name: property_batch_data_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.property_batch_data_id_seq', 1, false);


--
-- Name: property_images_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.property_images_id_seq', 1, false);


--
-- Name: property_notes_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.property_notes_id_seq', 1, false);


--
-- Name: property_visits_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.property_visits_id_seq', 1, false);


--
-- Name: role_types_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.role_types_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.roles_id_seq', 1, false);


--
-- Name: user_sessions_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.user_sessions_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: base_foundation; Owner: postgres
--

SELECT pg_catalog.setval('base_foundation.users_id_seq', 1, false);


--
-- Name: ai_agent_conversations_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.ai_agent_conversations_id_seq', 1, false);


--
-- Name: ai_agent_training_sessions_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.ai_agent_training_sessions_id_seq', 1, false);


--
-- Name: ai_chat_agents_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.ai_chat_agents_id_seq', 1, false);


--
-- Name: chat_attachments_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_attachments_id_seq', 1, false);


--
-- Name: chat_channel_members_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_channel_members_id_seq', 1, false);


--
-- Name: chat_channel_types_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_channel_types_id_seq', 1, false);


--
-- Name: chat_channels_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_channels_id_seq', 1, false);


--
-- Name: chat_mentions_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_mentions_id_seq', 1, false);


--
-- Name: chat_message_reactions_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_message_reactions_id_seq', 1, false);


--
-- Name: chat_message_threads_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_message_threads_id_seq', 1, false);


--
-- Name: chat_messages_id_seq; Type: SEQUENCE SET; Schema: chat_enterprise_agora; Owner: postgres
--

SELECT pg_catalog.setval('chat_enterprise_agora.chat_messages_id_seq', 1, false);


--
-- Name: document_access_log_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_access_log_id_seq', 1, false);


--
-- Name: document_folder_assignments_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_folder_assignments_id_seq', 1, false);


--
-- Name: document_folders_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_folders_id_seq', 1, false);


--
-- Name: document_ocr_results_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_ocr_results_id_seq', 1, false);


--
-- Name: document_permissions_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_permissions_id_seq', 1, false);


--
-- Name: document_reviews_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_reviews_id_seq', 1, false);


--
-- Name: document_shares_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_shares_id_seq', 1, false);


--
-- Name: document_tags_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_tags_id_seq', 1, false);


--
-- Name: document_types_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_types_id_seq', 1, false);


--
-- Name: document_versions_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.document_versions_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: documentos_file_management; Owner: postgres
--

SELECT pg_catalog.setval('documentos_file_management.documents_id_seq', 1, false);


--
-- Name: email_accounts_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_accounts_id_seq', 1, false);


--
-- Name: email_assignments_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_assignments_id_seq', 1, false);


--
-- Name: email_attachments_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_attachments_id_seq', 1, false);


--
-- Name: email_automated_responses_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_automated_responses_id_seq', 1, false);


--
-- Name: email_campaigns_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_campaigns_id_seq', 1, false);


--
-- Name: email_delivery_status_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_delivery_status_id_seq', 1, false);


--
-- Name: email_folders_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_folders_id_seq', 1, false);


--
-- Name: email_labels_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_labels_id_seq', 1, false);


--
-- Name: email_link_clicks_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_link_clicks_id_seq', 1, false);


--
-- Name: email_messages_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_messages_id_seq', 1, false);


--
-- Name: email_performance_metrics_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_performance_metrics_id_seq', 1, false);


--
-- Name: email_providers_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_providers_id_seq', 1, false);


--
-- Name: email_recipients_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_recipients_id_seq', 1, false);


--
-- Name: email_template_variables_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_template_variables_id_seq', 1, false);


--
-- Name: email_templates_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_templates_id_seq', 1, false);


--
-- Name: email_threads_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_threads_id_seq', 1, false);


--
-- Name: email_tracking_pixels_id_seq; Type: SEQUENCE SET; Schema: emails_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('emails_enterprise.email_tracking_pixels_id_seq', 1, false);


--
-- Name: bank_accounts_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.bank_accounts_id_seq', 1, false);


--
-- Name: bank_statements_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.bank_statements_id_seq', 1, false);


--
-- Name: cash_accounts_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.cash_accounts_id_seq', 1, false);


--
-- Name: check_register_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.check_register_id_seq', 1, false);


--
-- Name: commission_calculations_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.commission_calculations_id_seq', 1, false);


--
-- Name: invoice_payments_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.invoice_payments_id_seq', 1, false);


--
-- Name: irs_categories_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.irs_categories_id_seq', 1, false);


--
-- Name: transaction_categories_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.transaction_categories_id_seq', 1, false);


--
-- Name: virtual_wallets_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.virtual_wallets_id_seq', 1, false);


--
-- Name: wallet_balances_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.wallet_balances_id_seq', 1, false);


--
-- Name: wallet_types_id_seq; Type: SEQUENCE SET; Schema: finanzas_bookkeeping; Owner: postgres
--

SELECT pg_catalog.setval('finanzas_bookkeeping.wallet_types_id_seq', 1, false);


--
-- Name: content_categories_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.content_categories_id_seq', 1, false);


--
-- Name: damage_types_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.damage_types_id_seq', 1, false);


--
-- Name: equipment_types_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.equipment_types_id_seq', 1, false);


--
-- Name: iicrc_standards_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.iicrc_standards_id_seq', 1, false);


--
-- Name: inspection_areas_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.inspection_areas_id_seq', 1, false);


--
-- Name: inspection_types_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.inspection_types_id_seq', 1, false);


--
-- Name: inspections_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.inspections_id_seq', 1, false);


--
-- Name: service_categories_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.service_categories_id_seq', 1, false);


--
-- Name: water_damage_categories_id_seq; Type: SEQUENCE SET; Schema: inspecciones_evaluaciones; Owner: postgres
--

SELECT pg_catalog.setval('inspecciones_evaluaciones.water_damage_categories_id_seq', 1, false);


--
-- Name: note_attachments_id_seq; Type: SEQUENCE SET; Schema: notas_comunicacion; Owner: postgres
--

SELECT pg_catalog.setval('notas_comunicacion.note_attachments_id_seq', 1, false);


--
-- Name: note_mentions_id_seq; Type: SEQUENCE SET; Schema: notas_comunicacion; Owner: postgres
--

SELECT pg_catalog.setval('notas_comunicacion.note_mentions_id_seq', 1, false);


--
-- Name: note_notifications_id_seq; Type: SEQUENCE SET; Schema: notas_comunicacion; Owner: postgres
--

SELECT pg_catalog.setval('notas_comunicacion.note_notifications_id_seq', 1, false);


--
-- Name: note_reactions_id_seq; Type: SEQUENCE SET; Schema: notas_comunicacion; Owner: postgres
--

SELECT pg_catalog.setval('notas_comunicacion.note_reactions_id_seq', 1, false);


--
-- Name: note_tags_id_seq; Type: SEQUENCE SET; Schema: notas_comunicacion; Owner: postgres
--

SELECT pg_catalog.setval('notas_comunicacion.note_tags_id_seq', 1, false);


--
-- Name: notes_id_seq; Type: SEQUENCE SET; Schema: notas_comunicacion; Owner: postgres
--

SELECT pg_catalog.setval('notas_comunicacion.notes_id_seq', 1, false);


--
-- Name: escalation_rules_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.escalation_rules_id_seq', 1, false);


--
-- Name: notification_analytics_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_analytics_id_seq', 1, false);


--
-- Name: notification_delivery_log_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_delivery_log_id_seq', 1, false);


--
-- Name: notification_failures_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_failures_id_seq', 1, false);


--
-- Name: notification_queue_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_queue_id_seq', 1, false);


--
-- Name: notification_recipients_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_recipients_id_seq', 1, false);


--
-- Name: notification_rules_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_rules_id_seq', 1, false);


--
-- Name: notification_templates_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_templates_id_seq', 1, false);


--
-- Name: notification_triggers_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_triggers_id_seq', 1, false);


--
-- Name: notification_types_id_seq; Type: SEQUENCE SET; Schema: notifications_system_enterprise; Owner: postgres
--

SELECT pg_catalog.setval('notifications_system_enterprise.notification_types_id_seq', 1, false);


--
-- Name: ai_data_preparation_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.ai_data_preparation_id_seq', 1, false);


--
-- Name: ai_insight_log_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.ai_insight_log_id_seq', 1, false);


--
-- Name: cache_reports_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.cache_reports_id_seq', 1, false);


--
-- Name: dashboard_definitions_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.dashboard_definitions_id_seq', 1, false);


--
-- Name: dashboard_performance_metrics_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.dashboard_performance_metrics_id_seq', 1, false);


--
-- Name: dashboard_permissions_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.dashboard_permissions_id_seq', 1, false);


--
-- Name: dashboard_schedules_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.dashboard_schedules_id_seq', 1, false);


--
-- Name: dashboard_widgets_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.dashboard_widgets_id_seq', 1, false);


--
-- Name: data_dictionary_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.data_dictionary_id_seq', 1, false);


--
-- Name: data_quality_checks_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.data_quality_checks_id_seq', 1, false);


--
-- Name: data_warehouse_tables_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.data_warehouse_tables_id_seq', 1, false);


--
-- Name: etl_jobs_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.etl_jobs_id_seq', 1, false);


--
-- Name: kpi_alerts_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.kpi_alerts_id_seq', 1, false);


--
-- Name: kpi_benchmarks_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.kpi_benchmarks_id_seq', 1, false);


--
-- Name: kpi_definitions_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.kpi_definitions_id_seq', 1, false);


--
-- Name: kpi_values_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.kpi_values_id_seq', 1, false);


--
-- Name: performance_monitoring_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.performance_monitoring_id_seq', 1, false);


--
-- Name: query_optimizations_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.query_optimizations_id_seq', 1, false);


--
-- Name: report_access_log_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.report_access_log_id_seq', 1, false);


--
-- Name: report_definitions_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.report_definitions_id_seq', 1, false);


--
-- Name: report_executions_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.report_executions_id_seq', 1, false);


--
-- Name: report_performance_metrics_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.report_performance_metrics_id_seq', 1, false);


--
-- Name: report_permissions_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.report_permissions_id_seq', 1, false);


--
-- Name: report_schedules_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.report_schedules_id_seq', 1, false);


--
-- Name: user_analytics_id_seq; Type: SEQUENCE SET; Schema: reports_business_intelligence; Owner: postgres
--

SELECT pg_catalog.setval('reports_business_intelligence.user_analytics_id_seq', 1, false);


--
-- Name: appointment_types_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.appointment_types_id_seq', 1, false);


--
-- Name: route_optimizations_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.route_optimizations_id_seq', 1, false);


--
-- Name: technician_availability_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.technician_availability_id_seq', 1, false);


--
-- Name: technician_skills_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.technician_skills_id_seq', 1, false);


--
-- Name: travel_time_cache_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.travel_time_cache_id_seq', 1, false);


--
-- Name: weather_alerts_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.weather_alerts_id_seq', 1, false);


--
-- Name: weather_forecasts_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.weather_forecasts_id_seq', 1, false);


--
-- Name: weather_impact_rules_id_seq; Type: SEQUENCE SET; Schema: scheduling_weather; Owner: postgres
--

SELECT pg_catalog.setval('scheduling_weather.weather_impact_rules_id_seq', 1, false);


--
-- Name: common_tasks_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.common_tasks_id_seq', 1, false);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.projects_id_seq', 1, false);


--
-- Name: task_assignments_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_assignments_id_seq', 1, false);


--
-- Name: task_attachments_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_attachments_id_seq', 1, false);


--
-- Name: task_categories_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_categories_id_seq', 1, false);


--
-- Name: task_checklist_items_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_checklist_items_id_seq', 1, false);


--
-- Name: task_checklists_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_checklists_id_seq', 1, false);


--
-- Name: task_comments_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_comments_id_seq', 1, false);


--
-- Name: task_logs_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_logs_id_seq', 1, false);


--
-- Name: task_metrics_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_metrics_id_seq', 1, false);


--
-- Name: task_performance_metrics_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.task_performance_metrics_id_seq', 1, false);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: task_management; Owner: postgres
--

SELECT pg_catalog.setval('task_management.tasks_id_seq', 1, false);


--
-- Name: business_rules_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.business_rules_id_seq', 1, false);


--
-- Name: rule_actions_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.rule_actions_id_seq', 1, false);


--
-- Name: rule_conditions_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.rule_conditions_id_seq', 1, false);


--
-- Name: rule_executions_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.rule_executions_id_seq', 1, false);


--
-- Name: workflow_definitions_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.workflow_definitions_id_seq', 1, false);


--
-- Name: workflow_executions_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.workflow_executions_id_seq', 1, false);


--
-- Name: workflow_schedules_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.workflow_schedules_id_seq', 1, false);


--
-- Name: workflow_steps_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.workflow_steps_id_seq', 1, false);


--
-- Name: workflow_templates_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.workflow_templates_id_seq', 1, false);


--
-- Name: workflow_variables_id_seq; Type: SEQUENCE SET; Schema: workflows_automation_engine; Owner: postgres
--

SELECT pg_catalog.setval('workflows_automation_engine.workflow_variables_id_seq', 1, false);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: avatars avatars_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.avatars
    ADD CONSTRAINT avatars_pkey PRIMARY KEY (id);


--
-- Name: avatars avatars_url_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.avatars
    ADD CONSTRAINT avatars_url_key UNIQUE (url);


--
-- Name: companies companies_contact_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.companies
    ADD CONSTRAINT companies_contact_id_key UNIQUE (contact_id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: contact_organization_roles contact_organization_roles_contact_id_organization_id_role__key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles
    ADD CONSTRAINT contact_organization_roles_contact_id_organization_id_role__key UNIQUE (contact_id, organization_id, role_id);


--
-- Name: contact_organization_roles contact_organization_roles_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles
    ADD CONSTRAINT contact_organization_roles_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: customer_projects customer_projects_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.customer_projects
    ADD CONSTRAINT customer_projects_pkey PRIMARY KEY (id);


--
-- Name: emails emails_email_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.emails
    ADD CONSTRAINT emails_email_key UNIQUE (email);


--
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: employee_banking_info employee_banking_info_contact_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_banking_info
    ADD CONSTRAINT employee_banking_info_contact_id_key UNIQUE (contact_id);


--
-- Name: employee_banking_info employee_banking_info_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_banking_info
    ADD CONSTRAINT employee_banking_info_pkey PRIMARY KEY (id);


--
-- Name: employee_documents employee_documents_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_documents
    ADD CONSTRAINT employee_documents_pkey PRIMARY KEY (id);


--
-- Name: employee_emergency_contacts employee_emergency_contacts_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_emergency_contacts
    ADD CONSTRAINT employee_emergency_contacts_pkey PRIMARY KEY (id);


--
-- Name: employee_personal_info employee_personal_info_contact_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_personal_info
    ADD CONSTRAINT employee_personal_info_contact_id_key UNIQUE (contact_id);


--
-- Name: employee_personal_info employee_personal_info_employee_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_personal_info
    ADD CONSTRAINT employee_personal_info_employee_id_key UNIQUE (employee_id);


--
-- Name: employee_personal_info employee_personal_info_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_personal_info
    ADD CONSTRAINT employee_personal_info_pkey PRIMARY KEY (id);


--
-- Name: lead_sources lead_sources_organization_id_source_name_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_sources
    ADD CONSTRAINT lead_sources_organization_id_source_name_key UNIQUE (organization_id, source_name);


--
-- Name: lead_sources lead_sources_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_sources
    ADD CONSTRAINT lead_sources_pkey PRIMARY KEY (id);


--
-- Name: lead_statuses lead_statuses_organization_id_status_name_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_statuses
    ADD CONSTRAINT lead_statuses_organization_id_status_name_key UNIQUE (organization_id, status_name);


--
-- Name: lead_statuses lead_statuses_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_statuses
    ADD CONSTRAINT lead_statuses_pkey PRIMARY KEY (id);


--
-- Name: organization_integrations organization_integrations_organization_id_integration_type_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_integrations
    ADD CONSTRAINT organization_integrations_organization_id_integration_type_key UNIQUE (organization_id, integration_type);


--
-- Name: organization_integrations organization_integrations_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_integrations
    ADD CONSTRAINT organization_integrations_pkey PRIMARY KEY (id);


--
-- Name: organization_settings organization_settings_organization_id_setting_key_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_settings
    ADD CONSTRAINT organization_settings_organization_id_setting_key_key UNIQUE (organization_id, setting_key);


--
-- Name: organization_settings organization_settings_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_settings
    ADD CONSTRAINT organization_settings_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_token_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_token_key UNIQUE (token);


--
-- Name: payroll_deductions payroll_deductions_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_deductions
    ADD CONSTRAINT payroll_deductions_pkey PRIMARY KEY (id);


--
-- Name: payroll_records payroll_records_contact_id_pay_period_start_pay_period_end_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_records
    ADD CONSTRAINT payroll_records_contact_id_pay_period_start_pay_period_end_key UNIQUE (contact_id, pay_period_start, pay_period_end);


--
-- Name: payroll_records payroll_records_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_records
    ADD CONSTRAINT payroll_records_pkey PRIMARY KEY (id);


--
-- Name: persons persons_contact_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.persons
    ADD CONSTRAINT persons_contact_id_key UNIQUE (contact_id);


--
-- Name: persons persons_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.persons
    ADD CONSTRAINT persons_pkey PRIMARY KEY (id);


--
-- Name: phones phones_country_code_phone_number_extension_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.phones
    ADD CONSTRAINT phones_country_code_phone_number_extension_key UNIQUE (country_code, phone_number, extension);


--
-- Name: phones phones_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: properties properties_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.properties
    ADD CONSTRAINT properties_pkey PRIMARY KEY (id);


--
-- Name: properties properties_place_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.properties
    ADD CONSTRAINT properties_place_id_key UNIQUE (place_id);


--
-- Name: property_batch_data property_batch_data_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_batch_data
    ADD CONSTRAINT property_batch_data_pkey PRIMARY KEY (id);


--
-- Name: property_images property_images_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_images
    ADD CONSTRAINT property_images_pkey PRIMARY KEY (id);


--
-- Name: property_notes property_notes_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_notes
    ADD CONSTRAINT property_notes_pkey PRIMARY KEY (id);


--
-- Name: property_visits property_visits_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_visits
    ADD CONSTRAINT property_visits_pkey PRIMARY KEY (id);


--
-- Name: role_types role_types_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.role_types
    ADD CONSTRAINT role_types_pkey PRIMARY KEY (id);


--
-- Name: role_types role_types_role_name_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.role_types
    ADD CONSTRAINT role_types_role_name_key UNIQUE (role_name);


--
-- Name: roles roles_organization_id_role_name_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.roles
    ADD CONSTRAINT roles_organization_id_role_name_key UNIQUE (organization_id, role_name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (id);


--
-- Name: user_sessions user_sessions_session_token_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.user_sessions
    ADD CONSTRAINT user_sessions_session_token_key UNIQUE (session_token);


--
-- Name: users users_contact_id_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.users
    ADD CONSTRAINT users_contact_id_key UNIQUE (contact_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: ai_agent_conversations ai_agent_conversations_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations
    ADD CONSTRAINT ai_agent_conversations_pkey PRIMARY KEY (id);


--
-- Name: ai_agent_training_sessions ai_agent_training_sessions_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_training_sessions
    ADD CONSTRAINT ai_agent_training_sessions_pkey PRIMARY KEY (id);


--
-- Name: ai_chat_agents ai_chat_agents_organization_id_agent_name_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_chat_agents
    ADD CONSTRAINT ai_chat_agents_organization_id_agent_name_key UNIQUE (organization_id, agent_name);


--
-- Name: ai_chat_agents ai_chat_agents_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_chat_agents
    ADD CONSTRAINT ai_chat_agents_pkey PRIMARY KEY (id);


--
-- Name: chat_attachments chat_attachments_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_attachments
    ADD CONSTRAINT chat_attachments_pkey PRIMARY KEY (id);


--
-- Name: chat_channel_members chat_channel_members_chat_channel_id_contact_id_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_members
    ADD CONSTRAINT chat_channel_members_chat_channel_id_contact_id_key UNIQUE (chat_channel_id, contact_id);


--
-- Name: chat_channel_members chat_channel_members_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_members
    ADD CONSTRAINT chat_channel_members_pkey PRIMARY KEY (id);


--
-- Name: chat_channel_types chat_channel_types_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_types
    ADD CONSTRAINT chat_channel_types_pkey PRIMARY KEY (id);


--
-- Name: chat_channel_types chat_channel_types_type_name_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_types
    ADD CONSTRAINT chat_channel_types_type_name_key UNIQUE (type_name);


--
-- Name: chat_channels chat_channels_organization_id_channel_name_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channels
    ADD CONSTRAINT chat_channels_organization_id_channel_name_key UNIQUE (organization_id, channel_name);


--
-- Name: chat_channels chat_channels_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channels
    ADD CONSTRAINT chat_channels_pkey PRIMARY KEY (id);


--
-- Name: chat_mentions chat_mentions_chat_message_id_mentioned_contact_id_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_mentions
    ADD CONSTRAINT chat_mentions_chat_message_id_mentioned_contact_id_key UNIQUE (chat_message_id, mentioned_contact_id);


--
-- Name: chat_mentions chat_mentions_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_mentions
    ADD CONSTRAINT chat_mentions_pkey PRIMARY KEY (id);


--
-- Name: chat_message_reactions chat_message_reactions_chat_message_id_contact_id_reaction__key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_reactions
    ADD CONSTRAINT chat_message_reactions_chat_message_id_contact_id_reaction__key UNIQUE (chat_message_id, contact_id, reaction_type);


--
-- Name: chat_message_reactions chat_message_reactions_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_reactions
    ADD CONSTRAINT chat_message_reactions_pkey PRIMARY KEY (id);


--
-- Name: chat_message_threads chat_message_threads_parent_message_id_thread_message_id_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_threads
    ADD CONSTRAINT chat_message_threads_parent_message_id_thread_message_id_key UNIQUE (parent_message_id, thread_message_id);


--
-- Name: chat_message_threads chat_message_threads_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_threads
    ADD CONSTRAINT chat_message_threads_pkey PRIMARY KEY (id);


--
-- Name: chat_messages chat_messages_pkey; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_messages
    ADD CONSTRAINT chat_messages_pkey PRIMARY KEY (id);


--
-- Name: chat_messages chat_messages_signalr_message_id_key; Type: CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_messages
    ADD CONSTRAINT chat_messages_signalr_message_id_key UNIQUE (signalr_message_id);


--
-- Name: document_access_log document_access_log_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_access_log
    ADD CONSTRAINT document_access_log_pkey PRIMARY KEY (id);


--
-- Name: document_folder_assignments document_folder_assignments_document_id_folder_id_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folder_assignments
    ADD CONSTRAINT document_folder_assignments_document_id_folder_id_key UNIQUE (document_id, folder_id);


--
-- Name: document_folder_assignments document_folder_assignments_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folder_assignments
    ADD CONSTRAINT document_folder_assignments_pkey PRIMARY KEY (id);


--
-- Name: document_folders document_folders_organization_id_folder_path_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folders
    ADD CONSTRAINT document_folders_organization_id_folder_path_key UNIQUE (organization_id, folder_path);


--
-- Name: document_folders document_folders_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folders
    ADD CONSTRAINT document_folders_pkey PRIMARY KEY (id);


--
-- Name: document_ocr_results document_ocr_results_document_id_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_ocr_results
    ADD CONSTRAINT document_ocr_results_document_id_key UNIQUE (document_id);


--
-- Name: document_ocr_results document_ocr_results_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_ocr_results
    ADD CONSTRAINT document_ocr_results_pkey PRIMARY KEY (id);


--
-- Name: document_permissions document_permissions_document_id_grantee_type_grantee_id_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_permissions
    ADD CONSTRAINT document_permissions_document_id_grantee_type_grantee_id_key UNIQUE (document_id, grantee_type, grantee_id);


--
-- Name: document_permissions document_permissions_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_permissions
    ADD CONSTRAINT document_permissions_pkey PRIMARY KEY (id);


--
-- Name: document_reviews document_reviews_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_reviews
    ADD CONSTRAINT document_reviews_pkey PRIMARY KEY (id);


--
-- Name: document_shares document_shares_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_shares
    ADD CONSTRAINT document_shares_pkey PRIMARY KEY (id);


--
-- Name: document_shares document_shares_share_token_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_shares
    ADD CONSTRAINT document_shares_share_token_key UNIQUE (share_token);


--
-- Name: document_tags document_tags_document_id_tag_name_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_tags
    ADD CONSTRAINT document_tags_document_id_tag_name_key UNIQUE (document_id, tag_name);


--
-- Name: document_tags document_tags_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_tags
    ADD CONSTRAINT document_tags_pkey PRIMARY KEY (id);


--
-- Name: document_types document_types_name_category_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_types
    ADD CONSTRAINT document_types_name_category_key UNIQUE (name, category);


--
-- Name: document_types document_types_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (id);


--
-- Name: document_versions document_versions_document_id_version_number_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_versions
    ADD CONSTRAINT document_versions_document_id_version_number_key UNIQUE (document_id, version_number);


--
-- Name: document_versions document_versions_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_versions
    ADD CONSTRAINT document_versions_pkey PRIMARY KEY (id);


--
-- Name: document_versions document_versions_s3_key_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_versions
    ADD CONSTRAINT document_versions_s3_key_key UNIQUE (s3_key);


--
-- Name: documents documents_file_hash_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents
    ADD CONSTRAINT documents_file_hash_key UNIQUE (file_hash);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: documents documents_s3_key_key; Type: CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents
    ADD CONSTRAINT documents_s3_key_key UNIQUE (s3_key);


--
-- Name: email_accounts email_accounts_email_address_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_accounts
    ADD CONSTRAINT email_accounts_email_address_key UNIQUE (email_address);


--
-- Name: email_accounts email_accounts_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_accounts
    ADD CONSTRAINT email_accounts_pkey PRIMARY KEY (id);


--
-- Name: email_assignments email_assignments_email_message_id_assigned_to_contact_id_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_assignments
    ADD CONSTRAINT email_assignments_email_message_id_assigned_to_contact_id_key UNIQUE (email_message_id, assigned_to_contact_id);


--
-- Name: email_assignments email_assignments_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_assignments
    ADD CONSTRAINT email_assignments_pkey PRIMARY KEY (id);


--
-- Name: email_attachments email_attachments_email_message_id_attachment_id_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_attachments
    ADD CONSTRAINT email_attachments_email_message_id_attachment_id_key UNIQUE (email_message_id, attachment_id);


--
-- Name: email_attachments email_attachments_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_attachments
    ADD CONSTRAINT email_attachments_pkey PRIMARY KEY (id);


--
-- Name: email_automated_responses email_automated_responses_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_automated_responses
    ADD CONSTRAINT email_automated_responses_pkey PRIMARY KEY (id);


--
-- Name: email_automated_responses email_automated_responses_rule_name_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_automated_responses
    ADD CONSTRAINT email_automated_responses_rule_name_key UNIQUE (rule_name);


--
-- Name: email_campaigns email_campaigns_organization_id_campaign_name_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_campaigns
    ADD CONSTRAINT email_campaigns_organization_id_campaign_name_key UNIQUE (organization_id, campaign_name);


--
-- Name: email_campaigns email_campaigns_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_campaigns
    ADD CONSTRAINT email_campaigns_pkey PRIMARY KEY (id);


--
-- Name: email_delivery_status email_delivery_status_email_message_id_recipient_email_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_delivery_status
    ADD CONSTRAINT email_delivery_status_email_message_id_recipient_email_key UNIQUE (email_message_id, recipient_email);


--
-- Name: email_delivery_status email_delivery_status_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_delivery_status
    ADD CONSTRAINT email_delivery_status_pkey PRIMARY KEY (id);


--
-- Name: email_folders email_folders_email_account_id_external_folder_id_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_folders
    ADD CONSTRAINT email_folders_email_account_id_external_folder_id_key UNIQUE (email_account_id, external_folder_id);


--
-- Name: email_folders email_folders_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_folders
    ADD CONSTRAINT email_folders_pkey PRIMARY KEY (id);


--
-- Name: email_labels email_labels_organization_id_label_name_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_labels
    ADD CONSTRAINT email_labels_organization_id_label_name_key UNIQUE (organization_id, label_name);


--
-- Name: email_labels email_labels_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_labels
    ADD CONSTRAINT email_labels_pkey PRIMARY KEY (id);


--
-- Name: email_link_clicks email_link_clicks_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_link_clicks
    ADD CONSTRAINT email_link_clicks_pkey PRIMARY KEY (id);


--
-- Name: email_messages email_messages_email_account_id_message_id_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_messages
    ADD CONSTRAINT email_messages_email_account_id_message_id_key UNIQUE (email_account_id, message_id);


--
-- Name: email_messages email_messages_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_messages
    ADD CONSTRAINT email_messages_pkey PRIMARY KEY (id);


--
-- Name: email_performance_metrics email_performance_metrics_organization_id_email_account_id__key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_performance_metrics
    ADD CONSTRAINT email_performance_metrics_organization_id_email_account_id__key UNIQUE (organization_id, email_account_id, contact_id, metric_date);


--
-- Name: email_performance_metrics email_performance_metrics_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_performance_metrics
    ADD CONSTRAINT email_performance_metrics_pkey PRIMARY KEY (id);


--
-- Name: email_providers email_providers_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_providers
    ADD CONSTRAINT email_providers_pkey PRIMARY KEY (id);


--
-- Name: email_providers email_providers_provider_name_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_providers
    ADD CONSTRAINT email_providers_provider_name_key UNIQUE (provider_name);


--
-- Name: email_recipients email_recipients_email_message_id_email_address_recipient_t_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_recipients
    ADD CONSTRAINT email_recipients_email_message_id_email_address_recipient_t_key UNIQUE (email_message_id, email_address, recipient_type);


--
-- Name: email_recipients email_recipients_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_recipients
    ADD CONSTRAINT email_recipients_pkey PRIMARY KEY (id);


--
-- Name: email_template_variables email_template_variables_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_template_variables
    ADD CONSTRAINT email_template_variables_pkey PRIMARY KEY (id);


--
-- Name: email_template_variables email_template_variables_variable_name_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_template_variables
    ADD CONSTRAINT email_template_variables_variable_name_key UNIQUE (variable_name);


--
-- Name: email_templates email_templates_organization_id_template_name_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_templates
    ADD CONSTRAINT email_templates_organization_id_template_name_key UNIQUE (organization_id, template_name);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (id);


--
-- Name: email_threads email_threads_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_threads
    ADD CONSTRAINT email_threads_pkey PRIMARY KEY (id);


--
-- Name: email_threads email_threads_thread_id_key; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_threads
    ADD CONSTRAINT email_threads_thread_id_key UNIQUE (thread_id);


--
-- Name: email_tracking_pixels email_tracking_pixels_pkey; Type: CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_tracking_pixels
    ADD CONSTRAINT email_tracking_pixels_pkey PRIMARY KEY (id);


--
-- Name: bank_accounts bank_accounts_organization_id_account_number_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_accounts
    ADD CONSTRAINT bank_accounts_organization_id_account_number_key UNIQUE (organization_id, account_number);


--
-- Name: bank_accounts bank_accounts_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_accounts
    ADD CONSTRAINT bank_accounts_pkey PRIMARY KEY (id);


--
-- Name: bank_accounts bank_accounts_plaid_account_id_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_accounts
    ADD CONSTRAINT bank_accounts_plaid_account_id_key UNIQUE (plaid_account_id);


--
-- Name: bank_statements bank_statements_bank_account_id_statement_month_statement_y_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_statements
    ADD CONSTRAINT bank_statements_bank_account_id_statement_month_statement_y_key UNIQUE (bank_account_id, statement_month, statement_year);


--
-- Name: bank_statements bank_statements_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_statements
    ADD CONSTRAINT bank_statements_pkey PRIMARY KEY (id);


--
-- Name: cash_accounts cash_accounts_organization_id_account_name_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.cash_accounts
    ADD CONSTRAINT cash_accounts_organization_id_account_name_key UNIQUE (organization_id, account_name);


--
-- Name: cash_accounts cash_accounts_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.cash_accounts
    ADD CONSTRAINT cash_accounts_pkey PRIMARY KEY (id);


--
-- Name: check_register check_register_bank_account_id_check_number_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register
    ADD CONSTRAINT check_register_bank_account_id_check_number_key UNIQUE (bank_account_id, check_number);


--
-- Name: check_register check_register_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register
    ADD CONSTRAINT check_register_pkey PRIMARY KEY (id);


--
-- Name: commission_calculations commission_calculations_invoice_id_salesperson_contact_id_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.commission_calculations
    ADD CONSTRAINT commission_calculations_invoice_id_salesperson_contact_id_key UNIQUE (invoice_id, salesperson_contact_id);


--
-- Name: commission_calculations commission_calculations_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.commission_calculations
    ADD CONSTRAINT commission_calculations_pkey PRIMARY KEY (id);


--
-- Name: invoice_payments invoice_payments_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.invoice_payments
    ADD CONSTRAINT invoice_payments_pkey PRIMARY KEY (id);


--
-- Name: irs_categories irs_categories_category_code_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.irs_categories
    ADD CONSTRAINT irs_categories_category_code_key UNIQUE (category_code);


--
-- Name: irs_categories irs_categories_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.irs_categories
    ADD CONSTRAINT irs_categories_pkey PRIMARY KEY (id);


--
-- Name: transaction_categories transaction_categories_organization_id_category_name_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.transaction_categories
    ADD CONSTRAINT transaction_categories_organization_id_category_name_key UNIQUE (organization_id, category_name);


--
-- Name: transaction_categories transaction_categories_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.transaction_categories
    ADD CONSTRAINT transaction_categories_pkey PRIMARY KEY (id);


--
-- Name: virtual_wallets virtual_wallets_organization_id_wallet_name_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.virtual_wallets
    ADD CONSTRAINT virtual_wallets_organization_id_wallet_name_key UNIQUE (organization_id, wallet_name);


--
-- Name: virtual_wallets virtual_wallets_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.virtual_wallets
    ADD CONSTRAINT virtual_wallets_pkey PRIMARY KEY (id);


--
-- Name: wallet_balances wallet_balances_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_balances
    ADD CONSTRAINT wallet_balances_pkey PRIMARY KEY (id);


--
-- Name: wallet_balances wallet_balances_wallet_id_balance_date_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_balances
    ADD CONSTRAINT wallet_balances_wallet_id_balance_date_key UNIQUE (wallet_id, balance_date);


--
-- Name: wallet_types wallet_types_pkey; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_types
    ADD CONSTRAINT wallet_types_pkey PRIMARY KEY (id);


--
-- Name: wallet_types wallet_types_type_name_key; Type: CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_types
    ADD CONSTRAINT wallet_types_type_name_key UNIQUE (type_name);


--
-- Name: content_categories content_categories_name_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.content_categories
    ADD CONSTRAINT content_categories_name_key UNIQUE (name);


--
-- Name: content_categories content_categories_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.content_categories
    ADD CONSTRAINT content_categories_pkey PRIMARY KEY (id);


--
-- Name: damage_types damage_types_name_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.damage_types
    ADD CONSTRAINT damage_types_name_key UNIQUE (name);


--
-- Name: damage_types damage_types_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.damage_types
    ADD CONSTRAINT damage_types_pkey PRIMARY KEY (id);


--
-- Name: equipment_types equipment_types_name_category_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.equipment_types
    ADD CONSTRAINT equipment_types_name_category_key UNIQUE (name, category);


--
-- Name: equipment_types equipment_types_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.equipment_types
    ADD CONSTRAINT equipment_types_pkey PRIMARY KEY (id);


--
-- Name: iicrc_standards iicrc_standards_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.iicrc_standards
    ADD CONSTRAINT iicrc_standards_pkey PRIMARY KEY (id);


--
-- Name: iicrc_standards iicrc_standards_standard_code_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.iicrc_standards
    ADD CONSTRAINT iicrc_standards_standard_code_key UNIQUE (standard_code);


--
-- Name: inspection_areas inspection_areas_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_areas
    ADD CONSTRAINT inspection_areas_pkey PRIMARY KEY (id);


--
-- Name: inspection_types inspection_types_name_category_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_types
    ADD CONSTRAINT inspection_types_name_category_key UNIQUE (name, category);


--
-- Name: inspection_types inspection_types_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_types
    ADD CONSTRAINT inspection_types_pkey PRIMARY KEY (id);


--
-- Name: inspections inspections_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspections
    ADD CONSTRAINT inspections_pkey PRIMARY KEY (id);


--
-- Name: service_categories service_categories_name_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.service_categories
    ADD CONSTRAINT service_categories_name_key UNIQUE (name);


--
-- Name: service_categories service_categories_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (id);


--
-- Name: water_damage_categories water_damage_categories_category_level_key; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.water_damage_categories
    ADD CONSTRAINT water_damage_categories_category_level_key UNIQUE (category_level);


--
-- Name: water_damage_categories water_damage_categories_pkey; Type: CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.water_damage_categories
    ADD CONSTRAINT water_damage_categories_pkey PRIMARY KEY (id);


--
-- Name: note_attachments note_attachments_note_id_document_id_key; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_attachments
    ADD CONSTRAINT note_attachments_note_id_document_id_key UNIQUE (note_id, document_id);


--
-- Name: note_attachments note_attachments_pkey; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_attachments
    ADD CONSTRAINT note_attachments_pkey PRIMARY KEY (id);


--
-- Name: note_mentions note_mentions_note_id_mentioned_contact_id_key; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_mentions
    ADD CONSTRAINT note_mentions_note_id_mentioned_contact_id_key UNIQUE (note_id, mentioned_contact_id);


--
-- Name: note_mentions note_mentions_pkey; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_mentions
    ADD CONSTRAINT note_mentions_pkey PRIMARY KEY (id);


--
-- Name: note_notifications note_notifications_pkey; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_notifications
    ADD CONSTRAINT note_notifications_pkey PRIMARY KEY (id);


--
-- Name: note_reactions note_reactions_note_id_reacted_by_contact_id_key; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_reactions
    ADD CONSTRAINT note_reactions_note_id_reacted_by_contact_id_key UNIQUE (note_id, reacted_by_contact_id);


--
-- Name: note_reactions note_reactions_pkey; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_reactions
    ADD CONSTRAINT note_reactions_pkey PRIMARY KEY (id);


--
-- Name: note_tags note_tags_note_id_tag_name_key; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_tags
    ADD CONSTRAINT note_tags_note_id_tag_name_key UNIQUE (note_id, tag_name);


--
-- Name: note_tags note_tags_pkey; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_tags
    ADD CONSTRAINT note_tags_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: escalation_rules escalation_rules_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.escalation_rules
    ADD CONSTRAINT escalation_rules_pkey PRIMARY KEY (id);


--
-- Name: notification_analytics notification_analytics_organization_id_metric_date_metric_h_key; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_analytics
    ADD CONSTRAINT notification_analytics_organization_id_metric_date_metric_h_key UNIQUE (organization_id, metric_date, metric_hour, channel_type, notification_type_id);


--
-- Name: notification_analytics notification_analytics_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_analytics
    ADD CONSTRAINT notification_analytics_pkey PRIMARY KEY (id);


--
-- Name: notification_delivery_log notification_delivery_log_notification_queue_id_recipient_c_key; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_delivery_log
    ADD CONSTRAINT notification_delivery_log_notification_queue_id_recipient_c_key UNIQUE (notification_queue_id, recipient_contact_id, channel_type);


--
-- Name: notification_delivery_log notification_delivery_log_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_delivery_log
    ADD CONSTRAINT notification_delivery_log_pkey PRIMARY KEY (id);


--
-- Name: notification_failures notification_failures_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_failures
    ADD CONSTRAINT notification_failures_pkey PRIMARY KEY (id);


--
-- Name: notification_queue notification_queue_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue
    ADD CONSTRAINT notification_queue_pkey PRIMARY KEY (id);


--
-- Name: notification_recipients notification_recipients_notification_queue_id_recipient_con_key; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_recipients
    ADD CONSTRAINT notification_recipients_notification_queue_id_recipient_con_key UNIQUE (notification_queue_id, recipient_contact_id);


--
-- Name: notification_recipients notification_recipients_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_recipients
    ADD CONSTRAINT notification_recipients_pkey PRIMARY KEY (id);


--
-- Name: notification_rules notification_rules_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_rules
    ADD CONSTRAINT notification_rules_pkey PRIMARY KEY (id);


--
-- Name: notification_templates notification_templates_notification_type_id_template_name_c_key; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_templates
    ADD CONSTRAINT notification_templates_notification_type_id_template_name_c_key UNIQUE (notification_type_id, template_name, channel_type);


--
-- Name: notification_templates notification_templates_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_templates
    ADD CONSTRAINT notification_templates_pkey PRIMARY KEY (id);


--
-- Name: notification_triggers notification_triggers_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers
    ADD CONSTRAINT notification_triggers_pkey PRIMARY KEY (id);


--
-- Name: notification_types notification_types_pkey; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_types
    ADD CONSTRAINT notification_types_pkey PRIMARY KEY (id);


--
-- Name: notification_types notification_types_type_name_key; Type: CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_types
    ADD CONSTRAINT notification_types_type_name_key UNIQUE (type_name);


--
-- Name: ai_data_preparation ai_data_preparation_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.ai_data_preparation
    ADD CONSTRAINT ai_data_preparation_pkey PRIMARY KEY (id);


--
-- Name: ai_insight_log ai_insight_log_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.ai_insight_log
    ADD CONSTRAINT ai_insight_log_pkey PRIMARY KEY (id);


--
-- Name: cache_reports cache_reports_cache_key_key; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.cache_reports
    ADD CONSTRAINT cache_reports_cache_key_key UNIQUE (cache_key);


--
-- Name: cache_reports cache_reports_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.cache_reports
    ADD CONSTRAINT cache_reports_pkey PRIMARY KEY (id);


--
-- Name: dashboard_definitions dashboard_definitions_organization_id_dashboard_name_key; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_definitions
    ADD CONSTRAINT dashboard_definitions_organization_id_dashboard_name_key UNIQUE (organization_id, dashboard_name);


--
-- Name: dashboard_definitions dashboard_definitions_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_definitions
    ADD CONSTRAINT dashboard_definitions_pkey PRIMARY KEY (id);


--
-- Name: dashboard_performance_metrics dashboard_performance_metrics_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_performance_metrics
    ADD CONSTRAINT dashboard_performance_metrics_pkey PRIMARY KEY (id);


--
-- Name: dashboard_permissions dashboard_permissions_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_permissions
    ADD CONSTRAINT dashboard_permissions_pkey PRIMARY KEY (id);


--
-- Name: dashboard_schedules dashboard_schedules_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_schedules
    ADD CONSTRAINT dashboard_schedules_pkey PRIMARY KEY (id);


--
-- Name: dashboard_widgets dashboard_widgets_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_widgets
    ADD CONSTRAINT dashboard_widgets_pkey PRIMARY KEY (id);


--
-- Name: data_dictionary data_dictionary_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_dictionary
    ADD CONSTRAINT data_dictionary_pkey PRIMARY KEY (id);


--
-- Name: data_quality_checks data_quality_checks_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_quality_checks
    ADD CONSTRAINT data_quality_checks_pkey PRIMARY KEY (id);


--
-- Name: data_warehouse_tables data_warehouse_tables_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_warehouse_tables
    ADD CONSTRAINT data_warehouse_tables_pkey PRIMARY KEY (id);


--
-- Name: data_warehouse_tables data_warehouse_tables_table_name_key; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_warehouse_tables
    ADD CONSTRAINT data_warehouse_tables_table_name_key UNIQUE (table_name);


--
-- Name: etl_jobs etl_jobs_job_name_key; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.etl_jobs
    ADD CONSTRAINT etl_jobs_job_name_key UNIQUE (job_name);


--
-- Name: etl_jobs etl_jobs_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.etl_jobs
    ADD CONSTRAINT etl_jobs_pkey PRIMARY KEY (id);


--
-- Name: kpi_alerts kpi_alerts_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_alerts
    ADD CONSTRAINT kpi_alerts_pkey PRIMARY KEY (id);


--
-- Name: kpi_benchmarks kpi_benchmarks_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_benchmarks
    ADD CONSTRAINT kpi_benchmarks_pkey PRIMARY KEY (id);


--
-- Name: kpi_definitions kpi_definitions_organization_id_kpi_name_key; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_definitions
    ADD CONSTRAINT kpi_definitions_organization_id_kpi_name_key UNIQUE (organization_id, kpi_name);


--
-- Name: kpi_definitions kpi_definitions_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_definitions
    ADD CONSTRAINT kpi_definitions_pkey PRIMARY KEY (id);


--
-- Name: kpi_values kpi_values_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_values
    ADD CONSTRAINT kpi_values_pkey PRIMARY KEY (id);


--
-- Name: performance_monitoring performance_monitoring_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.performance_monitoring
    ADD CONSTRAINT performance_monitoring_pkey PRIMARY KEY (id);


--
-- Name: query_optimizations query_optimizations_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.query_optimizations
    ADD CONSTRAINT query_optimizations_pkey PRIMARY KEY (id);


--
-- Name: report_access_log report_access_log_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_access_log
    ADD CONSTRAINT report_access_log_pkey PRIMARY KEY (id);


--
-- Name: report_definitions report_definitions_organization_id_report_name_key; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_definitions
    ADD CONSTRAINT report_definitions_organization_id_report_name_key UNIQUE (organization_id, report_name);


--
-- Name: report_definitions report_definitions_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_definitions
    ADD CONSTRAINT report_definitions_pkey PRIMARY KEY (id);


--
-- Name: report_executions report_executions_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_executions
    ADD CONSTRAINT report_executions_pkey PRIMARY KEY (id);


--
-- Name: report_performance_metrics report_performance_metrics_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_performance_metrics
    ADD CONSTRAINT report_performance_metrics_pkey PRIMARY KEY (id);


--
-- Name: report_permissions report_permissions_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_permissions
    ADD CONSTRAINT report_permissions_pkey PRIMARY KEY (id);


--
-- Name: report_schedules report_schedules_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_schedules
    ADD CONSTRAINT report_schedules_pkey PRIMARY KEY (id);


--
-- Name: user_analytics user_analytics_pkey; Type: CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.user_analytics
    ADD CONSTRAINT user_analytics_pkey PRIMARY KEY (id);


--
-- Name: appointment_types appointment_types_name_key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.appointment_types
    ADD CONSTRAINT appointment_types_name_key UNIQUE (name);


--
-- Name: appointment_types appointment_types_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.appointment_types
    ADD CONSTRAINT appointment_types_pkey PRIMARY KEY (id);


--
-- Name: route_optimizations route_optimizations_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.route_optimizations
    ADD CONSTRAINT route_optimizations_pkey PRIMARY KEY (id);


--
-- Name: technician_availability technician_availability_contact_id_day_of_week_effective_st_key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_availability
    ADD CONSTRAINT technician_availability_contact_id_day_of_week_effective_st_key UNIQUE (contact_id, day_of_week, effective_start_date);


--
-- Name: technician_availability technician_availability_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_availability
    ADD CONSTRAINT technician_availability_pkey PRIMARY KEY (id);


--
-- Name: technician_skills technician_skills_contact_id_skill_name_key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_skills
    ADD CONSTRAINT technician_skills_contact_id_skill_name_key UNIQUE (contact_id, skill_name);


--
-- Name: technician_skills technician_skills_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_skills
    ADD CONSTRAINT technician_skills_pkey PRIMARY KEY (id);


--
-- Name: travel_time_cache travel_time_cache_origin_latitude_origin_longitude_destinat_key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.travel_time_cache
    ADD CONSTRAINT travel_time_cache_origin_latitude_origin_longitude_destinat_key UNIQUE (origin_latitude, origin_longitude, destination_latitude, destination_longitude, time_of_day, day_type);


--
-- Name: travel_time_cache travel_time_cache_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.travel_time_cache
    ADD CONSTRAINT travel_time_cache_pkey PRIMARY KEY (id);


--
-- Name: weather_alerts weather_alerts_alert_id_external_api_source_key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_alerts
    ADD CONSTRAINT weather_alerts_alert_id_external_api_source_key UNIQUE (alert_id_external, api_source);


--
-- Name: weather_alerts weather_alerts_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_alerts
    ADD CONSTRAINT weather_alerts_pkey PRIMARY KEY (id);


--
-- Name: weather_forecasts weather_forecasts_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_forecasts
    ADD CONSTRAINT weather_forecasts_pkey PRIMARY KEY (id);


--
-- Name: weather_forecasts weather_forecasts_property_id_forecast_date_forecast_time_key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_forecasts
    ADD CONSTRAINT weather_forecasts_property_id_forecast_date_forecast_time_key UNIQUE (property_id, forecast_date, forecast_time);


--
-- Name: weather_impact_rules weather_impact_rules_appointment_type_id_weather_condition__key; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_impact_rules
    ADD CONSTRAINT weather_impact_rules_appointment_type_id_weather_condition__key UNIQUE (appointment_type_id, weather_condition, threshold_value);


--
-- Name: weather_impact_rules weather_impact_rules_pkey; Type: CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_impact_rules
    ADD CONSTRAINT weather_impact_rules_pkey PRIMARY KEY (id);


--
-- Name: common_tasks common_tasks_organization_id_common_task_name_key; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.common_tasks
    ADD CONSTRAINT common_tasks_organization_id_common_task_name_key UNIQUE (organization_id, common_task_name);


--
-- Name: common_tasks common_tasks_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.common_tasks
    ADD CONSTRAINT common_tasks_pkey PRIMARY KEY (id);


--
-- Name: projects projects_organization_id_project_name_key; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.projects
    ADD CONSTRAINT projects_organization_id_project_name_key UNIQUE (organization_id, project_name);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: task_assignments task_assignments_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_assignments
    ADD CONSTRAINT task_assignments_pkey PRIMARY KEY (id);


--
-- Name: task_attachments task_attachments_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_attachments
    ADD CONSTRAINT task_attachments_pkey PRIMARY KEY (id);


--
-- Name: task_categories task_categories_name_key; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_categories
    ADD CONSTRAINT task_categories_name_key UNIQUE (name);


--
-- Name: task_categories task_categories_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_categories
    ADD CONSTRAINT task_categories_pkey PRIMARY KEY (id);


--
-- Name: task_checklist_items task_checklist_items_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklist_items
    ADD CONSTRAINT task_checklist_items_pkey PRIMARY KEY (id);


--
-- Name: task_checklists task_checklists_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklists
    ADD CONSTRAINT task_checklists_pkey PRIMARY KEY (id);


--
-- Name: task_checklists task_checklists_task_id_checklist_name_key; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklists
    ADD CONSTRAINT task_checklists_task_id_checklist_name_key UNIQUE (task_id, checklist_name);


--
-- Name: task_comments task_comments_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_comments
    ADD CONSTRAINT task_comments_pkey PRIMARY KEY (id);


--
-- Name: task_logs task_logs_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_logs
    ADD CONSTRAINT task_logs_pkey PRIMARY KEY (id);


--
-- Name: task_metrics task_metrics_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_metrics
    ADD CONSTRAINT task_metrics_pkey PRIMARY KEY (id);


--
-- Name: task_metrics task_metrics_task_id_key; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_metrics
    ADD CONSTRAINT task_metrics_task_id_key UNIQUE (task_id);


--
-- Name: task_performance_metrics task_performance_metrics_contact_id_period_start_date_perio_key; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_performance_metrics
    ADD CONSTRAINT task_performance_metrics_contact_id_period_start_date_perio_key UNIQUE (contact_id, period_start_date, period_end_date);


--
-- Name: task_performance_metrics task_performance_metrics_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_performance_metrics
    ADD CONSTRAINT task_performance_metrics_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: business_rules business_rules_organization_id_rule_name_key; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.business_rules
    ADD CONSTRAINT business_rules_organization_id_rule_name_key UNIQUE (organization_id, rule_name);


--
-- Name: business_rules business_rules_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.business_rules
    ADD CONSTRAINT business_rules_pkey PRIMARY KEY (id);


--
-- Name: rule_actions rule_actions_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_actions
    ADD CONSTRAINT rule_actions_pkey PRIMARY KEY (id);


--
-- Name: rule_conditions rule_conditions_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_conditions
    ADD CONSTRAINT rule_conditions_pkey PRIMARY KEY (id);


--
-- Name: rule_executions rule_executions_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_executions
    ADD CONSTRAINT rule_executions_pkey PRIMARY KEY (id);


--
-- Name: workflow_definitions workflow_definitions_organization_id_workflow_name_key; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_definitions
    ADD CONSTRAINT workflow_definitions_organization_id_workflow_name_key UNIQUE (organization_id, workflow_name);


--
-- Name: workflow_definitions workflow_definitions_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_definitions
    ADD CONSTRAINT workflow_definitions_pkey PRIMARY KEY (id);


--
-- Name: workflow_executions workflow_executions_execution_key_key; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_executions
    ADD CONSTRAINT workflow_executions_execution_key_key UNIQUE (execution_key);


--
-- Name: workflow_executions workflow_executions_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_executions
    ADD CONSTRAINT workflow_executions_pkey PRIMARY KEY (id);


--
-- Name: workflow_schedules workflow_schedules_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_schedules
    ADD CONSTRAINT workflow_schedules_pkey PRIMARY KEY (id);


--
-- Name: workflow_steps workflow_steps_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_steps
    ADD CONSTRAINT workflow_steps_pkey PRIMARY KEY (id);


--
-- Name: workflow_steps workflow_steps_workflow_definition_id_step_order_key; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_steps
    ADD CONSTRAINT workflow_steps_workflow_definition_id_step_order_key UNIQUE (workflow_definition_id, step_order);


--
-- Name: workflow_templates workflow_templates_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_templates
    ADD CONSTRAINT workflow_templates_pkey PRIMARY KEY (id);


--
-- Name: workflow_variables workflow_variables_pkey; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_variables
    ADD CONSTRAINT workflow_variables_pkey PRIMARY KEY (id);


--
-- Name: workflow_variables workflow_variables_workflow_execution_id_variable_name_key; Type: CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_variables
    ADD CONSTRAINT workflow_variables_workflow_execution_id_variable_name_key UNIQUE (workflow_execution_id, variable_name);


--
-- Name: idx_audit_log_created_at; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_audit_log_created_at ON base_foundation.audit_log USING btree (created_at);


--
-- Name: idx_audit_log_entity; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_audit_log_entity ON base_foundation.audit_log USING btree (entity_name, entity_id);


--
-- Name: idx_audit_log_operation; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_audit_log_operation ON base_foundation.audit_log USING btree (operation_type);


--
-- Name: idx_audit_log_org; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_audit_log_org ON base_foundation.audit_log USING btree (organization_id);


--
-- Name: idx_avatars_active; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_avatars_active ON base_foundation.avatars USING btree (is_active);


--
-- Name: idx_avatars_contact; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_avatars_contact ON base_foundation.avatars USING btree (contact_id);


--
-- Name: idx_banking_info_employee; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_banking_info_employee ON base_foundation.employee_banking_info USING btree (contact_id);


--
-- Name: idx_banking_info_verified; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_banking_info_verified ON base_foundation.employee_banking_info USING btree (verification_status);


--
-- Name: idx_batch_data_owner; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_batch_data_owner ON base_foundation.property_batch_data USING btree (owner_name);


--
-- Name: idx_batch_data_property; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_batch_data_property ON base_foundation.property_batch_data USING btree (property_id);


--
-- Name: idx_batch_data_value; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_batch_data_value ON base_foundation.property_batch_data USING btree (assessed_value, market_value);


--
-- Name: idx_companies_entity_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_companies_entity_type ON base_foundation.companies USING btree (legal_entity_type);


--
-- Name: idx_companies_industry; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_companies_industry ON base_foundation.companies USING btree (industry);


--
-- Name: idx_contact_org_roles_active; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_contact_org_roles_active ON base_foundation.contact_organization_roles USING btree (is_active);


--
-- Name: idx_contact_org_roles_contact; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_contact_org_roles_contact ON base_foundation.contact_organization_roles USING btree (contact_id);


--
-- Name: idx_contact_org_roles_org; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_contact_org_roles_org ON base_foundation.contact_organization_roles USING btree (organization_id);


--
-- Name: idx_contacts_company_flag; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_contacts_company_flag ON base_foundation.contacts USING btree (is_company);


--
-- Name: idx_contacts_full_name; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_contacts_full_name ON base_foundation.contacts USING btree (full_name);


--
-- Name: idx_contacts_salesperson; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_contacts_salesperson ON base_foundation.contacts USING btree (assigned_salesperson_id);


--
-- Name: idx_emails_contact; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_emails_contact ON base_foundation.emails USING btree (contact_id);


--
-- Name: idx_emails_verified; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_emails_verified ON base_foundation.emails USING btree (is_verified);


--
-- Name: idx_emergency_contacts_employee; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_emergency_contacts_employee ON base_foundation.employee_emergency_contacts USING btree (contact_id);


--
-- Name: idx_emergency_contacts_primary; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_emergency_contacts_primary ON base_foundation.employee_emergency_contacts USING btree (is_primary);


--
-- Name: idx_employee_docs_employee; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_employee_docs_employee ON base_foundation.employee_documents USING btree (contact_id);


--
-- Name: idx_employee_docs_expiration; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_employee_docs_expiration ON base_foundation.employee_documents USING btree (expiration_date);


--
-- Name: idx_employee_docs_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_employee_docs_type ON base_foundation.employee_documents USING btree (document_type);


--
-- Name: idx_employee_info_department; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_employee_info_department ON base_foundation.employee_personal_info USING btree (department);


--
-- Name: idx_employee_info_manager; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_employee_info_manager ON base_foundation.employee_personal_info USING btree (manager_contact_id);


--
-- Name: idx_employee_info_status; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_employee_info_status ON base_foundation.employee_personal_info USING btree (employment_status);


--
-- Name: idx_org_integrations_active; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_org_integrations_active ON base_foundation.organization_integrations USING btree (is_active);


--
-- Name: idx_org_integrations_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_org_integrations_type ON base_foundation.organization_integrations USING btree (integration_type);


--
-- Name: idx_org_settings_encrypted; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_org_settings_encrypted ON base_foundation.organization_settings USING btree (is_encrypted);


--
-- Name: idx_org_settings_key; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_org_settings_key ON base_foundation.organization_settings USING btree (setting_key);


--
-- Name: idx_orgs_industry; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_orgs_industry ON base_foundation.organizations USING btree (industry);


--
-- Name: idx_orgs_parent; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_orgs_parent ON base_foundation.organizations USING btree (parent_id);


--
-- Name: idx_orgs_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_orgs_type ON base_foundation.organizations USING btree (organization_type);


--
-- Name: idx_password_tokens_expires; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_password_tokens_expires ON base_foundation.password_reset_tokens USING btree (expires_at);


--
-- Name: idx_password_tokens_user; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_password_tokens_user ON base_foundation.password_reset_tokens USING btree (user_id);


--
-- Name: idx_payroll_employee; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_payroll_employee ON base_foundation.payroll_records USING btree (contact_id);


--
-- Name: idx_payroll_pay_date; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_payroll_pay_date ON base_foundation.payroll_records USING btree (pay_date);


--
-- Name: idx_payroll_period; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_payroll_period ON base_foundation.payroll_records USING btree (pay_period_start, pay_period_end);


--
-- Name: idx_persons_birth_date; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_persons_birth_date ON base_foundation.persons USING btree (birth_date);


--
-- Name: idx_persons_tax_id; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_persons_tax_id ON base_foundation.persons USING btree (tax_id);


--
-- Name: idx_phones_contact; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_phones_contact ON base_foundation.phones USING btree (contact_id);


--
-- Name: idx_phones_main; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_phones_main ON base_foundation.phones USING btree (is_main);


--
-- Name: idx_properties_city_state; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_properties_city_state ON base_foundation.properties USING btree (city, state);


--
-- Name: idx_properties_coordinates; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_properties_coordinates ON base_foundation.properties USING btree (latitude, longitude);


--
-- Name: idx_properties_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_properties_type ON base_foundation.properties USING btree (property_type);


--
-- Name: idx_property_images_primary; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_property_images_primary ON base_foundation.property_images USING btree (is_primary);


--
-- Name: idx_property_images_property; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_property_images_property ON base_foundation.property_images USING btree (property_id);


--
-- Name: idx_property_images_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_property_images_type ON base_foundation.property_images USING btree (image_type);


--
-- Name: idx_property_notes_important; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_property_notes_important ON base_foundation.property_notes USING btree (is_important);


--
-- Name: idx_property_notes_property; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_property_notes_property ON base_foundation.property_notes USING btree (property_id);


--
-- Name: idx_property_notes_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_property_notes_type ON base_foundation.property_notes USING btree (note_type);


--
-- Name: idx_role_types_name; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_role_types_name ON base_foundation.role_types USING btree (role_name);


--
-- Name: idx_role_types_system; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_role_types_system ON base_foundation.role_types USING btree (is_system_role);


--
-- Name: idx_roles_org; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_roles_org ON base_foundation.roles USING btree (organization_id);


--
-- Name: idx_roles_type; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_roles_type ON base_foundation.roles USING btree (role_type_id);


--
-- Name: idx_sessions_expires; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_sessions_expires ON base_foundation.user_sessions USING btree (expires_at);


--
-- Name: idx_sessions_token; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_sessions_token ON base_foundation.user_sessions USING btree (session_token);


--
-- Name: idx_sessions_user; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_sessions_user ON base_foundation.user_sessions USING btree (user_id);


--
-- Name: idx_users_active; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_users_active ON base_foundation.users USING btree (is_active);


--
-- Name: idx_users_email; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_users_email ON base_foundation.users USING btree (email);


--
-- Name: idx_users_username; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_users_username ON base_foundation.users USING btree (username);


--
-- Name: idx_visits_date; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_visits_date ON base_foundation.property_visits USING btree (visit_date);


--
-- Name: idx_visits_property; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_visits_property ON base_foundation.property_visits USING btree (property_id);


--
-- Name: idx_visits_sales_rep; Type: INDEX; Schema: base_foundation; Owner: postgres
--

CREATE INDEX idx_visits_sales_rep ON base_foundation.property_visits USING btree (sales_rep_id);


--
-- Name: idx_ai_agents_org_type; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_ai_agents_org_type ON chat_enterprise_agora.ai_chat_agents USING btree (organization_id, agent_type, is_active);


--
-- Name: idx_ai_conversations_agent_status; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_ai_conversations_agent_status ON chat_enterprise_agora.ai_agent_conversations USING btree (ai_agent_id, conversation_status);


--
-- Name: idx_ai_conversations_satisfaction; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_ai_conversations_satisfaction ON chat_enterprise_agora.ai_agent_conversations USING btree (user_satisfaction_score, resolution_type);


--
-- Name: idx_ai_conversations_user; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_ai_conversations_user ON chat_enterprise_agora.ai_agent_conversations USING btree (user_contact_id, started_at DESC);


--
-- Name: idx_ai_training_agent_type; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_ai_training_agent_type ON chat_enterprise_agora.ai_agent_training_sessions USING btree (ai_agent_id, training_type);


--
-- Name: idx_ai_training_source; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_ai_training_source ON chat_enterprise_agora.ai_agent_training_sessions USING btree (training_source);


--
-- Name: idx_chat_attachments_message; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_attachments_message ON chat_enterprise_agora.chat_attachments USING btree (chat_message_id);


--
-- Name: idx_chat_attachments_type; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_attachments_type ON chat_enterprise_agora.chat_attachments USING btree (file_type, upload_status);


--
-- Name: idx_chat_channel_types_system; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_channel_types_system ON chat_enterprise_agora.chat_channel_types USING btree (is_system_type);


--
-- Name: idx_chat_channels_org_type; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_channels_org_type ON chat_enterprise_agora.chat_channels USING btree (organization_id, channel_type);


--
-- Name: idx_chat_channels_signalr; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_channels_signalr ON chat_enterprise_agora.chat_channels USING btree (signalr_group_id);


--
-- Name: idx_chat_members_contact; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_members_contact ON chat_enterprise_agora.chat_channel_members USING btree (contact_id, is_active);


--
-- Name: idx_chat_members_last_read; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_members_last_read ON chat_enterprise_agora.chat_channel_members USING btree (chat_channel_id, last_read_at);


--
-- Name: idx_chat_mentions_contact; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_mentions_contact ON chat_enterprise_agora.chat_mentions USING btree (mentioned_contact_id, notification_read);


--
-- Name: idx_chat_mentions_message; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_mentions_message ON chat_enterprise_agora.chat_mentions USING btree (chat_message_id);


--
-- Name: idx_chat_messages_channel_time; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_messages_channel_time ON chat_enterprise_agora.chat_messages USING btree (chat_channel_id, created_at DESC);


--
-- Name: idx_chat_messages_sender; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_messages_sender ON chat_enterprise_agora.chat_messages USING btree (sender_contact_id, created_at DESC);


--
-- Name: idx_chat_messages_thread; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_messages_thread ON chat_enterprise_agora.chat_messages USING btree (replied_to_message_id);


--
-- Name: idx_chat_reactions_contact; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_reactions_contact ON chat_enterprise_agora.chat_message_reactions USING btree (contact_id);


--
-- Name: idx_chat_reactions_message; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_reactions_message ON chat_enterprise_agora.chat_message_reactions USING btree (chat_message_id, is_active);


--
-- Name: idx_chat_threads_level; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_threads_level ON chat_enterprise_agora.chat_message_threads USING btree (thread_level);


--
-- Name: idx_chat_threads_parent; Type: INDEX; Schema: chat_enterprise_agora; Owner: postgres
--

CREATE INDEX idx_chat_threads_parent ON chat_enterprise_agora.chat_message_threads USING btree (parent_message_id, thread_position);


--
-- Name: idx_automated_responses_account_active; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_automated_responses_account_active ON emails_enterprise.email_automated_responses USING btree (email_account_id, is_active);


--
-- Name: idx_automated_responses_out_of_office; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_automated_responses_out_of_office ON emails_enterprise.email_automated_responses USING btree (is_out_of_office);


--
-- Name: idx_delivery_status_message; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_status_message ON emails_enterprise.email_delivery_status USING btree (email_message_id);


--
-- Name: idx_delivery_status_status; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_status_status ON emails_enterprise.email_delivery_status USING btree (delivery_status);


--
-- Name: idx_delivery_status_timestamp; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_status_timestamp ON emails_enterprise.email_delivery_status USING btree (delivery_timestamp);


--
-- Name: idx_email_accounts_contact_primary; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_accounts_contact_primary ON emails_enterprise.email_accounts USING btree (contact_id, is_primary);


--
-- Name: idx_email_accounts_last_sync; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_accounts_last_sync ON emails_enterprise.email_accounts USING btree (last_sync_at);


--
-- Name: idx_email_accounts_org_status; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_accounts_org_status ON emails_enterprise.email_accounts USING btree (organization_id, sync_status);


--
-- Name: idx_email_assignments_assignee_status; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_assignments_assignee_status ON emails_enterprise.email_assignments USING btree (assigned_to_contact_id, status);


--
-- Name: idx_email_assignments_due_date_status; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_assignments_due_date_status ON emails_enterprise.email_assignments USING btree (due_date, status);


--
-- Name: idx_email_assignments_priority; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_assignments_priority ON emails_enterprise.email_assignments USING btree (priority_level);


--
-- Name: idx_email_attachments_download; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_attachments_download ON emails_enterprise.email_attachments USING btree (download_status);


--
-- Name: idx_email_attachments_message; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_attachments_message ON emails_enterprise.email_attachments USING btree (email_message_id);


--
-- Name: idx_email_attachments_size; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_attachments_size ON emails_enterprise.email_attachments USING btree (file_size);


--
-- Name: idx_email_campaigns_org_status; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_campaigns_org_status ON emails_enterprise.email_campaigns USING btree (organization_id, send_status);


--
-- Name: idx_email_campaigns_scheduled; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_campaigns_scheduled ON emails_enterprise.email_campaigns USING btree (scheduled_send_at);


--
-- Name: idx_email_campaigns_type; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_campaigns_type ON emails_enterprise.email_campaigns USING btree (campaign_type);


--
-- Name: idx_email_folders_account_type; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_folders_account_type ON emails_enterprise.email_folders USING btree (email_account_id, folder_type);


--
-- Name: idx_email_folders_parent; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_folders_parent ON emails_enterprise.email_folders USING btree (parent_folder_id);


--
-- Name: idx_email_folders_sync; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_folders_sync ON emails_enterprise.email_folders USING btree (sync_enabled);


--
-- Name: idx_email_labels_org_category; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_labels_org_category ON emails_enterprise.email_labels USING btree (organization_id, label_category);


--
-- Name: idx_email_labels_system; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_labels_system ON emails_enterprise.email_labels USING btree (is_system_label);


--
-- Name: idx_email_messages_assignee; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_messages_assignee ON emails_enterprise.email_messages USING btree (assigned_to_contact_id);


--
-- Name: idx_email_messages_context; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_messages_context ON emails_enterprise.email_messages USING btree (context_type, context_id);


--
-- Name: idx_email_messages_read_received; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_messages_read_received ON emails_enterprise.email_messages USING btree (is_read, received_at DESC);


--
-- Name: idx_email_messages_sent; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_messages_sent ON emails_enterprise.email_messages USING btree (sent_at DESC);


--
-- Name: idx_email_messages_thread; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_messages_thread ON emails_enterprise.email_messages USING btree (email_account_id, thread_id);


--
-- Name: idx_email_providers_active; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_providers_active ON emails_enterprise.email_providers USING btree (is_active);


--
-- Name: idx_email_providers_type; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_providers_type ON emails_enterprise.email_providers USING btree (provider_type);


--
-- Name: idx_email_recipients_contact; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_recipients_contact ON emails_enterprise.email_recipients USING btree (contact_id);


--
-- Name: idx_email_recipients_delivery; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_recipients_delivery ON emails_enterprise.email_recipients USING btree (delivery_status);


--
-- Name: idx_email_recipients_message_type; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_recipients_message_type ON emails_enterprise.email_recipients USING btree (email_message_id, recipient_type);


--
-- Name: idx_email_templates_active_usage; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_templates_active_usage ON emails_enterprise.email_templates USING btree (is_active, usage_count DESC);


--
-- Name: idx_email_templates_context; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_templates_context ON emails_enterprise.email_templates USING btree (usage_context);


--
-- Name: idx_email_templates_org_category; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_templates_org_category ON emails_enterprise.email_templates USING btree (organization_id, template_category);


--
-- Name: idx_email_threads_assignee; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_threads_assignee ON emails_enterprise.email_threads USING btree (assigned_to_contact_id, is_archived);


--
-- Name: idx_email_threads_context; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_threads_context ON emails_enterprise.email_threads USING btree (context_type, context_id);


--
-- Name: idx_email_threads_last_message; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_email_threads_last_message ON emails_enterprise.email_threads USING btree (last_message_at DESC);


--
-- Name: idx_link_clicks_message; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_link_clicks_message ON emails_enterprise.email_link_clicks USING btree (email_message_id);


--
-- Name: idx_link_clicks_recipient; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_link_clicks_recipient ON emails_enterprise.email_link_clicks USING btree (recipient_email);


--
-- Name: idx_link_clicks_timestamp; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_link_clicks_timestamp ON emails_enterprise.email_link_clicks USING btree (click_timestamp);


--
-- Name: idx_metrics_account_date; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_metrics_account_date ON emails_enterprise.email_performance_metrics USING btree (email_account_id, metric_date DESC);


--
-- Name: idx_metrics_contact_date; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_metrics_contact_date ON emails_enterprise.email_performance_metrics USING btree (contact_id, metric_date DESC);


--
-- Name: idx_metrics_org_date; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_metrics_org_date ON emails_enterprise.email_performance_metrics USING btree (organization_id, metric_date DESC);


--
-- Name: idx_one_primary_account; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE UNIQUE INDEX idx_one_primary_account ON emails_enterprise.email_accounts USING btree (contact_id) WHERE (is_primary = true);


--
-- Name: idx_template_variables_category; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_template_variables_category ON emails_enterprise.email_template_variables USING btree (variable_category);


--
-- Name: idx_template_variables_source_table; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_template_variables_source_table ON emails_enterprise.email_template_variables USING btree (data_source_table);


--
-- Name: idx_template_variables_system; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_template_variables_system ON emails_enterprise.email_template_variables USING btree (is_system_variable);


--
-- Name: idx_tracking_pixels_message; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_tracking_pixels_message ON emails_enterprise.email_tracking_pixels USING btree (email_message_id);


--
-- Name: idx_tracking_pixels_opened; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_tracking_pixels_opened ON emails_enterprise.email_tracking_pixels USING btree (opened_at);


--
-- Name: idx_tracking_pixels_token; Type: INDEX; Schema: emails_enterprise; Owner: postgres
--

CREATE INDEX idx_tracking_pixels_token ON emails_enterprise.email_tracking_pixels USING btree (tracking_token);


--
-- Name: idx_analytics_channel_type; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_analytics_channel_type ON notifications_system_enterprise.notification_analytics USING btree (channel_type, notification_type_id);


--
-- Name: idx_analytics_impact; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_analytics_impact ON notifications_system_enterprise.notification_analytics USING btree (business_impact_score DESC);


--
-- Name: idx_analytics_org_date_hour; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_analytics_org_date_hour ON notifications_system_enterprise.notification_analytics USING btree (organization_id, metric_date, metric_hour);


--
-- Name: idx_analytics_roi; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_analytics_roi ON notifications_system_enterprise.notification_analytics USING btree (roi_calculation DESC);


--
-- Name: idx_delivery_log_channel_status; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_log_channel_status ON notifications_system_enterprise.notification_delivery_log USING btree (channel_type, delivery_status);


--
-- Name: idx_delivery_log_delivered_opened; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_log_delivered_opened ON notifications_system_enterprise.notification_delivery_log USING btree (delivered_at, opened_at);


--
-- Name: idx_delivery_log_queue_status; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_log_queue_status ON notifications_system_enterprise.notification_delivery_log USING btree (notification_queue_id, delivery_status);


--
-- Name: idx_delivery_log_recipient_sent; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_delivery_log_recipient_sent ON notifications_system_enterprise.notification_delivery_log USING btree (recipient_contact_id, sent_at);


--
-- Name: idx_escalation_rules_active; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_escalation_rules_active ON notifications_system_enterprise.escalation_rules USING btree (is_active);


--
-- Name: idx_escalation_rules_org_type; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_escalation_rules_org_type ON notifications_system_enterprise.escalation_rules USING btree (organization_id, notification_type_id);


--
-- Name: idx_failures_next_retry; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_failures_next_retry ON notifications_system_enterprise.notification_failures USING btree (next_retry_at, auto_escalated);


--
-- Name: idx_failures_permanent_ts; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_failures_permanent_ts ON notifications_system_enterprise.notification_failures USING btree (failure_timestamp, is_permanent);


--
-- Name: idx_failures_queue_type; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_failures_queue_type ON notifications_system_enterprise.notification_failures USING btree (notification_queue_id, failure_type);


--
-- Name: idx_notification_types_ack; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_notification_types_ack ON notifications_system_enterprise.notification_types USING btree (requires_acknowledgment);


--
-- Name: idx_notification_types_category_active; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_notification_types_category_active ON notifications_system_enterprise.notification_types USING btree (type_category, is_active);


--
-- Name: idx_queue_context; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_queue_context ON notifications_system_enterprise.notification_queue USING btree (context_type, context_id);


--
-- Name: idx_queue_expires; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_queue_expires ON notifications_system_enterprise.notification_queue USING btree (expires_at);


--
-- Name: idx_queue_org_status_prio; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_queue_org_status_prio ON notifications_system_enterprise.notification_queue USING btree (organization_id, status, priority);


--
-- Name: idx_queue_scheduled_status; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_queue_scheduled_status ON notifications_system_enterprise.notification_queue USING btree (scheduled_for, status);


--
-- Name: idx_recipients_contact_status; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_recipients_contact_status ON notifications_system_enterprise.notification_recipients USING btree (recipient_contact_id, send_status);


--
-- Name: idx_recipients_queue; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_recipients_queue ON notifications_system_enterprise.notification_recipients USING btree (notification_queue_id);


--
-- Name: idx_rules_execution_order; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_rules_execution_order ON notifications_system_enterprise.notification_rules USING btree (execution_order, is_active);


--
-- Name: idx_rules_global_active; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_rules_global_active ON notifications_system_enterprise.notification_rules USING btree (is_global, is_active);


--
-- Name: idx_rules_org_cat_active; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_rules_org_cat_active ON notifications_system_enterprise.notification_rules USING btree (organization_id, rule_category, is_active);


--
-- Name: idx_templates_language; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_templates_language ON notifications_system_enterprise.notification_templates USING btree (language_code);


--
-- Name: idx_templates_performance; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_templates_performance ON notifications_system_enterprise.notification_templates USING btree (performance_score DESC);


--
-- Name: idx_templates_type_channel; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_templates_type_channel ON notifications_system_enterprise.notification_templates USING btree (notification_type_id, channel_type);


--
-- Name: idx_triggers_event_source; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_triggers_event_source ON notifications_system_enterprise.notification_triggers USING btree (event_source, is_active);


--
-- Name: idx_triggers_org_type_active; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_triggers_org_type_active ON notifications_system_enterprise.notification_triggers USING btree (organization_id, trigger_type, is_active);


--
-- Name: idx_triggers_workflow_def; Type: INDEX; Schema: notifications_system_enterprise; Owner: postgres
--

CREATE INDEX idx_triggers_workflow_def ON notifications_system_enterprise.notification_triggers USING btree (workflow_definition_id);


--
-- Name: idx_ai_data_prep_job; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_ai_data_prep_job ON reports_business_intelligence.ai_data_preparation USING btree (etl_job_id);


--
-- Name: idx_ai_data_prep_status; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_ai_data_prep_status ON reports_business_intelligence.ai_data_preparation USING btree (task_status);


--
-- Name: idx_ai_insight_action; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_ai_insight_action ON reports_business_intelligence.ai_insight_log USING btree (is_actionable, action_taken);


--
-- Name: idx_ai_insight_source; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_ai_insight_source ON reports_business_intelligence.ai_insight_log USING btree (insight_source_table, insight_source_id);


--
-- Name: idx_ai_insight_type; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_ai_insight_type ON reports_business_intelligence.ai_insight_log USING btree (insight_type);


--
-- Name: idx_alert_acknowledged; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_alert_acknowledged ON reports_business_intelligence.kpi_alerts USING btree (acknowledged_by_contact_id);


--
-- Name: idx_alert_kpi_definition; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_alert_kpi_definition ON reports_business_intelligence.kpi_alerts USING btree (kpi_definition_id);


--
-- Name: idx_alert_type_severity; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_alert_type_severity ON reports_business_intelligence.kpi_alerts USING btree (alert_type, severity_level);


--
-- Name: idx_cache_access_count; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_cache_access_count ON reports_business_intelligence.cache_reports USING btree (access_count);


--
-- Name: idx_cache_expires; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_cache_expires ON reports_business_intelligence.cache_reports USING btree (expires_at);


--
-- Name: idx_cache_report_key; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_cache_report_key ON reports_business_intelligence.cache_reports USING btree (report_definition_id, cache_key);


--
-- Name: idx_dash_metrics_dashboard; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dash_metrics_dashboard ON reports_business_intelligence.dashboard_performance_metrics USING btree (dashboard_definition_id);


--
-- Name: idx_dash_metrics_widget; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dash_metrics_widget ON reports_business_intelligence.dashboard_performance_metrics USING btree (widget_id);


--
-- Name: idx_dash_schedule_active; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dash_schedule_active ON reports_business_intelligence.dashboard_schedules USING btree (is_active);


--
-- Name: idx_dash_schedule_dash; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dash_schedule_dash ON reports_business_intelligence.dashboard_schedules USING btree (dashboard_definition_id);


--
-- Name: idx_dash_schedule_next_exec; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dash_schedule_next_exec ON reports_business_intelligence.dashboard_schedules USING btree (next_execution_at);


--
-- Name: idx_dashboard_active; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dashboard_active ON reports_business_intelligence.dashboard_definitions USING btree (is_active);


--
-- Name: idx_dashboard_audience; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dashboard_audience ON reports_business_intelligence.dashboard_definitions USING btree (target_audience);


--
-- Name: idx_dashboard_org_category; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dashboard_org_category ON reports_business_intelligence.dashboard_definitions USING btree (organization_id, dashboard_category);


--
-- Name: idx_dashboard_permissions_contact; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dashboard_permissions_contact ON reports_business_intelligence.dashboard_permissions USING btree (contact_id);


--
-- Name: idx_dashboard_permissions_granted; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dashboard_permissions_granted ON reports_business_intelligence.dashboard_permissions USING btree (granted_by_contact_id);


--
-- Name: idx_dashboard_permissions_level; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dashboard_permissions_level ON reports_business_intelligence.dashboard_permissions USING btree (permission_level);


--
-- Name: idx_data_dict_owner; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_data_dict_owner ON reports_business_intelligence.data_dictionary USING btree (data_owner_contact_id);


--
-- Name: idx_data_dict_table_column; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_data_dict_table_column ON reports_business_intelligence.data_dictionary USING btree (table_id, column_name);


--
-- Name: idx_data_quality_checks_status; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_data_quality_checks_status ON reports_business_intelligence.data_quality_checks USING btree (check_status);


--
-- Name: idx_data_quality_checks_table; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_data_quality_checks_table ON reports_business_intelligence.data_quality_checks USING btree (checked_table);


--
-- Name: idx_dw_ingestion_frequency; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dw_ingestion_frequency ON reports_business_intelligence.data_warehouse_tables USING btree (ingestion_frequency);


--
-- Name: idx_dw_table_name; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_dw_table_name ON reports_business_intelligence.data_warehouse_tables USING btree (table_name);


--
-- Name: idx_etl_jobs_schedule; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_etl_jobs_schedule ON reports_business_intelligence.etl_jobs USING btree (schedule_cron);


--
-- Name: idx_etl_jobs_status; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_etl_jobs_status ON reports_business_intelligence.etl_jobs USING btree (last_run_status);


--
-- Name: idx_execution_completed; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_execution_completed ON reports_business_intelligence.report_executions USING btree (completed_at);


--
-- Name: idx_execution_contact; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_execution_contact ON reports_business_intelligence.report_executions USING btree (executed_by_contact_id);


--
-- Name: idx_execution_report; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_execution_report ON reports_business_intelligence.report_executions USING btree (report_definition_id);


--
-- Name: idx_execution_status; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_execution_status ON reports_business_intelligence.report_executions USING btree (execution_status);


--
-- Name: idx_kpi_active; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_active ON reports_business_intelligence.kpi_definitions USING btree (is_active);


--
-- Name: idx_kpi_benchmarks_industry; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_benchmarks_industry ON reports_business_intelligence.kpi_benchmarks USING btree (industry_segment);


--
-- Name: idx_kpi_benchmarks_kpi; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_benchmarks_kpi ON reports_business_intelligence.kpi_benchmarks USING btree (kpi_definition_id);


--
-- Name: idx_kpi_frequency; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_frequency ON reports_business_intelligence.kpi_definitions USING btree (calculation_frequency);


--
-- Name: idx_kpi_org_category; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_org_category ON reports_business_intelligence.kpi_definitions USING btree (organization_id, kpi_category);


--
-- Name: idx_kpi_value_calculated; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_value_calculated ON reports_business_intelligence.kpi_values USING btree (calculated_at);


--
-- Name: idx_kpi_value_definition_date; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_value_definition_date ON reports_business_intelligence.kpi_values USING btree (kpi_definition_id, calculation_date);


--
-- Name: idx_kpi_value_status; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_kpi_value_status ON reports_business_intelligence.kpi_values USING btree (performance_status);


--
-- Name: idx_perf_monitor_entity; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_perf_monitor_entity ON reports_business_intelligence.performance_monitoring USING btree (entity_type, entity_id);


--
-- Name: idx_perf_monitor_name; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_perf_monitor_name ON reports_business_intelligence.performance_monitoring USING btree (metric_name);


--
-- Name: idx_query_optimizations_applied; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_query_optimizations_applied ON reports_business_intelligence.query_optimizations USING btree (is_applied, suggestion_type);


--
-- Name: idx_query_optimizations_kpi; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_query_optimizations_kpi ON reports_business_intelligence.query_optimizations USING btree (kpi_definition_id);


--
-- Name: idx_query_optimizations_report; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_query_optimizations_report ON reports_business_intelligence.query_optimizations USING btree (report_definition_id);


--
-- Name: idx_report_access_log_contact; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_access_log_contact ON reports_business_intelligence.report_access_log USING btree (contact_id);


--
-- Name: idx_report_access_log_entity; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_access_log_entity ON reports_business_intelligence.report_access_log USING btree (entity_type, entity_id);


--
-- Name: idx_report_active; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_active ON reports_business_intelligence.report_definitions USING btree (is_active);


--
-- Name: idx_report_execution_time; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_execution_time ON reports_business_intelligence.report_definitions USING btree (estimated_execution_time);


--
-- Name: idx_report_metrics_execution; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_metrics_execution ON reports_business_intelligence.report_performance_metrics USING btree (execution_id);


--
-- Name: idx_report_metrics_report; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_metrics_report ON reports_business_intelligence.report_performance_metrics USING btree (report_definition_id);


--
-- Name: idx_report_org_category; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_org_category ON reports_business_intelligence.report_definitions USING btree (organization_id, report_category);


--
-- Name: idx_report_permissions_contact; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_permissions_contact ON reports_business_intelligence.report_permissions USING btree (contact_id);


--
-- Name: idx_report_permissions_granted; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_permissions_granted ON reports_business_intelligence.report_permissions USING btree (granted_by_contact_id);


--
-- Name: idx_report_permissions_level; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_report_permissions_level ON reports_business_intelligence.report_permissions USING btree (permission_level);


--
-- Name: idx_schedule_active; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_schedule_active ON reports_business_intelligence.report_schedules USING btree (is_active);


--
-- Name: idx_schedule_next_execution; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_schedule_next_execution ON reports_business_intelligence.report_schedules USING btree (next_execution_at);


--
-- Name: idx_schedule_report; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_schedule_report ON reports_business_intelligence.report_schedules USING btree (report_definition_id);


--
-- Name: idx_user_analytics_activity; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_user_analytics_activity ON reports_business_intelligence.user_analytics USING btree (activity_type);


--
-- Name: idx_user_analytics_contact; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_user_analytics_contact ON reports_business_intelligence.user_analytics USING btree (contact_id);


--
-- Name: idx_widget_dashboard; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_widget_dashboard ON reports_business_intelligence.dashboard_widgets USING btree (dashboard_definition_id);


--
-- Name: idx_widget_position; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_widget_position ON reports_business_intelligence.dashboard_widgets USING btree (position_x, position_y);


--
-- Name: idx_widget_type; Type: INDEX; Schema: reports_business_intelligence; Owner: postgres
--

CREATE INDEX idx_widget_type ON reports_business_intelligence.dashboard_widgets USING btree (widget_type);


--
-- Name: idx_appointment_types_category; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_appointment_types_category ON scheduling_weather.appointment_types USING btree (category);


--
-- Name: idx_appointment_types_priority; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_appointment_types_priority ON scheduling_weather.appointment_types USING btree (priority_level);


--
-- Name: idx_availability_active; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_availability_active ON scheduling_weather.technician_availability USING btree (is_active, effective_start_date);


--
-- Name: idx_availability_contact; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_availability_contact ON scheduling_weather.technician_availability USING btree (contact_id);


--
-- Name: idx_availability_day; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_availability_day ON scheduling_weather.technician_availability USING btree (day_of_week);


--
-- Name: idx_one_active_route; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE UNIQUE INDEX idx_one_active_route ON scheduling_weather.route_optimizations USING btree (technician_contact_id, route_date) WHERE (is_active_route = true);


--
-- Name: idx_routes_active; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_routes_active ON scheduling_weather.route_optimizations USING btree (is_active_route);


--
-- Name: idx_routes_status; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_routes_status ON scheduling_weather.route_optimizations USING btree (route_status);


--
-- Name: idx_routes_technician_date; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_routes_technician_date ON scheduling_weather.route_optimizations USING btree (technician_contact_id, route_date);


--
-- Name: idx_skills_contact; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_skills_contact ON scheduling_weather.technician_skills USING btree (contact_id);


--
-- Name: idx_skills_expiration; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_skills_expiration ON scheduling_weather.technician_skills USING btree (expiration_date);


--
-- Name: idx_skills_level; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_skills_level ON scheduling_weather.technician_skills USING btree (skill_level);


--
-- Name: idx_skills_name; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_skills_name ON scheduling_weather.technician_skills USING btree (skill_name);


--
-- Name: idx_travel_cache_destination; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_travel_cache_destination ON scheduling_weather.travel_time_cache USING btree (destination_latitude, destination_longitude);


--
-- Name: idx_travel_cache_expiry; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_travel_cache_expiry ON scheduling_weather.travel_time_cache USING btree (cache_expires_at);


--
-- Name: idx_travel_cache_origin; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_travel_cache_origin ON scheduling_weather.travel_time_cache USING btree (origin_latitude, origin_longitude);


--
-- Name: idx_weather_alerts_severity; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_alerts_severity ON scheduling_weather.weather_alerts USING btree (severity_level);


--
-- Name: idx_weather_alerts_time; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_alerts_time ON scheduling_weather.weather_alerts USING btree (alert_start_time, alert_end_time);


--
-- Name: idx_weather_property_date; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_property_date ON scheduling_weather.weather_forecasts USING btree (property_id, forecast_date);


--
-- Name: idx_weather_risk_score; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_risk_score ON scheduling_weather.weather_forecasts USING btree (weather_risk_score);


--
-- Name: idx_weather_rules_active; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_rules_active ON scheduling_weather.weather_impact_rules USING btree (is_active, priority_order);


--
-- Name: idx_weather_rules_condition; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_rules_condition ON scheduling_weather.weather_impact_rules USING btree (weather_condition);


--
-- Name: idx_weather_rules_type; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_rules_type ON scheduling_weather.weather_impact_rules USING btree (appointment_type_id);


--
-- Name: idx_weather_suitable_roof; Type: INDEX; Schema: scheduling_weather; Owner: postgres
--

CREATE INDEX idx_weather_suitable_roof ON scheduling_weather.weather_forecasts USING btree (is_suitable_for_roof_work);


--
-- Name: idx_business_rules_applies_to; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_business_rules_applies_to ON workflows_automation_engine.business_rules USING btree (applies_to_table);


--
-- Name: idx_business_rules_org_active; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_business_rules_org_active ON workflows_automation_engine.business_rules USING btree (organization_id, is_active);


--
-- Name: idx_business_rules_priority; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_business_rules_priority ON workflows_automation_engine.business_rules USING btree (rule_priority);


--
-- Name: idx_rule_actions_rule_order; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_actions_rule_order ON workflows_automation_engine.rule_actions USING btree (business_rule_id, action_order);


--
-- Name: idx_rule_actions_success_rate; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_actions_success_rate ON workflows_automation_engine.rule_actions USING btree (success_rate);


--
-- Name: idx_rule_actions_type; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_actions_type ON workflows_automation_engine.rule_actions USING btree (action_type);


--
-- Name: idx_rule_conditions_rule_order; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_conditions_rule_order ON workflows_automation_engine.rule_conditions USING btree (business_rule_id, condition_order);


--
-- Name: idx_rule_conditions_type; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_conditions_type ON workflows_automation_engine.rule_conditions USING btree (condition_type);


--
-- Name: idx_rule_executions_context; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_executions_context ON workflows_automation_engine.rule_executions USING btree (context_table, context_id);


--
-- Name: idx_rule_executions_result_confidence; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_executions_result_confidence ON workflows_automation_engine.rule_executions USING btree (rule_result, ai_confidence_score);


--
-- Name: idx_rule_executions_rule_executed; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_rule_executions_rule_executed ON workflows_automation_engine.rule_executions USING btree (business_rule_id, executed_at);


--
-- Name: idx_workflow_definitions_category; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_definitions_category ON workflows_automation_engine.workflow_definitions USING btree (workflow_category);


--
-- Name: idx_workflow_definitions_org_active; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_definitions_org_active ON workflows_automation_engine.workflow_definitions USING btree (organization_id, is_active);


--
-- Name: idx_workflow_definitions_trigger_type; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_definitions_trigger_type ON workflows_automation_engine.workflow_definitions USING btree (trigger_type);


--
-- Name: idx_workflow_executions_context; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_executions_context ON workflows_automation_engine.workflow_executions USING btree (context_table, context_id);


--
-- Name: idx_workflow_executions_def_status; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_executions_def_status ON workflows_automation_engine.workflow_executions USING btree (workflow_definition_id, execution_status);


--
-- Name: idx_workflow_executions_status_started; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_executions_status_started ON workflows_automation_engine.workflow_executions USING btree (execution_status, started_at);


--
-- Name: idx_workflow_schedules_def; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_schedules_def ON workflows_automation_engine.workflow_schedules USING btree (workflow_definition_id);


--
-- Name: idx_workflow_schedules_next_active; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_schedules_next_active ON workflows_automation_engine.workflow_schedules USING btree (next_execution_at, is_active);


--
-- Name: idx_workflow_schedules_type; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_schedules_type ON workflows_automation_engine.workflow_schedules USING btree (schedule_type);


--
-- Name: idx_workflow_steps_def_order; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_steps_def_order ON workflows_automation_engine.workflow_steps USING btree (workflow_definition_id, step_order);


--
-- Name: idx_workflow_steps_type; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_steps_type ON workflows_automation_engine.workflow_steps USING btree (step_type);


--
-- Name: idx_workflow_templates_cat_ai; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_templates_cat_ai ON workflows_automation_engine.workflow_templates USING btree (template_category, ai_recommendation_score);


--
-- Name: idx_workflow_templates_industry_public; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_templates_industry_public ON workflows_automation_engine.workflow_templates USING btree (industry_specific, is_public);


--
-- Name: idx_workflow_templates_usage_success; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_templates_usage_success ON workflows_automation_engine.workflow_templates USING btree (usage_count, success_rate);


--
-- Name: idx_workflow_variables_ai_gen; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_variables_ai_gen ON workflows_automation_engine.workflow_variables USING btree (is_ai_generated);


--
-- Name: idx_workflow_variables_exec_scope; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_variables_exec_scope ON workflows_automation_engine.workflow_variables USING btree (workflow_execution_id, variable_scope);


--
-- Name: idx_workflow_variables_type; Type: INDEX; Schema: workflows_automation_engine; Owner: postgres
--

CREATE INDEX idx_workflow_variables_type ON workflows_automation_engine.workflow_variables USING btree (variable_type);


--
-- Name: audit_log fk_audit_log_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.audit_log
    ADD CONSTRAINT fk_audit_log_contact FOREIGN KEY (changed_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: audit_log fk_audit_log_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.audit_log
    ADD CONSTRAINT fk_audit_log_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: audit_log fk_audit_log_user; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.audit_log
    ADD CONSTRAINT fk_audit_log_user FOREIGN KEY (changed_by_user_id) REFERENCES base_foundation.users(id);


--
-- Name: avatars fk_avatars_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.avatars
    ADD CONSTRAINT fk_avatars_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_banking_info fk_banking_info_employee; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_banking_info
    ADD CONSTRAINT fk_banking_info_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: property_batch_data fk_batch_data_property; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_batch_data
    ADD CONSTRAINT fk_batch_data_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);


--
-- Name: companies fk_companies_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.companies
    ADD CONSTRAINT fk_companies_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: contact_organization_roles fk_contact_org_roles_assigned_by_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles
    ADD CONSTRAINT fk_contact_org_roles_assigned_by_contact FOREIGN KEY (assigned_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: contact_organization_roles fk_contact_org_roles_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles
    ADD CONSTRAINT fk_contact_org_roles_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: contact_organization_roles fk_contact_org_roles_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles
    ADD CONSTRAINT fk_contact_org_roles_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: contact_organization_roles fk_contact_org_roles_role; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contact_organization_roles
    ADD CONSTRAINT fk_contact_org_roles_role FOREIGN KEY (role_id) REFERENCES base_foundation.roles(id);


--
-- Name: contacts fk_contacts_assigned_salesperson; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contacts
    ADD CONSTRAINT fk_contacts_assigned_salesperson FOREIGN KEY (assigned_salesperson_id) REFERENCES base_foundation.contacts(id);


--
-- Name: contacts fk_contacts_lead_source; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contacts
    ADD CONSTRAINT fk_contacts_lead_source FOREIGN KEY (lead_source_id) REFERENCES base_foundation.lead_sources(id);


--
-- Name: contacts fk_contacts_lead_status; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.contacts
    ADD CONSTRAINT fk_contacts_lead_status FOREIGN KEY (lead_status_id) REFERENCES base_foundation.lead_statuses(id);


--
-- Name: customer_projects fk_customer_projects_client; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.customer_projects
    ADD CONSTRAINT fk_customer_projects_client FOREIGN KEY (client_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: customer_projects fk_customer_projects_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.customer_projects
    ADD CONSTRAINT fk_customer_projects_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: emails fk_emails_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.emails
    ADD CONSTRAINT fk_emails_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_emergency_contacts fk_emergency_contacts_employee; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_emergency_contacts
    ADD CONSTRAINT fk_emergency_contacts_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_documents fk_employee_docs_approver; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_documents
    ADD CONSTRAINT fk_employee_docs_approver FOREIGN KEY (approved_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_documents fk_employee_docs_employee; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_documents
    ADD CONSTRAINT fk_employee_docs_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_documents fk_employee_docs_uploader; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_documents
    ADD CONSTRAINT fk_employee_docs_uploader FOREIGN KEY (uploaded_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_personal_info fk_employee_info_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_personal_info
    ADD CONSTRAINT fk_employee_info_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: employee_personal_info fk_employee_info_manager; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.employee_personal_info
    ADD CONSTRAINT fk_employee_info_manager FOREIGN KEY (manager_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: lead_sources fk_lead_sources_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_sources
    ADD CONSTRAINT fk_lead_sources_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: lead_statuses fk_lead_statuses_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.lead_statuses
    ADD CONSTRAINT fk_lead_statuses_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: organization_integrations fk_org_integrations_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_integrations
    ADD CONSTRAINT fk_org_integrations_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: organization_settings fk_org_settings_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organization_settings
    ADD CONSTRAINT fk_org_settings_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: organizations fk_organizations_parent; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.organizations
    ADD CONSTRAINT fk_organizations_parent FOREIGN KEY (parent_id) REFERENCES base_foundation.organizations(id);


--
-- Name: password_reset_tokens fk_password_tokens_user; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.password_reset_tokens
    ADD CONSTRAINT fk_password_tokens_user FOREIGN KEY (user_id) REFERENCES base_foundation.users(id);


--
-- Name: payroll_deductions fk_payroll_deductions_record; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_deductions
    ADD CONSTRAINT fk_payroll_deductions_record FOREIGN KEY (payroll_record_id) REFERENCES base_foundation.payroll_records(id);


--
-- Name: payroll_records fk_payroll_employee; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.payroll_records
    ADD CONSTRAINT fk_payroll_employee FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: persons fk_persons_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.persons
    ADD CONSTRAINT fk_persons_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: phones fk_phones_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.phones
    ADD CONSTRAINT fk_phones_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: property_images fk_property_images_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_images
    ADD CONSTRAINT fk_property_images_contact FOREIGN KEY (taken_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: property_images fk_property_images_property; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_images
    ADD CONSTRAINT fk_property_images_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);


--
-- Name: property_notes fk_property_notes_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_notes
    ADD CONSTRAINT fk_property_notes_contact FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: property_notes fk_property_notes_property; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_notes
    ADD CONSTRAINT fk_property_notes_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);


--
-- Name: roles fk_roles_organization; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.roles
    ADD CONSTRAINT fk_roles_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: roles fk_roles_role_type; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.roles
    ADD CONSTRAINT fk_roles_role_type FOREIGN KEY (role_type_id) REFERENCES base_foundation.role_types(id);


--
-- Name: user_sessions fk_sessions_user; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.user_sessions
    ADD CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES base_foundation.users(id);


--
-- Name: users fk_users_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.users
    ADD CONSTRAINT fk_users_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: property_visits fk_visits_contact; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_visits
    ADD CONSTRAINT fk_visits_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: property_visits fk_visits_property; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_visits
    ADD CONSTRAINT fk_visits_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);


--
-- Name: property_visits fk_visits_sales_rep; Type: FK CONSTRAINT; Schema: base_foundation; Owner: postgres
--

ALTER TABLE ONLY base_foundation.property_visits
    ADD CONSTRAINT fk_visits_sales_rep FOREIGN KEY (sales_rep_id) REFERENCES base_foundation.contacts(id);


--
-- Name: ai_chat_agents fk_ai_agents_creator; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_chat_agents
    ADD CONSTRAINT fk_ai_agents_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: ai_chat_agents fk_ai_agents_org; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_chat_agents
    ADD CONSTRAINT fk_ai_agents_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: ai_agent_conversations fk_ai_conv_agent; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations
    ADD CONSTRAINT fk_ai_conv_agent FOREIGN KEY (ai_agent_id) REFERENCES chat_enterprise_agora.ai_chat_agents(id) ON DELETE CASCADE;


--
-- Name: ai_agent_conversations fk_ai_conv_channel; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations
    ADD CONSTRAINT fk_ai_conv_channel FOREIGN KEY (chat_channel_id) REFERENCES chat_enterprise_agora.chat_channels(id);


--
-- Name: ai_agent_conversations fk_ai_conv_escalation; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations
    ADD CONSTRAINT fk_ai_conv_escalation FOREIGN KEY (escalated_to_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: ai_agent_conversations fk_ai_conv_start_msg; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations
    ADD CONSTRAINT fk_ai_conv_start_msg FOREIGN KEY (conversation_start_message_id) REFERENCES chat_enterprise_agora.chat_messages(id);


--
-- Name: ai_agent_conversations fk_ai_conv_user; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_conversations
    ADD CONSTRAINT fk_ai_conv_user FOREIGN KEY (user_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: ai_agent_training_sessions fk_ai_training_agent; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_training_sessions
    ADD CONSTRAINT fk_ai_training_agent FOREIGN KEY (ai_agent_id) REFERENCES chat_enterprise_agora.ai_chat_agents(id) ON DELETE CASCADE;


--
-- Name: ai_agent_training_sessions fk_ai_training_conv; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_training_sessions
    ADD CONSTRAINT fk_ai_training_conv FOREIGN KEY (conversation_id) REFERENCES chat_enterprise_agora.ai_agent_conversations(id);


--
-- Name: ai_agent_training_sessions fk_ai_training_trainer; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.ai_agent_training_sessions
    ADD CONSTRAINT fk_ai_training_trainer FOREIGN KEY (trainer_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: chat_attachments fk_chat_attachments_message; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_attachments
    ADD CONSTRAINT fk_chat_attachments_message FOREIGN KEY (chat_message_id) REFERENCES chat_enterprise_agora.chat_messages(id) ON DELETE CASCADE;


--
-- Name: chat_channels fk_chat_channels_creator; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channels
    ADD CONSTRAINT fk_chat_channels_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: chat_channels fk_chat_channels_org; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channels
    ADD CONSTRAINT fk_chat_channels_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: chat_channel_members fk_chat_members_channel; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_members
    ADD CONSTRAINT fk_chat_members_channel FOREIGN KEY (chat_channel_id) REFERENCES chat_enterprise_agora.chat_channels(id) ON DELETE CASCADE;


--
-- Name: chat_channel_members fk_chat_members_contact; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_channel_members
    ADD CONSTRAINT fk_chat_members_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: chat_mentions fk_chat_mentions_contact; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_mentions
    ADD CONSTRAINT fk_chat_mentions_contact FOREIGN KEY (mentioned_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: chat_mentions fk_chat_mentions_message; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_mentions
    ADD CONSTRAINT fk_chat_mentions_message FOREIGN KEY (chat_message_id) REFERENCES chat_enterprise_agora.chat_messages(id) ON DELETE CASCADE;


--
-- Name: chat_messages fk_chat_messages_channel; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_messages
    ADD CONSTRAINT fk_chat_messages_channel FOREIGN KEY (chat_channel_id) REFERENCES chat_enterprise_agora.chat_channels(id) ON DELETE CASCADE;


--
-- Name: chat_messages fk_chat_messages_reply; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_messages
    ADD CONSTRAINT fk_chat_messages_reply FOREIGN KEY (replied_to_message_id) REFERENCES chat_enterprise_agora.chat_messages(id);


--
-- Name: chat_messages fk_chat_messages_sender; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_messages
    ADD CONSTRAINT fk_chat_messages_sender FOREIGN KEY (sender_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: chat_message_reactions fk_chat_reactions_contact; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_reactions
    ADD CONSTRAINT fk_chat_reactions_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: chat_message_reactions fk_chat_reactions_message; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_reactions
    ADD CONSTRAINT fk_chat_reactions_message FOREIGN KEY (chat_message_id) REFERENCES chat_enterprise_agora.chat_messages(id) ON DELETE CASCADE;


--
-- Name: chat_message_threads fk_chat_threads_message; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_threads
    ADD CONSTRAINT fk_chat_threads_message FOREIGN KEY (thread_message_id) REFERENCES chat_enterprise_agora.chat_messages(id) ON DELETE CASCADE;


--
-- Name: chat_message_threads fk_chat_threads_parent; Type: FK CONSTRAINT; Schema: chat_enterprise_agora; Owner: postgres
--

ALTER TABLE ONLY chat_enterprise_agora.chat_message_threads
    ADD CONSTRAINT fk_chat_threads_parent FOREIGN KEY (parent_message_id) REFERENCES chat_enterprise_agora.chat_messages(id) ON DELETE CASCADE;


--
-- Name: document_access_log fk_document_access_log_contact; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_access_log
    ADD CONSTRAINT fk_document_access_log_contact FOREIGN KEY (accessed_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_access_log fk_document_access_log_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_access_log
    ADD CONSTRAINT fk_document_access_log_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_folders fk_document_folders_creator; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folders
    ADD CONSTRAINT fk_document_folders_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_folders fk_document_folders_organization; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folders
    ADD CONSTRAINT fk_document_folders_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: document_folders fk_document_folders_parent; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folders
    ADD CONSTRAINT fk_document_folders_parent FOREIGN KEY (parent_folder_id) REFERENCES documentos_file_management.document_folders(id);


--
-- Name: document_ocr_results fk_document_ocr_results_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_ocr_results
    ADD CONSTRAINT fk_document_ocr_results_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_permissions fk_document_permissions_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_permissions
    ADD CONSTRAINT fk_document_permissions_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_permissions fk_document_permissions_granter; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_permissions
    ADD CONSTRAINT fk_document_permissions_granter FOREIGN KEY (granted_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_reviews fk_document_reviews_assigner; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_reviews
    ADD CONSTRAINT fk_document_reviews_assigner FOREIGN KEY (assigned_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_reviews fk_document_reviews_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_reviews
    ADD CONSTRAINT fk_document_reviews_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_reviews fk_document_reviews_reviewer; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_reviews
    ADD CONSTRAINT fk_document_reviews_reviewer FOREIGN KEY (reviewer_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_shares fk_document_shares_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_shares
    ADD CONSTRAINT fk_document_shares_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_shares fk_document_shares_sharer; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_shares
    ADD CONSTRAINT fk_document_shares_sharer FOREIGN KEY (shared_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_tags fk_document_tags_creator; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_tags
    ADD CONSTRAINT fk_document_tags_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_tags fk_document_tags_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_tags
    ADD CONSTRAINT fk_document_tags_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_versions fk_document_versions_creator; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_versions
    ADD CONSTRAINT fk_document_versions_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_versions fk_document_versions_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_versions
    ADD CONSTRAINT fk_document_versions_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: documents fk_documents_organization; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents
    ADD CONSTRAINT fk_documents_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: documents fk_documents_type; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents
    ADD CONSTRAINT fk_documents_type FOREIGN KEY (document_type_id) REFERENCES documentos_file_management.document_types(id);


--
-- Name: documents fk_documents_uploader; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.documents
    ADD CONSTRAINT fk_documents_uploader FOREIGN KEY (uploaded_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_folder_assignments fk_folder_assignments_assigner; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folder_assignments
    ADD CONSTRAINT fk_folder_assignments_assigner FOREIGN KEY (assigned_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: document_folder_assignments fk_folder_assignments_document; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folder_assignments
    ADD CONSTRAINT fk_folder_assignments_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: document_folder_assignments fk_folder_assignments_folder; Type: FK CONSTRAINT; Schema: documentos_file_management; Owner: postgres
--

ALTER TABLE ONLY documentos_file_management.document_folder_assignments
    ADD CONSTRAINT fk_folder_assignments_folder FOREIGN KEY (folder_id) REFERENCES documentos_file_management.document_folders(id);


--
-- Name: email_automated_responses fk_automated_responses_account; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_automated_responses
    ADD CONSTRAINT fk_automated_responses_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id);


--
-- Name: email_automated_responses fk_automated_responses_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_automated_responses
    ADD CONSTRAINT fk_automated_responses_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_automated_responses fk_automated_responses_template; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_automated_responses
    ADD CONSTRAINT fk_automated_responses_template FOREIGN KEY (email_template_id) REFERENCES emails_enterprise.email_templates(id);


--
-- Name: email_accounts fk_email_accounts_contact; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_accounts
    ADD CONSTRAINT fk_email_accounts_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_accounts fk_email_accounts_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_accounts
    ADD CONSTRAINT fk_email_accounts_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_accounts fk_email_accounts_provider; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_accounts
    ADD CONSTRAINT fk_email_accounts_provider FOREIGN KEY (email_provider_id) REFERENCES emails_enterprise.email_providers(id);


--
-- Name: email_assignments fk_email_assignments_assignee; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_assignments
    ADD CONSTRAINT fk_email_assignments_assignee FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_assignments fk_email_assignments_assigner; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_assignments
    ADD CONSTRAINT fk_email_assignments_assigner FOREIGN KEY (assigned_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_assignments fk_email_assignments_message; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_assignments
    ADD CONSTRAINT fk_email_assignments_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id);


--
-- Name: email_attachments fk_email_attachments_message; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_attachments
    ADD CONSTRAINT fk_email_attachments_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id) ON DELETE CASCADE;


--
-- Name: email_campaigns fk_email_campaigns_creator; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_campaigns
    ADD CONSTRAINT fk_email_campaigns_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_campaigns fk_email_campaigns_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_campaigns
    ADD CONSTRAINT fk_email_campaigns_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_campaigns fk_email_campaigns_template; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_campaigns
    ADD CONSTRAINT fk_email_campaigns_template FOREIGN KEY (email_template_id) REFERENCES emails_enterprise.email_templates(id);


--
-- Name: email_folders fk_email_folders_account; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_folders
    ADD CONSTRAINT fk_email_folders_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id) ON DELETE CASCADE;


--
-- Name: email_folders fk_email_folders_parent; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_folders
    ADD CONSTRAINT fk_email_folders_parent FOREIGN KEY (parent_folder_id) REFERENCES emails_enterprise.email_folders(id);


--
-- Name: email_labels fk_email_labels_creator; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_labels
    ADD CONSTRAINT fk_email_labels_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_labels fk_email_labels_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_labels
    ADD CONSTRAINT fk_email_labels_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_messages fk_email_messages_account; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_messages
    ADD CONSTRAINT fk_email_messages_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id);


--
-- Name: email_messages fk_email_messages_assignee; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_messages
    ADD CONSTRAINT fk_email_messages_assignee FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_messages fk_email_messages_folder; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_messages
    ADD CONSTRAINT fk_email_messages_folder FOREIGN KEY (email_folder_id) REFERENCES emails_enterprise.email_folders(id);


--
-- Name: email_recipients fk_email_recipients_contact; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_recipients
    ADD CONSTRAINT fk_email_recipients_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_recipients fk_email_recipients_message; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_recipients
    ADD CONSTRAINT fk_email_recipients_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id) ON DELETE CASCADE;


--
-- Name: email_templates fk_email_templates_creator; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_templates
    ADD CONSTRAINT fk_email_templates_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_templates fk_email_templates_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_templates
    ADD CONSTRAINT fk_email_templates_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_threads fk_email_threads_assignee; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_threads
    ADD CONSTRAINT fk_email_threads_assignee FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_threads fk_email_threads_last_contact; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_threads
    ADD CONSTRAINT fk_email_threads_last_contact FOREIGN KEY (last_activity_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_threads fk_email_threads_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_threads
    ADD CONSTRAINT fk_email_threads_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_performance_metrics fk_metrics_account; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_performance_metrics
    ADD CONSTRAINT fk_metrics_account FOREIGN KEY (email_account_id) REFERENCES emails_enterprise.email_accounts(id);


--
-- Name: email_performance_metrics fk_metrics_contact; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_performance_metrics
    ADD CONSTRAINT fk_metrics_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: email_performance_metrics fk_metrics_org; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_performance_metrics
    ADD CONSTRAINT fk_metrics_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: email_tracking_pixels fk_tracking_pixels_message; Type: FK CONSTRAINT; Schema: emails_enterprise; Owner: postgres
--

ALTER TABLE ONLY emails_enterprise.email_tracking_pixels
    ADD CONSTRAINT fk_tracking_pixels_message FOREIGN KEY (email_message_id) REFERENCES emails_enterprise.email_messages(id);


--
-- Name: bank_accounts fk_bank_accounts_organization; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_accounts
    ADD CONSTRAINT fk_bank_accounts_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: bank_statements fk_bank_statements_account; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_statements
    ADD CONSTRAINT fk_bank_statements_account FOREIGN KEY (bank_account_id) REFERENCES finanzas_bookkeeping.bank_accounts(id);


--
-- Name: bank_statements fk_bank_statements_contact; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.bank_statements
    ADD CONSTRAINT fk_bank_statements_contact FOREIGN KEY (reconciled_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: cash_accounts fk_cash_accounts_contact; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.cash_accounts
    ADD CONSTRAINT fk_cash_accounts_contact FOREIGN KEY (responsible_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: cash_accounts fk_cash_accounts_organization; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.cash_accounts
    ADD CONSTRAINT fk_cash_accounts_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: check_register fk_check_register_bank_account; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register
    ADD CONSTRAINT fk_check_register_bank_account FOREIGN KEY (bank_account_id) REFERENCES finanzas_bookkeeping.bank_accounts(id);


--
-- Name: check_register fk_check_register_issued_by; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register
    ADD CONSTRAINT fk_check_register_issued_by FOREIGN KEY (issued_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: check_register fk_check_register_payee; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register
    ADD CONSTRAINT fk_check_register_payee FOREIGN KEY (payee_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: check_register fk_check_register_wallet; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.check_register
    ADD CONSTRAINT fk_check_register_wallet FOREIGN KEY (wallet_id) REFERENCES finanzas_bookkeeping.virtual_wallets(id);


--
-- Name: commission_calculations fk_commission_calc_check; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.commission_calculations
    ADD CONSTRAINT fk_commission_calc_check FOREIGN KEY (paid_via_check_id) REFERENCES finanzas_bookkeeping.check_register(id);


--
-- Name: commission_calculations fk_commission_calc_contact; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.commission_calculations
    ADD CONSTRAINT fk_commission_calc_contact FOREIGN KEY (salesperson_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: commission_calculations fk_commission_calc_wallet; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.commission_calculations
    ADD CONSTRAINT fk_commission_calc_wallet FOREIGN KEY (wallet_id) REFERENCES finanzas_bookkeeping.virtual_wallets(id);


--
-- Name: invoice_payments fk_invoice_payments_bank_account; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.invoice_payments
    ADD CONSTRAINT fk_invoice_payments_bank_account FOREIGN KEY (bank_account_id) REFERENCES finanzas_bookkeeping.bank_accounts(id);


--
-- Name: invoice_payments fk_invoice_payments_contact; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.invoice_payments
    ADD CONSTRAINT fk_invoice_payments_contact FOREIGN KEY (processed_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: transaction_categories fk_transaction_categories_irs; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.transaction_categories
    ADD CONSTRAINT fk_transaction_categories_irs FOREIGN KEY (irs_category_id) REFERENCES finanzas_bookkeeping.irs_categories(id);


--
-- Name: transaction_categories fk_transaction_categories_org; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.transaction_categories
    ADD CONSTRAINT fk_transaction_categories_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: transaction_categories fk_transaction_categories_parent; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.transaction_categories
    ADD CONSTRAINT fk_transaction_categories_parent FOREIGN KEY (parent_category_id) REFERENCES finanzas_bookkeeping.transaction_categories(id);


--
-- Name: wallet_balances fk_wallet_balances_wallet; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.wallet_balances
    ADD CONSTRAINT fk_wallet_balances_wallet FOREIGN KEY (wallet_id) REFERENCES finanzas_bookkeeping.virtual_wallets(id);


--
-- Name: virtual_wallets fk_wallets_contact; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.virtual_wallets
    ADD CONSTRAINT fk_wallets_contact FOREIGN KEY (responsible_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: virtual_wallets fk_wallets_org; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.virtual_wallets
    ADD CONSTRAINT fk_wallets_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: virtual_wallets fk_wallets_type; Type: FK CONSTRAINT; Schema: finanzas_bookkeeping; Owner: postgres
--

ALTER TABLE ONLY finanzas_bookkeeping.virtual_wallets
    ADD CONSTRAINT fk_wallets_type FOREIGN KEY (wallet_type_id) REFERENCES finanzas_bookkeeping.wallet_types(id);


--
-- Name: inspection_areas fk_inspection_areas_inspection; Type: FK CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_areas
    ADD CONSTRAINT fk_inspection_areas_inspection FOREIGN KEY (inspection_id) REFERENCES inspecciones_evaluaciones.inspections(id);


--
-- Name: inspection_types fk_inspection_types_standard; Type: FK CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspection_types
    ADD CONSTRAINT fk_inspection_types_standard FOREIGN KEY (iicrc_standard_id) REFERENCES inspecciones_evaluaciones.iicrc_standards(id);


--
-- Name: inspections fk_inspections_inspector; Type: FK CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspections
    ADD CONSTRAINT fk_inspections_inspector FOREIGN KEY (inspector_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: inspections fk_inspections_project; Type: FK CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspections
    ADD CONSTRAINT fk_inspections_project FOREIGN KEY (customer_project_id) REFERENCES base_foundation.customer_projects(id);


--
-- Name: inspections fk_inspections_standard; Type: FK CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspections
    ADD CONSTRAINT fk_inspections_standard FOREIGN KEY (iicrc_standard_id) REFERENCES inspecciones_evaluaciones.iicrc_standards(id);


--
-- Name: inspections fk_inspections_type; Type: FK CONSTRAINT; Schema: inspecciones_evaluaciones; Owner: postgres
--

ALTER TABLE ONLY inspecciones_evaluaciones.inspections
    ADD CONSTRAINT fk_inspections_type FOREIGN KEY (inspection_type_id) REFERENCES inspecciones_evaluaciones.inspection_types(id);


--
-- Name: note_attachments fk_note_attachments_attacher; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_attachments
    ADD CONSTRAINT fk_note_attachments_attacher FOREIGN KEY (attached_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: note_attachments fk_note_attachments_document; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_attachments
    ADD CONSTRAINT fk_note_attachments_document FOREIGN KEY (document_id) REFERENCES documentos_file_management.documents(id);


--
-- Name: note_attachments fk_note_attachments_note; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_attachments
    ADD CONSTRAINT fk_note_attachments_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id);


--
-- Name: note_mentions fk_note_mentions_contact; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_mentions
    ADD CONSTRAINT fk_note_mentions_contact FOREIGN KEY (mentioned_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: note_mentions fk_note_mentions_note; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_mentions
    ADD CONSTRAINT fk_note_mentions_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id);


--
-- Name: note_notifications fk_note_notifications_note; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_notifications
    ADD CONSTRAINT fk_note_notifications_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id);


--
-- Name: note_notifications fk_note_notifications_recipient; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_notifications
    ADD CONSTRAINT fk_note_notifications_recipient FOREIGN KEY (recipient_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: note_reactions fk_note_reactions_note; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_reactions
    ADD CONSTRAINT fk_note_reactions_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id);


--
-- Name: note_reactions fk_note_reactions_reactor; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_reactions
    ADD CONSTRAINT fk_note_reactions_reactor FOREIGN KEY (reacted_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: note_tags fk_note_tags_creator; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_tags
    ADD CONSTRAINT fk_note_tags_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: note_tags fk_note_tags_note; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.note_tags
    ADD CONSTRAINT fk_note_tags_note FOREIGN KEY (note_id) REFERENCES notas_comunicacion.notes(id);


--
-- Name: notes fk_notes_creator; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.notes
    ADD CONSTRAINT fk_notes_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notes fk_notes_parent; Type: FK CONSTRAINT; Schema: notas_comunicacion; Owner: postgres
--

ALTER TABLE ONLY notas_comunicacion.notes
    ADD CONSTRAINT fk_notes_parent FOREIGN KEY (parent_note_id) REFERENCES notas_comunicacion.notes(id);


--
-- Name: notification_analytics fk_analytics_org; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_analytics
    ADD CONSTRAINT fk_analytics_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: notification_analytics fk_analytics_type; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_analytics
    ADD CONSTRAINT fk_analytics_type FOREIGN KEY (notification_type_id) REFERENCES notifications_system_enterprise.notification_types(id);


--
-- Name: notification_delivery_log fk_delivery_log_queue; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_delivery_log
    ADD CONSTRAINT fk_delivery_log_queue FOREIGN KEY (notification_queue_id) REFERENCES notifications_system_enterprise.notification_queue(id) ON DELETE CASCADE;


--
-- Name: notification_delivery_log fk_delivery_log_recipient; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_delivery_log
    ADD CONSTRAINT fk_delivery_log_recipient FOREIGN KEY (recipient_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: escalation_rules fk_escalation_rules_creator; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.escalation_rules
    ADD CONSTRAINT fk_escalation_rules_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: escalation_rules fk_escalation_rules_org; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.escalation_rules
    ADD CONSTRAINT fk_escalation_rules_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: escalation_rules fk_escalation_rules_template; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.escalation_rules
    ADD CONSTRAINT fk_escalation_rules_template FOREIGN KEY (notification_template_id) REFERENCES notifications_system_enterprise.notification_templates(id);


--
-- Name: escalation_rules fk_escalation_rules_type; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.escalation_rules
    ADD CONSTRAINT fk_escalation_rules_type FOREIGN KEY (notification_type_id) REFERENCES notifications_system_enterprise.notification_types(id) ON DELETE CASCADE;


--
-- Name: notification_failures fk_failures_queue; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_failures
    ADD CONSTRAINT fk_failures_queue FOREIGN KEY (notification_queue_id) REFERENCES notifications_system_enterprise.notification_queue(id) ON DELETE CASCADE;


--
-- Name: notification_failures fk_failures_resolver; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_failures
    ADD CONSTRAINT fk_failures_resolver FOREIGN KEY (resolved_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notification_queue fk_queue_creator; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue
    ADD CONSTRAINT fk_queue_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notification_queue fk_queue_notification_type; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue
    ADD CONSTRAINT fk_queue_notification_type FOREIGN KEY (notification_type_id) REFERENCES notifications_system_enterprise.notification_types(id) ON DELETE SET NULL;


--
-- Name: notification_queue fk_queue_organization; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue
    ADD CONSTRAINT fk_queue_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: notification_queue fk_queue_template; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue
    ADD CONSTRAINT fk_queue_template FOREIGN KEY (template_id) REFERENCES notifications_system_enterprise.notification_templates(id) ON DELETE SET NULL;


--
-- Name: notification_queue fk_queue_trigger; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_queue
    ADD CONSTRAINT fk_queue_trigger FOREIGN KEY (trigger_id) REFERENCES notifications_system_enterprise.notification_triggers(id) ON DELETE SET NULL;


--
-- Name: notification_recipients fk_recipients_contact; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_recipients
    ADD CONSTRAINT fk_recipients_contact FOREIGN KEY (recipient_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notification_recipients fk_recipients_queue; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_recipients
    ADD CONSTRAINT fk_recipients_queue FOREIGN KEY (notification_queue_id) REFERENCES notifications_system_enterprise.notification_queue(id) ON DELETE CASCADE;


--
-- Name: notification_rules fk_rules_creator; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_rules
    ADD CONSTRAINT fk_rules_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notification_rules fk_rules_organization; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_rules
    ADD CONSTRAINT fk_rules_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: notification_templates fk_templates_creator; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_templates
    ADD CONSTRAINT fk_templates_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notification_templates fk_templates_notification_type; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_templates
    ADD CONSTRAINT fk_templates_notification_type FOREIGN KEY (notification_type_id) REFERENCES notifications_system_enterprise.notification_types(id) ON DELETE CASCADE;


--
-- Name: notification_triggers fk_triggers_creator; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers
    ADD CONSTRAINT fk_triggers_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: notification_triggers fk_triggers_notification_type; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers
    ADD CONSTRAINT fk_triggers_notification_type FOREIGN KEY (notification_type_id) REFERENCES notifications_system_enterprise.notification_types(id) ON DELETE CASCADE;


--
-- Name: notification_triggers fk_triggers_organization; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers
    ADD CONSTRAINT fk_triggers_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: notification_triggers fk_triggers_workflow_def; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers
    ADD CONSTRAINT fk_triggers_workflow_def FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);


--
-- Name: notification_triggers fk_triggers_workflow_step; Type: FK CONSTRAINT; Schema: notifications_system_enterprise; Owner: postgres
--

ALTER TABLE ONLY notifications_system_enterprise.notification_triggers
    ADD CONSTRAINT fk_triggers_workflow_step FOREIGN KEY (workflow_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);


--
-- Name: ai_data_preparation fk_ai_data_prep_job; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.ai_data_preparation
    ADD CONSTRAINT fk_ai_data_prep_job FOREIGN KEY (etl_job_id) REFERENCES reports_business_intelligence.etl_jobs(id);


--
-- Name: cache_reports fk_cache_reports_report; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.cache_reports
    ADD CONSTRAINT fk_cache_reports_report FOREIGN KEY (report_definition_id) REFERENCES reports_business_intelligence.report_definitions(id) ON DELETE CASCADE;


--
-- Name: dashboard_definitions fk_dashboard_definitions_creator; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_definitions
    ADD CONSTRAINT fk_dashboard_definitions_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: dashboard_definitions fk_dashboard_definitions_org; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_definitions
    ADD CONSTRAINT fk_dashboard_definitions_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: dashboard_performance_metrics fk_dashboard_metrics_dashboard; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_performance_metrics
    ADD CONSTRAINT fk_dashboard_metrics_dashboard FOREIGN KEY (dashboard_definition_id) REFERENCES reports_business_intelligence.dashboard_definitions(id) ON DELETE CASCADE;


--
-- Name: dashboard_performance_metrics fk_dashboard_metrics_widget; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_performance_metrics
    ADD CONSTRAINT fk_dashboard_metrics_widget FOREIGN KEY (widget_id) REFERENCES reports_business_intelligence.dashboard_widgets(id) ON DELETE CASCADE;


--
-- Name: dashboard_permissions fk_dashboard_permissions_contact; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_permissions
    ADD CONSTRAINT fk_dashboard_permissions_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: dashboard_permissions fk_dashboard_permissions_dashboard; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_permissions
    ADD CONSTRAINT fk_dashboard_permissions_dashboard FOREIGN KEY (dashboard_definition_id) REFERENCES reports_business_intelligence.dashboard_definitions(id) ON DELETE CASCADE;


--
-- Name: dashboard_permissions fk_dashboard_permissions_granted_by; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_permissions
    ADD CONSTRAINT fk_dashboard_permissions_granted_by FOREIGN KEY (granted_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: dashboard_schedules fk_dashboard_schedules_dashboard; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_schedules
    ADD CONSTRAINT fk_dashboard_schedules_dashboard FOREIGN KEY (dashboard_definition_id) REFERENCES reports_business_intelligence.dashboard_definitions(id) ON DELETE CASCADE;


--
-- Name: dashboard_widgets fk_dashboard_widgets_dashboard; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.dashboard_widgets
    ADD CONSTRAINT fk_dashboard_widgets_dashboard FOREIGN KEY (dashboard_definition_id) REFERENCES reports_business_intelligence.dashboard_definitions(id) ON DELETE CASCADE;


--
-- Name: data_dictionary fk_data_dictionary_owner; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_dictionary
    ADD CONSTRAINT fk_data_dictionary_owner FOREIGN KEY (data_owner_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: data_dictionary fk_data_dictionary_table; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_dictionary
    ADD CONSTRAINT fk_data_dictionary_table FOREIGN KEY (table_id) REFERENCES reports_business_intelligence.data_warehouse_tables(id) ON DELETE CASCADE;


--
-- Name: data_quality_checks fk_data_quality_checks_job; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.data_quality_checks
    ADD CONSTRAINT fk_data_quality_checks_job FOREIGN KEY (etl_job_id) REFERENCES reports_business_intelligence.etl_jobs(id) ON DELETE CASCADE;


--
-- Name: etl_jobs fk_etl_jobs_creator; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.etl_jobs
    ADD CONSTRAINT fk_etl_jobs_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: kpi_alerts fk_kpi_alerts_contact; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_alerts
    ADD CONSTRAINT fk_kpi_alerts_contact FOREIGN KEY (acknowledged_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: kpi_alerts fk_kpi_alerts_kpi; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_alerts
    ADD CONSTRAINT fk_kpi_alerts_kpi FOREIGN KEY (kpi_definition_id) REFERENCES reports_business_intelligence.kpi_definitions(id) ON DELETE CASCADE;


--
-- Name: kpi_alerts fk_kpi_alerts_value; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_alerts
    ADD CONSTRAINT fk_kpi_alerts_value FOREIGN KEY (kpi_value_id) REFERENCES reports_business_intelligence.kpi_values(id) ON DELETE CASCADE;


--
-- Name: kpi_benchmarks fk_kpi_benchmarks_kpi; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_benchmarks
    ADD CONSTRAINT fk_kpi_benchmarks_kpi FOREIGN KEY (kpi_definition_id) REFERENCES reports_business_intelligence.kpi_definitions(id) ON DELETE CASCADE;


--
-- Name: kpi_benchmarks fk_kpi_benchmarks_org; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_benchmarks
    ADD CONSTRAINT fk_kpi_benchmarks_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: kpi_definitions fk_kpi_definitions_creator; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_definitions
    ADD CONSTRAINT fk_kpi_definitions_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: kpi_definitions fk_kpi_definitions_org; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_definitions
    ADD CONSTRAINT fk_kpi_definitions_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: kpi_values fk_kpi_values_kpi; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.kpi_values
    ADD CONSTRAINT fk_kpi_values_kpi FOREIGN KEY (kpi_definition_id) REFERENCES reports_business_intelligence.kpi_definitions(id) ON DELETE CASCADE;


--
-- Name: query_optimizations fk_query_optimizations_kpi; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.query_optimizations
    ADD CONSTRAINT fk_query_optimizations_kpi FOREIGN KEY (kpi_definition_id) REFERENCES reports_business_intelligence.kpi_definitions(id);


--
-- Name: query_optimizations fk_query_optimizations_report; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.query_optimizations
    ADD CONSTRAINT fk_query_optimizations_report FOREIGN KEY (report_definition_id) REFERENCES reports_business_intelligence.report_definitions(id);


--
-- Name: report_access_log fk_report_access_log_contact; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_access_log
    ADD CONSTRAINT fk_report_access_log_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: report_definitions fk_report_definitions_creator; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_definitions
    ADD CONSTRAINT fk_report_definitions_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: report_definitions fk_report_definitions_org; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_definitions
    ADD CONSTRAINT fk_report_definitions_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: report_executions fk_report_executions_contact; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_executions
    ADD CONSTRAINT fk_report_executions_contact FOREIGN KEY (executed_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: report_executions fk_report_executions_report; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_executions
    ADD CONSTRAINT fk_report_executions_report FOREIGN KEY (report_definition_id) REFERENCES reports_business_intelligence.report_definitions(id) ON DELETE CASCADE;


--
-- Name: report_performance_metrics fk_report_metrics_execution; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_performance_metrics
    ADD CONSTRAINT fk_report_metrics_execution FOREIGN KEY (execution_id) REFERENCES reports_business_intelligence.report_executions(id) ON DELETE CASCADE;


--
-- Name: report_performance_metrics fk_report_metrics_report; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_performance_metrics
    ADD CONSTRAINT fk_report_metrics_report FOREIGN KEY (report_definition_id) REFERENCES reports_business_intelligence.report_definitions(id) ON DELETE CASCADE;


--
-- Name: report_permissions fk_report_permissions_contact; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_permissions
    ADD CONSTRAINT fk_report_permissions_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: report_permissions fk_report_permissions_granted_by; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_permissions
    ADD CONSTRAINT fk_report_permissions_granted_by FOREIGN KEY (granted_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: report_permissions fk_report_permissions_report; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_permissions
    ADD CONSTRAINT fk_report_permissions_report FOREIGN KEY (report_definition_id) REFERENCES reports_business_intelligence.report_definitions(id) ON DELETE CASCADE;


--
-- Name: report_schedules fk_report_schedules_report; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.report_schedules
    ADD CONSTRAINT fk_report_schedules_report FOREIGN KEY (report_definition_id) REFERENCES reports_business_intelligence.report_definitions(id) ON DELETE CASCADE;


--
-- Name: user_analytics fk_user_analytics_contact; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.user_analytics
    ADD CONSTRAINT fk_user_analytics_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: user_analytics fk_user_analytics_org; Type: FK CONSTRAINT; Schema: reports_business_intelligence; Owner: postgres
--

ALTER TABLE ONLY reports_business_intelligence.user_analytics
    ADD CONSTRAINT fk_user_analytics_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: technician_availability fk_availability_contact; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_availability
    ADD CONSTRAINT fk_availability_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: route_optimizations fk_routes_technician; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.route_optimizations
    ADD CONSTRAINT fk_routes_technician FOREIGN KEY (technician_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: weather_impact_rules fk_rules_appointment_type; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_impact_rules
    ADD CONSTRAINT fk_rules_appointment_type FOREIGN KEY (appointment_type_id) REFERENCES scheduling_weather.appointment_types(id);


--
-- Name: weather_impact_rules fk_rules_creator; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_impact_rules
    ADD CONSTRAINT fk_rules_creator FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: technician_skills fk_skills_contact; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_skills
    ADD CONSTRAINT fk_skills_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: technician_skills fk_skills_verifier; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.technician_skills
    ADD CONSTRAINT fk_skills_verifier FOREIGN KEY (verified_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: weather_forecasts fk_weather_property; Type: FK CONSTRAINT; Schema: scheduling_weather; Owner: postgres
--

ALTER TABLE ONLY scheduling_weather.weather_forecasts
    ADD CONSTRAINT fk_weather_property FOREIGN KEY (property_id) REFERENCES base_foundation.properties(id);


--
-- Name: task_checklist_items fk_checklist_items_checklist; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklist_items
    ADD CONSTRAINT fk_checklist_items_checklist FOREIGN KEY (checklist_id) REFERENCES task_management.task_checklists(id);


--
-- Name: task_checklist_items fk_checklist_items_contact; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklist_items
    ADD CONSTRAINT fk_checklist_items_contact FOREIGN KEY (completed_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: common_tasks fk_common_tasks_category; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.common_tasks
    ADD CONSTRAINT fk_common_tasks_category FOREIGN KEY (task_category_id) REFERENCES task_management.task_categories(id);


--
-- Name: common_tasks fk_common_tasks_created_by; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.common_tasks
    ADD CONSTRAINT fk_common_tasks_created_by FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: common_tasks fk_common_tasks_org; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.common_tasks
    ADD CONSTRAINT fk_common_tasks_org FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: projects fk_projects_manager; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.projects
    ADD CONSTRAINT fk_projects_manager FOREIGN KEY (project_manager_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: projects fk_projects_organization; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.projects
    ADD CONSTRAINT fk_projects_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: task_assignments fk_task_assignments_contact; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_assignments
    ADD CONSTRAINT fk_task_assignments_contact FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: task_assignments fk_task_assignments_task; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_assignments
    ADD CONSTRAINT fk_task_assignments_task FOREIGN KEY (task_id) REFERENCES task_management.tasks(id);


--
-- Name: task_attachments fk_task_attachments_contact; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_attachments
    ADD CONSTRAINT fk_task_attachments_contact FOREIGN KEY (uploaded_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: task_attachments fk_task_attachments_task; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_attachments
    ADD CONSTRAINT fk_task_attachments_task FOREIGN KEY (task_id) REFERENCES task_management.tasks(id);


--
-- Name: task_categories fk_task_categories_parent; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_categories
    ADD CONSTRAINT fk_task_categories_parent FOREIGN KEY (parent_category_id) REFERENCES task_management.task_categories(id);


--
-- Name: task_checklists fk_task_checklists_task; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_checklists
    ADD CONSTRAINT fk_task_checklists_task FOREIGN KEY (task_id) REFERENCES task_management.tasks(id);


--
-- Name: task_comments fk_task_comments_contact; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_comments
    ADD CONSTRAINT fk_task_comments_contact FOREIGN KEY (comment_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: task_comments fk_task_comments_task; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_comments
    ADD CONSTRAINT fk_task_comments_task FOREIGN KEY (task_id) REFERENCES task_management.tasks(id);


--
-- Name: task_logs fk_task_logs_contact; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_logs
    ADD CONSTRAINT fk_task_logs_contact FOREIGN KEY (changed_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: task_logs fk_task_logs_task; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_logs
    ADD CONSTRAINT fk_task_logs_task FOREIGN KEY (task_id) REFERENCES task_management.tasks(id);


--
-- Name: task_metrics fk_task_metrics_task; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_metrics
    ADD CONSTRAINT fk_task_metrics_task FOREIGN KEY (task_id) REFERENCES task_management.tasks(id);


--
-- Name: task_performance_metrics fk_task_performance_contact; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.task_performance_metrics
    ADD CONSTRAINT fk_task_performance_contact FOREIGN KEY (contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: tasks fk_tasks_assigned_to; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks
    ADD CONSTRAINT fk_tasks_assigned_to FOREIGN KEY (assigned_to_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: tasks fk_tasks_category; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks
    ADD CONSTRAINT fk_tasks_category FOREIGN KEY (task_category_id) REFERENCES task_management.task_categories(id);


--
-- Name: tasks fk_tasks_created_by; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks
    ADD CONSTRAINT fk_tasks_created_by FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: tasks fk_tasks_project; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks
    ADD CONSTRAINT fk_tasks_project FOREIGN KEY (project_id) REFERENCES task_management.projects(id);


--
-- Name: tasks fk_tasks_workflow_execution; Type: FK CONSTRAINT; Schema: task_management; Owner: postgres
--

ALTER TABLE ONLY task_management.tasks
    ADD CONSTRAINT fk_tasks_workflow_execution FOREIGN KEY (workflow_execution_id) REFERENCES workflows_automation_engine.workflow_executions(id);


--
-- Name: business_rules fk_business_rules_created_by_contact; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.business_rules
    ADD CONSTRAINT fk_business_rules_created_by_contact FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: business_rules fk_business_rules_organization; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.business_rules
    ADD CONSTRAINT fk_business_rules_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: business_rules fk_business_rules_related_workflow; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.business_rules
    ADD CONSTRAINT fk_business_rules_related_workflow FOREIGN KEY (related_workflow_id) REFERENCES workflows_automation_engine.workflow_definitions(id);


--
-- Name: rule_actions fk_rule_actions_business_rule; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_actions
    ADD CONSTRAINT fk_rule_actions_business_rule FOREIGN KEY (business_rule_id) REFERENCES workflows_automation_engine.business_rules(id);


--
-- Name: rule_conditions fk_rule_conditions_business_rule; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_conditions
    ADD CONSTRAINT fk_rule_conditions_business_rule FOREIGN KEY (business_rule_id) REFERENCES workflows_automation_engine.business_rules(id);


--
-- Name: rule_executions fk_rule_executions_business_rule; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_executions
    ADD CONSTRAINT fk_rule_executions_business_rule FOREIGN KEY (business_rule_id) REFERENCES workflows_automation_engine.business_rules(id);


--
-- Name: rule_executions fk_rule_executions_workflow_execution; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.rule_executions
    ADD CONSTRAINT fk_rule_executions_workflow_execution FOREIGN KEY (workflow_execution_id) REFERENCES workflows_automation_engine.workflow_executions(id);


--
-- Name: workflow_definitions fk_workflow_definitions_created_by_contact; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_definitions
    ADD CONSTRAINT fk_workflow_definitions_created_by_contact FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: workflow_definitions fk_workflow_definitions_organization; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_definitions
    ADD CONSTRAINT fk_workflow_definitions_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: workflow_executions fk_workflow_executions_current_step; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_executions
    ADD CONSTRAINT fk_workflow_executions_current_step FOREIGN KEY (current_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);


--
-- Name: workflow_executions fk_workflow_executions_definition; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_executions
    ADD CONSTRAINT fk_workflow_executions_definition FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);


--
-- Name: workflow_executions fk_workflow_executions_triggered_by_contact; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_executions
    ADD CONSTRAINT fk_workflow_executions_triggered_by_contact FOREIGN KEY (triggered_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: workflow_schedules fk_workflow_schedules_definition; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_schedules
    ADD CONSTRAINT fk_workflow_schedules_definition FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);


--
-- Name: workflow_steps fk_workflow_steps_definition; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_steps
    ADD CONSTRAINT fk_workflow_steps_definition FOREIGN KEY (workflow_definition_id) REFERENCES workflows_automation_engine.workflow_definitions(id);


--
-- Name: workflow_steps fk_workflow_steps_parent_step; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_steps
    ADD CONSTRAINT fk_workflow_steps_parent_step FOREIGN KEY (parent_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);


--
-- Name: workflow_templates fk_workflow_templates_created_by_contact; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_templates
    ADD CONSTRAINT fk_workflow_templates_created_by_contact FOREIGN KEY (created_by_contact_id) REFERENCES base_foundation.contacts(id);


--
-- Name: workflow_templates fk_workflow_templates_organization; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_templates
    ADD CONSTRAINT fk_workflow_templates_organization FOREIGN KEY (organization_id) REFERENCES base_foundation.organizations(id);


--
-- Name: workflow_variables fk_workflow_variables_execution; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_variables
    ADD CONSTRAINT fk_workflow_variables_execution FOREIGN KEY (workflow_execution_id) REFERENCES workflows_automation_engine.workflow_executions(id);


--
-- Name: workflow_variables fk_workflow_variables_source_step; Type: FK CONSTRAINT; Schema: workflows_automation_engine; Owner: postgres
--

ALTER TABLE ONLY workflows_automation_engine.workflow_variables
    ADD CONSTRAINT fk_workflow_variables_source_step FOREIGN KEY (source_step_id) REFERENCES workflows_automation_engine.workflow_steps(id);


--
-- PostgreSQL database dump complete
--

