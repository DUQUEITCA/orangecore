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

