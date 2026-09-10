--
-- PostgreSQL database cluster dump
--

\restrict EDNDbsWwbLPCbnDoBTs3OhmtwIzdlUCALhrzvV04Zdsm5I4fzDxfw4sKTXRNyHX

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE anon;
ALTER ROLE anon WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticated;
ALTER ROLE authenticated WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE authenticator;
ALTER ROLE authenticator WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:TB2Hxbef2pjW0dKdBtJT+Q==$WtgQ4wEAgy0nX2g9s546M/lglVFWhRQOo5S3neDVFrQ=:F/3KsuaEjh5C3E40IB6sLb+KQhEQdKChNq9P8qit+qs=';
CREATE ROLE dashboard_user;
ALTER ROLE dashboard_user WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB NOLOGIN REPLICATION NOBYPASSRLS;
CREATE ROLE pgbouncer;
ALTER ROLE pgbouncer WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:ICuLfnWMeS9Wn69R6PyHBQ==$rr9Ta/tdD0AlDKXxGun+URdwVkeanAF6xADeiYFWkbA=:/2KnOInRb6357h2fFzeRVwnR9mlYDNoAt0r5/o/K+WU=';
CREATE ROLE postgres;
ALTER ROLE postgres WITH NOSUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:AUwNG00emGE1TpCrtiJnAg==$4MKmc7oRoLYZ8QRcXBbzMtldrw5IO1hDAf2bGjulclY=:YP6ZvgrWCp5CtumS67EXXul7mJqvo0x/2ZKyjHnGqfc=';
CREATE ROLE service_role;
ALTER ROLE service_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION BYPASSRLS;
CREATE ROLE supabase_admin;
ALTER ROLE supabase_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:l/Sf8koDoxXlKFR8MxothA==$aVkI/DuMjqHvRpUNF+ZNBoCyZfon/T5aBFN0Zx1a2uU=:1wbT/Y1/6b4RMUWJ31sP0PuV67xUekl7G0Wsz0KIupw=';
CREATE ROLE supabase_auth_admin;
ALTER ROLE supabase_auth_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:sPL5o5yxgwXiZhaSigrkMg==$kuKE876WHV23/0hxZlWPUyekEDcH3UyvYW0u+Z9asCA=:L+ylHyPs8xbQ/SOVUG2CyoAS32X8Xw077vj4LOvEVmg=';
CREATE ROLE supabase_etl_admin;
ALTER ROLE supabase_etl_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE supabase_functions_admin;
ALTER ROLE supabase_functions_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_privileged_role;
ALTER ROLE supabase_privileged_role WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_read_only_user;
ALTER ROLE supabase_read_only_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:T9Anxvwpg0YmT3u7nCLm4A==$otb2I72OpRqDl2IGM6wDuPTesnveXdBDFfcmFpwCMdk=:vUMODOzbgQUO+qqQmSpyzBnyxv7cSe2NCCfX3EEXdtE=';
CREATE ROLE supabase_realtime_admin;
ALTER ROLE supabase_realtime_admin WITH NOSUPERUSER NOINHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE supabase_replication_admin;
ALTER ROLE supabase_replication_admin WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN REPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:R2F10UWXSDxt+LzUEQVQQQ==$4a9EocoISIyr9YA4QzR0l2PBXdzZohPD+bCLI/Uxda0=:nhcJU1kpohNCQRLCw1lbbSwA8NWWy9DW5/OwjocGRU4=';
CREATE ROLE supabase_storage_admin;
ALTER ROLE supabase_storage_admin WITH NOSUPERUSER NOINHERIT CREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:MjRo3HqL0DDK8nMV08nJRQ==$YBDUMz8GXXlHjdujU3yj6RAEWs7NCtkXBAUWTOAeKIw=:pD/emeZTfMa2kechBxdpNg4MdTS4KzdWi6eCIKNNUak=';

--
-- User Configurations
--

--
-- User Config "anon"
--

ALTER ROLE anon SET statement_timeout TO '3s';

--
-- User Config "authenticated"
--

ALTER ROLE authenticated SET statement_timeout TO '8s';

--
-- User Config "authenticator"
--

ALTER ROLE authenticator SET session_preload_libraries TO 'safeupdate';
ALTER ROLE authenticator SET statement_timeout TO '8s';
ALTER ROLE authenticator SET lock_timeout TO '8s';

--
-- User Config "postgres"
--

ALTER ROLE postgres SET search_path TO E'\\$user', 'public', 'extensions';

--
-- User Config "supabase_admin"
--

ALTER ROLE supabase_admin SET search_path TO E'\\$user', 'public', 'auth', 'extensions';
ALTER ROLE supabase_admin SET log_statement TO 'none';

--
-- User Config "supabase_auth_admin"
--

ALTER ROLE supabase_auth_admin SET search_path TO 'auth';
ALTER ROLE supabase_auth_admin SET idle_in_transaction_session_timeout TO '60000';
ALTER ROLE supabase_auth_admin SET log_statement TO 'none';

--
-- User Config "supabase_functions_admin"
--

ALTER ROLE supabase_functions_admin SET search_path TO 'supabase_functions';

--
-- User Config "supabase_read_only_user"
--

ALTER ROLE supabase_read_only_user SET default_transaction_read_only TO 'on';

--
-- User Config "supabase_storage_admin"
--

ALTER ROLE supabase_storage_admin SET search_path TO 'storage';
ALTER ROLE supabase_storage_admin SET log_statement TO 'none';


--
-- Role memberships
--

GRANT anon TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT anon TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticated TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT authenticated TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticator TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT authenticator TO supabase_storage_admin WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT pg_create_subscription TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_monitor TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_monitor TO supabase_etl_admin WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_monitor TO supabase_read_only_user WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO supabase_etl_admin WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_read_all_data TO supabase_read_only_user WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT pg_signal_backend TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT service_role TO authenticator WITH INHERIT FALSE GRANTED BY supabase_admin;
GRANT service_role TO postgres WITH ADMIN OPTION, INHERIT TRUE GRANTED BY supabase_admin;
GRANT supabase_functions_admin TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT supabase_privileged_role TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT supabase_privileged_role TO supabase_etl_admin WITH INHERIT TRUE GRANTED BY supabase_admin;
GRANT supabase_realtime_admin TO postgres WITH INHERIT TRUE GRANTED BY supabase_admin;






\unrestrict EDNDbsWwbLPCbnDoBTs3OhmtwIzdlUCALhrzvV04Zdsm5I4fzDxfw4sKTXRNyHX

--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

\restrict fD3S87DaKGGUcempPsAzn3jCVzVhOlcJXqsGEkSNCghbmhn9wDyLDge7CZ6fvrV

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- PostgreSQL database dump complete
--

\unrestrict fD3S87DaKGGUcempPsAzn3jCVzVhOlcJXqsGEkSNCghbmhn9wDyLDge7CZ6fvrV

--
-- Database "_supabase" dump
--

--
-- PostgreSQL database dump
--

\restrict fIfFRqNe2MZpMPH6QehufqghkX960EpbNbvAc6YeY2ig2TPVNn66ilZbe4juLqw

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: _supabase; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE _supabase WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';


ALTER DATABASE _supabase OWNER TO postgres;

\unrestrict fIfFRqNe2MZpMPH6QehufqghkX960EpbNbvAc6YeY2ig2TPVNn66ilZbe4juLqw
\connect _supabase
\restrict fIfFRqNe2MZpMPH6QehufqghkX960EpbNbvAc6YeY2ig2TPVNn66ilZbe4juLqw

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
-- Name: _analytics; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _analytics;


ALTER SCHEMA _analytics OWNER TO postgres;

--
-- Name: _supavisor; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _supavisor;


ALTER SCHEMA _supavisor OWNER TO postgres;

--
-- Name: oban_job_state; Type: TYPE; Schema: public; Owner: supabase_admin
--

CREATE TYPE public.oban_job_state AS ENUM (
    'available',
    'scheduled',
    'executing',
    'retryable',
    'completed',
    'discarded',
    'cancelled'
);


ALTER TYPE public.oban_job_state OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alert_queries; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.alert_queries (
    id bigint NOT NULL,
    name character varying(255),
    token uuid,
    query text,
    description text,
    language character varying(255),
    cron character varying(255),
    source_mapping jsonb,
    slack_hook_url character varying(255),
    webhook_notification_url character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE _analytics.alert_queries OWNER TO supabase_admin;

--
-- Name: alert_queries_backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.alert_queries_backends (
    id bigint NOT NULL,
    alert_query_id bigint,
    backend_id bigint
);


ALTER TABLE _analytics.alert_queries_backends OWNER TO supabase_admin;

--
-- Name: alert_queries_backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.alert_queries_backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.alert_queries_backends_id_seq OWNER TO supabase_admin;

--
-- Name: alert_queries_backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.alert_queries_backends_id_seq OWNED BY _analytics.alert_queries_backends.id;


--
-- Name: alert_queries_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.alert_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.alert_queries_id_seq OWNER TO supabase_admin;

--
-- Name: alert_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.alert_queries_id_seq OWNED BY _analytics.alert_queries.id;


--
-- Name: backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.backends (
    id bigint NOT NULL,
    name character varying(255),
    description text,
    user_id bigint,
    type character varying(255),
    config jsonb,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    token uuid NOT NULL,
    metadata jsonb,
    config_encrypted bytea,
    default_ingest boolean DEFAULT false
);


ALTER TABLE _analytics.backends OWNER TO supabase_admin;

--
-- Name: backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.backends_id_seq OWNER TO supabase_admin;

--
-- Name: backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.backends_id_seq OWNED BY _analytics.backends.id;


--
-- Name: billing_accounts; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.billing_accounts (
    id bigint NOT NULL,
    latest_successful_stripe_session jsonb,
    stripe_customer character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    stripe_subscriptions jsonb,
    stripe_invoices jsonb,
    "lifetime_plan?" boolean DEFAULT false,
    lifetime_plan_invoice character varying(255),
    default_payment_method character varying(255),
    custom_invoice_fields jsonb[] DEFAULT ARRAY[]::jsonb[],
    lifetime_plan boolean DEFAULT false NOT NULL
);


ALTER TABLE _analytics.billing_accounts OWNER TO supabase_admin;

--
-- Name: billing_accounts_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.billing_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.billing_accounts_id_seq OWNER TO supabase_admin;

--
-- Name: billing_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.billing_accounts_id_seq OWNED BY _analytics.billing_accounts.id;


--
-- Name: billing_counts; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.billing_counts (
    id bigint NOT NULL,
    node character varying(255),
    count integer,
    user_id bigint,
    source_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.billing_counts OWNER TO supabase_admin;

--
-- Name: billing_counts_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.billing_counts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.billing_counts_id_seq OWNER TO supabase_admin;

--
-- Name: billing_counts_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.billing_counts_id_seq OWNED BY _analytics.billing_counts.id;


--
-- Name: endpoint_queries; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.endpoint_queries (
    id bigint NOT NULL,
    name character varying(255),
    token uuid,
    query text,
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    source_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    sandboxable boolean DEFAULT false,
    cache_duration_seconds integer DEFAULT 3600,
    proactive_requerying_seconds integer DEFAULT 1800,
    max_limit integer DEFAULT 1000,
    enable_auth boolean DEFAULT false,
    language character varying(255) NOT NULL,
    description character varying(255),
    sandbox_query_id bigint,
    labels text,
    backend_id bigint,
    redact_pii boolean DEFAULT false NOT NULL,
    enable_dynamic_reservation boolean DEFAULT false NOT NULL
);


ALTER TABLE _analytics.endpoint_queries OWNER TO supabase_admin;

--
-- Name: endpoint_queries_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.endpoint_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.endpoint_queries_id_seq OWNER TO supabase_admin;

--
-- Name: endpoint_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.endpoint_queries_id_seq OWNED BY _analytics.endpoint_queries.id;


--
-- Name: key_values; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.key_values (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    key text NOT NULL,
    value jsonb NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE _analytics.key_values OWNER TO supabase_admin;

--
-- Name: key_values_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.key_values_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.key_values_id_seq OWNER TO supabase_admin;

--
-- Name: key_values_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.key_values_id_seq OWNED BY _analytics.key_values.id;


--
-- Name: log_events_059cce8e_5319_497a_a83d_6612ed24c8b4; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_059cce8e_5319_497a_a83d_6612ed24c8b4 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_059cce8e_5319_497a_a83d_6612ed24c8b4 OWNER TO postgres;

--
-- Name: log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589 OWNER TO postgres;

--
-- Name: log_events_11ed185c_5891_4562_9b97_69876e020f21; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_11ed185c_5891_4562_9b97_69876e020f21 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_11ed185c_5891_4562_9b97_69876e020f21 OWNER TO postgres;

--
-- Name: log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe OWNER TO postgres;

--
-- Name: log_events_65417733_c8ee_4141_8e1f_393f2691af40; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_65417733_c8ee_4141_8e1f_393f2691af40 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_65417733_c8ee_4141_8e1f_393f2691af40 OWNER TO postgres;

--
-- Name: log_events_af662be7_b391_434f_aeef_5cb26ef0b1df; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_af662be7_b391_434f_aeef_5cb26ef0b1df (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_af662be7_b391_434f_aeef_5cb26ef0b1df OWNER TO postgres;

--
-- Name: log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44 OWNER TO postgres;

--
-- Name: log_events_eac2f713_ac8b_46b2_84b3_671d794588c2; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_eac2f713_ac8b_46b2_84b3_671d794588c2 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_eac2f713_ac8b_46b2_84b3_671d794588c2 OWNER TO postgres;

--
-- Name: log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8; Type: TABLE; Schema: _analytics; Owner: postgres
--

CREATE TABLE _analytics.log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8 (
    id text NOT NULL,
    body jsonb,
    event_message text,
    "timestamp" timestamp without time zone
);


ALTER TABLE _analytics.log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8 OWNER TO postgres;

--
-- Name: oauth_access_grants; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.oauth_access_grants (
    id bigint NOT NULL,
    resource_owner_id integer NOT NULL,
    application_id bigint,
    token character varying(255) NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    revoked_at timestamp(0) without time zone,
    scopes character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.oauth_access_grants OWNER TO supabase_admin;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.oauth_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.oauth_access_grants_id_seq OWNER TO supabase_admin;

--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.oauth_access_grants_id_seq OWNED BY _analytics.oauth_access_grants.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.oauth_access_tokens (
    id bigint NOT NULL,
    application_id bigint,
    resource_owner_id integer,
    token character varying(255) NOT NULL,
    refresh_token character varying(255),
    expires_in integer,
    revoked_at timestamp(0) without time zone,
    scopes character varying(255),
    previous_refresh_token character varying(255) DEFAULT ''::character varying NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    description text
);


ALTER TABLE _analytics.oauth_access_tokens OWNER TO supabase_admin;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.oauth_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.oauth_access_tokens_id_seq OWNER TO supabase_admin;

--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.oauth_access_tokens_id_seq OWNED BY _analytics.oauth_access_tokens.id;


--
-- Name: oauth_applications; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.oauth_applications (
    id bigint NOT NULL,
    owner_id integer NOT NULL,
    name character varying(255) NOT NULL,
    uid character varying(255) NOT NULL,
    secret character varying(255) DEFAULT ''::character varying NOT NULL,
    redirect_uri character varying(255) NOT NULL,
    scopes character varying(255) DEFAULT ''::character varying NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.oauth_applications OWNER TO supabase_admin;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.oauth_applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.oauth_applications_id_seq OWNER TO supabase_admin;

--
-- Name: oauth_applications_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.oauth_applications_id_seq OWNED BY _analytics.oauth_applications.id;


--
-- Name: partner_users; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.partner_users (
    id bigint NOT NULL,
    partner_id bigint,
    user_id bigint,
    upgraded boolean DEFAULT false NOT NULL
);


ALTER TABLE _analytics.partner_users OWNER TO supabase_admin;

--
-- Name: partner_users_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.partner_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.partner_users_id_seq OWNER TO supabase_admin;

--
-- Name: partner_users_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.partner_users_id_seq OWNED BY _analytics.partner_users.id;


--
-- Name: partners; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.partners (
    id bigint NOT NULL,
    name bytea,
    token bytea
);


ALTER TABLE _analytics.partners OWNER TO supabase_admin;

--
-- Name: partners_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.partners_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.partners_id_seq OWNER TO supabase_admin;

--
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.partners_id_seq OWNED BY _analytics.partners.id;


--
-- Name: payment_methods; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.payment_methods (
    id bigint NOT NULL,
    stripe_id character varying(255),
    price_id character varying(255),
    last_four character varying(255),
    brand character varying(255),
    exp_year integer,
    exp_month integer,
    customer_id character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.payment_methods OWNER TO supabase_admin;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.payment_methods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.payment_methods_id_seq OWNER TO supabase_admin;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.payment_methods_id_seq OWNED BY _analytics.payment_methods.id;


--
-- Name: plans; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.plans (
    id bigint NOT NULL,
    name character varying(255),
    stripe_id character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    period character varying(255),
    price integer,
    limit_sources integer,
    limit_rate_limit integer,
    limit_alert_freq integer,
    limit_source_rate_limit integer,
    limit_saved_search_limit integer,
    limit_team_users_limit integer,
    limit_source_fields_limit integer,
    limit_source_ttl bigint DEFAULT 259200000,
    type character varying(255) DEFAULT 'standard'::character varying,
    limit_key_values integer DEFAULT 0
);


ALTER TABLE _analytics.plans OWNER TO supabase_admin;

--
-- Name: plans_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.plans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.plans_id_seq OWNER TO supabase_admin;

--
-- Name: plans_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.plans_id_seq OWNED BY _analytics.plans.id;


--
-- Name: rules; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.rules (
    id bigint NOT NULL,
    regex character varying(255),
    sink uuid,
    source_id bigint NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    regex_struct bytea,
    lql_string text DEFAULT ''::text NOT NULL,
    lql_filters bytea DEFAULT '\x836a'::bytea NOT NULL,
    backend_id bigint,
    token uuid DEFAULT gen_random_uuid()
);

ALTER TABLE ONLY _analytics.rules REPLICA IDENTITY FULL;


ALTER TABLE _analytics.rules OWNER TO supabase_admin;

--
-- Name: rules_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.rules_id_seq OWNER TO supabase_admin;

--
-- Name: rules_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.rules_id_seq OWNED BY _analytics.rules.id;


--
-- Name: saved_search_counters; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.saved_search_counters (
    id bigint NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    saved_search_id bigint NOT NULL,
    granularity text DEFAULT 'day'::text NOT NULL,
    non_tailing_count integer,
    tailing_count integer
);


ALTER TABLE _analytics.saved_search_counters OWNER TO supabase_admin;

--
-- Name: saved_search_counters_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.saved_search_counters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.saved_search_counters_id_seq OWNER TO supabase_admin;

--
-- Name: saved_search_counters_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.saved_search_counters_id_seq OWNED BY _analytics.saved_search_counters.id;


--
-- Name: saved_searches; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.saved_searches (
    id bigint NOT NULL,
    querystring text,
    source_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    saved_by_user boolean,
    lql_filters jsonb,
    lql_charts jsonb,
    "tailing?" boolean DEFAULT true NOT NULL,
    tailing boolean DEFAULT true NOT NULL
);


ALTER TABLE _analytics.saved_searches OWNER TO supabase_admin;

--
-- Name: saved_searches_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.saved_searches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.saved_searches_id_seq OWNER TO supabase_admin;

--
-- Name: saved_searches_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.saved_searches_id_seq OWNED BY _analytics.saved_searches.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _analytics.schema_migrations OWNER TO supabase_admin;

--
-- Name: source_backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.source_backends (
    id bigint NOT NULL,
    source_id bigint,
    type character varying(255),
    config jsonb,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.source_backends OWNER TO supabase_admin;

--
-- Name: source_backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.source_backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.source_backends_id_seq OWNER TO supabase_admin;

--
-- Name: source_backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.source_backends_id_seq OWNED BY _analytics.source_backends.id;


--
-- Name: source_schemas; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.source_schemas (
    id bigint NOT NULL,
    bigquery_schema bytea,
    source_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    schema_flat_map bytea
);


ALTER TABLE _analytics.source_schemas OWNER TO supabase_admin;

--
-- Name: source_schemas_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.source_schemas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.source_schemas_id_seq OWNER TO supabase_admin;

--
-- Name: source_schemas_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.source_schemas_id_seq OWNED BY _analytics.source_schemas.id;


--
-- Name: sources; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.sources (
    id bigint NOT NULL,
    name character varying(255),
    token uuid NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    user_id integer NOT NULL,
    public_token character varying(255),
    favorite boolean DEFAULT false NOT NULL,
    bigquery_table_ttl integer,
    api_quota integer DEFAULT 5 NOT NULL,
    webhook_notification_url character varying(255),
    slack_hook_url character varying(255),
    notifications jsonb DEFAULT '{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}'::jsonb NOT NULL,
    custom_event_message_keys character varying(255),
    log_events_updated_at timestamp(0) without time zone,
    bigquery_schema bytea,
    notifications_every integer DEFAULT 14400000,
    bq_table_partition_type text,
    lock_schema boolean DEFAULT false,
    validate_schema boolean DEFAULT true,
    drop_lql_filters bytea DEFAULT '\x836a'::bytea NOT NULL,
    drop_lql_string character varying(255),
    v2_pipeline boolean DEFAULT false,
    suggested_keys character varying(255) DEFAULT ''::character varying,
    service_name character varying(255),
    transform_copy_fields character varying(255),
    disable_tailing boolean DEFAULT false,
    bq_storage_write_api boolean DEFAULT false,
    bigquery_clustering_fields character varying(255),
    default_ingest_backend_enabled boolean DEFAULT false,
    system_source boolean DEFAULT false,
    system_source_type character varying(255),
    labels text,
    transform_key_values text,
    description text
);

ALTER TABLE ONLY _analytics.sources REPLICA IDENTITY FULL;


ALTER TABLE _analytics.sources OWNER TO supabase_admin;

--
-- Name: sources_backends; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.sources_backends (
    id bigint NOT NULL,
    backend_id bigint,
    source_id bigint
);


ALTER TABLE _analytics.sources_backends OWNER TO supabase_admin;

--
-- Name: sources_backends_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.sources_backends_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.sources_backends_id_seq OWNER TO supabase_admin;

--
-- Name: sources_backends_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.sources_backends_id_seq OWNED BY _analytics.sources_backends.id;


--
-- Name: sources_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.sources_id_seq OWNER TO supabase_admin;

--
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.sources_id_seq OWNED BY _analytics.sources.id;


--
-- Name: system_metrics; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.system_metrics (
    id bigint NOT NULL,
    all_logs_logged bigint,
    node character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.system_metrics OWNER TO supabase_admin;

--
-- Name: system_metrics_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.system_metrics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.system_metrics_id_seq OWNER TO supabase_admin;

--
-- Name: system_metrics_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.system_metrics_id_seq OWNED BY _analytics.system_metrics.id;


--
-- Name: team_users; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.team_users (
    id bigint NOT NULL,
    email character varying(255),
    token text,
    provider character varying(255),
    email_preferred character varying(255),
    name character varying(255),
    image character varying(255),
    email_me_product boolean DEFAULT false NOT NULL,
    phone character varying(255),
    valid_google_account boolean DEFAULT false NOT NULL,
    provider_uid text,
    team_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    preferences jsonb
);


ALTER TABLE _analytics.team_users OWNER TO supabase_admin;

--
-- Name: team_users_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.team_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.team_users_id_seq OWNER TO supabase_admin;

--
-- Name: team_users_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.team_users_id_seq OWNED BY _analytics.team_users.id;


--
-- Name: teams; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.teams (
    id bigint NOT NULL,
    name character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    token character varying(255) DEFAULT gen_random_uuid()
);


ALTER TABLE _analytics.teams OWNER TO supabase_admin;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.teams_id_seq OWNER TO supabase_admin;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.teams_id_seq OWNED BY _analytics.teams.id;


--
-- Name: users; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.users (
    id bigint NOT NULL,
    email character varying(255),
    provider character varying(255) NOT NULL,
    token text NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    api_key character varying(255) NOT NULL,
    old_api_key character varying(255),
    email_preferred character varying(255),
    name character varying(255),
    image character varying(255),
    email_me_product boolean DEFAULT true NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    phone character varying(255),
    bigquery_project_id character varying(255),
    api_quota integer DEFAULT 125 NOT NULL,
    bigquery_dataset_location character varying(255),
    bigquery_dataset_id character varying(255),
    valid_google_account boolean,
    provider_uid text NOT NULL,
    company character varying(255),
    bigquery_udfs_hash character varying(255) DEFAULT ''::character varying NOT NULL,
    bigquery_processed_bytes_limit bigint DEFAULT '10000000000'::bigint NOT NULL,
    "billing_enabled?" boolean DEFAULT false NOT NULL,
    preferences jsonb,
    billing_enabled boolean DEFAULT false NOT NULL,
    endpoints_beta boolean DEFAULT false,
    metadata jsonb,
    partner_upgraded boolean DEFAULT false,
    partner_id bigint,
    bigquery_enable_managed_service_accounts boolean DEFAULT false,
    system_monitoring boolean DEFAULT false NOT NULL,
    bigquery_reservation_search character varying(255),
    bigquery_reservation_alerts character varying(255),
    bigquery_additional_projects character varying(255)
);


ALTER TABLE _analytics.users OWNER TO supabase_admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.users_id_seq OWNER TO supabase_admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.users_id_seq OWNED BY _analytics.users.id;


--
-- Name: vercel_auths; Type: TABLE; Schema: _analytics; Owner: supabase_admin
--

CREATE TABLE _analytics.vercel_auths (
    id bigint NOT NULL,
    access_token character varying(255),
    installation_id character varying(255),
    team_id character varying(255),
    token_type character varying(255),
    vercel_user_id character varying(255),
    user_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _analytics.vercel_auths OWNER TO supabase_admin;

--
-- Name: vercel_auths_id_seq; Type: SEQUENCE; Schema: _analytics; Owner: supabase_admin
--

CREATE SEQUENCE _analytics.vercel_auths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE _analytics.vercel_auths_id_seq OWNER TO supabase_admin;

--
-- Name: vercel_auths_id_seq; Type: SEQUENCE OWNED BY; Schema: _analytics; Owner: supabase_admin
--

ALTER SEQUENCE _analytics.vercel_auths_id_seq OWNED BY _analytics.vercel_auths.id;


--
-- Name: oban_jobs; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE TABLE public.oban_jobs (
    id bigint NOT NULL,
    state public.oban_job_state DEFAULT 'available'::public.oban_job_state NOT NULL,
    queue text DEFAULT 'default'::text NOT NULL,
    worker text NOT NULL,
    args jsonb DEFAULT '{}'::jsonb NOT NULL,
    errors jsonb[] DEFAULT ARRAY[]::jsonb[] NOT NULL,
    attempt integer DEFAULT 0 NOT NULL,
    max_attempts integer DEFAULT 20 NOT NULL,
    inserted_at timestamp without time zone DEFAULT timezone('UTC'::text, now()) NOT NULL,
    scheduled_at timestamp without time zone DEFAULT timezone('UTC'::text, now()) NOT NULL,
    attempted_at timestamp without time zone,
    completed_at timestamp without time zone,
    attempted_by text[],
    discarded_at timestamp without time zone,
    priority integer DEFAULT 0 NOT NULL,
    tags text[] DEFAULT ARRAY[]::text[],
    meta jsonb DEFAULT '{}'::jsonb,
    cancelled_at timestamp without time zone,
    CONSTRAINT attempt_range CHECK (((attempt >= 0) AND (attempt <= max_attempts))),
    CONSTRAINT positive_max_attempts CHECK ((max_attempts > 0)),
    CONSTRAINT queue_length CHECK (((char_length(queue) > 0) AND (char_length(queue) < 128))),
    CONSTRAINT worker_length CHECK (((char_length(worker) > 0) AND (char_length(worker) < 128)))
);


ALTER TABLE public.oban_jobs OWNER TO supabase_admin;

--
-- Name: TABLE oban_jobs; Type: COMMENT; Schema: public; Owner: supabase_admin
--

COMMENT ON TABLE public.oban_jobs IS '12';


--
-- Name: oban_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: supabase_admin
--

CREATE SEQUENCE public.oban_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oban_jobs_id_seq OWNER TO supabase_admin;

--
-- Name: oban_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: supabase_admin
--

ALTER SEQUENCE public.oban_jobs_id_seq OWNED BY public.oban_jobs.id;


--
-- Name: oban_peers; Type: TABLE; Schema: public; Owner: supabase_admin
--

CREATE UNLOGGED TABLE public.oban_peers (
    name text NOT NULL,
    node text NOT NULL,
    started_at timestamp without time zone NOT NULL,
    expires_at timestamp without time zone NOT NULL
);


ALTER TABLE public.oban_peers OWNER TO supabase_admin;

--
-- Name: alert_queries id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries ALTER COLUMN id SET DEFAULT nextval('_analytics.alert_queries_id_seq'::regclass);


--
-- Name: alert_queries_backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries_backends ALTER COLUMN id SET DEFAULT nextval('_analytics.alert_queries_backends_id_seq'::regclass);


--
-- Name: backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.backends ALTER COLUMN id SET DEFAULT nextval('_analytics.backends_id_seq'::regclass);


--
-- Name: billing_accounts id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_accounts ALTER COLUMN id SET DEFAULT nextval('_analytics.billing_accounts_id_seq'::regclass);


--
-- Name: billing_counts id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_counts ALTER COLUMN id SET DEFAULT nextval('_analytics.billing_counts_id_seq'::regclass);


--
-- Name: endpoint_queries id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries ALTER COLUMN id SET DEFAULT nextval('_analytics.endpoint_queries_id_seq'::regclass);


--
-- Name: key_values id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.key_values ALTER COLUMN id SET DEFAULT nextval('_analytics.key_values_id_seq'::regclass);


--
-- Name: oauth_access_grants id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_grants ALTER COLUMN id SET DEFAULT nextval('_analytics.oauth_access_grants_id_seq'::regclass);


--
-- Name: oauth_access_tokens id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_tokens ALTER COLUMN id SET DEFAULT nextval('_analytics.oauth_access_tokens_id_seq'::regclass);


--
-- Name: oauth_applications id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_applications ALTER COLUMN id SET DEFAULT nextval('_analytics.oauth_applications_id_seq'::regclass);


--
-- Name: partner_users id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users ALTER COLUMN id SET DEFAULT nextval('_analytics.partner_users_id_seq'::regclass);


--
-- Name: partners id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partners ALTER COLUMN id SET DEFAULT nextval('_analytics.partners_id_seq'::regclass);


--
-- Name: payment_methods id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.payment_methods ALTER COLUMN id SET DEFAULT nextval('_analytics.payment_methods_id_seq'::regclass);


--
-- Name: plans id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.plans ALTER COLUMN id SET DEFAULT nextval('_analytics.plans_id_seq'::regclass);


--
-- Name: rules id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules ALTER COLUMN id SET DEFAULT nextval('_analytics.rules_id_seq'::regclass);


--
-- Name: saved_search_counters id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_search_counters ALTER COLUMN id SET DEFAULT nextval('_analytics.saved_search_counters_id_seq'::regclass);


--
-- Name: saved_searches id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_searches ALTER COLUMN id SET DEFAULT nextval('_analytics.saved_searches_id_seq'::regclass);


--
-- Name: source_backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_backends ALTER COLUMN id SET DEFAULT nextval('_analytics.source_backends_id_seq'::regclass);


--
-- Name: source_schemas id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_schemas ALTER COLUMN id SET DEFAULT nextval('_analytics.source_schemas_id_seq'::regclass);


--
-- Name: sources id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources ALTER COLUMN id SET DEFAULT nextval('_analytics.sources_id_seq'::regclass);


--
-- Name: sources_backends id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends ALTER COLUMN id SET DEFAULT nextval('_analytics.sources_backends_id_seq'::regclass);


--
-- Name: system_metrics id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.system_metrics ALTER COLUMN id SET DEFAULT nextval('_analytics.system_metrics_id_seq'::regclass);


--
-- Name: team_users id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.team_users ALTER COLUMN id SET DEFAULT nextval('_analytics.team_users_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.teams ALTER COLUMN id SET DEFAULT nextval('_analytics.teams_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.users ALTER COLUMN id SET DEFAULT nextval('_analytics.users_id_seq'::regclass);


--
-- Name: vercel_auths id; Type: DEFAULT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.vercel_auths ALTER COLUMN id SET DEFAULT nextval('_analytics.vercel_auths_id_seq'::regclass);


--
-- Name: oban_jobs id; Type: DEFAULT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.oban_jobs ALTER COLUMN id SET DEFAULT nextval('public.oban_jobs_id_seq'::regclass);


--
-- Data for Name: alert_queries; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.alert_queries (id, name, token, query, description, language, cron, source_mapping, slack_hook_url, webhook_notification_url, user_id, inserted_at, updated_at, enabled) FROM stdin;
\.


--
-- Data for Name: alert_queries_backends; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.alert_queries_backends (id, alert_query_id, backend_id) FROM stdin;
\.


--
-- Data for Name: backends; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.backends (id, name, description, user_id, type, config, inserted_at, updated_at, token, metadata, config_encrypted, default_ingest) FROM stdin;
\.


--
-- Data for Name: billing_accounts; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.billing_accounts (id, latest_successful_stripe_session, stripe_customer, user_id, inserted_at, updated_at, stripe_subscriptions, stripe_invoices, "lifetime_plan?", lifetime_plan_invoice, default_payment_method, custom_invoice_fields, lifetime_plan) FROM stdin;
\.


--
-- Data for Name: billing_counts; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.billing_counts (id, node, count, user_id, source_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: endpoint_queries; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.endpoint_queries (id, name, token, query, user_id, inserted_at, updated_at, source_mapping, sandboxable, cache_duration_seconds, proactive_requerying_seconds, max_limit, enable_auth, language, description, sandbox_query_id, labels, backend_id, redact_pii, enable_dynamic_reservation) FROM stdin;
1	logs.all	96ef063a-d4a0-4598-8bc0-5c9e89b32d61	with edge_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `cloudflare.logs.prod` as t\n  cross join unnest(metadata) as m\nwhere\n  -- order of the where clauses matters\n  -- project then timestamp then everything else\n  t.project = @project\n  AND CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\norder by\n  cast(t.timestamp as timestamp) desc\n),\n\npostgres_logs as (\n  select \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata\nfrom `postgres.logs` as t\nwhere\n  -- order of the where clauses matters\n  -- project then timestamp then everything else\n  t.project = @project\n  AND CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\n  order by cast(t.timestamp as timestamp) desc\n),\n\nfunction_edge_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `deno-relay-logs` as t\n  cross join unnest(t.metadata) as m\nwhere\n  CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\n  and m.project_ref = @project\norder by cast(t.timestamp as timestamp) desc\n),\n\nfunction_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `deno-subhosting-events` as t\n  cross join unnest(t.metadata) as m\nwhere\n  -- order of the where clauses matters\n  -- project then timestamp then everything else\n  m.project_ref = @project\n  AND CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\norder by cast(t.timestamp as timestamp) desc\n),\n\nauth_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `gotrue.logs.prod` as t\n  cross join unnest(t.metadata) as m\nwhere\n  -- order of the where clauses matters\n  -- project then timestamp then everything else\n  -- m.project = @project\n  t.project = @project\n  AND CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\norder by cast(t.timestamp as timestamp) desc\n),\n\nrealtime_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `realtime.logs.prod` as t\n  cross join unnest(t.metadata) as m\nwhere\n  m.project = @project \n  AND CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\norder by cast(t.timestamp as timestamp) desc\n),\n\nstorage_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `storage.logs.prod.2` as t\n  cross join unnest(t.metadata) as m\nwhere\n  m.project = @project\n  AND CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\norder by cast(t.timestamp as timestamp) desc\n),\n\npostgrest_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `postgREST.logs.prod` as t\n  cross join unnest(t.metadata) as m\nwhere\n  CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\n  AND t.project = @project\norder by cast(t.timestamp as timestamp) desc\n),\n\npgbouncer_logs as (\nselect \n  t.timestamp,\n  t.id, \n  t.event_message, \n  t.metadata \nfrom `pgbouncer.logs.prod` as t\n  cross join unnest(t.metadata) as m\nwhere\n  CASE WHEN COALESCE(@iso_timestamp_start, '') = '' THEN  TRUE ELSE  cast(t.timestamp as timestamp) > cast(@iso_timestamp_start as timestamp) END\n  AND CASE WHEN COALESCE(@iso_timestamp_end, '') = '' THEN TRUE ELSE cast(t.timestamp as timestamp) <= cast(@iso_timestamp_end as timestamp) END\n  AND t.project = @project\norder by cast(t.timestamp as timestamp) desc\n)\n\nSELECT id, timestamp, event_message, metadata\nFROM edge_logs\nLIMIT 100	1	2026-05-29 22:10:38	2026-05-29 22:10:38	{"postgres.logs": "e2da31ee-05c7-4f75-b3c9-33a9f755fc44", "deno-relay-logs": "3968f339-d656-4a65-9f15-aefa4ed90dbe", "gotrue.logs.prod": "eac2f713-ac8b-46b2-84b3-671d794588c2", "realtime.logs.prod": "65417733-c8ee-4141-8e1f-393f2691af40", "pgbouncer.logs.prod": "af662be7-b391-434f-aeef-5cb26ef0b1df", "postgREST.logs.prod": "fe8c457a-2c2a-432b-ad22-de7c8d3f8fd8", "storage.logs.prod.2": "11ed185c-5891-4562-9b97-69876e020f21", "cloudflare.logs.prod": "059cce8e-5319-497a-a83d-6612ed24c8b4", "deno-subhosting-events": "10dd98e2-dbb3-47ee-ad59-5d7eb762a589"}	t	0	1800	1000	t	bq_sql	\N	\N	\N	\N	f	f
2	usage.api-counts	4682839d-3bf0-4a43-a495-450fff3c8a4c	with \ndates as (\n  select (case\n    when @interval = 'hourly' then timestamp_sub(current_timestamp(), interval 1 hour)\n    when @interval = 'daily' then timestamp_sub(current_timestamp(), interval 7 day)\n    when @interval = 'minutely' then timestamp_sub(current_timestamp(), interval 60 minute)\n  end) as start\n),\nchart_counts as (\nselect\n  (case\n    when @interval = 'hourly' then timestamp_trunc(f0.timestamp,  hour)\n    when @interval = 'daily' then timestamp_trunc(f0.timestamp,  day)\n    when @interval = 'minutely' then timestamp_trunc(f0.timestamp,  minute)\n  end\n  ) as timestamp,\n  COUNTIF(REGEXP_CONTAINS(f2.path, '/rest')) as total_rest_requests,\n  COUNTIF(REGEXP_CONTAINS(f2.path, '/storage')) as total_storage_requests,\n  COUNTIF(REGEXP_CONTAINS(f2.path, '/auth')) as total_auth_requests,\n  COUNTIF(REGEXP_CONTAINS(f2.path, '/realtime')) as total_realtime_requests,\nFROM\n  dates, \n  `cloudflare.logs.prod` as f0\n  LEFT JOIN UNNEST(metadata) AS f1 ON TRUE\n  LEFT JOIN UNNEST(f1.request) AS f2 ON TRUE\nwhere\n  REGEXP_CONTAINS(f2.url, @project) AND f0.timestamp >= dates[0]\n  -- project = @project\nGROUP BY\n    timestamp\n)\nSELECT\n    datetime(chart_counts.timestamp, 'UTC') as timestamp,\n    COALESCE(SUM(chart_counts.total_rest_requests), 0) as total_rest_requests,\n    COALESCE(SUM(chart_counts.total_storage_requests), 0) as total_storage_requests,\n    COALESCE(SUM(chart_counts.total_auth_requests), 0) as total_auth_requests,\n    COALESCE(SUM(chart_counts.total_realtime_requests), 0) as total_realtime_requests,\nFROM  \n  chart_counts\nGROUP BY\n    timestamp\nORDER BY\n    timestamp asc;	1	2026-05-29 22:10:38	2026-05-29 22:10:38	{"cloudflare.logs.prod": "059cce8e-5319-497a-a83d-6612ed24c8b4"}	t	900	300	1000	t	bq_sql	\N	\N	\N	\N	f	f
\.


--
-- Data for Name: key_values; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.key_values (id, user_id, key, value, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: log_events_059cce8e_5319_497a_a83d_6612ed24c8b4; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_059cce8e_5319_497a_a83d_6612ed24c8b4 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_11ed185c_5891_4562_9b97_69876e020f21; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_11ed185c_5891_4562_9b97_69876e020f21 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_65417733_c8ee_4141_8e1f_393f2691af40; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_65417733_c8ee_4141_8e1f_393f2691af40 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_af662be7_b391_434f_aeef_5cb26ef0b1df; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_af662be7_b391_434f_aeef_5cb26ef0b1df (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_eac2f713_ac8b_46b2_84b3_671d794588c2; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_eac2f713_ac8b_46b2_84b3_671d794588c2 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8; Type: TABLE DATA; Schema: _analytics; Owner: postgres
--

COPY _analytics.log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8 (id, body, event_message, "timestamp") FROM stdin;
\.


--
-- Data for Name: oauth_access_grants; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.oauth_access_grants (id, resource_owner_id, application_id, token, expires_in, redirect_uri, revoked_at, scopes, inserted_at) FROM stdin;
\.


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.oauth_access_tokens (id, application_id, resource_owner_id, token, refresh_token, expires_in, revoked_at, scopes, previous_refresh_token, inserted_at, updated_at, description) FROM stdin;
1	\N	1	api-key	\N	\N	\N	private		2026-05-29 22:10:38	2026-05-29 22:10:38	LOGFLARE_PRIVATE_ACCESS_TOKEN
\.


--
-- Data for Name: oauth_applications; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.oauth_applications (id, owner_id, name, uid, secret, redirect_uri, scopes, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: partner_users; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.partner_users (id, partner_id, user_id, upgraded) FROM stdin;
\.


--
-- Data for Name: partners; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.partners (id, name, token) FROM stdin;
\.


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.payment_methods (id, stripe_id, price_id, last_four, brand, exp_year, exp_month, customer_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: plans; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.plans (id, name, stripe_id, inserted_at, updated_at, period, price, limit_sources, limit_rate_limit, limit_alert_freq, limit_source_rate_limit, limit_saved_search_limit, limit_team_users_limit, limit_source_fields_limit, limit_source_ttl, type, limit_key_values) FROM stdin;
1	Enterprise	\N	2026-05-29 22:10:38	2026-05-29 22:10:38	year	20000	500	500000	1000	100000	1	2	500	5184000000	standard	0
\.


--
-- Data for Name: rules; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.rules (id, regex, sink, source_id, inserted_at, updated_at, regex_struct, lql_string, lql_filters, backend_id, token) FROM stdin;
\.


--
-- Data for Name: saved_search_counters; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.saved_search_counters (id, "timestamp", saved_search_id, granularity, non_tailing_count, tailing_count) FROM stdin;
\.


--
-- Data for Name: saved_searches; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.saved_searches (id, querystring, source_id, inserted_at, updated_at, saved_by_user, lql_filters, lql_charts, "tailing?", tailing) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.schema_migrations (version, inserted_at) FROM stdin;
20181212161742	2026-05-29 22:10:24
20181212220417	2026-05-29 22:10:24
20181212220843	2026-05-29 22:10:24
20181219123536	2026-05-29 22:10:24
20181220234951	2026-05-29 22:10:24
20190111193432	2026-05-29 22:10:24
20190111222747	2026-05-29 22:10:24
20190111223908	2026-05-29 22:10:24
20190128145905	2026-05-29 22:10:24
20190211145604	2026-05-29 22:10:24
20190211215002	2026-05-29 22:10:24
20190212190412	2026-05-29 22:10:24
20190218171231	2026-05-29 22:10:24
20190220020658	2026-05-29 22:10:25
20190220150309	2026-05-29 22:10:25
20190226224323	2026-05-29 22:10:25
20190226225345	2026-05-29 22:10:25
20190313222100	2026-05-29 22:10:25
20190314210542	2026-05-29 22:10:25
20190314234158	2026-05-29 22:10:25
20190321135403	2026-05-29 22:10:25
20190322184724	2026-05-29 22:10:25
20190322194928	2026-05-29 22:10:25
20190326182605	2026-05-29 22:10:25
20190507163835	2026-05-29 22:10:25
20190509154645	2026-05-29 22:10:25
20190522200854	2026-05-29 22:10:25
20190528132518	2026-05-29 22:10:25
20190603134249	2026-05-29 22:10:25
20190604130811	2026-05-29 22:10:25
20190814185734	2026-05-29 22:10:25
20190815222912	2026-05-29 22:10:25
20190820170701	2026-05-29 22:10:25
20190823211533	2026-05-29 22:10:25
20190912214717	2026-05-29 22:10:25
20191007163747	2026-05-29 22:10:25
20191014233159	2026-05-29 22:10:25
20191108163345	2026-05-29 22:10:25
20191111221000	2026-05-29 22:10:25
20191114120409	2026-05-29 22:10:25
20191226181646	2026-05-29 22:10:25
20191230164304	2026-05-29 22:10:25
20200106161131	2026-05-29 22:10:25
20200109165508	2026-05-29 22:10:25
20200113132611	2026-05-29 22:10:25
20200114231904	2026-05-29 22:10:25
20200116122225	2026-05-29 22:10:25
20200116143027	2026-05-29 22:10:25
20200130185455	2026-05-29 22:10:25
20200205180641	2026-05-29 22:10:25
20200311175358	2026-05-29 22:10:25
20200317130710	2026-05-29 22:10:25
20200319164038	2026-05-29 22:10:25
20200320161900	2026-05-29 22:10:25
20200401102642	2026-05-29 22:10:25
20200401132720	2026-05-29 22:10:25
20200401182732	2026-05-29 22:10:25
20200402180315	2026-05-29 22:10:25
20200403130311	2026-05-29 22:10:25
20200409120508	2026-05-29 22:10:25
20200409150827	2026-05-29 22:10:25
20200413161605	2026-05-29 22:10:25
20200422211654	2026-05-29 22:10:25
20200507184618	2026-05-29 22:10:25
20200512205718	2026-05-29 22:10:25
20200513154911	2026-05-29 22:10:25
20200519181117	2026-05-29 22:10:25
20200603150413	2026-05-29 22:10:25
20200605164057	2026-05-29 22:10:25
20200605185446	2026-05-29 22:10:25
20200606140153	2026-05-29 22:10:25
20200803211251	2026-05-29 22:10:25
20200806201742	2026-05-29 22:10:25
20200824155733	2026-05-29 22:10:25
20200826141015	2026-05-29 22:10:25
20201130170051	2026-05-29 22:10:25
20201211125013	2026-05-29 22:10:25
20201229174131	2026-05-29 22:10:25
20210104192144	2026-05-29 22:10:25
20210106205729	2026-05-29 22:10:25
20210118220058	2026-05-29 22:10:25
20210121220159	2026-05-29 22:10:25
20210204203050	2026-05-29 22:10:25
20210215163446	2026-05-29 22:10:25
20210215165548	2026-05-29 22:10:25
20210322193905	2026-05-29 22:10:25
20210521142331	2026-05-29 22:10:25
20210526120333	2026-05-29 22:10:25
20210707201854	2026-05-29 22:10:25
20210712201152	2026-05-29 22:10:25
20210715022534	2026-05-29 22:10:25
20210728172720	2026-05-29 22:10:25
20210729161959	2026-05-29 22:10:25
20210802194723	2026-05-29 22:10:25
20210803020354	2026-05-29 22:10:25
20210804210634	2026-05-29 22:10:25
20210810182003	2026-05-29 22:10:25
20210830181842	2026-05-29 22:10:25
20211027175016	2026-05-29 22:10:25
20211122181200	2026-05-29 22:10:26
20211123192744	2026-05-29 22:10:26
20211130190948	2026-05-29 22:10:26
20211130201505	2026-05-29 22:10:26
20220310172806	2026-05-29 22:10:26
20220523135557	2026-05-29 22:10:26
20220524125216	2026-05-29 22:10:26
20220707030041	2026-05-29 22:10:26
20220714033012	2026-05-29 22:10:26
20220803211705	2026-05-29 22:10:26
20221210010955	2026-05-29 22:10:26
20221210011115	2026-05-29 22:10:26
20230110121321	2026-05-29 22:10:26
20230206155428	2026-05-29 22:10:26
20230223162441	2026-05-29 22:10:26
20230227183828	2026-05-29 22:10:26
20230622160150	2026-05-29 22:10:26
20230622160250	2026-05-29 22:10:26
20230714041101	2026-05-29 22:10:26
20230727111150	2026-05-29 22:10:26
20230807162746	2026-05-29 22:10:26
20230911181436	2026-05-29 22:10:26
20231023174255	2026-05-29 22:10:26
20231027221103	2026-05-29 22:10:26
20231207113137	2026-05-29 22:10:26
20231213013433	2026-05-29 22:10:26
20240214170611	2026-05-29 22:10:26
20240219101411	2026-05-29 22:10:26
20240223104413	2026-05-29 22:10:26
20240327073534	2026-05-29 22:10:26
20240429194758	2026-05-29 22:10:26
20240708025030	2026-05-29 22:10:26
20240725033149	2026-05-29 22:10:26
20240725083359	2026-05-29 22:10:26
20240802110527	2026-05-29 22:10:26
20240806105357	2026-05-29 22:10:26
20240808172408	2026-05-29 22:10:26
20241121183147	2026-05-29 22:10:26
20241204120824	2026-05-29 22:10:26
20250203131456	2026-05-29 22:10:26
20250221154207	2026-05-29 22:10:26
20250224140820	2026-05-29 22:10:26
20250422145132	2026-05-29 22:10:26
20250507072233	2026-05-29 22:10:26
20250518215453	2026-05-29 22:10:26
20250605124931	2026-05-29 22:10:26
20250617074424	2026-05-29 22:10:26
20250617075400	2026-05-29 22:10:26
20250630074142	2026-05-29 22:10:26
20250702081228	2026-05-29 22:10:26
20250709072539	2026-05-29 22:10:26
20250710164717	2026-05-29 22:10:26
20250804174212	2026-05-29 22:10:26
20250804175351	2026-05-29 22:10:26
20250902185149	2026-05-29 22:10:26
20250918055134	2026-05-29 22:10:26
20250922180823	2026-05-29 22:10:26
20251112085259	2026-05-29 22:10:26
20251205181853	2026-05-29 22:10:26
20251216204334	2026-05-29 22:10:26
20251216234322	2026-05-29 22:10:26
20260209080413	2026-05-29 22:10:26
20260209080414	2026-05-29 22:10:26
20260209080415	2026-05-29 22:10:26
20260209080416	2026-05-29 22:10:26
20260216120000	2026-05-29 22:10:26
20260220120000	2026-05-29 22:10:26
20260225110000	2026-05-29 22:10:26
20260227080000	2026-05-29 22:10:26
20260302000000	2026-05-29 22:10:26
20260320011623	2026-05-29 22:10:26
20260403000000	2026-05-29 22:10:26
\.


--
-- Data for Name: source_backends; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.source_backends (id, source_id, type, config, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: source_schemas; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.source_schemas (id, bigquery_schema, source_id, inserted_at, updated_at, schema_flat_map) FROM stdin;
\.


--
-- Data for Name: sources; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.sources (id, name, token, inserted_at, updated_at, user_id, public_token, favorite, bigquery_table_ttl, api_quota, webhook_notification_url, slack_hook_url, notifications, custom_event_message_keys, log_events_updated_at, bigquery_schema, notifications_every, bq_table_partition_type, lock_schema, validate_schema, drop_lql_filters, drop_lql_string, v2_pipeline, suggested_keys, service_name, transform_copy_fields, disable_tailing, bq_storage_write_api, bigquery_clustering_fields, default_ingest_backend_enabled, system_source, system_source_type, labels, transform_key_values, description) FROM stdin;
1	cloudflare.logs.prod	059cce8e-5319-497a-a83d-6612ed24c8b4	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
2	postgres.logs	e2da31ee-05c7-4f75-b3c9-33a9f755fc44	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
3	deno-relay-logs	3968f339-d656-4a65-9f15-aefa4ed90dbe	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
4	deno-subhosting-events	10dd98e2-dbb3-47ee-ad59-5d7eb762a589	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
5	gotrue.logs.prod	eac2f713-ac8b-46b2-84b3-671d794588c2	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
6	realtime.logs.prod	65417733-c8ee-4141-8e1f-393f2691af40	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
7	storage.logs.prod.2	11ed185c-5891-4562-9b97-69876e020f21	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
8	postgREST.logs.prod	fe8c457a-2c2a-432b-ad22-de7c8d3f8fd8	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
9	pgbouncer.logs.prod	af662be7-b391-434f-aeef-5cb26ef0b1df	2026-05-29 22:10:38	2026-05-29 22:10:38	1	\N	f	\N	25	\N	\N	{"team_user_ids_for_sms": [], "team_user_ids_for_email": [], "user_text_notifications": false, "user_email_notifications": false, "other_email_notifications": null, "team_user_ids_for_schema_updates": [], "user_schema_update_notifications": true}	\N	\N	\N	14400000	timestamp	f	t	\\x836a	\N	f		\N	\N	f	f	\N	f	f	\N	\N	\N	\N
\.


--
-- Data for Name: sources_backends; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.sources_backends (id, backend_id, source_id) FROM stdin;
\.


--
-- Data for Name: system_metrics; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.system_metrics (id, all_logs_logged, node, inserted_at, updated_at) FROM stdin;
1	0	logflare@127.0.0.1	2026-05-29 22:10:43	2026-05-29 22:10:43
\.


--
-- Data for Name: team_users; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.team_users (id, email, token, provider, email_preferred, name, image, email_me_product, phone, valid_google_account, provider_uid, team_id, inserted_at, updated_at, preferences) FROM stdin;
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.teams (id, name, user_id, inserted_at, updated_at, token) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.users (id, email, provider, token, inserted_at, updated_at, api_key, old_api_key, email_preferred, name, image, email_me_product, admin, phone, bigquery_project_id, api_quota, bigquery_dataset_location, bigquery_dataset_id, valid_google_account, provider_uid, company, bigquery_udfs_hash, bigquery_processed_bytes_limit, "billing_enabled?", preferences, billing_enabled, endpoints_beta, metadata, partner_upgraded, partner_id, bigquery_enable_managed_service_accounts, system_monitoring, bigquery_reservation_search, bigquery_reservation_alerts, bigquery_additional_projects) FROM stdin;
1	default@logflare.app	default	54e09244-4412-4bbf-a0ff-833a153d553f	2026-05-29 22:10:38	2026-05-29 22:10:38	nQrxn--QB3zq	\N	default@logflare.app	default	\N	f	f	\N	\N	150	\N	\N	\N	default	\N		10000000000	f	\N	t	t	\N	f	\N	f	f	\N	\N	\N
\.


--
-- Data for Name: vercel_auths; Type: TABLE DATA; Schema: _analytics; Owner: supabase_admin
--

COPY _analytics.vercel_auths (id, access_token, installation_id, team_id, token_type, vercel_user_id, user_id, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: oban_jobs; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.oban_jobs (id, state, queue, worker, args, errors, attempt, max_attempts, inserted_at, scheduled_at, attempted_at, completed_at, attempted_by, discarded_at, priority, tags, meta, cancelled_at) FROM stdin;
1918	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:53:00.245463	2026-06-18 19:53:00.245463	2026-06-18 19:53:00.262859	2026-06-18 19:53:00.276862	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1949	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:22:00.366623	2026-06-18 20:22:00.366623	2026-06-18 20:22:00.383679	2026-06-18 20:22:00.395725	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1933	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:07:00.290596	2026-06-18 20:07:00.290596	2026-06-18 20:07:00.304906	2026-06-18 20:07:00.311856	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1939	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:13:00.32186	2026-06-18 20:13:00.32186	2026-06-18 20:13:00.336065	2026-06-18 20:13:00.345745	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1916	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:51:00.241661	2026-06-18 19:51:00.241661	2026-06-18 19:51:00.254314	2026-06-18 19:51:00.260876	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1941	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:15:00.32918	2026-06-18 20:15:00.32918	2026-06-18 20:15:00.350819	2026-06-18 20:15:00.364903	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1942	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-18 20:15:00.32918	2026-06-18 20:15:00.32918	2026-06-18 20:15:00.350531	2026-06-18 20:15:00.868677	{logflare@127.0.0.1,92d5d154-b8eb-40d3-a342-cce5ad098d8f}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1919	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:54:00.249026	2026-06-18 19:54:00.249026	2026-06-18 19:54:00.259678	2026-06-18 19:54:00.265366	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1950	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:23:00.371857	2026-06-18 20:23:00.371857	2026-06-18 20:23:00.389948	2026-06-18 20:23:00.402179	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1928	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:02:00.275746	2026-06-18 20:02:00.275746	2026-06-18 20:02:00.288959	2026-06-18 20:02:00.297503	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1917	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:52:00.24053	2026-06-18 19:52:00.24053	2026-06-18 19:52:00.258484	2026-06-18 19:52:00.271416	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1931	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:05:00.281124	2026-06-18 20:05:00.281124	2026-06-18 20:05:00.296397	2026-06-18 20:05:00.305868	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1940	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:14:00.324386	2026-06-18 20:14:00.324386	2026-06-18 20:14:00.341658	2026-06-18 20:14:00.353104	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1920	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:55:00.24803	2026-06-18 19:55:00.24803	2026-06-18 19:55:00.26323	2026-06-18 19:55:00.273037	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1951	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:24:00.378237	2026-06-18 20:24:00.378237	2026-06-18 20:24:00.392744	2026-06-18 20:24:00.402068	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1923	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:58:00.256698	2026-06-18 19:58:00.256698	2026-06-18 19:58:00.27634	2026-06-18 19:58:00.289708	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1924	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:59:00.263199	2026-06-18 19:59:00.263199	2026-06-18 19:59:00.275828	2026-06-18 19:59:00.283806	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1943	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:16:00.340512	2026-06-18 20:16:00.340512	2026-06-18 20:16:00.356365	2026-06-18 20:16:00.367656	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1921	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:56:00.249512	2026-06-18 19:56:00.249512	2026-06-18 19:56:00.266787	2026-06-18 19:56:00.279495	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1932	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:06:00.284923	2026-06-18 20:06:00.284923	2026-06-18 20:06:00.302882	2026-06-18 20:06:00.315836	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1952	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:25:00.38165	2026-06-18 20:25:00.38165	2026-06-18 20:25:00.398735	2026-06-18 20:25:00.409793	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1945	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:18:00.349449	2026-06-18 20:18:00.349449	2026-06-18 20:18:00.366665	2026-06-18 20:18:00.379476	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1922	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:57:00.253977	2026-06-18 19:57:00.253977	2026-06-18 19:57:00.27043	2026-06-18 19:57:00.283374	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1929	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:03:00.275606	2026-06-18 20:03:00.275606	2026-06-18 20:03:00.289005	2026-06-18 20:03:00.296197	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1953	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:26:00.387652	2026-06-18 20:26:00.387652	2026-06-18 20:26:00.404856	2026-06-18 20:26:00.41781	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1954	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:27:00.392887	2026-06-18 20:27:00.392887	2026-06-18 20:27:00.411094	2026-06-18 20:27:00.423276	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1727	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:35:00.994968	2026-06-17 20:35:00.994968	2026-06-17 20:35:01.005681	2026-06-17 20:35:01.014457	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1728	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:36:00.998031	2026-06-17 20:36:00.998031	2026-06-17 20:36:01.011556	2026-06-17 20:36:01.016502	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1955	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:28:00.399138	2026-06-18 20:28:00.399138	2026-06-18 20:28:00.418309	2026-06-18 20:28:00.430315	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1729	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:37:00.003753	2026-06-17 20:37:00.003753	2026-06-17 20:37:00.015562	2026-06-17 20:37:00.022253	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1730	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:38:00.007873	2026-06-17 20:38:00.007873	2026-06-17 20:38:00.02039	2026-06-17 20:38:00.02739	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1925	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:00:00.263981	2026-06-18 20:00:00.263981	2026-06-18 20:00:00.284369	2026-06-18 20:00:00.294323	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1731	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:39:00.01339	2026-06-17 20:39:00.01339	2026-06-17 20:39:00.026669	2026-06-17 20:39:00.032287	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1926	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-18 20:00:00.263981	2026-06-18 20:00:00.263981	2026-06-18 20:00:00.284361	2026-06-18 20:00:00.800379	{logflare@127.0.0.1,92d5d154-b8eb-40d3-a342-cce5ad098d8f}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1957	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:30:00.413026	2026-06-18 20:30:00.413026	2026-06-18 20:30:00.436081	2026-06-18 20:30:00.448784	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1958	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-18 20:30:00.413026	2026-06-18 20:30:00.413026	2026-06-18 20:30:00.436081	2026-06-18 20:30:00.952258	{logflare@127.0.0.1,92d5d154-b8eb-40d3-a342-cce5ad098d8f}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1960	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:32:00.43097	2026-06-18 20:32:00.43097	2026-06-18 20:32:00.449088	2026-06-18 20:32:00.461989	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1930	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:04:00.27699	2026-06-18 20:04:00.27699	2026-06-18 20:04:00.292275	2026-06-18 20:04:00.302364	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1927	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:01:00.270254	2026-06-18 20:01:00.270254	2026-06-18 20:01:00.287424	2026-06-18 20:01:00.301547	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1956	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:29:00.406427	2026-06-18 20:29:00.406427	2026-06-18 20:29:00.423506	2026-06-18 20:29:00.436436	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1934	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:08:00.29338	2026-06-18 20:08:00.29338	2026-06-18 20:08:00.31027	2026-06-18 20:08:00.322692	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1962	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:34:00.442818	2026-06-18 20:34:00.442818	2026-06-18 20:34:00.460758	2026-06-18 20:34:00.474375	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1819	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:01:00.36059	2026-06-17 22:01:00.36059	2026-06-17 22:01:00.372267	2026-06-17 22:01:00.377256	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1732	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:40:00.018826	2026-06-17 20:40:00.018826	2026-06-17 20:40:00.031465	2026-06-17 20:40:00.037828	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1772	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:17:00.177893	2026-06-17 21:17:00.177893	2026-06-17 21:17:00.188506	2026-06-17 21:17:00.194552	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1733	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:41:00.023699	2026-06-17 20:41:00.023699	2026-06-17 20:41:00.03539	2026-06-17 20:41:00.040705	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1734	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:42:00.027742	2026-06-17 20:42:00.027742	2026-06-17 20:42:00.038484	2026-06-17 20:42:00.042799	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1820	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:02:00.364798	2026-06-17 22:02:00.364798	2026-06-17 22:02:00.376513	2026-06-17 22:02:00.381422	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1776	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:21:00.19124	2026-06-17 21:21:00.19124	2026-06-17 21:21:00.202832	2026-06-17 21:21:00.208859	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1783	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:28:00.217945	2026-06-17 21:28:00.217945	2026-06-17 21:28:00.229623	2026-06-17 21:28:00.234322	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1826	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:08:00.383181	2026-06-17 22:08:00.383181	2026-06-17 22:08:00.392752	2026-06-17 22:08:00.398553	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1784	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:29:00.22244	2026-06-17 21:29:00.22244	2026-06-17 21:29:00.234997	2026-06-17 21:29:00.241231	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1790	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:34:00.241553	2026-06-17 21:34:00.241553	2026-06-17 21:34:00.253363	2026-06-17 21:34:00.258943	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1828	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:10:00.388006	2026-06-17 22:10:00.388006	2026-06-17 22:10:00.398611	2026-06-17 22:10:00.404088	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1799	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:43:00.281656	2026-06-17 21:43:00.281656	2026-06-17 21:43:00.292522	2026-06-17 21:43:00.298205	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1801	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:45:00.291147	2026-06-17 21:45:00.291147	2026-06-17 21:45:00.304815	2026-06-17 21:45:00.313171	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1807	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:50:00.311807	2026-06-17 21:50:00.311807	2026-06-17 21:50:00.324683	2026-06-17 21:50:00.330655	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1831	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:13:00.399412	2026-06-17 22:13:00.399412	2026-06-17 22:13:00.411098	2026-06-17 22:13:00.416908	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1810	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:53:00.323118	2026-06-17 21:53:00.323118	2026-06-17 21:53:00.337868	2026-06-17 21:53:00.343297	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1837	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:18:00.423312	2026-06-17 22:18:00.423312	2026-06-17 22:18:00.436054	2026-06-17 22:18:00.441573	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1840	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:21:00.437163	2026-06-17 22:21:00.437163	2026-06-17 22:21:00.448089	2026-06-17 22:21:00.453594	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1815	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:58:00.345626	2026-06-17 21:58:00.345626	2026-06-17 21:58:00.358241	2026-06-17 21:58:00.364158	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1842	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:23:00.444489	2026-06-17 22:23:00.444489	2026-06-17 22:23:00.455246	2026-06-17 22:23:00.460674	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1850	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 22:30:00.473412	2026-06-17 22:30:00.473412	2026-06-17 22:30:00.486269	2026-06-17 22:30:00.993226	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1735	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:43:00.030694	2026-06-17 20:43:00.030694	2026-06-17 20:43:00.04253	2026-06-17 20:43:00.048072	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1736	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:44:00.034156	2026-06-17 20:44:00.034156	2026-06-17 20:44:00.049447	2026-06-17 20:44:00.065209	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1773	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:18:00.181202	2026-06-17 21:18:00.181202	2026-06-17 21:18:00.191984	2026-06-17 21:18:00.198008	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1821	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:03:00.368275	2026-06-17 22:03:00.368275	2026-06-17 22:03:00.378955	2026-06-17 22:03:00.383971	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1737	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:45:00.042592	2026-06-17 20:45:00.042592	2026-06-17 20:45:00.056362	2026-06-17 20:45:00.0634	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1738	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 20:45:00.042592	2026-06-17 20:45:00.042592	2026-06-17 20:45:00.056423	2026-06-17 20:45:00.563393	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1786	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 21:30:00.227758	2026-06-17 21:30:00.227758	2026-06-17 21:30:00.240462	2026-06-17 21:30:00.746549	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1796	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:40:00.269764	2026-06-17 21:40:00.269764	2026-06-17 21:40:00.28158	2026-06-17 21:40:00.287094	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1739	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:46:00.048508	2026-06-17 20:46:00.048508	2026-06-17 20:46:00.06009	2026-06-17 20:46:00.067007	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1746	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:53:00.076794	2026-06-17 20:53:00.076794	2026-06-17 20:53:00.089479	2026-06-17 20:53:00.095918	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1808	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:51:00.317212	2026-06-17 21:51:00.317212	2026-06-17 21:51:00.328958	2026-06-17 21:51:00.335206	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1752	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:59:00.105398	2026-06-17 20:59:00.105398	2026-06-17 20:59:00.118758	2026-06-17 20:59:00.125097	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1811	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:54:00.330079	2026-06-17 21:54:00.330079	2026-06-17 21:54:00.341684	2026-06-17 21:54:00.346886	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1822	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:04:00.371765	2026-06-17 22:04:00.371765	2026-06-17 22:04:00.384356	2026-06-17 22:04:00.38968	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1827	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:09:00.385009	2026-06-17 22:09:00.385009	2026-06-17 22:09:00.395707	2026-06-17 22:09:00.402862	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1838	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:19:00.428241	2026-06-17 22:19:00.428241	2026-06-17 22:19:00.441066	2026-06-17 22:19:00.452345	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1839	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:20:00.433036	2026-06-17 22:20:00.433036	2026-06-17 22:20:00.444804	2026-06-17 22:20:00.450551	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1845	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:26:00.454321	2026-06-17 22:26:00.454321	2026-06-17 22:26:00.466981	2026-06-17 22:26:00.472605	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1847	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:28:00.464682	2026-06-17 22:28:00.464682	2026-06-17 22:28:00.477201	2026-06-17 22:28:00.483954	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1851	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:31:00.478951	2026-06-17 22:31:00.478951	2026-06-17 22:31:00.489731	2026-06-17 22:31:00.494278	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1852	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:32:00.482391	2026-06-17 22:32:00.482391	2026-06-17 22:32:00.493847	2026-06-17 22:32:00.499859	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1853	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:33:00.486562	2026-06-17 22:33:00.486562	2026-06-17 22:33:00.499214	2026-06-17 22:33:00.50527	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1740	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:47:00.052582	2026-06-17 20:47:00.052582	2026-06-17 20:47:00.064277	2026-06-17 20:47:00.070063	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1741	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:48:00.056692	2026-06-17 20:48:00.056692	2026-06-17 20:48:00.069281	2026-06-17 20:48:00.074784	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1742	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:49:00.060745	2026-06-17 20:49:00.060745	2026-06-17 20:49:00.072516	2026-06-17 20:49:00.078012	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1774	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:19:00.1836	2026-06-17 21:19:00.1836	2026-06-17 21:19:00.195992	2026-06-17 21:19:00.201747	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1823	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:05:00.376899	2026-06-17 22:05:00.376899	2026-06-17 22:05:00.386615	2026-06-17 22:05:00.392049	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1745	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:52:00.072854	2026-06-17 20:52:00.072854	2026-06-17 20:52:00.0844	2026-06-17 20:52:00.090247	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1750	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:57:00.094883	2026-06-17 20:57:00.094883	2026-06-17 20:57:00.106643	2026-06-17 20:57:00.112433	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1777	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:22:00.195646	2026-06-17 21:22:00.195646	2026-06-17 21:22:00.205279	2026-06-17 21:22:00.209752	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1751	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:58:00.099402	2026-06-17 20:58:00.099402	2026-06-17 20:58:00.112862	2026-06-17 20:58:00.122396	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1785	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:30:00.227758	2026-06-17 21:30:00.227758	2026-06-17 21:30:00.240404	2026-06-17 21:30:00.246654	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1832	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:14:00.402647	2026-06-17 22:14:00.402647	2026-06-17 22:14:00.41239	2026-06-17 22:14:00.417523	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1835	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:16:00.409731	2026-06-17 22:16:00.409731	2026-06-17 22:16:00.42142	2026-06-17 22:16:00.427085	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1787	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:31:00.232791	2026-06-17 21:31:00.232791	2026-06-17 21:31:00.242391	2026-06-17 21:31:00.248727	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1753	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:00:00.111081	2026-06-17 21:00:00.111081	2026-06-17 21:00:00.124786	2026-06-17 21:00:00.130925	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1754	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 21:00:00.111081	2026-06-17 21:00:00.111081	2026-06-17 21:00:00.124844	2026-06-17 21:00:00.634788	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1757	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:03:00.125023	2026-06-17 21:03:00.125023	2026-06-17 21:03:00.134748	2026-06-17 21:03:00.139872	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1788	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:32:00.235054	2026-06-17 21:32:00.235054	2026-06-17 21:32:00.24484	2026-06-17 21:32:00.251005	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1758	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:04:00.126823	2026-06-17 21:04:00.126823	2026-06-17 21:04:00.138518	2026-06-17 21:04:00.143768	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1802	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 21:45:00.291147	2026-06-17 21:45:00.291147	2026-06-17 21:45:00.304705	2026-06-17 21:45:00.814699	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1844	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:25:00.45118	2026-06-17 22:25:00.45118	2026-06-17 22:25:00.462862	2026-06-17 22:25:00.467612	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1804	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:47:00.30195	2026-06-17 21:47:00.30195	2026-06-17 21:47:00.312581	2026-06-17 21:47:00.318988	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1809	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:52:00.321171	2026-06-17 21:52:00.321171	2026-06-17 21:52:00.330779	2026-06-17 21:52:00.33594	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1743	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:50:00.064353	2026-06-17 20:50:00.064353	2026-06-17 20:50:00.078113	2026-06-17 20:50:00.087731	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1775	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:20:00.187381	2026-06-17 21:20:00.187381	2026-06-17 21:20:00.200019	2026-06-17 21:20:00.205824	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1744	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:51:00.070698	2026-06-17 20:51:00.070698	2026-06-17 20:51:00.080447	2026-06-17 20:51:00.088795	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1747	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:54:00.081893	2026-06-17 20:54:00.081893	2026-06-17 20:54:00.093567	2026-06-17 20:54:00.099649	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1824	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:06:00.378654	2026-06-17 22:06:00.378654	2026-06-17 22:06:00.388467	2026-06-17 22:06:00.393487	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1756	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:02:00.121403	2026-06-17 21:02:00.121403	2026-06-17 21:02:00.132932	2026-06-17 21:02:00.13958	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1779	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:24:00.203183	2026-06-17 21:24:00.203183	2026-06-17 21:24:00.213689	2026-06-17 21:24:00.219174	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1829	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:11:00.39125	2026-06-17 22:11:00.39125	2026-06-17 22:11:00.401892	2026-06-17 22:11:00.408326	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1780	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:25:00.205719	2026-06-17 21:25:00.205719	2026-06-17 21:25:00.217317	2026-06-17 21:25:00.222307	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1789	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:33:00.237368	2026-06-17 21:33:00.237368	2026-06-17 21:33:00.250169	2026-06-17 21:33:00.256594	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1791	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:35:00.246278	2026-06-17 21:35:00.246278	2026-06-17 21:35:00.258538	2026-06-17 21:35:00.266508	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1794	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:38:00.261442	2026-06-17 21:38:00.261442	2026-06-17 21:38:00.272185	2026-06-17 21:38:00.277035	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1833	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:15:00.405865	2026-06-17 22:15:00.405865	2026-06-17 22:15:00.417468	2026-06-17 22:15:00.422631	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1834	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 22:15:00.405865	2026-06-17 22:15:00.405865	2026-06-17 22:15:00.417468	2026-06-17 22:15:00.926423	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1795	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:39:00.264277	2026-06-17 21:39:00.264277	2026-06-17 21:39:00.27703	2026-06-17 21:39:00.281872	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1798	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:42:00.277816	2026-06-17 21:42:00.277816	2026-06-17 21:42:00.289417	2026-06-17 21:42:00.294597	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1843	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:24:00.447999	2026-06-17 22:24:00.447999	2026-06-17 22:24:00.458596	2026-06-17 22:24:00.464113	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1812	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:55:00.334265	2026-06-17 21:55:00.334265	2026-06-17 21:55:00.343896	2026-06-17 21:55:00.348458	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1846	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:27:00.45957	2026-06-17 22:27:00.45957	2026-06-17 22:27:00.472139	2026-06-17 22:27:00.478798	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1814	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:57:00.337747	2026-06-17 21:57:00.337747	2026-06-17 21:57:00.352441	2026-06-17 21:57:00.357108	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1816	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:59:00.350878	2026-06-17 21:59:00.350878	2026-06-17 21:59:00.363383	2026-06-17 21:59:00.368271	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1817	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:00:00.355456	2026-06-17 22:00:00.355456	2026-06-17 22:00:00.368145	2026-06-17 22:00:00.372575	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1874	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:53:00.56644	2026-06-17 22:53:00.56644	2026-06-17 22:53:00.579003	2026-06-17 22:53:00.584688	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1748	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:55:00.086121	2026-06-17 20:55:00.086121	2026-06-17 20:55:00.097727	2026-06-17 20:55:00.103142	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1778	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:23:00.197423	2026-06-17 21:23:00.197423	2026-06-17 21:23:00.210047	2026-06-17 21:23:00.215891	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1749	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 20:56:00.089994	2026-06-17 20:56:00.089994	2026-06-17 20:56:00.102794	2026-06-17 20:56:00.10843	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1755	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:01:00.11719	2026-06-17 21:01:00.11719	2026-06-17 21:01:00.12881	2026-06-17 21:01:00.134143	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1782	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:27:00.214222	2026-06-17 21:27:00.214222	2026-06-17 21:27:00.225982	2026-06-17 21:27:00.231255	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1759	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:05:00.131048	2026-06-17 21:05:00.131048	2026-06-17 21:05:00.13979	2026-06-17 21:05:00.145357	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1760	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:06:00.132149	2026-06-17 21:06:00.132149	2026-06-17 21:06:00.14481	2026-06-17 21:06:00.149309	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1761	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:07:00.137148	2026-06-17 21:07:00.137148	2026-06-17 21:07:00.147913	2026-06-17 21:07:00.154461	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1762	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:08:00.140027	2026-06-17 21:08:00.140027	2026-06-17 21:08:00.151823	2026-06-17 21:08:00.156691	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1792	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:36:00.251267	2026-06-17 21:36:00.251267	2026-06-17 21:36:00.26393	2026-06-17 21:36:00.271107	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1763	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:09:00.14434	2026-06-17 21:09:00.14434	2026-06-17 21:09:00.156814	2026-06-17 21:09:00.162521	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1764	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:10:00.147681	2026-06-17 21:10:00.147681	2026-06-17 21:10:00.158349	2026-06-17 21:10:00.162568	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1765	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:11:00.151394	2026-06-17 21:11:00.151394	2026-06-17 21:11:00.163063	2026-06-17 21:11:00.168068	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1793	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:37:00.255933	2026-06-17 21:37:00.255933	2026-06-17 21:37:00.268658	2026-06-17 21:37:00.274903	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1766	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:12:00.15566	2026-06-17 21:12:00.15566	2026-06-17 21:12:00.168169	2026-06-17 21:12:00.174124	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1767	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:13:00.160489	2026-06-17 21:13:00.160489	2026-06-17 21:13:00.172106	2026-06-17 21:13:00.177593	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1797	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:41:00.273893	2026-06-17 21:41:00.273893	2026-06-17 21:41:00.285696	2026-06-17 21:41:00.291156	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1813	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:56:00.336385	2026-06-17 21:56:00.336385	2026-06-17 21:56:00.346065	2026-06-17 21:56:00.351381	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1769	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:15:00.168712	2026-06-17 21:15:00.168712	2026-06-17 21:15:00.182364	2026-06-17 21:15:00.189639	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1770	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 21:15:00.168712	2026-06-17 21:15:00.168712	2026-06-17 21:15:00.1824	2026-06-17 21:15:00.689253	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1771	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:16:00.173785	2026-06-17 21:16:00.173785	2026-06-17 21:16:00.185296	2026-06-17 21:16:00.191257	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1825	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:07:00.380745	2026-06-17 22:07:00.380745	2026-06-17 22:07:00.390354	2026-06-17 22:07:00.394891	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1768	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:14:00.164405	2026-06-17 21:14:00.164405	2026-06-17 21:14:00.176032	2026-06-17 21:14:00.181962	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1959	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:31:00.425131	2026-06-18 20:31:00.425131	2026-06-18 20:31:00.442555	2026-06-18 20:31:00.453451	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1781	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:26:00.210037	2026-06-17 21:26:00.210037	2026-06-17 21:26:00.221868	2026-06-17 21:26:00.227986	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1830	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:12:00.394441	2026-06-17 22:12:00.394441	2026-06-17 22:12:00.407029	2026-06-17 22:12:00.413752	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1800	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:44:00.285157	2026-06-17 21:44:00.285157	2026-06-17 21:44:00.298794	2026-06-17 21:44:00.305771	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1803	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:46:00.297159	2026-06-17 21:46:00.297159	2026-06-17 21:46:00.309472	2026-06-17 21:46:00.316368	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1805	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:48:00.304979	2026-06-17 21:48:00.304979	2026-06-17 21:48:00.316944	2026-06-17 21:48:00.322343	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1836	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:17:00.4141	2026-06-17 22:17:00.4141	2026-06-17 22:17:00.430581	2026-06-17 22:17:00.435834	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1806	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 21:49:00.309143	2026-06-17 21:49:00.309143	2026-06-17 21:49:00.319886	2026-06-17 21:49:00.324586	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1841	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:22:00.440785	2026-06-17 22:22:00.440785	2026-06-17 22:22:00.452311	2026-06-17 22:22:00.457562	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1818	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 22:00:00.355456	2026-06-17 22:00:00.355456	2026-06-17 22:00:00.368145	2026-06-17 22:00:00.875247	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1848	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:29:00.469667	2026-06-17 22:29:00.469667	2026-06-17 22:29:00.48148	2026-06-17 22:29:00.486251	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1849	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:30:00.473412	2026-06-17 22:30:00.473412	2026-06-17 22:30:00.486216	2026-06-17 22:30:00.491337	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1854	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:34:00.490491	2026-06-17 22:34:00.490491	2026-06-17 22:34:00.500255	2026-06-17 22:34:00.505684	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1855	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:35:00.492748	2026-06-17 22:35:00.492748	2026-06-17 22:35:00.503544	2026-06-17 22:35:00.508101	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1856	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:36:00.496085	2026-06-17 22:36:00.496085	2026-06-17 22:36:00.510732	2026-06-17 22:36:00.516181	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1857	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:37:00.503278	2026-06-17 22:37:00.503278	2026-06-17 22:37:00.514838	2026-06-17 22:37:00.52001	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1858	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:38:00.507104	2026-06-17 22:38:00.507104	2026-06-17 22:38:00.518623	2026-06-17 22:38:00.52408	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1859	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:39:00.511562	2026-06-17 22:39:00.511562	2026-06-17 22:39:00.523162	2026-06-17 22:39:00.529456	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1860	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:40:00.515521	2026-06-17 22:40:00.515521	2026-06-17 22:40:00.528061	2026-06-17 22:40:00.534227	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1861	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:41:00.520698	2026-06-17 22:41:00.520698	2026-06-17 22:41:00.532411	2026-06-17 22:41:00.537295	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1862	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:42:00.524977	2026-06-17 22:42:00.524977	2026-06-17 22:42:00.536601	2026-06-17 22:42:00.542024	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1875	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:54:00.572075	2026-06-17 22:54:00.572075	2026-06-17 22:54:00.582791	2026-06-17 22:54:00.588994	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1866	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 22:45:00.537002	2026-06-17 22:45:00.537002	2026-06-17 22:45:00.547778	2026-06-17 22:45:01.055778	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1873	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:52:00.564336	2026-06-17 22:52:00.564336	2026-06-17 22:52:00.574135	2026-06-17 22:52:00.57738	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1877	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:56:00.578459	2026-06-17 22:56:00.578459	2026-06-17 22:56:00.589157	2026-06-17 22:56:00.594175	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1883	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 23:01:00.602102	2026-06-17 23:01:00.602102	2026-06-17 23:01:00.614635	2026-06-17 23:01:00.621666	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1935	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:09:00.298864	2026-06-18 20:09:00.298864	2026-06-18 20:09:00.317963	2026-06-18 20:09:00.331511	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1961	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:33:00.438967	2026-06-18 20:33:00.438967	2026-06-18 20:33:00.453284	2026-06-18 20:33:00.462304	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1884	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 23:02:00.60756	2026-06-17 23:02:00.60756	2026-06-17 23:02:00.619057	2026-06-17 23:02:00.625995	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1938	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:12:00.317189	2026-06-18 20:12:00.317189	2026-06-18 20:12:00.334168	2026-06-18 20:12:00.346822	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1948	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:21:00.363312	2026-06-18 20:21:00.363312	2026-06-18 20:21:00.378249	2026-06-18 20:21:00.391784	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1863	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:43:00.529011	2026-06-17 22:43:00.529011	2026-06-17 22:43:00.540834	2026-06-17 22:43:00.546695	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1864	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:44:00.533253	2026-06-17 22:44:00.533253	2026-06-17 22:44:00.544878	2026-06-17 22:44:00.551256	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1865	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:45:00.537002	2026-06-17 22:45:00.537002	2026-06-17 22:45:00.547701	2026-06-17 22:45:00.553187	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1867	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:46:00.540145	2026-06-17 22:46:00.540145	2026-06-17 22:46:00.551773	2026-06-17 22:46:00.558088	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1876	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:55:00.575128	2026-06-17 22:55:00.575128	2026-06-17 22:55:00.585771	2026-06-17 22:55:00.5918	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1879	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:58:00.585579	2026-06-17 22:58:00.585579	2026-06-17 22:58:00.600337	2026-06-17 22:58:00.604898	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1871	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:50:00.558275	2026-06-17 22:50:00.558275	2026-06-17 22:50:00.568749	2026-06-17 22:50:00.575137	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1872	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:51:00.561042	2026-06-17 22:51:00.561042	2026-06-17 22:51:00.571738	2026-06-17 22:51:00.577295	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1880	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:59:00.592317	2026-06-17 22:59:00.592317	2026-06-17 22:59:00.605188	2026-06-17 22:59:00.611783	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1881	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 23:00:00.597576	2026-06-17 23:00:00.597576	2026-06-17 23:00:00.610254	2026-06-17 23:00:00.618088	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1936	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:10:00.306344	2026-06-18 20:10:00.306344	2026-06-18 20:10:00.321833	2026-06-18 20:10:00.332201	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1914	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:49:59.976295	2026-06-18 19:49:59.976295	2026-06-18 19:49:59.993667	2026-06-18 19:50:00.011238	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{}	\N
1946	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:19:00.356191	2026-06-18 20:19:00.356191	2026-06-18 20:19:00.371492	2026-06-18 20:19:00.381653	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1947	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:20:00.35933	2026-06-18 20:20:00.35933	2026-06-18 20:20:00.374625	2026-06-18 20:20:00.383722	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1868	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:47:00.544483	2026-06-17 22:47:00.544483	2026-06-17 22:47:00.556107	2026-06-17 22:47:00.566771	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1869	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:48:00.548449	2026-06-17 22:48:00.548449	2026-06-17 22:48:00.561032	2026-06-17 22:48:00.566858	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1870	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:49:00.553217	2026-06-17 22:49:00.553217	2026-06-17 22:49:00.565995	2026-06-17 22:49:00.572986	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1878	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-17 22:57:00.580979	2026-06-17 22:57:00.580979	2026-06-17 22:57:00.592788	2026-06-17 22:57:00.597795	{logflare@127.0.0.1,d389c202-0a4c-4d3d-8c1f-befe43470ab9}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1882	completed	default	Logflare.Sources.RecentEventsTouchWorker	{}	{}	1	1	2026-06-17 23:00:00.597576	2026-06-17 23:00:00.597576	2026-06-17 23:00:00.610294	2026-06-17 23:00:01.117323	{logflare@127.0.0.1,90f14ec1-8261-40be-b353-f7536d33deef}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "*/15 * * * *", "cron_name": "130119752"}	\N
1937	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:11:00.30979	2026-06-18 20:11:00.30979	2026-06-18 20:11:00.32792	2026-06-18 20:11:00.342426	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1915	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 19:50:00.242559	2026-06-18 19:50:00.242559	2026-06-18 19:50:00.253702	2026-06-18 19:50:00.261148	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
1944	completed	alerts	Logflare.Alerting.AlertSchedulerWorker	{}	{}	1	3	2026-06-18 20:17:00.344175	2026-06-18 20:17:00.344175	2026-06-18 20:17:00.36309	2026-06-18 20:17:00.3777	{logflare@127.0.0.1,ae6ee338-d2db-4401-bf54-b77cdf18c451}	\N	0	{}	{"cron": true, "cron_tz": "Etc/UTC", "cron_expr": "* * * * *", "cron_name": "96607550"}	\N
\.


--
-- Data for Name: oban_peers; Type: TABLE DATA; Schema: public; Owner: supabase_admin
--

COPY public.oban_peers (name, node, started_at, expires_at) FROM stdin;
Oban	logflare@127.0.0.1	2026-06-18 19:49:59.304659	2026-06-18 20:35:16.873167
\.


--
-- Name: alert_queries_backends_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.alert_queries_backends_id_seq', 1, false);


--
-- Name: alert_queries_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.alert_queries_id_seq', 1, false);


--
-- Name: backends_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.backends_id_seq', 1, false);


--
-- Name: billing_accounts_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.billing_accounts_id_seq', 1, false);


--
-- Name: billing_counts_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.billing_counts_id_seq', 1, false);


--
-- Name: endpoint_queries_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.endpoint_queries_id_seq', 2, true);


--
-- Name: key_values_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.key_values_id_seq', 1, false);


--
-- Name: oauth_access_grants_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.oauth_access_grants_id_seq', 1, false);


--
-- Name: oauth_access_tokens_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.oauth_access_tokens_id_seq', 1, true);


--
-- Name: oauth_applications_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.oauth_applications_id_seq', 1, false);


--
-- Name: partner_users_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.partner_users_id_seq', 1, false);


--
-- Name: partners_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.partners_id_seq', 1, false);


--
-- Name: payment_methods_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.payment_methods_id_seq', 1, false);


--
-- Name: plans_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.plans_id_seq', 1, true);


--
-- Name: rules_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.rules_id_seq', 1, false);


--
-- Name: saved_search_counters_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.saved_search_counters_id_seq', 1, false);


--
-- Name: saved_searches_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.saved_searches_id_seq', 1, false);


--
-- Name: source_backends_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.source_backends_id_seq', 1, false);


--
-- Name: source_schemas_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.source_schemas_id_seq', 1, false);


--
-- Name: sources_backends_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.sources_backends_id_seq', 1, false);


--
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.sources_id_seq', 9, true);


--
-- Name: system_metrics_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.system_metrics_id_seq', 1, true);


--
-- Name: team_users_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.team_users_id_seq', 1, false);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.teams_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.users_id_seq', 176, true);


--
-- Name: vercel_auths_id_seq; Type: SEQUENCE SET; Schema: _analytics; Owner: supabase_admin
--

SELECT pg_catalog.setval('_analytics.vercel_auths_id_seq', 1, false);


--
-- Name: oban_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: supabase_admin
--

SELECT pg_catalog.setval('public.oban_jobs_id_seq', 1962, true);


--
-- Name: alert_queries_backends alert_queries_backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries_backends
    ADD CONSTRAINT alert_queries_backends_pkey PRIMARY KEY (id);


--
-- Name: alert_queries alert_queries_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries
    ADD CONSTRAINT alert_queries_pkey PRIMARY KEY (id);


--
-- Name: backends backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.backends
    ADD CONSTRAINT backends_pkey PRIMARY KEY (id);


--
-- Name: billing_accounts billing_accounts_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_accounts
    ADD CONSTRAINT billing_accounts_pkey PRIMARY KEY (id);


--
-- Name: billing_counts billing_counts_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_counts
    ADD CONSTRAINT billing_counts_pkey PRIMARY KEY (id);


--
-- Name: endpoint_queries endpoint_queries_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_pkey PRIMARY KEY (id);


--
-- Name: key_values key_values_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.key_values
    ADD CONSTRAINT key_values_pkey PRIMARY KEY (id);


--
-- Name: log_events_059cce8e_5319_497a_a83d_6612ed24c8b4 log_events_059cce8e_5319_497a_a83d_6612ed24c8b4_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_059cce8e_5319_497a_a83d_6612ed24c8b4
    ADD CONSTRAINT log_events_059cce8e_5319_497a_a83d_6612ed24c8b4_pkey PRIMARY KEY (id);


--
-- Name: log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589 log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589
    ADD CONSTRAINT log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589_pkey PRIMARY KEY (id);


--
-- Name: log_events_11ed185c_5891_4562_9b97_69876e020f21 log_events_11ed185c_5891_4562_9b97_69876e020f21_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_11ed185c_5891_4562_9b97_69876e020f21
    ADD CONSTRAINT log_events_11ed185c_5891_4562_9b97_69876e020f21_pkey PRIMARY KEY (id);


--
-- Name: log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe
    ADD CONSTRAINT log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe_pkey PRIMARY KEY (id);


--
-- Name: log_events_65417733_c8ee_4141_8e1f_393f2691af40 log_events_65417733_c8ee_4141_8e1f_393f2691af40_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_65417733_c8ee_4141_8e1f_393f2691af40
    ADD CONSTRAINT log_events_65417733_c8ee_4141_8e1f_393f2691af40_pkey PRIMARY KEY (id);


--
-- Name: log_events_af662be7_b391_434f_aeef_5cb26ef0b1df log_events_af662be7_b391_434f_aeef_5cb26ef0b1df_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_af662be7_b391_434f_aeef_5cb26ef0b1df
    ADD CONSTRAINT log_events_af662be7_b391_434f_aeef_5cb26ef0b1df_pkey PRIMARY KEY (id);


--
-- Name: log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44 log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44
    ADD CONSTRAINT log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44_pkey PRIMARY KEY (id);


--
-- Name: log_events_eac2f713_ac8b_46b2_84b3_671d794588c2 log_events_eac2f713_ac8b_46b2_84b3_671d794588c2_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_eac2f713_ac8b_46b2_84b3_671d794588c2
    ADD CONSTRAINT log_events_eac2f713_ac8b_46b2_84b3_671d794588c2_pkey PRIMARY KEY (id);


--
-- Name: log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8 log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: postgres
--

ALTER TABLE ONLY _analytics.log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8
    ADD CONSTRAINT log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_grants oauth_access_grants_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_applications oauth_applications_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (id);


--
-- Name: partner_users partner_users_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users
    ADD CONSTRAINT partner_users_pkey PRIMARY KEY (id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.plans
    ADD CONSTRAINT plans_pkey PRIMARY KEY (id);


--
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);


--
-- Name: saved_search_counters saved_search_counters_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_search_counters
    ADD CONSTRAINT saved_search_counters_pkey PRIMARY KEY (id);


--
-- Name: saved_searches saved_searches_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_searches
    ADD CONSTRAINT saved_searches_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: source_backends source_backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_backends
    ADD CONSTRAINT source_backends_pkey PRIMARY KEY (id);


--
-- Name: source_schemas source_schemas_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_schemas
    ADD CONSTRAINT source_schemas_pkey PRIMARY KEY (id);


--
-- Name: sources_backends sources_backends_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends
    ADD CONSTRAINT sources_backends_pkey PRIMARY KEY (id);


--
-- Name: sources sources_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources
    ADD CONSTRAINT sources_pkey PRIMARY KEY (id);


--
-- Name: system_metrics system_metrics_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.system_metrics
    ADD CONSTRAINT system_metrics_pkey PRIMARY KEY (id);


--
-- Name: team_users team_users_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.team_users
    ADD CONSTRAINT team_users_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vercel_auths vercel_auths_pkey; Type: CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.vercel_auths
    ADD CONSTRAINT vercel_auths_pkey PRIMARY KEY (id);


--
-- Name: oban_jobs non_negative_priority; Type: CHECK CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE public.oban_jobs
    ADD CONSTRAINT non_negative_priority CHECK ((priority >= 0)) NOT VALID;


--
-- Name: oban_jobs oban_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.oban_jobs
    ADD CONSTRAINT oban_jobs_pkey PRIMARY KEY (id);


--
-- Name: oban_peers oban_peers_pkey; Type: CONSTRAINT; Schema: public; Owner: supabase_admin
--

ALTER TABLE ONLY public.oban_peers
    ADD CONSTRAINT oban_peers_pkey PRIMARY KEY (name);


--
-- Name: alert_queries_backends_alert_query_id_backend_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX alert_queries_backends_alert_query_id_backend_id_index ON _analytics.alert_queries_backends USING btree (alert_query_id, backend_id);


--
-- Name: alert_queries_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX alert_queries_token_index ON _analytics.alert_queries USING btree (token);


--
-- Name: alert_queries_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX alert_queries_user_id_index ON _analytics.alert_queries USING btree (user_id);


--
-- Name: billing_accounts_stripe_customer_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX billing_accounts_stripe_customer_index ON _analytics.billing_accounts USING btree (stripe_customer);


--
-- Name: billing_accounts_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX billing_accounts_user_id_index ON _analytics.billing_accounts USING btree (user_id);


--
-- Name: billing_counts_inserted_at_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX billing_counts_inserted_at_index ON _analytics.billing_counts USING btree (inserted_at);


--
-- Name: billing_counts_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX billing_counts_source_id_index ON _analytics.billing_counts USING btree (source_id);


--
-- Name: billing_counts_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX billing_counts_user_id_index ON _analytics.billing_counts USING btree (user_id);


--
-- Name: endpoint_queries_backend_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX endpoint_queries_backend_id_index ON _analytics.endpoint_queries USING btree (backend_id);


--
-- Name: endpoint_queries_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX endpoint_queries_token_index ON _analytics.endpoint_queries USING btree (token);


--
-- Name: endpoint_queries_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX endpoint_queries_user_id_index ON _analytics.endpoint_queries USING btree (user_id);


--
-- Name: idx_backends_default_ingest; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX idx_backends_default_ingest ON _analytics.backends USING btree (default_ingest) WHERE (default_ingest = true);


--
-- Name: key_values_user_id_key_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX key_values_user_id_key_index ON _analytics.key_values USING btree (user_id, key);


--
-- Name: log_events_059cce8e_5319_497a_a83d_6612ed24c8b4_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_059cce8e_5319_497a_a83d_6612ed24c8b4_timestamp_brin_ ON _analytics.log_events_059cce8e_5319_497a_a83d_6612ed24c8b4 USING brin ("timestamp");


--
-- Name: log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589_timestamp_brin_ ON _analytics.log_events_10dd98e2_dbb3_47ee_ad59_5d7eb762a589 USING brin ("timestamp");


--
-- Name: log_events_11ed185c_5891_4562_9b97_69876e020f21_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_11ed185c_5891_4562_9b97_69876e020f21_timestamp_brin_ ON _analytics.log_events_11ed185c_5891_4562_9b97_69876e020f21 USING brin ("timestamp");


--
-- Name: log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe_timestamp_brin_ ON _analytics.log_events_3968f339_d656_4a65_9f15_aefa4ed90dbe USING brin ("timestamp");


--
-- Name: log_events_65417733_c8ee_4141_8e1f_393f2691af40_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_65417733_c8ee_4141_8e1f_393f2691af40_timestamp_brin_ ON _analytics.log_events_65417733_c8ee_4141_8e1f_393f2691af40 USING brin ("timestamp");


--
-- Name: log_events_af662be7_b391_434f_aeef_5cb26ef0b1df_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_af662be7_b391_434f_aeef_5cb26ef0b1df_timestamp_brin_ ON _analytics.log_events_af662be7_b391_434f_aeef_5cb26ef0b1df USING brin ("timestamp");


--
-- Name: log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44_timestamp_brin_ ON _analytics.log_events_e2da31ee_05c7_4f75_b3c9_33a9f755fc44 USING brin ("timestamp");


--
-- Name: log_events_eac2f713_ac8b_46b2_84b3_671d794588c2_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_eac2f713_ac8b_46b2_84b3_671d794588c2_timestamp_brin_ ON _analytics.log_events_eac2f713_ac8b_46b2_84b3_671d794588c2 USING brin ("timestamp");


--
-- Name: log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8_timestamp_brin_; Type: INDEX; Schema: _analytics; Owner: postgres
--

CREATE INDEX log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8_timestamp_brin_ ON _analytics.log_events_fe8c457a_2c2a_432b_ad22_de7c8d3f8fd8 USING brin ("timestamp");


--
-- Name: oauth_access_grants_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_access_grants_token_index ON _analytics.oauth_access_grants USING btree (token);


--
-- Name: oauth_access_tokens_refresh_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_access_tokens_refresh_token_index ON _analytics.oauth_access_tokens USING btree (refresh_token);


--
-- Name: oauth_access_tokens_resource_owner_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX oauth_access_tokens_resource_owner_id_index ON _analytics.oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: oauth_access_tokens_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_access_tokens_token_index ON _analytics.oauth_access_tokens USING btree (token);


--
-- Name: oauth_applications_owner_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX oauth_applications_owner_id_index ON _analytics.oauth_applications USING btree (owner_id);


--
-- Name: oauth_applications_uid_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX oauth_applications_uid_index ON _analytics.oauth_applications USING btree (uid);


--
-- Name: partner_users_partner_id_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX partner_users_partner_id_user_id_index ON _analytics.partner_users USING btree (partner_id, user_id);


--
-- Name: partner_users_partner_id_user_id_upgraded_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX partner_users_partner_id_user_id_upgraded_index ON _analytics.partner_users USING btree (partner_id, user_id, upgraded);


--
-- Name: payment_methods_customer_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX payment_methods_customer_id_index ON _analytics.payment_methods USING btree (customer_id);


--
-- Name: payment_methods_stripe_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX payment_methods_stripe_id_index ON _analytics.payment_methods USING btree (stripe_id);


--
-- Name: rules_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX rules_source_id_index ON _analytics.rules USING btree (source_id);


--
-- Name: rules_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX rules_token_index ON _analytics.rules USING btree (token);


--
-- Name: saved_search_counters_timestamp_saved_search_id_granularity_ind; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX saved_search_counters_timestamp_saved_search_id_granularity_ind ON _analytics.saved_search_counters USING btree ("timestamp", saved_search_id, granularity);


--
-- Name: saved_searches_querystring_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX saved_searches_querystring_source_id_index ON _analytics.saved_searches USING btree (querystring, source_id);


--
-- Name: saved_searches_source_id_inserted_at_idx; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX saved_searches_source_id_inserted_at_idx ON _analytics.saved_searches USING btree (source_id, inserted_at) WHERE (saved_by_user = true);


--
-- Name: source_schemas_source_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX source_schemas_source_id_index ON _analytics.source_schemas USING btree (source_id);


--
-- Name: sources_name_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_name_index ON _analytics.sources USING btree (id, name);


--
-- Name: sources_public_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_public_token_index ON _analytics.sources USING btree (public_token);


--
-- Name: sources_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_token_index ON _analytics.sources USING btree (token);


--
-- Name: sources_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX sources_user_id_index ON _analytics.sources USING btree (user_id);


--
-- Name: sources_user_id_system_source_type_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX sources_user_id_system_source_type_index ON _analytics.sources USING btree (user_id, system_source_type);


--
-- Name: system_metrics_node_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX system_metrics_node_index ON _analytics.system_metrics USING btree (node);


--
-- Name: team_users_provider_uid_team_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX team_users_provider_uid_team_id_index ON _analytics.team_users USING btree (provider_uid, team_id);


--
-- Name: team_users_team_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX team_users_team_id_index ON _analytics.team_users USING btree (team_id);


--
-- Name: teams_token_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX teams_token_index ON _analytics.teams USING btree (token);


--
-- Name: teams_user_id_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX teams_user_id_index ON _analytics.teams USING btree (user_id);


--
-- Name: users_api_key_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE INDEX users_api_key_index ON _analytics.users USING btree (api_key);


--
-- Name: users_lower_email_index; Type: INDEX; Schema: _analytics; Owner: supabase_admin
--

CREATE UNIQUE INDEX users_lower_email_index ON _analytics.users USING btree (lower((email)::text));


--
-- Name: oban_jobs_args_index; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX oban_jobs_args_index ON public.oban_jobs USING gin (args);


--
-- Name: oban_jobs_meta_index; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX oban_jobs_meta_index ON public.oban_jobs USING gin (meta);


--
-- Name: oban_jobs_state_queue_priority_scheduled_at_id_index; Type: INDEX; Schema: public; Owner: supabase_admin
--

CREATE INDEX oban_jobs_state_queue_priority_scheduled_at_id_index ON public.oban_jobs USING btree (state, queue, priority, scheduled_at, id);


--
-- Name: alert_queries_backends alert_queries_backends_alert_query_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries_backends
    ADD CONSTRAINT alert_queries_backends_alert_query_id_fkey FOREIGN KEY (alert_query_id) REFERENCES _analytics.alert_queries(id) ON DELETE CASCADE;


--
-- Name: alert_queries_backends alert_queries_backends_backend_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries_backends
    ADD CONSTRAINT alert_queries_backends_backend_id_fkey FOREIGN KEY (backend_id) REFERENCES _analytics.backends(id) ON DELETE CASCADE;


--
-- Name: alert_queries alert_queries_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.alert_queries
    ADD CONSTRAINT alert_queries_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: backends backends_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.backends
    ADD CONSTRAINT backends_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id);


--
-- Name: billing_accounts billing_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_accounts
    ADD CONSTRAINT billing_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: billing_counts billing_counts_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.billing_counts
    ADD CONSTRAINT billing_counts_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: endpoint_queries endpoint_queries_backend_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_backend_id_fkey FOREIGN KEY (backend_id) REFERENCES _analytics.backends(id) ON DELETE SET NULL;


--
-- Name: endpoint_queries endpoint_queries_sandbox_query_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_sandbox_query_id_fkey FOREIGN KEY (sandbox_query_id) REFERENCES _analytics.endpoint_queries(id);


--
-- Name: endpoint_queries endpoint_queries_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.endpoint_queries
    ADD CONSTRAINT endpoint_queries_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: key_values key_values_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.key_values
    ADD CONSTRAINT key_values_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: oauth_access_grants oauth_access_grants_application_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_application_id_fkey FOREIGN KEY (application_id) REFERENCES _analytics.oauth_applications(id);


--
-- Name: oauth_access_tokens oauth_access_tokens_application_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_application_id_fkey FOREIGN KEY (application_id) REFERENCES _analytics.oauth_applications(id);


--
-- Name: partner_users partner_users_partner_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users
    ADD CONSTRAINT partner_users_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES _analytics.partners(id);


--
-- Name: partner_users partner_users_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.partner_users
    ADD CONSTRAINT partner_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: payment_methods payment_methods_customer_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.payment_methods
    ADD CONSTRAINT payment_methods_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES _analytics.billing_accounts(stripe_customer) ON DELETE CASCADE;


--
-- Name: rules rules_backend_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_backend_id_fkey FOREIGN KEY (backend_id) REFERENCES _analytics.backends(id) ON DELETE CASCADE;


--
-- Name: rules rules_sink_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_sink_fkey FOREIGN KEY (sink) REFERENCES _analytics.sources(token) ON DELETE CASCADE;


--
-- Name: rules rules_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.rules
    ADD CONSTRAINT rules_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id) ON DELETE CASCADE;


--
-- Name: saved_search_counters saved_search_counters_saved_search_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_search_counters
    ADD CONSTRAINT saved_search_counters_saved_search_id_fkey FOREIGN KEY (saved_search_id) REFERENCES _analytics.saved_searches(id) ON DELETE CASCADE;


--
-- Name: saved_searches saved_searches_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.saved_searches
    ADD CONSTRAINT saved_searches_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id) ON DELETE CASCADE;


--
-- Name: source_backends source_backends_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_backends
    ADD CONSTRAINT source_backends_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id);


--
-- Name: source_schemas source_schemas_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.source_schemas
    ADD CONSTRAINT source_schemas_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id) ON DELETE CASCADE;


--
-- Name: sources_backends sources_backends_backend_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends
    ADD CONSTRAINT sources_backends_backend_id_fkey FOREIGN KEY (backend_id) REFERENCES _analytics.backends(id);


--
-- Name: sources_backends sources_backends_source_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources_backends
    ADD CONSTRAINT sources_backends_source_id_fkey FOREIGN KEY (source_id) REFERENCES _analytics.sources(id);


--
-- Name: sources sources_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.sources
    ADD CONSTRAINT sources_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: team_users team_users_team_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.team_users
    ADD CONSTRAINT team_users_team_id_fkey FOREIGN KEY (team_id) REFERENCES _analytics.teams(id) ON DELETE CASCADE;


--
-- Name: teams teams_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.teams
    ADD CONSTRAINT teams_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: users users_partner_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.users
    ADD CONSTRAINT users_partner_id_fkey FOREIGN KEY (partner_id) REFERENCES _analytics.partners(id);


--
-- Name: vercel_auths vercel_auths_user_id_fkey; Type: FK CONSTRAINT; Schema: _analytics; Owner: supabase_admin
--

ALTER TABLE ONLY _analytics.vercel_auths
    ADD CONSTRAINT vercel_auths_user_id_fkey FOREIGN KEY (user_id) REFERENCES _analytics.users(id) ON DELETE CASCADE;


--
-- Name: logflare_pub; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION logflare_pub WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION logflare_pub OWNER TO supabase_admin;

--
-- Name: logflare_pub backends; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.backends;


--
-- Name: logflare_pub billing_accounts; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.billing_accounts;


--
-- Name: logflare_pub key_values; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.key_values;


--
-- Name: logflare_pub oauth_access_tokens; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.oauth_access_tokens;


--
-- Name: logflare_pub plans; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.plans;


--
-- Name: logflare_pub rules; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.rules;


--
-- Name: logflare_pub saved_searches; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.saved_searches;


--
-- Name: logflare_pub source_schemas; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.source_schemas;


--
-- Name: logflare_pub sources; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.sources;


--
-- Name: logflare_pub team_users; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.team_users;


--
-- Name: logflare_pub users; Type: PUBLICATION TABLE; Schema: _analytics; Owner: supabase_admin
--

ALTER PUBLICATION logflare_pub ADD TABLE ONLY _analytics.users;


--
-- PostgreSQL database dump complete
--

\unrestrict fIfFRqNe2MZpMPH6QehufqghkX960EpbNbvAc6YeY2ig2TPVNn66ilZbe4juLqw

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

\restrict RcFdCP7mAXHkiHIqlepPUiNzgcj1TLJSZPOi9dHWbJ8VT9Hc8EHsHF0MTtiWUhT

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO postgres;

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: admin_delete_user_data(uuid, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.admin_delete_user_data(p_user_id uuid, p_actor_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  PERFORM set_config('audit.changed_by', p_actor_id::text, false);

  DELETE FROM public.user_permissions WHERE user_id = p_user_id;
  DELETE FROM public.profiles WHERE id = p_user_id;
END;
$$;


ALTER FUNCTION public.admin_delete_user_data(p_user_id uuid, p_actor_id uuid) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    username text NOT NULL,
    full_name text,
    is_active boolean DEFAULT true NOT NULL,
    locale text DEFAULT 'ar'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: admin_update_profile(uuid, uuid, text, text, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.admin_update_profile(p_user_id uuid, p_actor_id uuid, p_username text, p_full_name text, p_is_active boolean) RETURNS public.profiles
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  updated_profile public.profiles;
BEGIN
  PERFORM set_config('audit.changed_by', p_actor_id::text, false);

  UPDATE public.profiles
  SET
    username = COALESCE(p_username, username),
    full_name = COALESCE(p_full_name, full_name),
    is_active = COALESCE(p_is_active, is_active),
    updated_by = p_actor_id,
    updated_at = now()
  WHERE id = p_user_id
  RETURNING * INTO updated_profile;

  RETURN updated_profile;
END;
$$;


ALTER FUNCTION public.admin_update_profile(p_user_id uuid, p_actor_id uuid, p_username text, p_full_name text, p_is_active boolean) OWNER TO postgres;

--
-- Name: audit_log_diff(jsonb, jsonb); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit_log_diff(old_row jsonb, new_row jsonb) RETURNS jsonb
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
  result jsonb := '[]'::jsonb;
  key_name text;
BEGIN
  FOR key_name IN
    SELECT DISTINCT key
    FROM (
      SELECT key FROM jsonb_each(COALESCE(old_row, '{}'::jsonb))
      UNION
      SELECT key FROM jsonb_each(COALESCE(new_row, '{}'::jsonb))
    ) keys
    ORDER BY key
  LOOP
    IF (COALESCE(old_row, '{}'::jsonb) -> key_name) IS DISTINCT FROM (COALESCE(new_row, '{}'::jsonb) -> key_name) THEN
      result := result || jsonb_build_array(
        jsonb_build_object(
          'field', key_name,
          'old', COALESCE(old_row, '{}'::jsonb) -> key_name,
          'new', COALESCE(new_row, '{}'::jsonb) -> key_name
        )
      );
    END IF;
  END LOOP;

  RETURN result;
END;
$$;


ALTER FUNCTION public.audit_log_diff(old_row jsonb, new_row jsonb) OWNER TO postgres;

--
-- Name: audit_log_row_change(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.audit_log_row_change() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  actor_id uuid;
  old_json jsonb;
  new_json jsonb;
  claims_text text;
  action_name text := lower(TG_OP);
  record_id uuid;
BEGIN
  -- helper to extract sub from JSON GUC safely
  PERFORM 1;

  IF TG_OP = 'INSERT' THEN
    new_json := to_jsonb(NEW);
    -- try direct fields, direct claim keys, JSON claim objects, and audit.changed_by
    actor_id := COALESCE(
      NULLIF(new_json ->> 'updated_by', '')::uuid,
      NULLIF(new_json ->> 'created_by', '')::uuid,
      NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,
      NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,
      (CASE WHEN current_setting('request.jwt.claims', true) IS NOT NULL
        THEN NULLIF((current_setting('request.jwt.claims', true))::json->>'sub', '')::uuid
        ELSE NULL END),
      (CASE WHEN current_setting('jwt.claims', true) IS NOT NULL
        THEN NULLIF((current_setting('jwt.claims', true))::json->>'sub', '')::uuid
        ELSE NULL END),
      NULLIF(current_setting('audit.changed_by', true), '')::uuid
    );
    record_id := CASE WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid ELSE NULL END;

    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)
    VALUES (TG_TABLE_NAME, record_id, action_name, actor_id,
      jsonb_build_object('before', NULL, 'after', new_json, 'changes', public.audit_log_diff('{}'::jsonb, new_json)));
    RETURN NEW;

  ELSIF TG_OP = 'UPDATE' THEN
    old_json := to_jsonb(OLD);
    new_json := to_jsonb(NEW);
    actor_id := COALESCE(
      NULLIF(new_json ->> 'updated_by', '')::uuid,
      NULLIF(new_json ->> 'created_by', '')::uuid,
      NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,
      NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,
      (CASE WHEN current_setting('request.jwt.claims', true) IS NOT NULL
        THEN NULLIF((current_setting('request.jwt.claims', true))::json->>'sub', '')::uuid
        ELSE NULL END),
      (CASE WHEN current_setting('jwt.claims', true) IS NOT NULL
        THEN NULLIF((current_setting('jwt.claims', true))::json->>'sub', '')::uuid
        ELSE NULL END),
      NULLIF(current_setting('audit.changed_by', true), '')::uuid
    );
    record_id := CASE WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid ELSE NULL END;

    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)
    VALUES (TG_TABLE_NAME, record_id, action_name, actor_id,
      jsonb_build_object('before', old_json, 'after', new_json, 'changes', public.audit_log_diff(old_json, new_json)));
    RETURN NEW;

  ELSE
    old_json := to_jsonb(OLD);
    actor_id := COALESCE(
      NULLIF(old_json ->> 'updated_by', '')::uuid,
      NULLIF(old_json ->> 'created_by', '')::uuid,
      NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,
      NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,
      (CASE WHEN current_setting('request.jwt.claims', true) IS NOT NULL
        THEN NULLIF((current_setting('request.jwt.claims', true))::json->>'sub', '')::uuid
        ELSE NULL END),
      (CASE WHEN current_setting('jwt.claims', true) IS NOT NULL
        THEN NULLIF((current_setting('jwt.claims', true))::json->>'sub', '')::uuid
        ELSE NULL END),
      NULLIF(current_setting('audit.changed_by', true), '')::uuid
    );
    record_id := CASE WHEN old_json ? 'id' THEN NULLIF(old_json ->> 'id', '')::uuid ELSE NULL END;

    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)
    VALUES (TG_TABLE_NAME, record_id, action_name, actor_id,
      jsonb_build_object('before', old_json, 'after', NULL, 'changes', public.audit_log_diff(old_json, '{}'::jsonb)));
    RETURN OLD;
  END IF;
END;
$$;


ALTER FUNCTION public.audit_log_row_change() OWNER TO postgres;

--
-- Name: compute_debt_local(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.compute_debt_local() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
BEGIN
  NEW.amount_local := NEW.amount * NEW.exchange_rate;
  RETURN NEW;
END $$;


ALTER FUNCTION public.compute_debt_local() OWNER TO postgres;

--
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_username TEXT;
  v_count INT;
  v_admin_group UUID;
BEGIN
  v_username := COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1));

  INSERT INTO public.profiles (id, username, full_name)
  VALUES (NEW.id, v_username, COALESCE(NEW.raw_user_meta_data->>'full_name', v_username));

  SELECT COUNT(*) INTO v_count FROM public.profiles;
  IF v_count = 1 THEN
    SELECT id INTO v_admin_group FROM public.permission_groups WHERE name = 'admin';
    IF v_admin_group IS NOT NULL THEN
      INSERT INTO public.user_permission_groups (user_id, group_id) VALUES (NEW.id, v_admin_group);
    END IF;
  END IF;

  RETURN NEW;
END $$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- Name: has_permission(uuid, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.has_permission(_user_id uuid, _permission text) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.user_permissions
    WHERE user_id = _user_id AND permission_key = _permission
  ) OR EXISTS (
    SELECT 1 FROM public.user_permission_groups upg
    JOIN public.permission_group_items pgi ON pgi.group_id = upg.group_id
    WHERE upg.user_id = _user_id AND pgi.permission_key = _permission
  );
$$;


ALTER FUNCTION public.has_permission(_user_id uuid, _permission text) OWNER TO postgres;

--
-- Name: is_admin(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_admin(_user_id uuid) RETURNS boolean
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT public.has_permission(_user_id, 'system.admin');
$$;


ALTER FUNCTION public.is_admin(_user_id uuid) OWNER TO postgres;

--
-- Name: on_invoice_item_change(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.on_invoice_item_change() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_invoice public.purchase_invoices%ROWTYPE;
BEGIN
  SELECT * INTO v_invoice FROM public.purchase_invoices WHERE id = NEW.invoice_id;

  INSERT INTO public.stock_movements (
    item_id, movement_type, quantity, unit_price_local,
    reference_table, reference_id, movement_date, created_by
  ) VALUES (
    NEW.item_id, 'purchase', NEW.quantity, NEW.price_local,
    'purchase_invoices', NEW.invoice_id, v_invoice.invoice_date, v_invoice.created_by
  );

  UPDATE public.items
    SET last_purchase_price_local = NEW.price_local, updated_at = now()
    WHERE id = NEW.item_id;

  RETURN NEW;
END $$;


ALTER FUNCTION public.on_invoice_item_change() OWNER TO postgres;

--
-- Name: on_invoice_item_delete(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.on_invoice_item_delete() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  DELETE FROM public.stock_movements
  WHERE reference_table = 'purchase_invoices'
    AND reference_id = OLD.invoice_id
    AND item_id = OLD.item_id;
  RETURN OLD;
END $$;


ALTER FUNCTION public.on_invoice_item_delete() OWNER TO postgres;

--
-- Name: prevent_currency_code_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.prevent_currency_code_update() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  IF TG_OP = 'UPDATE' AND NEW.code IS DISTINCT FROM OLD.code THEN
    RAISE EXCEPTION 'currency code cannot be changed once created (old=% , new=%)', OLD.code, NEW.code;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.prevent_currency_code_update() OWNER TO postgres;

--
-- Name: set_audit_changed_by(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_audit_changed_by(audit_uid uuid) RETURNS void
    LANGUAGE sql SECURITY DEFINER
    AS $$
SELECT set_config('audit.changed_by', audit_uid::text, false);
$$;


ALTER FUNCTION public.set_audit_changed_by(audit_uid uuid) OWNER TO postgres;

--
-- Name: FUNCTION set_audit_changed_by(audit_uid uuid); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.set_audit_changed_by(audit_uid uuid) IS 'Helper to set session audit.changed_by GUC for RPC calls from supabase-js via service role client.';


--
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END $$;


ALTER FUNCTION public.set_updated_at() OWNER TO postgres;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_
        -- Filter by action early - only get subscriptions interested in this action
        -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
        and (subs.action_filter = '*' or subs.action_filter = action::text);

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL AND ppt.tablename NOT LIKE '% %'),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  -- Count raw slot entries before apply_rls/subscription filter
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  -- Apply RLS and filter as before
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  -- Real rows with slot count attached
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  -- Sentinel row: always returned when no real rows exist so Elixir can
  -- always read slot_changes_count. Identified by wal IS NULL.
  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


ALTER FUNCTION storage.allow_any_operation(expected_operations text[]) OWNER TO supabase_storage_admin;

--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


ALTER FUNCTION storage.allow_only_operation(expected_operation text) OWNER TO supabase_storage_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


ALTER FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.protect_delete() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

--
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _realtime.extensions OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'gen_rpc'::character varying,
    max_presence_events_per_second integer DEFAULT 1000,
    max_payload_size_in_kb integer DEFAULT 3000,
    max_client_presence_events_per_window integer,
    client_presence_window_ms integer,
    presence_enabled boolean DEFAULT false NOT NULL,
    CONSTRAINT jwt_secret_or_jwt_jwks_required CHECK (((jwt_secret IS NOT NULL) OR (jwt_jwks IS NOT NULL)))
);


ALTER TABLE _realtime.tenants OWNER TO supabase_admin;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


ALTER TABLE auth.custom_oauth_providers OWNER TO supabase_auth_admin;

--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE auth.oauth_client_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


ALTER TABLE auth.webauthn_challenges OWNER TO supabase_auth_admin;

--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


ALTER TABLE auth.webauthn_credentials OWNER TO supabase_auth_admin;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    table_name text NOT NULL,
    record_id uuid,
    action text NOT NULL,
    changed_by uuid,
    changed_at timestamp with time zone DEFAULT now() NOT NULL,
    diff jsonb
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name_ar text NOT NULL,
    name_en text,
    parent_id uuid,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currencies (
    code text NOT NULL,
    name_ar text NOT NULL,
    name_en text NOT NULL,
    symbol text NOT NULL,
    is_base boolean DEFAULT false NOT NULL
);


ALTER TABLE public.currencies OWNER TO postgres;

--
-- Name: customer_balances; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.customer_balances AS
SELECT
    NULL::uuid AS customer_id,
    NULL::text AS name,
    NULL::text AS phone,
    NULL::numeric AS total_debit,
    NULL::numeric AS total_credit,
    NULL::numeric AS balance;


ALTER VIEW public.customer_balances OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    phone text,
    notes text,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: debt_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.debt_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    transaction_type text NOT NULL,
    amount numeric(18,4) NOT NULL,
    currency_code text NOT NULL,
    exchange_rate numeric(18,6) DEFAULT 1 NOT NULL,
    amount_local numeric(18,4) NOT NULL,
    invoice_ref text,
    notes text,
    transaction_date date DEFAULT CURRENT_DATE NOT NULL,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT debt_transactions_transaction_type_check CHECK ((transaction_type = ANY (ARRAY['debit'::text, 'credit'::text])))
);


ALTER TABLE public.debt_transactions OWNER TO postgres;

--
-- Name: exchange_rates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exchange_rates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    currency_code text NOT NULL,
    rate_to_base numeric(18,6) NOT NULL,
    rate_date date DEFAULT CURRENT_DATE NOT NULL,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.exchange_rates OWNER TO postgres;

--
-- Name: item_stock; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.item_stock AS
SELECT
    NULL::uuid AS item_id,
    NULL::text AS code,
    NULL::text AS name_ar,
    NULL::text AS name_en,
    NULL::uuid AS category_id,
    NULL::uuid AS unit_id,
    NULL::numeric(18,4) AS last_purchase_price_local,
    NULL::numeric AS current_quantity,
    NULL::numeric AS stock_value;


ALTER VIEW public.item_stock OWNER TO postgres;

--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    code text,
    name_ar text NOT NULL,
    name_en text,
    category_id uuid,
    unit_id uuid,
    last_purchase_price_local numeric(18,4) DEFAULT 0,
    notes text,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.items OWNER TO postgres;

--
-- Name: permission_group_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission_group_items (
    group_id uuid NOT NULL,
    permission_key text NOT NULL
);


ALTER TABLE public.permission_group_items OWNER TO postgres;

--
-- Name: permission_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permission_groups (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.permission_groups OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    key text NOT NULL,
    label_ar text NOT NULL,
    label_en text NOT NULL,
    category text NOT NULL
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: purchase_invoice_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_invoice_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_id uuid NOT NULL,
    item_id uuid NOT NULL,
    quantity numeric(18,4) NOT NULL,
    price_foreign numeric(18,4) DEFAULT 0,
    price_local numeric(18,4) NOT NULL,
    line_total_local numeric(18,4) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.purchase_invoice_items OWNER TO postgres;

--
-- Name: purchase_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchase_invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    invoice_no text NOT NULL,
    invoice_date date DEFAULT CURRENT_DATE NOT NULL,
    supplier_id uuid,
    payment_type text DEFAULT 'cash'::text NOT NULL,
    currency_code text NOT NULL,
    exchange_rate numeric(18,6) DEFAULT 1 NOT NULL,
    total_foreign numeric(18,4) DEFAULT 0 NOT NULL,
    total_local numeric(18,4) DEFAULT 0 NOT NULL,
    notes text,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT purchase_invoices_payment_type_check CHECK ((payment_type = ANY (ARRAY['cash'::text, 'credit'::text])))
);


ALTER TABLE public.purchase_invoices OWNER TO postgres;

--
-- Name: stock_movements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_movements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    item_id uuid NOT NULL,
    movement_type text NOT NULL,
    quantity numeric(18,4) NOT NULL,
    unit_price_local numeric(18,4) DEFAULT 0 NOT NULL,
    reference_table text,
    reference_id uuid,
    movement_date date DEFAULT CURRENT_DATE NOT NULL,
    notes text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT stock_movements_movement_type_check CHECK ((movement_type = ANY (ARRAY['purchase'::text, 'adjustment'::text, 'opening'::text])))
);


ALTER TABLE public.stock_movements OWNER TO postgres;

--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    phone text,
    notes text,
    created_by uuid,
    updated_by uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    default_currency text,
    default_payment_type text DEFAULT 'cash'::text NOT NULL
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: units; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.units (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name_ar text NOT NULL,
    name_en text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.units OWNER TO postgres;

--
-- Name: user_permission_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permission_groups (
    user_id uuid NOT NULL,
    group_id uuid NOT NULL,
    created_by uuid
);


ALTER TABLE public.user_permission_groups OWNER TO postgres;

--
-- Name: user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_permissions (
    user_id uuid NOT NULL,
    permission_key text NOT NULL,
    created_by uuid
);


ALTER TABLE public.user_permissions OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: messages_2026_06_16; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_06_16 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_06_16 OWNER TO supabase_admin;

--
-- Name: messages_2026_06_17; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_06_17 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_06_17 OWNER TO supabase_admin;

--
-- Name: messages_2026_06_18; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_06_18 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_06_18 OWNER TO supabase_admin;

--
-- Name: messages_2026_06_19; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_06_19 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_06_19 OWNER TO supabase_admin;

--
-- Name: messages_2026_06_20; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_06_20 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_06_20 OWNER TO supabase_admin;

--
-- Name: messages_2026_06_21; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2026_06_21 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2026_06_21 OWNER TO supabase_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_vectors OWNER TO supabase_storage_admin;

--
-- Name: iceberg_namespaces; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_namespaces (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    catalog_id uuid NOT NULL
);


ALTER TABLE storage.iceberg_namespaces OWNER TO supabase_storage_admin;

--
-- Name: iceberg_tables; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.iceberg_tables (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    namespace_id uuid NOT NULL,
    bucket_name text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    location text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    remote_table_id text,
    shard_key text,
    shard_id text,
    catalog_id uuid NOT NULL
);


ALTER TABLE storage.iceberg_tables OWNER TO supabase_storage_admin;

--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.vector_indexes OWNER TO supabase_storage_admin;

--
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- Name: messages_2026_06_16; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_06_16 FOR VALUES FROM ('2026-06-16 00:00:00') TO ('2026-06-17 00:00:00');


--
-- Name: messages_2026_06_17; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_06_17 FOR VALUES FROM ('2026-06-17 00:00:00') TO ('2026-06-18 00:00:00');


--
-- Name: messages_2026_06_18; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_06_18 FOR VALUES FROM ('2026-06-18 00:00:00') TO ('2026-06-19 00:00:00');


--
-- Name: messages_2026_06_19; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_06_19 FOR VALUES FROM ('2026-06-19 00:00:00') TO ('2026-06-20 00:00:00');


--
-- Name: messages_2026_06_20; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_06_20 FOR VALUES FROM ('2026-06-20 00:00:00') TO ('2026-06-21 00:00:00');


--
-- Name: messages_2026_06_21; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2026_06_21 FOR VALUES FROM ('2026-06-21 00:00:00') TO ('2026-06-22 00:00:00');


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
a4a36656-c464-44d7-bec4-9bbc1dab4ef7	postgres_cdc_rls	{"region": "us-east-1", "db_host": "8YHtzmgMl2PoEEko79K27tE3iP7+77yQOfxOMdb7pjpPNrrhma6I8nd28t/mto4/", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2026-06-18 19:49:49	2026-06-18 19:49:49
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2026-05-29 22:10:05
20220329161857	2026-05-29 22:10:05
20220410212326	2026-05-29 22:10:05
20220506102948	2026-05-29 22:10:05
20220527210857	2026-05-29 22:10:05
20220815211129	2026-05-29 22:10:05
20220815215024	2026-05-29 22:10:05
20220818141501	2026-05-29 22:10:05
20221018173709	2026-05-29 22:10:05
20221102172703	2026-05-29 22:10:05
20221223010058	2026-05-29 22:10:05
20230110180046	2026-05-29 22:10:05
20230810220907	2026-05-29 22:10:05
20230810220924	2026-05-29 22:10:05
20231024094642	2026-05-29 22:10:05
20240306114423	2026-05-29 22:10:05
20240418082835	2026-05-29 22:10:05
20240625211759	2026-05-29 22:10:05
20240704172020	2026-05-29 22:10:05
20240902173232	2026-05-29 22:10:05
20241106103258	2026-05-29 22:10:05
20250424203323	2026-05-29 22:10:05
20250613072131	2026-05-29 22:10:05
20250711044927	2026-05-29 22:10:05
20250811121559	2026-05-29 22:10:05
20250926223044	2026-05-29 22:10:05
20251204170944	2026-05-29 22:10:05
20251218000543	2026-05-29 22:10:05
20260209232800	2026-05-29 22:10:05
20260304000000	2026-05-29 22:10:05
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter, max_presence_events_per_second, max_payload_size_in_kb, max_client_presence_events_per_window, client_presence_window_ms, presence_enabled) FROM stdin;
ea3d899b-cf51-4ba2-b71d-82ac614fcc5f	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2026-06-18 19:49:49	2026-06-18 19:49:49	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"x": "M5Sjqn5zwC9Kl1zVfUUGvv9boQjCGd45G8sdopBExB4", "y": "P6IXMvA2WYXSHSOMTBH2jsw_9rrzGy89FjPf6oOsIxQ", "alg": "ES256", "crv": "P-256", "ext": true, "kid": "b81269f1-21d8-4f2e-b719-c2240a840d90", "kty": "EC", "use": "sig", "key_ops": ["verify"]}, {"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	69	gen_rpc	1000	3000	\N	\N	f
\.


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	e5dc70ce-2b5c-4308-b5f3-6811077ae994	{"action":"user_signedup","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2026-05-29 22:13:49.002674+00	
00000000-0000-0000-0000-000000000000	28deab92-98c8-4399-9cae-c23f91ae5cb8	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 22:13:49.017269+00	
00000000-0000-0000-0000-000000000000	bccf0e25-3c17-478b-a867-ec58160d057c	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-29 22:21:31.869667+00	
00000000-0000-0000-0000-000000000000	1986eba7-e269-4949-be37-98443d859940	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 22:21:45.016569+00	
00000000-0000-0000-0000-000000000000	92fbb61d-8ae4-4e8d-b5c2-82a76dbdc00b	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 22:22:05.086367+00	
00000000-0000-0000-0000-000000000000	1a32946e-4989-4e8d-8ac2-f22fd39463b7	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-29 23:28:47.08169+00	
00000000-0000-0000-0000-000000000000	1a0f9f3c-7518-4199-80e4-5a801e4da4fd	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-29 23:28:47.083747+00	
00000000-0000-0000-0000-000000000000	c7337eb2-b5c4-4cd2-b229-fcdb534df77c	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-29 23:29:24.351439+00	
00000000-0000-0000-0000-000000000000	1de657e5-6bf9-41b5-b813-d00511029c88	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-29 23:29:24.352325+00	
00000000-0000-0000-0000-000000000000	15cc8500-0509-460b-a06c-6a788a62722e	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-29 23:29:35.361761+00	
00000000-0000-0000-0000-000000000000	2c056d62-eeb5-47a3-966a-1bd0e1718ea3	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 23:30:54.37744+00	
00000000-0000-0000-0000-000000000000	4427b533-73e8-42a4-9436-978a34c81fd3	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-29 23:31:09.309981+00	
00000000-0000-0000-0000-000000000000	0bab73b4-4733-4e42-a0f1-5a2b8026eb84	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 23:31:13.063683+00	
00000000-0000-0000-0000-000000000000	a3aba129-1e32-4130-a88a-c879d9ec247a	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 23:32:07.69593+00	
00000000-0000-0000-0000-000000000000	d9efd9cd-08f8-488d-b5d2-89c41f67ffd5	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-29 23:43:31.706489+00	
00000000-0000-0000-0000-000000000000	74bc685c-a409-4b33-a988-a7cc69ad5b03	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-30 00:03:19.691151+00	
00000000-0000-0000-0000-000000000000	c6a5f60f-832b-4a45-8887-24935e651ff6	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 00:04:30.554885+00	
00000000-0000-0000-0000-000000000000	06813a66-0bf1-4519-a1c7-15444ee2e7ec	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 00:16:02.936788+00	
00000000-0000-0000-0000-000000000000	9f95d25c-8213-4a3c-ac2c-44da7c9c580b	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 00:51:18.136835+00	
00000000-0000-0000-0000-000000000000	c52e4f31-0d42-4d11-93c3-c471309d5c97	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"alselwi@inv.local","user_id":"f7a39037-7d9f-44c8-9d39-e22549c02e6c","user_phone":""}}	2026-05-30 00:51:47.206256+00	
00000000-0000-0000-0000-000000000000	3b41a1ad-9742-4c7f-a0fb-c52be97998e7	{"action":"user_recovery_requested","actor_id":"f7a39037-7d9f-44c8-9d39-e22549c02e6c","actor_name":"alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"user"}	2026-05-30 00:55:41.425479+00	
00000000-0000-0000-0000-000000000000	21577edf-5779-4af7-adb6-0eb8d9098da4	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-30 00:55:47.773845+00	
00000000-0000-0000-0000-000000000000	e6c3fac4-1628-487a-9633-579662b2f89d	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 00:59:13.935825+00	
00000000-0000-0000-0000-000000000000	43c9ec96-aa5d-4eb9-96e7-e2d917925eff	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"ali@inv.local","user_id":"fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1","user_phone":""}}	2026-05-30 01:00:01.100781+00	
00000000-0000-0000-0000-000000000000	b765f7c7-135f-40da-96f5-b98344e94c1d	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-30 01:00:48.381122+00	
00000000-0000-0000-0000-000000000000	b079e9ed-d26c-40dc-add7-35c37db78f6c	{"action":"login","actor_id":"fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1","actor_name":"ali","actor_username":"ali@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 01:00:56.581583+00	
00000000-0000-0000-0000-000000000000	47b39ebb-0954-48e8-a484-0cbd96d67cbd	{"action":"logout","actor_id":"fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1","actor_name":"ali","actor_username":"ali@inv.local","actor_via_sso":false,"log_type":"account"}	2026-05-30 01:01:11.070932+00	
00000000-0000-0000-0000-000000000000	83190575-0a70-4c54-b8b1-26b1d0f0ea2c	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 01:01:18.378753+00	
00000000-0000-0000-0000-000000000000	a99253c9-f313-432e-aff4-8d127d86846c	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 01:03:27.848464+00	
00000000-0000-0000-0000-000000000000	4ef8c0f9-f467-48d5-9bec-f39a8ee3d56a	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 01:04:46.718625+00	
00000000-0000-0000-0000-000000000000	c4fa6750-7ccf-4247-a761-e5ce56e56f9d	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"alselwi@inv.local","user_id":"f7a39037-7d9f-44c8-9d39-e22549c02e6c","user_phone":""}}	2026-05-30 01:04:54.858245+00	
00000000-0000-0000-0000-000000000000	91258b15-d897-49f1-80b2-de5ead63c407	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 16:40:48.774492+00	
00000000-0000-0000-0000-000000000000	fe616f82-dba5-4371-92c0-4e1e5450777a	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"hussein alselwi","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 16:40:48.783211+00	
00000000-0000-0000-0000-000000000000	1cb31946-970c-4967-afe5-8d59e401d494	{"action":"user_modified","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"user","traits":{"user_email":"admin@inv.local","user_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","user_phone":""}}	2026-05-30 16:42:00.595692+00	
00000000-0000-0000-0000-000000000000	d0939b99-46a3-4830-a546-6355fb0a2c58	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 17:06:30.502875+00	
00000000-0000-0000-0000-000000000000	ea697e28-d2c7-45ff-8baf-094df63405cd	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 17:06:30.510954+00	
00000000-0000-0000-0000-000000000000	deabe110-ad20-410c-91da-7bad7fcabb72	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 17:21:59.027985+00	
00000000-0000-0000-0000-000000000000	0e245617-22a7-4f70-9bc3-a6f386bf39f4	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 17:40:08.587329+00	
00000000-0000-0000-0000-000000000000	8322a609-b33f-4511-81be-05dd8eb2c19d	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 17:40:08.589564+00	
00000000-0000-0000-0000-000000000000	44ee8dbf-2b49-453a-ac09-6355ff2bd027	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 18:17:12.978878+00	
00000000-0000-0000-0000-000000000000	8ef0131f-ec53-45ab-bdd3-818407ad7419	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 18:53:14.777557+00	
00000000-0000-0000-0000-000000000000	f3f56f6b-fbcb-4aa7-9c57-5ee8c9ecf6c6	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 18:53:14.780535+00	
00000000-0000-0000-0000-000000000000	856b9760-9719-4642-9e73-192a1b559535	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 18:53:15.81151+00	
00000000-0000-0000-0000-000000000000	ce0fbf8f-0f76-4eac-83c1-9b4b237ab0cb	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 19:15:42.257961+00	
00000000-0000-0000-0000-000000000000	18a9d39c-6ffd-438a-b5f3-f65d88a33569	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 19:15:42.259243+00	
00000000-0000-0000-0000-000000000000	0d47997c-7eda-4029-a932-1bbee1a72da5	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"alselwi@inv.local","user_id":"8ef3ddb7-80d2-4e16-b70d-6c6aa57e1305","user_phone":""}}	2026-05-30 19:25:16.786982+00	
00000000-0000-0000-0000-000000000000	18bd4b1b-89a9-45fb-9222-470b0e57e848	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 19:59:33.632748+00	
00000000-0000-0000-0000-000000000000	3c009434-9fbb-4d95-8325-099383030cef	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 19:59:33.63433+00	
00000000-0000-0000-0000-000000000000	9e8b4f89-0782-47da-8f21-0591bf1c9df4	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:14:11.087636+00	
00000000-0000-0000-0000-000000000000	80210d64-7ef8-4214-b128-3ab368194cc9	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:14:11.088896+00	
00000000-0000-0000-0000-000000000000	ce4e818c-3490-4b8a-ae2d-04d9e25947aa	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:58:02.193794+00	
00000000-0000-0000-0000-000000000000	67690a98-4ebf-4b88-8e1a-e7606a4b19fd	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 20:58:02.196541+00	
00000000-0000-0000-0000-000000000000	c84b8cd0-134b-45d1-8451-7d01c7063605	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 21:12:48.203321+00	
00000000-0000-0000-0000-000000000000	8535813e-68f3-4ede-892e-79253377fb29	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-05-30 21:12:48.204912+00	
00000000-0000-0000-0000-000000000000	eca798d7-ba73-4e16-91d7-8a1f4b0ec3b1	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 21:38:00.028416+00	
00000000-0000-0000-0000-000000000000	b15acda2-e5aa-49e5-a9b6-063fbe8b71c1	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-05-30 21:41:45.549799+00	
00000000-0000-0000-0000-000000000000	f4d3458a-6c09-4e28-956e-daf1f53b73bf	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:31:28.462821+00	
00000000-0000-0000-0000-000000000000	45a6e6ff-a1f0-417e-a8c2-d55b16ea0d5b	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:31:28.470131+00	
00000000-0000-0000-0000-000000000000	0bdbdd73-653e-4bb8-9d41-8de361aa01a7	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:35:02.832231+00	
00000000-0000-0000-0000-000000000000	ddb12e1f-3be4-4f40-a37f-00d47166f329	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 19:35:02.835306+00	
00000000-0000-0000-0000-000000000000	026a3adb-9337-4de0-ad86-b2b305b87a0a	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 19:47:13.75616+00	
00000000-0000-0000-0000-000000000000	7062e657-0c81-4a6b-adf0-155dbe163711	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:17:48.031801+00	
00000000-0000-0000-0000-000000000000	06e95285-7ba9-43b4-abf9-84c8e5c63d8e	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:17:48.03318+00	
00000000-0000-0000-0000-000000000000	e072948e-f0df-4dab-b912-6fa89bd7aa94	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:34:04.625491+00	
00000000-0000-0000-0000-000000000000	3e0f05ee-a277-4776-ae0f-090e0ead09f9	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:34:04.62731+00	
00000000-0000-0000-0000-000000000000	2dc5a74f-cb39-400c-8838-df0baca7a036	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:45:53.242708+00	
00000000-0000-0000-0000-000000000000	19bbeb30-1f3a-461e-b0f6-fe1d169f6589	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 20:45:53.243599+00	
00000000-0000-0000-0000-000000000000	7db16186-e0b5-4df4-870f-7d5e43017897	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-01 20:59:52.564428+00	
00000000-0000-0000-0000-000000000000	5d96506c-3a28-4094-af3e-557e86d36ff2	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:00:07.624069+00	
00000000-0000-0000-0000-000000000000	868453df-19d9-4704-a412-c8647fd617cd	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:02:05.048127+00	
00000000-0000-0000-0000-000000000000	979b9fec-fec1-4292-a697-c716a83eaa87	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:13:52.330344+00	
00000000-0000-0000-0000-000000000000	51b9308f-cee8-405c-832b-bb9b6aabe0e9	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:14:08.151451+00	
00000000-0000-0000-0000-000000000000	acd4f8a5-2310-4a4e-9402-3cc5235fbd46	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:21:41.166136+00	
00000000-0000-0000-0000-000000000000	0060fcad-2f93-48b6-961c-1f8faa9383fd	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-01 21:24:04.665775+00	
00000000-0000-0000-0000-000000000000	c8c66b41-5e23-4ccf-9a8d-67915c627d96	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"salah@inv.local","user_id":"98289d34-511f-4600-8f62-3b01a53a4f30","user_phone":""}}	2026-06-01 21:26:07.096552+00	
00000000-0000-0000-0000-000000000000	54c10367-3cf1-480d-a0c2-bf9b0c9e12f8	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:27:34.551001+00	
00000000-0000-0000-0000-000000000000	6a54028b-9e14-4d8e-962e-b9405ee9dd0d	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"aboali@inv.local","user_id":"c11a79d7-bb34-4320-8a7d-7a0f6be3d194","user_phone":""}}	2026-06-01 21:30:56.869413+00	
00000000-0000-0000-0000-000000000000	ab4e730b-eb79-438e-a4f4-51d2ca9b7b0f	{"action":"login","actor_id":"c11a79d7-bb34-4320-8a7d-7a0f6be3d194","actor_name":"abo ali","actor_username":"aboali@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:31:46.50705+00	
00000000-0000-0000-0000-000000000000	496e7d4f-fb77-4583-b73f-f6983579e87d	{"action":"user_recovery_requested","actor_id":"98289d34-511f-4600-8f62-3b01a53a4f30","actor_name":"صلاح الدين طرووش","actor_username":"salah@inv.local","actor_via_sso":false,"log_type":"user"}	2026-06-01 21:32:20.383379+00	
00000000-0000-0000-0000-000000000000	6d9ac39c-9969-4a7f-9e52-1f344ba9b0da	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"salah@inv.local","user_id":"98289d34-511f-4600-8f62-3b01a53a4f30","user_phone":""}}	2026-06-01 21:32:25.029676+00	
00000000-0000-0000-0000-000000000000	e72ca090-3d0b-4ddf-b7c1-d811f37f1b5f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"alselwi@inv.local","user_id":"8ef3ddb7-80d2-4e16-b70d-6c6aa57e1305","user_phone":""}}	2026-06-01 21:32:31.085711+00	
00000000-0000-0000-0000-000000000000	fb06064b-efd8-4cf7-abf5-358a9080befa	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ali@inv.local","user_id":"fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1","user_phone":""}}	2026-06-01 21:32:34.451398+00	
00000000-0000-0000-0000-000000000000	f1212374-2154-4dc9-825b-10806cee9b27	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:34:01.048961+00	
00000000-0000-0000-0000-000000000000	13937551-c5be-4ef9-ae60-7b13a979d156	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 21:47:27.400862+00	
00000000-0000-0000-0000-000000000000	27a31ab8-f703-486b-9fb8-77ffe0917d33	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"salah@inv.local","user_id":"a36f3f23-61d5-4b30-8573-23d6a3fc2273","user_phone":""}}	2026-06-01 21:48:13.949453+00	
00000000-0000-0000-0000-000000000000	065e67f6-a51c-4536-ac15-131263b0b9cc	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"tarboosh@inv.local","user_id":"fcd49be9-d3ad-44bf-af22-2c3bca9599f2","user_phone":""}}	2026-06-01 22:00:57.112727+00	
00000000-0000-0000-0000-000000000000	bd426c90-36db-4337-84e5-d40914d2191a	{"action":"login","actor_id":"c11a79d7-bb34-4320-8a7d-7a0f6be3d194","actor_name":"abo ali","actor_username":"aboali@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-01 22:09:29.568466+00	
00000000-0000-0000-0000-000000000000	dec6dd69-1c67-46b3-8723-7c33e3e1a5cf	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 22:25:58.598501+00	
00000000-0000-0000-0000-000000000000	78b80ee9-7fbd-4a04-9256-62b8d89f58a1	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 22:25:58.600625+00	
00000000-0000-0000-0000-000000000000	51f86bf9-69ac-4a86-89ab-85cf30ebc888	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 22:47:36.149158+00	
00000000-0000-0000-0000-000000000000	2ae1ea5c-0a81-41db-88e5-5be21b350836	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-01 22:47:36.150243+00	
00000000-0000-0000-0000-000000000000	50f95891-27a8-4794-9e40-a0b79d5fb2ec	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"alselwi@inv.local","user_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","user_phone":""}}	2026-06-01 23:12:43.662026+00	
00000000-0000-0000-0000-000000000000	22e8b779-4cb1-4d10-ae88-f1ff7b39f0b7	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-02 00:03:03.821681+00	
00000000-0000-0000-0000-000000000000	b3f7c1da-29b1-4810-98ef-73ab0d51d2bf	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-02 00:03:03.824364+00	
00000000-0000-0000-0000-000000000000	1296bd26-3095-4dc6-a175-7d9c6c6c8035	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-02 00:37:22.156459+00	
00000000-0000-0000-0000-000000000000	6e8afc00-6e1f-4d0c-95ad-161d1db839b4	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-02 00:37:22.158251+00	
00000000-0000-0000-0000-000000000000	b8156f13-430d-43d1-87ac-d144b9465617	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"try@inv.local","user_id":"38864ff1-f161-4ace-8919-2297a65286e6","user_phone":""}}	2026-06-02 00:38:06.565156+00	
00000000-0000-0000-0000-000000000000	5a2f0129-3aae-4616-8d05-e48379b9d5c0	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-03 22:47:15.705545+00	
00000000-0000-0000-0000-000000000000	b130947c-2bc1-4a0b-9ae2-29367433d58f	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-03 22:47:15.709878+00	
00000000-0000-0000-0000-000000000000	072dcb60-44aa-4460-bf3f-f8d5fd91066f	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 22:47:25.372691+00	
00000000-0000-0000-0000-000000000000	b665a985-62ca-42a6-842f-4b64f9e56ae3	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:08:31.35638+00	
00000000-0000-0000-0000-000000000000	685bc5ad-cfc2-4e7d-83d8-8c6840e8cef7	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:08:39.160389+00	
00000000-0000-0000-0000-000000000000	69036f36-2d0e-4ace-81b8-4974398f13da	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:12:19.680273+00	
00000000-0000-0000-0000-000000000000	258e83f2-2028-4a77-98ba-f6e25e948e72	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:12:40.103813+00	
00000000-0000-0000-0000-000000000000	7ae333a2-1c51-4c24-a4f0-a51a40646a24	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:12:51.142545+00	
00000000-0000-0000-0000-000000000000	fd516c87-e96c-4627-9480-de584113d1a8	{"action":"logout","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:12:57.544907+00	
00000000-0000-0000-0000-000000000000	ec95529e-3881-4be8-a214-3586cb8a2454	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:13:00.611683+00	
00000000-0000-0000-0000-000000000000	c94fe061-f458-4faf-94d9-afddc311a9be	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:13:19.960172+00	
00000000-0000-0000-0000-000000000000	6d3ac519-6897-4ea1-abce-d11ae2bd80af	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:13:28.169332+00	
00000000-0000-0000-0000-000000000000	f6c450b2-9e20-4373-b9da-4e17c701fbcd	{"action":"logout","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:13:53.845055+00	
00000000-0000-0000-0000-000000000000	38e76830-f7b4-4656-a649-05d096926373	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:13:56.38343+00	
00000000-0000-0000-0000-000000000000	978b6dd6-263c-4440-9c20-173f1f052567	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:14:24.918177+00	
00000000-0000-0000-0000-000000000000	e585b975-fae2-4e71-8f50-873d0f02e308	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:14:32.717867+00	
00000000-0000-0000-0000-000000000000	356d5040-6fb9-4e8f-abea-3c550d57a3a8	{"action":"logout","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:14:44.882495+00	
00000000-0000-0000-0000-000000000000	ab3e38a2-732c-43a5-9310-5ea4fcf4837e	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:14:47.920732+00	
00000000-0000-0000-0000-000000000000	3b18e611-c882-481d-a2cc-eac768912f02	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-03 23:15:26.05023+00	
00000000-0000-0000-0000-000000000000	4a074a1b-038a-4ef6-ba4e-98891bf3a3f2	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:15:28.809399+00	
00000000-0000-0000-0000-000000000000	1d80eba9-35b7-472c-8f9a-da61d5df22f2	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-03 23:38:38.444744+00	
00000000-0000-0000-0000-000000000000	9dbe0b91-f9fe-4208-a99f-a4c7d68cfc9f	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:09:47.402301+00	
00000000-0000-0000-0000-000000000000	f2b4ded0-46b9-4747-b314-f24686399d44	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:31:24.515534+00	
00000000-0000-0000-0000-000000000000	557a122a-4d65-4172-a327-dbc95904ef0f	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"tarboosh@inv.local","user_id":"fcd49be9-d3ad-44bf-af22-2c3bca9599f2","user_phone":""}}	2026-06-04 00:31:54.436624+00	
00000000-0000-0000-0000-000000000000	d76877ff-37c7-4852-8f7c-463bec3f4634	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:33:17.524604+00	
00000000-0000-0000-0000-000000000000	ee6028bd-eb57-44b8-9553-8dc3d8933301	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"try@inv.local","user_id":"38864ff1-f161-4ace-8919-2297a65286e6","user_phone":""}}	2026-06-04 00:33:41.669241+00	
00000000-0000-0000-0000-000000000000	0febe9e2-a60b-4bb1-a103-fe0c58ff374f	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-04 00:35:23.690666+00	
00000000-0000-0000-0000-000000000000	8741f59a-c301-4a11-854a-9c78f154476d	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:35:38.684074+00	
00000000-0000-0000-0000-000000000000	442f5aaf-74b8-4448-8ca4-dc72ea064262	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:36:27.573365+00	
00000000-0000-0000-0000-000000000000	78d6c51e-23b9-4e30-8d1e-65cf687a1840	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:37:11.514292+00	
00000000-0000-0000-0000-000000000000	c2e86dda-f045-4c78-b8c8-a582903bc117	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 00:42:53.398577+00	
00000000-0000-0000-0000-000000000000	5556d0ae-68fd-4beb-a91a-80c74f57e1d2	{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"aboali@inv.local","user_id":"c11a79d7-bb34-4320-8a7d-7a0f6be3d194","user_phone":""}}	2026-06-04 00:43:35.398825+00	
00000000-0000-0000-0000-000000000000	1a13e6d7-9932-44fb-a59a-c07a77eeff8b	{"action":"token_refreshed","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-04 21:29:23.697309+00	
00000000-0000-0000-0000-000000000000	aa102e0a-62e9-4546-8587-a06c13caafee	{"action":"token_revoked","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-04 21:29:23.705847+00	
00000000-0000-0000-0000-000000000000	1cfc8127-9dc6-4a62-aa22-78edefb89a2b	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 21:29:28.081668+00	
00000000-0000-0000-0000-000000000000	9010ca86-f369-43d8-96a8-625411f2a2d1	{"action":"logout","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account"}	2026-06-04 21:29:58.237027+00	
00000000-0000-0000-0000-000000000000	f43c5429-08e8-406d-96b9-f94ac7fd10fa	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 21:30:01.820652+00	
00000000-0000-0000-0000-000000000000	bceab47c-20c3-4115-b122-f1dccea510c8	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 21:30:18.608459+00	
00000000-0000-0000-0000-000000000000	47e51f15-28a1-4816-8720-2c22dca00210	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 21:31:21.65094+00	
00000000-0000-0000-0000-000000000000	03fb75f6-a4cf-4765-ada7-19bf02ec7bb7	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 21:35:01.412293+00	
00000000-0000-0000-0000-000000000000	962e037c-0048-4c95-aea6-ca15510bb5ca	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"oshaip@inv.local","user_id":"dbf26535-d542-4c77-9151-d39dbad967cd","user_phone":""}}	2026-06-04 21:35:31.225476+00	
00000000-0000-0000-0000-000000000000	88025234-eab6-41d1-b8f4-093fdc27c450	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 22:14:44.902369+00	
00000000-0000-0000-0000-000000000000	df62dac2-ab9f-4dd1-b4b8-255e16fb14d3	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 22:18:47.558245+00	
00000000-0000-0000-0000-000000000000	8b33ffd0-9461-4f4b-a27e-89fb90cf2fbb	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-04 22:32:51.036619+00	
00000000-0000-0000-0000-000000000000	af044aee-d173-4bef-90ac-eb01d47df62e	{"action":"token_refreshed","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 19:12:47.921223+00	
00000000-0000-0000-0000-000000000000	7c3418af-87f3-40e9-9007-6e32f76ea63c	{"action":"token_revoked","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 19:12:47.926303+00	
00000000-0000-0000-0000-000000000000	b41ccf89-e34f-464b-849a-95150c38a820	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 19:13:45.290192+00	
00000000-0000-0000-0000-000000000000	7a37b108-42d3-425f-bb25-77ed4501f1dc	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 19:22:54.489441+00	
00000000-0000-0000-0000-000000000000	af621a7b-a96e-4f88-b09c-8cc40346bfad	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 19:22:54.490372+00	
00000000-0000-0000-0000-000000000000	4ffa341a-ab5d-4673-83aa-2fc607d3fbdf	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 19:23:35.49953+00	
00000000-0000-0000-0000-000000000000	18ee69c7-72b9-4949-861b-61f9e9742375	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 20:07:29.86869+00	
00000000-0000-0000-0000-000000000000	9130356d-54a9-443a-96d2-5740d328d4d4	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 20:08:02.796048+00	
00000000-0000-0000-0000-000000000000	7ee28a66-263a-4852-baa8-d9174637c3e5	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 20:23:24.509552+00	
00000000-0000-0000-0000-000000000000	c39b0b65-9b71-43cd-bfa7-48e06537f658	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 20:29:19.796816+00	
00000000-0000-0000-0000-000000000000	38ea3f47-c34c-4daf-aec8-3715d1b266ed	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 20:31:38.034734+00	
00000000-0000-0000-0000-000000000000	fa399773-a32a-42a0-ae42-a31bf1e82b41	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 20:37:17.324115+00	
00000000-0000-0000-0000-000000000000	3193f95e-7a11-4efd-a519-be3cefdb2c61	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:28:12.513907+00	
00000000-0000-0000-0000-000000000000	6d04336b-f1f9-4057-afdf-1915bc8c4752	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:37:05.158133+00	
00000000-0000-0000-0000-000000000000	9d847566-c609-4794-bc8d-9269924926f2	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:49:30.808086+00	
00000000-0000-0000-0000-000000000000	63ba53d6-0ba9-4860-9a92-d3ed43d9353e	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:51:01.596682+00	
00000000-0000-0000-0000-000000000000	e7f21415-8371-44fd-981b-1d7374f9fb49	{"action":"token_refreshed","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 21:51:14.658328+00	
00000000-0000-0000-0000-000000000000	73c83806-d123-4764-a768-caa41d5481a7	{"action":"token_revoked","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 21:51:14.659869+00	
00000000-0000-0000-0000-000000000000	f12804fa-a764-48d5-a0a1-4d4e26250cd3	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:51:41.203322+00	
00000000-0000-0000-0000-000000000000	93455b09-52be-4133-b60f-f24128e248ff	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:51:59.164169+00	
00000000-0000-0000-0000-000000000000	357b5b72-c85e-4488-b6e4-1625ae2445f9	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:52:47.501101+00	
00000000-0000-0000-0000-000000000000	0bee53fd-83ab-4b41-ae25-01a736781522	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 21:58:03.651492+00	
00000000-0000-0000-0000-000000000000	0beba807-8230-42a8-bf60-414567d31eb5	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:02:06.404786+00	
00000000-0000-0000-0000-000000000000	a7a4419c-3d22-4215-96b3-481684acb8dc	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:13:36.023666+00	
00000000-0000-0000-0000-000000000000	7b982c52-13b8-4b00-910a-3f27d23e7e7c	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:15:24.898832+00	
00000000-0000-0000-0000-000000000000	bbfe95d6-be7f-4479-91f6-285103ad4e86	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:17:55.051051+00	
00000000-0000-0000-0000-000000000000	478b9bb9-192c-4dae-8733-56ebf7ce76b9	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:19:22.858098+00	
00000000-0000-0000-0000-000000000000	538c7bc9-7a34-4e01-82dc-202971b40bd2	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:29:49.191015+00	
00000000-0000-0000-0000-000000000000	e9f4d318-c43b-46a6-81b6-ea01dfbb1662	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:30:38.635982+00	
00000000-0000-0000-0000-000000000000	3628c496-c293-4ad2-969c-4e5916b8b6bf	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:30:51.574599+00	
00000000-0000-0000-0000-000000000000	947125d8-2235-4422-b6ce-189dee41637a	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:33:59.410421+00	
00000000-0000-0000-0000-000000000000	9f99a0cf-8ed0-4d3c-9eec-492eef090ff1	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:34:51.278637+00	
00000000-0000-0000-0000-000000000000	598a0c80-4dfc-4ba4-b219-745532cf5100	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:35:14.899869+00	
00000000-0000-0000-0000-000000000000	63d0578c-d5c7-449e-91b2-f92e4e49dd2c	{"action":"login","actor_id":"6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d","actor_name":"hussein alselwi","actor_username":"alselwi@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:37:23.032633+00	
00000000-0000-0000-0000-000000000000	261d892b-d414-4130-b93f-ea5223b5c925	{"action":"login","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-06-17 22:45:28.276779+00	
00000000-0000-0000-0000-000000000000	2207b2fd-f64a-4815-b861-a5ccaf1f01e0	{"action":"token_refreshed","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 22:53:30.46675+00	
00000000-0000-0000-0000-000000000000	f2e16acd-3586-4e84-9bc0-afc3a714f0ea	{"action":"token_revoked","actor_id":"85d2a767-bae1-4a79-8dda-cbe035239f5a","actor_name":"Admin","actor_username":"admin@inv.local","actor_via_sso":false,"log_type":"token"}	2026-06-17 22:53:30.467893+00	
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a	{"sub": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "email": "admin@inv.local", "username": "admin", "full_name": "hussein alselwi", "email_verified": false, "phone_verified": false}	email	2026-05-29 22:13:48.998687+00	2026-05-29 22:13:48.998716+00	2026-05-29 22:13:48.998716+00	33ae7ae8-3076-4f22-9958-1d1b59ac996d
a36f3f23-61d5-4b30-8573-23d6a3fc2273	a36f3f23-61d5-4b30-8573-23d6a3fc2273	{"sub": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "email": "salah@inv.local", "email_verified": false, "phone_verified": false}	email	2026-06-01 21:48:13.948254+00	2026-06-01 21:48:13.948284+00	2026-06-01 21:48:13.948284+00	174b0aa1-c07d-45d4-8d69-ff1bb62959fa
6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	{"sub": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "email": "alselwi@inv.local", "email_verified": false, "phone_verified": false}	email	2026-06-01 23:12:43.660245+00	2026-06-01 23:12:43.660285+00	2026-06-01 23:12:43.660285+00	0196e54b-e0b8-4972-b4f0-f733fdc2a812
dbf26535-d542-4c77-9151-d39dbad967cd	dbf26535-d542-4c77-9151-d39dbad967cd	{"sub": "dbf26535-d542-4c77-9151-d39dbad967cd", "email": "oshaip@inv.local", "email_verified": false, "phone_verified": false}	email	2026-06-04 21:35:31.222612+00	2026-06-04 21:35:31.22269+00	2026-06-04 21:35:31.22269+00	d26ef4ad-9e84-40ae-9bc9-7bbb656250be
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
d7e6ab71-831b-454d-997d-b7d173532006	2026-06-03 23:15:28.814553+00	2026-06-03 23:15:28.814553+00	password	ee6ae32d-ed76-435a-a80d-b4c03c0ae604
f50cac38-606e-4909-a97e-9c1a122d5455	2026-06-04 00:35:38.689811+00	2026-06-04 00:35:38.689811+00	password	b26725f9-92c2-426b-9576-34a137db20be
b822a16a-e95e-40a0-94bd-71e7fa074c6c	2026-06-04 00:36:27.578686+00	2026-06-04 00:36:27.578686+00	password	58127ccc-42d0-4165-96d1-431e3d5ba7b4
af25c4fd-ff97-4f09-b710-69ab865cee82	2026-06-04 00:42:53.404925+00	2026-06-04 00:42:53.404925+00	password	6f071ede-16fa-44e0-ac90-924a7c0636ce
b802b007-0513-416e-bbd8-3da7674b6250	2026-06-04 21:30:01.828111+00	2026-06-04 21:30:01.828111+00	password	4a3b1dff-b203-4281-81d4-2859b9ecbd97
c70a087b-6313-49af-acf3-8f9ca415cae1	2026-06-04 21:30:18.618531+00	2026-06-04 21:30:18.618531+00	password	07dc1605-961f-40df-9d03-5c7eb653b94e
0ffa0d53-847c-4881-91d2-521dd2c767b8	2026-06-04 21:31:21.659+00	2026-06-04 21:31:21.659+00	password	177ffb69-1127-479e-a2f9-7f75c0b9547a
4dc82aa0-1726-45d8-ba5b-535f29df7a73	2026-06-04 21:35:01.428345+00	2026-06-04 21:35:01.428345+00	password	a183c686-0b04-4ff6-b319-9bb5e7c4c814
87f7cc91-441c-4a36-a721-171a6e85a77d	2026-06-04 22:14:44.921042+00	2026-06-04 22:14:44.921042+00	password	4541647f-3680-4457-b73d-b373afba887d
70ad533d-077e-4735-92ec-529463b9e7df	2026-06-04 22:18:47.571831+00	2026-06-04 22:18:47.571831+00	password	b9203c00-c2ad-4bfa-bb25-8020c1103870
e4a5ec35-5dfc-4d4a-9f8e-a12fa3cc5a60	2026-06-04 22:32:51.048035+00	2026-06-04 22:32:51.048035+00	password	809343ee-68e1-4772-929f-489cb2e416a0
c004f20d-f82b-41fb-b9ea-6f7618a1f411	2026-06-17 19:13:45.295327+00	2026-06-17 19:13:45.295327+00	password	8dc917d2-ab28-4dcd-ad05-63694d164b93
3fe9a5ce-8437-4001-9653-ea143cdf59cf	2026-06-17 19:23:35.505401+00	2026-06-17 19:23:35.505401+00	password	726eae8b-bb97-4d7b-8872-fa4b59c066aa
d90f5c1e-f9c4-4135-87e5-ab42a549b99c	2026-06-17 20:07:29.874411+00	2026-06-17 20:07:29.874411+00	password	ba1e69ea-1816-466a-8558-4cc66c2441ac
3e91f91d-0d9f-442f-b3de-ae9c2d03fd92	2026-06-17 20:08:02.80065+00	2026-06-17 20:08:02.80065+00	password	5c039516-b2d9-42c8-9ecf-07fb46e37985
f03e16bd-f5df-42c2-97eb-04bfb754e09a	2026-06-17 20:23:24.514886+00	2026-06-17 20:23:24.514886+00	password	2b4d3bac-d7e2-4fc0-9087-dcbf681cbcdb
0e054ed3-a822-42a1-8c46-9500f1d14ac6	2026-06-17 20:29:19.802351+00	2026-06-17 20:29:19.802351+00	password	a342c476-7515-45f5-b0f8-a90e1941db17
9a434b02-58bb-4897-a4b2-b782f08abe87	2026-06-17 20:31:38.03965+00	2026-06-17 20:31:38.03965+00	password	92d04101-460e-4e9f-a612-5b594bbbc78e
17e2e8c0-d752-4726-b831-a964a16e1b0f	2026-06-17 20:37:17.329464+00	2026-06-17 20:37:17.329464+00	password	2b9579f5-1210-4eb7-8f9b-a68c9272ac4b
c34b4d91-5e15-4241-a054-310886824f68	2026-06-17 21:28:12.521068+00	2026-06-17 21:28:12.521068+00	password	c3c25960-77e5-4582-8f0d-241b189098e7
b25828d3-be5e-4886-b7a8-39dfdc89c44d	2026-06-17 21:37:05.164805+00	2026-06-17 21:37:05.164805+00	password	4d5ce776-7130-4cce-b685-cf5dfa901895
0a379722-0236-4558-8024-178ebac36037	2026-06-17 21:49:30.813357+00	2026-06-17 21:49:30.813357+00	password	9e30f6a3-20cf-483f-abef-8ee63312269e
a71286aa-a1ff-4e98-8c9e-b38d076b02b5	2026-06-17 21:51:01.602155+00	2026-06-17 21:51:01.602155+00	password	93c9b126-a698-4538-844f-a1668395a33a
afc1bffc-3244-4697-a5f4-7a9df400bad8	2026-06-17 21:51:41.209135+00	2026-06-17 21:51:41.209135+00	password	6a18ad63-9e8a-4022-b3bd-9a002f2924ca
d4d2f338-3ecc-4cc1-baa5-12b71663c2f7	2026-06-17 21:51:59.170153+00	2026-06-17 21:51:59.170153+00	password	c5ae54dd-41ed-48eb-8d7c-76f78b8f3a2d
6b671b60-3dfd-4c05-a93f-1d629352673b	2026-06-17 21:52:47.506788+00	2026-06-17 21:52:47.506788+00	password	a9bbc545-cfb4-4c4e-b09f-e1c25b87004e
25324f76-1a0d-47c0-bb07-8c147a0191c2	2026-06-17 21:58:03.656752+00	2026-06-17 21:58:03.656752+00	password	05875a06-ee20-4df0-ac9d-fd53bd19c98b
07d5061d-73f4-4be9-a464-7743d4e235c6	2026-06-17 22:02:06.40999+00	2026-06-17 22:02:06.40999+00	password	3096a702-ee82-4855-aa93-19a948b715b1
83e2c36d-b227-4ad7-b7d9-f23dea8faf46	2026-06-17 22:13:36.028511+00	2026-06-17 22:13:36.028511+00	password	9c577e4c-2fae-4333-94ca-0b0b0788739b
c83dc760-8f67-4631-8244-b9aee066195c	2026-06-17 22:15:24.904677+00	2026-06-17 22:15:24.904677+00	password	b34e95b1-c47d-4fc2-972f-e932d198dfe2
a4004d79-8ac8-4812-b421-6923e499495b	2026-06-17 22:17:55.056003+00	2026-06-17 22:17:55.056003+00	password	c3c9b0d3-80b2-4446-9854-8411b27770dc
b48fef0b-e2d0-462a-a050-fa9c0017ade3	2026-06-17 22:19:22.863226+00	2026-06-17 22:19:22.863226+00	password	44f7e83e-5ff6-4c25-94ad-28e5f8f385f4
257a233d-22a9-4a73-a7a8-836aa92eac87	2026-06-17 22:29:49.19655+00	2026-06-17 22:29:49.19655+00	password	878dbce3-6b8e-475c-9e21-0c0c5250bbdf
3172e3f5-06a9-469a-ae3f-11a36242fb2e	2026-06-17 22:30:38.641805+00	2026-06-17 22:30:38.641805+00	password	f149182a-8e37-465b-b1e3-723ff76eac00
95e2fec5-9533-4575-ae5d-29641e24cd05	2026-06-17 22:30:51.580081+00	2026-06-17 22:30:51.580081+00	password	dd26648b-c119-47e2-8cf9-52b3d02e63e7
01eb5eb7-d13d-4653-8aa7-840805aca640	2026-06-17 22:33:59.415732+00	2026-06-17 22:33:59.415732+00	password	b82085c1-9a78-43be-9fc7-2105e50bb864
f1b58aa7-2ac6-42d2-af30-50c410aa129b	2026-06-17 22:34:51.28386+00	2026-06-17 22:34:51.28386+00	password	2ff770e6-aa9f-4b06-8af6-03ef59caf150
1ffc30d6-194b-4872-8042-4e7d50f9ab26	2026-06-17 22:35:14.907101+00	2026-06-17 22:35:14.907101+00	password	2bf80a18-b025-4fef-8dfc-432abe2f1ea7
5321df84-0475-4ff0-af99-e5cadd376c2d	2026-06-17 22:37:23.03762+00	2026-06-17 22:37:23.03762+00	password	38671438-2b08-40d3-a384-dcbc84cee4ad
1ec80d2d-ec0a-496e-9f20-a2e5d58b50a4	2026-06-17 22:45:28.281972+00	2026-06-17 22:45:28.281972+00	password	5e80f32d-3b1a-42a6-a63f-8fae31180e98
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	61	blqsk6qneit6	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-03 23:15:28.812443+00	2026-06-03 23:15:28.812443+00	\N	d7e6ab71-831b-454d-997d-b7d173532006
00000000-0000-0000-0000-000000000000	66	ros3nbkspif3	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-04 00:35:38.687526+00	2026-06-04 00:35:38.687526+00	\N	f50cac38-606e-4909-a97e-9c1a122d5455
00000000-0000-0000-0000-000000000000	67	hqgmo3gv57ou	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-04 00:36:27.576516+00	2026-06-04 00:36:27.576516+00	\N	b822a16a-e95e-40a0-94bd-71e7fa074c6c
00000000-0000-0000-0000-000000000000	69	af4eimcbkkrx	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	t	2026-06-04 00:42:53.402434+00	2026-06-04 21:29:23.708193+00	\N	af25c4fd-ff97-4f09-b710-69ab865cee82
00000000-0000-0000-0000-000000000000	102	nllnnlgni3qj	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-04 21:29:23.710971+00	2026-06-04 21:29:23.710971+00	af4eimcbkkrx	af25c4fd-ff97-4f09-b710-69ab865cee82
00000000-0000-0000-0000-000000000000	104	zug32yjobxy6	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-04 21:30:01.825249+00	2026-06-04 21:30:01.825249+00	\N	b802b007-0513-416e-bbd8-3da7674b6250
00000000-0000-0000-0000-000000000000	105	itgcdhiboshs	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-04 21:30:18.614552+00	2026-06-04 21:30:18.614552+00	\N	c70a087b-6313-49af-acf3-8f9ca415cae1
00000000-0000-0000-0000-000000000000	106	ss7gpitowxfl	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-04 21:31:21.655818+00	2026-06-04 21:31:21.655818+00	\N	0ffa0d53-847c-4881-91d2-521dd2c767b8
00000000-0000-0000-0000-000000000000	135	sqnbrfrcqndn	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-04 21:35:01.421101+00	2026-06-04 21:35:01.421101+00	\N	4dc82aa0-1726-45d8-ba5b-535f29df7a73
00000000-0000-0000-0000-000000000000	136	3viqbkmvlsgw	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-04 22:14:44.913927+00	2026-06-04 22:14:44.913927+00	\N	87f7cc91-441c-4a36-a721-171a6e85a77d
00000000-0000-0000-0000-000000000000	137	wqiotdvsielf	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	t	2026-06-04 22:18:47.565915+00	2026-06-17 19:12:47.928481+00	\N	70ad533d-077e-4735-92ec-529463b9e7df
00000000-0000-0000-0000-000000000000	139	ycmunfyxoeyd	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 19:12:47.930152+00	2026-06-17 19:12:47.930152+00	wqiotdvsielf	70ad533d-077e-4735-92ec-529463b9e7df
00000000-0000-0000-0000-000000000000	138	qd7o5kcgt55m	85d2a767-bae1-4a79-8dda-cbe035239f5a	t	2026-06-04 22:32:51.043903+00	2026-06-17 19:22:54.491068+00	\N	e4a5ec35-5dfc-4d4a-9f8e-a12fa3cc5a60
00000000-0000-0000-0000-000000000000	141	o6kb6g3knwsn	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 19:22:54.491822+00	2026-06-17 19:22:54.491822+00	qd7o5kcgt55m	e4a5ec35-5dfc-4d4a-9f8e-a12fa3cc5a60
00000000-0000-0000-0000-000000000000	142	v5kgmgbwykv2	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 19:23:35.503183+00	2026-06-17 19:23:35.503183+00	\N	3fe9a5ce-8437-4001-9653-ea143cdf59cf
00000000-0000-0000-0000-000000000000	144	nxc2uttcmaxy	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 20:08:02.798824+00	2026-06-17 20:08:02.798824+00	\N	3e91f91d-0d9f-442f-b3de-ae9c2d03fd92
00000000-0000-0000-0000-000000000000	145	f6wxvu6hvut5	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 20:23:24.512958+00	2026-06-17 20:23:24.512958+00	\N	f03e16bd-f5df-42c2-97eb-04bfb754e09a
00000000-0000-0000-0000-000000000000	146	zgpc4z6nkka5	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 20:29:19.800094+00	2026-06-17 20:29:19.800094+00	\N	0e054ed3-a822-42a1-8c46-9500f1d14ac6
00000000-0000-0000-0000-000000000000	147	3vl6jxxfmwk3	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 20:31:38.037814+00	2026-06-17 20:31:38.037814+00	\N	9a434b02-58bb-4897-a4b2-b782f08abe87
00000000-0000-0000-0000-000000000000	148	qlkdmdwcsoz5	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 20:37:17.327445+00	2026-06-17 20:37:17.327445+00	\N	17e2e8c0-d752-4726-b831-a964a16e1b0f
00000000-0000-0000-0000-000000000000	149	ea5unf5gbjz7	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 21:28:12.51851+00	2026-06-17 21:28:12.51851+00	\N	c34b4d91-5e15-4241-a054-310886824f68
00000000-0000-0000-0000-000000000000	143	eepv5bgpwpyw	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	t	2026-06-17 20:07:29.872336+00	2026-06-17 21:51:14.660741+00	\N	d90f5c1e-f9c4-4135-87e5-ab42a549b99c
00000000-0000-0000-0000-000000000000	140	sh7wvcekbyxe	85d2a767-bae1-4a79-8dda-cbe035239f5a	t	2026-06-17 19:13:45.293487+00	2026-06-17 22:53:30.468816+00	\N	c004f20d-f82b-41fb-b9ea-6f7618a1f411
00000000-0000-0000-0000-000000000000	150	zruzio3gyvjd	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 21:37:05.161846+00	2026-06-17 21:37:05.161846+00	\N	b25828d3-be5e-4886-b7a8-39dfdc89c44d
00000000-0000-0000-0000-000000000000	151	ymzqsuiqxsuv	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 21:49:30.811312+00	2026-06-17 21:49:30.811312+00	\N	0a379722-0236-4558-8024-178ebac36037
00000000-0000-0000-0000-000000000000	152	glio7gywq2jl	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 21:51:01.599852+00	2026-06-17 21:51:01.599852+00	\N	a71286aa-a1ff-4e98-8c9e-b38d076b02b5
00000000-0000-0000-0000-000000000000	153	e4zgrxbzixbd	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 21:51:14.661635+00	2026-06-17 21:51:14.661635+00	eepv5bgpwpyw	d90f5c1e-f9c4-4135-87e5-ab42a549b99c
00000000-0000-0000-0000-000000000000	154	6shbfahofevk	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 21:51:41.2069+00	2026-06-17 21:51:41.2069+00	\N	afc1bffc-3244-4697-a5f4-7a9df400bad8
00000000-0000-0000-0000-000000000000	155	gdneremwccok	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 21:51:59.168123+00	2026-06-17 21:51:59.168123+00	\N	d4d2f338-3ecc-4cc1-baa5-12b71663c2f7
00000000-0000-0000-0000-000000000000	156	egljwlg7gqck	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 21:52:47.504213+00	2026-06-17 21:52:47.504213+00	\N	6b671b60-3dfd-4c05-a93f-1d629352673b
00000000-0000-0000-0000-000000000000	157	54qkywjoohma	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 21:58:03.654659+00	2026-06-17 21:58:03.654659+00	\N	25324f76-1a0d-47c0-bb07-8c147a0191c2
00000000-0000-0000-0000-000000000000	158	cp4u2sp655ok	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:02:06.407946+00	2026-06-17 22:02:06.407946+00	\N	07d5061d-73f4-4be9-a464-7743d4e235c6
00000000-0000-0000-0000-000000000000	159	agjrcfqspm7o	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:13:36.026595+00	2026-06-17 22:13:36.026595+00	\N	83e2c36d-b227-4ad7-b7d9-f23dea8faf46
00000000-0000-0000-0000-000000000000	160	dzbmotsqkb2f	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 22:15:24.902181+00	2026-06-17 22:15:24.902181+00	\N	c83dc760-8f67-4631-8244-b9aee066195c
00000000-0000-0000-0000-000000000000	161	7g4vvh2vweu5	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:17:55.053997+00	2026-06-17 22:17:55.053997+00	\N	a4004d79-8ac8-4812-b421-6923e499495b
00000000-0000-0000-0000-000000000000	162	grw464c3a3ss	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:19:22.861274+00	2026-06-17 22:19:22.861274+00	\N	b48fef0b-e2d0-462a-a050-fa9c0017ade3
00000000-0000-0000-0000-000000000000	163	axh5rhedzllg	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 22:29:49.194601+00	2026-06-17 22:29:49.194601+00	\N	257a233d-22a9-4a73-a7a8-836aa92eac87
00000000-0000-0000-0000-000000000000	164	ttlj2mgn5j4u	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:30:38.639892+00	2026-06-17 22:30:38.639892+00	\N	3172e3f5-06a9-469a-ae3f-11a36242fb2e
00000000-0000-0000-0000-000000000000	165	sklhzgllyntf	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:30:51.578201+00	2026-06-17 22:30:51.578201+00	\N	95e2fec5-9533-4575-ae5d-29641e24cd05
00000000-0000-0000-0000-000000000000	166	54zcdqckfgw7	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:33:59.413723+00	2026-06-17 22:33:59.413723+00	\N	01eb5eb7-d13d-4653-8aa7-840805aca640
00000000-0000-0000-0000-000000000000	167	khzkak2fawyf	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 22:34:51.2816+00	2026-06-17 22:34:51.2816+00	\N	f1b58aa7-2ac6-42d2-af30-50c410aa129b
00000000-0000-0000-0000-000000000000	168	viyu3y2ca6on	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:35:14.904267+00	2026-06-17 22:35:14.904267+00	\N	1ffc30d6-194b-4872-8042-4e7d50f9ab26
00000000-0000-0000-0000-000000000000	169	shwpourxqcte	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	f	2026-06-17 22:37:23.035707+00	2026-06-17 22:37:23.035707+00	\N	5321df84-0475-4ff0-af99-e5cadd376c2d
00000000-0000-0000-0000-000000000000	170	jqo3h5id5i6n	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:45:28.280012+00	2026-06-17 22:45:28.280012+00	\N	1ec80d2d-ec0a-496e-9f20-a2e5d58b50a4
00000000-0000-0000-0000-000000000000	171	yv6dkrobcmpa	85d2a767-bae1-4a79-8dda-cbe035239f5a	f	2026-06-17 22:53:30.46984+00	2026-06-17 22:53:30.46984+00	sh7wvcekbyxe	c004f20d-f82b-41fb-b9ea-6f7618a1f411
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
d7e6ab71-831b-454d-997d-b7d173532006	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-03 23:15:28.810605+00	2026-06-03 23:15:28.810605+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
f50cac38-606e-4909-a97e-9c1a122d5455	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 00:35:38.685621+00	2026-06-04 00:35:38.685621+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
b822a16a-e95e-40a0-94bd-71e7fa074c6c	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 00:36:27.574705+00	2026-06-04 00:36:27.574705+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
af25c4fd-ff97-4f09-b710-69ab865cee82	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 00:42:53.399938+00	2026-06-04 21:29:23.725395+00	\N	aal1	\N	2026-06-04 21:29:23.725195	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
b802b007-0513-416e-bbd8-3da7674b6250	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 21:30:01.822415+00	2026-06-04 21:30:01.822415+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
c70a087b-6313-49af-acf3-8f9ca415cae1	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-04 21:30:18.61058+00	2026-06-04 21:30:18.61058+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.122.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
0ffa0d53-847c-4881-91d2-521dd2c767b8	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 21:31:21.652816+00	2026-06-04 21:31:21.652816+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
4dc82aa0-1726-45d8-ba5b-535f29df7a73	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-04 21:35:01.41587+00	2026-06-04 21:35:01.41587+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.122.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
87f7cc91-441c-4a36-a721-171a6e85a77d	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-04 22:14:44.908015+00	2026-06-04 22:14:44.908015+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.122.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
70ad533d-077e-4735-92ec-529463b9e7df	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:18:47.561584+00	2026-06-17 19:12:47.937432+00	\N	aal1	\N	2026-06-17 19:12:47.937288	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
e4a5ec35-5dfc-4d4a-9f8e-a12fa3cc5a60	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-04 22:32:51.039381+00	2026-06-17 19:22:54.494481+00	\N	aal1	\N	2026-06-17 19:22:54.494399	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
3fe9a5ce-8437-4001-9653-ea143cdf59cf	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 19:23:35.500819+00	2026-06-17 19:23:35.500819+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
3e91f91d-0d9f-442f-b3de-ae9c2d03fd92	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 20:08:02.797163+00	2026-06-17 20:08:02.797163+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
f03e16bd-f5df-42c2-97eb-04bfb754e09a	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 20:23:24.51091+00	2026-06-17 20:23:24.51091+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
0e054ed3-a822-42a1-8c46-9500f1d14ac6	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 20:29:19.798219+00	2026-06-17 20:29:19.798219+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
9a434b02-58bb-4897-a4b2-b782f08abe87	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 20:31:38.035985+00	2026-06-17 20:31:38.035985+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
17e2e8c0-d752-4726-b831-a964a16e1b0f	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 20:37:17.325474+00	2026-06-17 20:37:17.325474+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
c34b4d91-5e15-4241-a054-310886824f68	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:28:12.515891+00	2026-06-17 21:28:12.515891+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
b25828d3-be5e-4886-b7a8-39dfdc89c44d	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:37:05.159809+00	2026-06-17 21:37:05.159809+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
0a379722-0236-4558-8024-178ebac36037	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:49:30.809552+00	2026-06-17 21:49:30.809552+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
a71286aa-a1ff-4e98-8c9e-b38d076b02b5	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:51:01.597999+00	2026-06-17 21:51:01.597999+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
d90f5c1e-f9c4-4135-87e5-ab42a549b99c	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 20:07:29.870357+00	2026-06-17 21:51:14.66487+00	\N	aal1	\N	2026-06-17 21:51:14.66478	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
afc1bffc-3244-4697-a5f4-7a9df400bad8	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:51:41.2046+00	2026-06-17 21:51:41.2046+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
d4d2f338-3ecc-4cc1-baa5-12b71663c2f7	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:51:59.165963+00	2026-06-17 21:51:59.165963+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
6b671b60-3dfd-4c05-a93f-1d629352673b	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:52:47.502385+00	2026-06-17 21:52:47.502385+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
25324f76-1a0d-47c0-bb07-8c147a0191c2	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:58:03.652762+00	2026-06-17 21:58:03.652762+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
07d5061d-73f4-4be9-a464-7743d4e235c6	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:02:06.406102+00	2026-06-17 22:02:06.406102+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
83e2c36d-b227-4ad7-b7d9-f23dea8faf46	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:13:36.02486+00	2026-06-17 22:13:36.02486+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
c83dc760-8f67-4631-8244-b9aee066195c	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 22:15:24.900272+00	2026-06-17 22:15:24.900272+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
a4004d79-8ac8-4812-b421-6923e499495b	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:17:55.052346+00	2026-06-17 22:17:55.052346+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
b48fef0b-e2d0-462a-a050-fa9c0017ade3	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:19:22.85941+00	2026-06-17 22:19:22.85941+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
257a233d-22a9-4a73-a7a8-836aa92eac87	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 22:29:49.192337+00	2026-06-17 22:29:49.192337+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
3172e3f5-06a9-469a-ae3f-11a36242fb2e	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:30:38.637281+00	2026-06-17 22:30:38.637281+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
95e2fec5-9533-4575-ae5d-29641e24cd05	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:30:51.575999+00	2026-06-17 22:30:51.575999+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
01eb5eb7-d13d-4653-8aa7-840805aca640	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:33:59.411863+00	2026-06-17 22:33:59.411863+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
f1b58aa7-2ac6-42d2-af30-50c410aa129b	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 22:34:51.279802+00	2026-06-17 22:34:51.279802+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
1ffc30d6-194b-4872-8042-4e7d50f9ab26	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:35:14.901846+00	2026-06-17 22:35:14.901846+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
5321df84-0475-4ff0-af99-e5cadd376c2d	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 22:37:23.033924+00	2026-06-17 22:37:23.033924+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
1ec80d2d-ec0a-496e-9f20-a2e5d58b50a4	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:45:28.278129+00	2026-06-17 22:45:28.278129+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.125.0 Chrome/148.0.7778.97 Electron/42.2.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
c004f20d-f82b-41fb-b9ea-6f7618a1f411	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 19:13:45.291471+00	2026-06-17 22:53:30.472467+00	\N	aal1	\N	2026-06-17 22:53:30.472407	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36	172.18.0.1	\N	\N	\N	\N	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	dbf26535-d542-4c77-9151-d39dbad967cd	authenticated	authenticated	oshaip@inv.local	$2a$10$c6246pHB.GFzH0mZWGRUzeuFpvwge6LIiuosvEyJwlBbfbJwz/c5S	2026-06-04 21:35:31.22963+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"username": "oshaip", "full_name": "oshaip alselwi", "email_verified": true}	\N	2026-06-04 21:35:31.202601+00	2026-06-04 21:35:31.233199+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	a36f3f23-61d5-4b30-8573-23d6a3fc2273	authenticated	authenticated	salah@inv.local	$2a$10$SkGMuEmZ87bgtPdflsbIi.X7xvUitBg6JS1kx5NCgIii2MT4Gpc3y	2026-06-01 21:48:13.951156+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"username": "salah", "full_name": "صلاح الدين طربوش", "email_verified": true}	\N	2026-06-01 21:48:13.943483+00	2026-06-01 21:48:13.951986+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	authenticated	authenticated	alselwi@inv.local	$2a$10$q3yn7/iHSaHvPHom4lz1ie003LSmTYpca6H6GKXgv8.vNfvQwzfna	2026-06-01 23:12:43.664055+00	\N		\N		\N			\N	2026-06-17 22:37:23.033872+00	{"provider": "email", "providers": ["email"]}	{"username": "alselwi", "full_name": "hussein alselwi", "email_verified": true}	\N	2026-06-01 23:12:43.653698+00	2026-06-17 22:37:23.036926+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	85d2a767-bae1-4a79-8dda-cbe035239f5a	authenticated	authenticated	admin@inv.local	$2a$10$ceg1Bai9uS9B7xk7wwu5peDSrXnvmwRdr64onqTcp48b1jCMMwAk.	2026-05-29 22:13:49.003867+00	\N		\N		\N			\N	2026-06-17 22:45:28.27807+00	{"provider": "email", "providers": ["email"]}	{"sub": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "email": "admin@inv.local", "username": "admin", "full_name": "Admin", "email_verified": true, "phone_verified": false}	\N	2026-05-29 22:13:48.990077+00	2026-06-17 22:53:30.470975+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, table_name, record_id, action, changed_by, changed_at, diff) FROM stdin;
c29960a8-cafb-4fc1-9c6b-f5ad1d0c9cca	categories	eec82ece-08e0-4d63-ad41-b758484d8832	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-05-30 19:57:01.435791+00	{"after": {"id": "eec82ece-08e0-4d63-ad41-b758484d8832", "name_ar": "Audit Test", "name_en": null, "parent_id": null, "created_at": "2026-05-30T18:34:33.401+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T19:57:01.435791+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "before": {"id": "eec82ece-08e0-4d63-ad41-b758484d8832", "name_ar": "Audit Test تجريبي", "name_en": null, "parent_id": null, "created_at": "2026-05-30T18:34:33.401+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T18:43:06.119627+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "changes": [{"new": "Audit Test", "old": "Audit Test تجريبي", "field": "name_ar"}, {"new": "2026-05-30T19:57:01.435791+00:00", "old": "2026-05-30T18:43:06.119627+00:00", "field": "updated_at"}]}
0b55120c-d1f4-48a6-81b8-ce171b83bfee	customers	a17c7bc8-243b-4a9d-a7d7-f0555a783a38	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-05-30 19:57:09.413555+00	{"after": null, "before": {"id": "a17c7bc8-243b-4a9d-a7d7-f0555a783a38", "name": "تجريبي", "notes": "هذا العميل تجريبي ", "phone": "771310424", "created_at": "2026-05-30T18:37:57.407537+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T18:37:57.407537+00:00", "updated_by": null}, "changes": [{"new": null, "old": "2026-05-30T18:37:57.407537+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "a17c7bc8-243b-4a9d-a7d7-f0555a783a38", "field": "id"}, {"new": null, "old": "تجريبي", "field": "name"}, {"new": null, "old": "هذا العميل تجريبي ", "field": "notes"}, {"new": null, "old": "771310424", "field": "phone"}, {"new": null, "old": "2026-05-30T18:37:57.407537+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
84fbb7f7-ae89-4742-ac55-8e50cfa77ac7	customers	be9e96dc-6493-487b-a5af-3fd05734753e	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-05-30 19:57:24.134029+00	{"after": {"id": "be9e96dc-6493-487b-a5af-3fd05734753e", "name": "تجريبي", "notes": "هذا العميل تجريبي", "phone": "771310424", "created_at": "2026-05-30T19:57:24.134029+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T19:57:24.134029+00:00", "updated_by": null}, "before": null, "changes": [{"new": "2026-05-30T19:57:24.134029+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "be9e96dc-6493-487b-a5af-3fd05734753e", "old": null, "field": "id"}, {"new": "تجريبي", "old": null, "field": "name"}, {"new": "هذا العميل تجريبي", "old": null, "field": "notes"}, {"new": "771310424", "old": null, "field": "phone"}, {"new": "2026-05-30T19:57:24.134029+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
9d496217-b11f-4540-81f7-761124224661	profiles	c11a79d7-bb34-4320-8a7d-7a0f6be3d194	update	\N	2026-06-01 21:30:56.8957+00	{"after": {"id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "locale": "ar", "username": "aboali", "full_name": "abo ali", "is_active": true, "created_at": "2026-06-01T21:30:56.859039+00:00", "updated_at": "2026-06-01T21:30:56.8957+00:00"}, "before": {"id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "locale": "ar", "username": "aboali", "full_name": "abo ali", "is_active": true, "created_at": "2026-06-01T21:30:56.859039+00:00", "updated_at": "2026-06-01T21:30:56.859039+00:00"}, "changes": [{"new": "2026-06-01T21:30:56.8957+00:00", "old": "2026-06-01T21:30:56.859039+00:00", "field": "updated_at"}]}
a11a66b9-af74-4316-9cb7-b075ee40e384	profiles	fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1	delete	\N	2026-06-01 21:32:34.357439+00	{"after": null, "before": {"id": "fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1", "locale": "ar", "username": "ali", "full_name": "ali", "is_active": true, "created_at": "2026-05-30T01:00:01.086138+00:00", "updated_at": "2026-05-30T01:00:01.086138+00:00"}, "changes": [{"new": null, "old": "2026-05-30T01:00:01.086138+00:00", "field": "created_at"}, {"new": null, "old": "ali", "field": "full_name"}, {"new": null, "old": "fad1e4a8-872c-44cb-8af4-7bcaf8b94dd1", "field": "id"}, {"new": null, "old": true, "field": "is_active"}, {"new": null, "old": "ar", "field": "locale"}, {"new": null, "old": "2026-05-30T01:00:01.086138+00:00", "field": "updated_at"}, {"new": null, "old": "ali", "field": "username"}]}
199bc5fa-4f15-4af6-8685-717ab10278f4	profiles	a36f3f23-61d5-4b30-8573-23d6a3fc2273	insert	\N	2026-06-01 21:48:13.943211+00	{"after": {"id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طربوش", "is_active": true, "created_at": "2026-06-01T21:48:13.943211+00:00", "updated_at": "2026-06-01T21:48:13.943211+00:00"}, "before": null, "changes": [{"new": "2026-06-01T21:48:13.943211+00:00", "old": null, "field": "created_at"}, {"new": "صلاح الدين طربوش", "old": null, "field": "full_name"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-01T21:48:13.943211+00:00", "old": null, "field": "updated_at"}, {"new": "salah", "old": null, "field": "username"}]}
57b8f2d4-49a2-437b-a9e8-81188324fd62	profiles	a36f3f23-61d5-4b30-8573-23d6a3fc2273	update	\N	2026-06-01 21:48:13.972822+00	{"after": {"id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طربوش", "is_active": true, "created_at": "2026-06-01T21:48:13.943211+00:00", "updated_at": "2026-06-01T21:48:13.972822+00:00"}, "before": {"id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طربوش", "is_active": true, "created_at": "2026-06-01T21:48:13.943211+00:00", "updated_at": "2026-06-01T21:48:13.943211+00:00"}, "changes": [{"new": "2026-06-01T21:48:13.972822+00:00", "old": "2026-06-01T21:48:13.943211+00:00", "field": "updated_at"}]}
ea8c1f91-023c-404c-8caf-cd9590455d2c	profiles	fcd49be9-d3ad-44bf-af22-2c3bca9599f2	insert	\N	2026-06-01 22:00:57.104971+00	{"after": {"id": "fcd49be9-d3ad-44bf-af22-2c3bca9599f2", "locale": "ar", "username": "tarboosh", "full_name": "tarboosh alselwi", "is_active": true, "created_at": "2026-06-01T22:00:57.104971+00:00", "updated_at": "2026-06-01T22:00:57.104971+00:00"}, "before": null, "changes": [{"new": "2026-06-01T22:00:57.104971+00:00", "old": null, "field": "created_at"}, {"new": "tarboosh alselwi", "old": null, "field": "full_name"}, {"new": "fcd49be9-d3ad-44bf-af22-2c3bca9599f2", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-01T22:00:57.104971+00:00", "old": null, "field": "updated_at"}, {"new": "tarboosh", "old": null, "field": "username"}]}
cbf908e8-2202-4e5d-9466-db338e58dc91	user_permission_groups	\N	insert	\N	2026-06-01 23:11:40.83406+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7"}, "before": null, "changes": [{"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
9c4f254a-b941-4408-b96d-921cc8e63a2d	suppliers	c342befe-7a43-448e-aeb8-894768037270	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-05-30 20:26:36.833482+00	{"after": {"id": "c342befe-7a43-448e-aeb8-894768037270", "name": "احمد الاشول", "notes": "تجريبي", "phone": "777777000", "created_at": "2026-05-30T20:26:36.833482+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T20:26:36.833482+00:00", "updated_by": null}, "before": null, "changes": [{"new": "2026-05-30T20:26:36.833482+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "id"}, {"new": "احمد الاشول", "old": null, "field": "name"}, {"new": "تجريبي", "old": null, "field": "notes"}, {"new": "777777000", "old": null, "field": "phone"}, {"new": "2026-05-30T20:26:36.833482+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
4f96f67b-7fbd-4a82-b95e-ab444f4e7d29	purchase_invoices	8d62725d-b45f-4286-98a3-6085a9092622	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:34:29.421484+00	{"after": {"id": "8d62725d-b45f-4286-98a3-6085a9092622", "notes": null, "created_at": "2026-06-01T19:34:29.421484+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "155134", "updated_at": "2026-06-01T19:34:29.421484+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 25680.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 48.0000}, "before": null, "changes": [{"new": "2026-06-01T19:34:29.421484+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "8d62725d-b45f-4286-98a3-6085a9092622", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "155134", "old": null, "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 48.0000, "old": null, "field": "total_foreign"}, {"new": 25680.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T19:34:29.421484+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
0ef1c460-8f16-451a-a73d-c180d6184642	purchase_invoices	d4e2b7fc-208f-4536-83e7-74f1de4876d4	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:34:35.723189+00	{"after": {"id": "d4e2b7fc-208f-4536-83e7-74f1de4876d4", "notes": null, "created_at": "2026-06-01T19:34:35.723189+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "155134", "updated_at": "2026-06-01T19:34:35.723189+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 25680.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 48.0000}, "before": null, "changes": [{"new": "2026-06-01T19:34:35.723189+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "d4e2b7fc-208f-4536-83e7-74f1de4876d4", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "155134", "old": null, "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 48.0000, "old": null, "field": "total_foreign"}, {"new": 25680.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T19:34:35.723189+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
bc19754c-8b9f-46b6-96c0-993227cad366	purchase_invoices	c9eae51c-a960-4dde-a146-0e92bb4f8251	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:34:41.659218+00	{"after": {"id": "c9eae51c-a960-4dde-a146-0e92bb4f8251", "notes": null, "created_at": "2026-06-01T19:34:41.659218+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "155134", "updated_at": "2026-06-01T19:34:41.659218+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 25680.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 48.0000}, "before": null, "changes": [{"new": "2026-06-01T19:34:41.659218+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "c9eae51c-a960-4dde-a146-0e92bb4f8251", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "155134", "old": null, "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 48.0000, "old": null, "field": "total_foreign"}, {"new": 25680.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T19:34:41.659218+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
b97cd03e-c9e4-41fd-843d-a62c79edd183	purchase_invoices	8d62725d-b45f-4286-98a3-6085a9092622	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:35:37.784983+00	{"after": null, "before": {"id": "8d62725d-b45f-4286-98a3-6085a9092622", "notes": null, "created_at": "2026-06-01T19:34:29.421484+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "155134", "updated_at": "2026-06-01T19:34:29.421484+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 25680.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 48.0000}, "changes": [{"new": null, "old": "2026-06-01T19:34:29.421484+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "USD", "field": "currency_code"}, {"new": null, "old": 535.000000, "field": "exchange_rate"}, {"new": null, "old": "8d62725d-b45f-4286-98a3-6085a9092622", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "155134", "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": "credit", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 48.0000, "field": "total_foreign"}, {"new": null, "old": 25680.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T19:34:29.421484+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
42ec3650-331e-48f3-8e7c-59945b430bb9	purchase_invoices	d4e2b7fc-208f-4536-83e7-74f1de4876d4	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:35:41.787931+00	{"after": null, "before": {"id": "d4e2b7fc-208f-4536-83e7-74f1de4876d4", "notes": null, "created_at": "2026-06-01T19:34:35.723189+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "155134", "updated_at": "2026-06-01T19:34:35.723189+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 25680.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 48.0000}, "changes": [{"new": null, "old": "2026-06-01T19:34:35.723189+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "USD", "field": "currency_code"}, {"new": null, "old": 535.000000, "field": "exchange_rate"}, {"new": null, "old": "d4e2b7fc-208f-4536-83e7-74f1de4876d4", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "155134", "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": "credit", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 48.0000, "field": "total_foreign"}, {"new": null, "old": 25680.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T19:34:35.723189+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
f2fb74a3-a536-4029-9966-956b48aac3c5	purchase_invoices	c9eae51c-a960-4dde-a146-0e92bb4f8251	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:35:44.577532+00	{"after": null, "before": {"id": "c9eae51c-a960-4dde-a146-0e92bb4f8251", "notes": null, "created_at": "2026-06-01T19:34:41.659218+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "155134", "updated_at": "2026-06-01T19:34:41.659218+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 25680.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 48.0000}, "changes": [{"new": null, "old": "2026-06-01T19:34:41.659218+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "USD", "field": "currency_code"}, {"new": null, "old": 535.000000, "field": "exchange_rate"}, {"new": null, "old": "c9eae51c-a960-4dde-a146-0e92bb4f8251", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "155134", "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": "credit", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 48.0000, "field": "total_foreign"}, {"new": null, "old": 25680.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T19:34:41.659218+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
152e089e-293f-48a6-bade-3801e16a0026	purchase_invoices	6f46e176-60fb-48bb-ad78-06b71ccdcba7	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:36:36.203483+00	{"after": {"id": "6f46e176-60fb-48bb-ad78-06b71ccdcba7", "notes": null, "created_at": "2026-06-01T19:36:36.203483+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "115", "updated_at": "2026-06-01T19:36:36.203483+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 21400.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 40.0000}, "before": null, "changes": [{"new": "2026-06-01T19:36:36.203483+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "6f46e176-60fb-48bb-ad78-06b71ccdcba7", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "115", "old": null, "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 40.0000, "old": null, "field": "total_foreign"}, {"new": 21400.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T19:36:36.203483+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
419dd072-8b13-4332-9e4e-bef5430e5bf5	purchase_invoices	4972b0fd-3a26-4f01-8847-5c4afab7fed2	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:50:00.266186+00	{"after": {"id": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "notes": "test invoice", "created_at": "2026-06-01T19:50:00.266186+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "TEST-INV-001", "updated_at": "2026-06-01T19:50:00.266186+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 10.0000, "invoice_date": "2026-06-01", "payment_type": "cash", "currency_code": "YER", "exchange_rate": 1.000000, "total_foreign": 10.0000}, "before": null, "changes": [{"new": "2026-06-01T19:50:00.266186+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "YER", "old": null, "field": "currency_code"}, {"new": 1.000000, "old": null, "field": "exchange_rate"}, {"new": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "TEST-INV-001", "old": null, "field": "invoice_no"}, {"new": "test invoice", "old": null, "field": "notes"}, {"new": "cash", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 10.0000, "old": null, "field": "total_foreign"}, {"new": 10.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T19:50:00.266186+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
7f412c4c-a324-4d01-afb7-b7e9d3b46768	purchase_invoice_items	bb37bc71-1e7e-42fc-9243-435693858a85	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:50:00.266186+00	{"after": {"id": "bb37bc71-1e7e-42fc-9243-435693858a85", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 2.0000, "created_at": "2026-06-01T19:50:00.266186+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "updated_by": null, "price_local": 5.0000, "price_foreign": 5.0000, "line_total_local": 10.0000}, "before": null, "changes": [{"new": "2026-06-01T19:50:00.266186+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "bb37bc71-1e7e-42fc-9243-435693858a85", "old": null, "field": "id"}, {"new": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 10.0000, "old": null, "field": "line_total_local"}, {"new": 5.0000, "old": null, "field": "price_foreign"}, {"new": 5.0000, "old": null, "field": "price_local"}, {"new": 2.0000, "old": null, "field": "quantity"}, {"new": null, "old": null, "field": "updated_by"}]}
b42be2f9-0550-46e5-8d89-6b7b3bcf33cd	stock_movements	c99c5d6b-fa89-4899-accc-2b9055e06f00	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:50:00.266186+00	{"after": {"id": "c99c5d6b-fa89-4899-accc-2b9055e06f00", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 2.0000, "created_at": "2026-06-01T19:50:00.266186+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5.0000}, "before": null, "changes": [{"new": "2026-06-01T19:50:00.266186+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "c99c5d6b-fa89-4899-accc-2b9055e06f00", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 2.0000, "old": null, "field": "quantity"}, {"new": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5.0000, "old": null, "field": "unit_price_local"}]}
7dbbbb8d-9651-4782-a6a0-30ccbc07edff	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:50:00.266186+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T19:50:00.266186+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T17:52:57.842588+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 0.0000}, "changes": [{"new": 5.0000, "old": 0.0000, "field": "last_purchase_price_local"}, {"new": "2026-06-01T19:50:00.266186+00:00", "old": "2026-05-30T17:52:57.842588+00:00", "field": "updated_at"}]}
9ad3d4fa-4594-4af6-a793-4debd92221bd	purchase_invoices	f1834587-c99b-4a20-86c7-02fbce303021	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:52:19.411159+00	{"after": {"id": "f1834587-c99b-4a20-86c7-02fbce303021", "notes": "test", "created_at": "2026-06-01T19:52:19.411159+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "100", "updated_at": "2026-06-01T19:52:19.411159+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 42800.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 80.0000}, "before": null, "changes": [{"new": "2026-06-01T19:52:19.411159+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "f1834587-c99b-4a20-86c7-02fbce303021", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "100", "old": null, "field": "invoice_no"}, {"new": "test", "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 80.0000, "old": null, "field": "total_foreign"}, {"new": 42800.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T19:52:19.411159+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
a0becf48-6e5b-4df1-a3a8-fd29ca0eb436	purchase_invoice_items	0cf658fd-f22f-430f-be4e-622655db9f46	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:52:19.44098+00	{"after": {"id": "0cf658fd-f22f-430f-be4e-622655db9f46", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 8.0000, "created_at": "2026-06-01T19:52:19.44098+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "f1834587-c99b-4a20-86c7-02fbce303021", "updated_by": null, "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 42800.0000}, "before": null, "changes": [{"new": "2026-06-01T19:52:19.44098+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "0cf658fd-f22f-430f-be4e-622655db9f46", "old": null, "field": "id"}, {"new": "f1834587-c99b-4a20-86c7-02fbce303021", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 42800.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 8.0000, "old": null, "field": "quantity"}, {"new": null, "old": null, "field": "updated_by"}]}
5897d0b8-d9ca-493b-9746-0f4b0af12f89	stock_movements	1a4ca682-8652-40cc-a52c-f7a6103679e0	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:52:19.44098+00	{"after": {"id": "1a4ca682-8652-40cc-a52c-f7a6103679e0", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 8.0000, "created_at": "2026-06-01T19:52:19.44098+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "f1834587-c99b-4a20-86c7-02fbce303021", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T19:52:19.44098+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "1a4ca682-8652-40cc-a52c-f7a6103679e0", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 8.0000, "old": null, "field": "quantity"}, {"new": "f1834587-c99b-4a20-86c7-02fbce303021", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
3116d579-6759-4394-8f54-a3ec118b26df	profiles	98289d34-511f-4600-8f62-3b01a53a4f30	delete	\N	2026-06-01 21:32:24.912777+00	{"after": null, "before": {"id": "98289d34-511f-4600-8f62-3b01a53a4f30", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طرووش", "is_active": true, "created_at": "2026-06-01T21:26:07.083529+00:00", "updated_at": "2026-06-01T21:26:07.118861+00:00"}, "changes": [{"new": null, "old": "2026-06-01T21:26:07.083529+00:00", "field": "created_at"}, {"new": null, "old": "صلاح الدين طرووش", "field": "full_name"}, {"new": null, "old": "98289d34-511f-4600-8f62-3b01a53a4f30", "field": "id"}, {"new": null, "old": true, "field": "is_active"}, {"new": null, "old": "ar", "field": "locale"}, {"new": null, "old": "2026-06-01T21:26:07.118861+00:00", "field": "updated_at"}, {"new": null, "old": "salah", "field": "username"}]}
50e83f9b-8000-4846-a084-5ace6f4ad104	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:52:19.44098+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T19:52:19.44098+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T19:50:00.266186+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5.0000}, "changes": [{"new": 5350.0000, "old": 5.0000, "field": "last_purchase_price_local"}, {"new": "2026-06-01T19:52:19.44098+00:00", "old": "2026-06-01T19:50:00.266186+00:00", "field": "updated_at"}]}
1569fe5b-9eb7-4b17-8863-008b6b15cccd	stock_movements	1a4ca682-8652-40cc-a52c-f7a6103679e0	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:01.618221+00	{"after": null, "before": {"id": "1a4ca682-8652-40cc-a52c-f7a6103679e0", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 8.0000, "created_at": "2026-06-01T19:52:19.44098+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "f1834587-c99b-4a20-86c7-02fbce303021", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "changes": [{"new": null, "old": "2026-06-01T19:52:19.44098+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "1a4ca682-8652-40cc-a52c-f7a6103679e0", "field": "id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": "2026-06-01", "field": "movement_date"}, {"new": null, "old": "purchase", "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": 8.0000, "field": "quantity"}, {"new": null, "old": "f1834587-c99b-4a20-86c7-02fbce303021", "field": "reference_id"}, {"new": null, "old": "purchase_invoices", "field": "reference_table"}, {"new": null, "old": 5350.0000, "field": "unit_price_local"}]}
90fdb26d-94d4-49b9-8fcb-1b40fd7569e3	purchase_invoices	f1834587-c99b-4a20-86c7-02fbce303021	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:01.618221+00	{"after": null, "before": {"id": "f1834587-c99b-4a20-86c7-02fbce303021", "notes": "test", "created_at": "2026-06-01T19:52:19.411159+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "100", "updated_at": "2026-06-01T19:52:19.411159+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 42800.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 80.0000}, "changes": [{"new": null, "old": "2026-06-01T19:52:19.411159+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "USD", "field": "currency_code"}, {"new": null, "old": 535.000000, "field": "exchange_rate"}, {"new": null, "old": "f1834587-c99b-4a20-86c7-02fbce303021", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "100", "field": "invoice_no"}, {"new": null, "old": "test", "field": "notes"}, {"new": null, "old": "credit", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 80.0000, "field": "total_foreign"}, {"new": null, "old": 42800.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T19:52:19.411159+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
8f300d70-270b-4e82-83ab-2f3d7633ed25	purchase_invoice_items	0cf658fd-f22f-430f-be4e-622655db9f46	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:01.618221+00	{"after": null, "before": {"id": "0cf658fd-f22f-430f-be4e-622655db9f46", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 8.0000, "created_at": "2026-06-01T19:52:19.44098+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "f1834587-c99b-4a20-86c7-02fbce303021", "updated_by": null, "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 42800.0000}, "changes": [{"new": null, "old": "2026-06-01T19:52:19.44098+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "0cf658fd-f22f-430f-be4e-622655db9f46", "field": "id"}, {"new": null, "old": "f1834587-c99b-4a20-86c7-02fbce303021", "field": "invoice_id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": 42800.0000, "field": "line_total_local"}, {"new": null, "old": 10.0000, "field": "price_foreign"}, {"new": null, "old": 5350.0000, "field": "price_local"}, {"new": null, "old": 8.0000, "field": "quantity"}, {"new": null, "old": null, "field": "updated_by"}]}
facfd366-25c3-4463-9cf1-414fc0e2dd15	stock_movements	c99c5d6b-fa89-4899-accc-2b9055e06f00	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:05.109932+00	{"after": null, "before": {"id": "c99c5d6b-fa89-4899-accc-2b9055e06f00", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 2.0000, "created_at": "2026-06-01T19:50:00.266186+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5.0000}, "changes": [{"new": null, "old": "2026-06-01T19:50:00.266186+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "c99c5d6b-fa89-4899-accc-2b9055e06f00", "field": "id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": "2026-06-01", "field": "movement_date"}, {"new": null, "old": "purchase", "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": 2.0000, "field": "quantity"}, {"new": null, "old": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "field": "reference_id"}, {"new": null, "old": "purchase_invoices", "field": "reference_table"}, {"new": null, "old": 5.0000, "field": "unit_price_local"}]}
4a8c238a-b688-45b7-b65a-b747eb2a423c	profiles	8ef3ddb7-80d2-4e16-b70d-6c6aa57e1305	delete	\N	2026-06-01 21:32:31.016194+00	{"after": null, "before": {"id": "8ef3ddb7-80d2-4e16-b70d-6c6aa57e1305", "locale": "ar", "username": "alselwi", "full_name": "حسين الصلوي", "is_active": true, "created_at": "2026-05-30T19:25:16.776624+00:00", "updated_at": "2026-05-30T19:25:16.776624+00:00"}, "changes": [{"new": null, "old": "2026-05-30T19:25:16.776624+00:00", "field": "created_at"}, {"new": null, "old": "حسين الصلوي", "field": "full_name"}, {"new": null, "old": "8ef3ddb7-80d2-4e16-b70d-6c6aa57e1305", "field": "id"}, {"new": null, "old": true, "field": "is_active"}, {"new": null, "old": "ar", "field": "locale"}, {"new": null, "old": "2026-05-30T19:25:16.776624+00:00", "field": "updated_at"}, {"new": null, "old": "alselwi", "field": "username"}]}
f91b738b-5552-4114-8786-33dd892d13c3	purchase_invoices	4972b0fd-3a26-4f01-8847-5c4afab7fed2	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:05.109932+00	{"after": null, "before": {"id": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "notes": "test invoice", "created_at": "2026-06-01T19:50:00.266186+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "TEST-INV-001", "updated_at": "2026-06-01T19:50:00.266186+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 10.0000, "invoice_date": "2026-06-01", "payment_type": "cash", "currency_code": "YER", "exchange_rate": 1.000000, "total_foreign": 10.0000}, "changes": [{"new": null, "old": "2026-06-01T19:50:00.266186+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "YER", "field": "currency_code"}, {"new": null, "old": 1.000000, "field": "exchange_rate"}, {"new": null, "old": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "TEST-INV-001", "field": "invoice_no"}, {"new": null, "old": "test invoice", "field": "notes"}, {"new": null, "old": "cash", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 10.0000, "field": "total_foreign"}, {"new": null, "old": 10.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T19:50:00.266186+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
ab283711-b0da-473c-8f40-6012feaaa9a9	purchase_invoice_items	bb37bc71-1e7e-42fc-9243-435693858a85	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:05.109932+00	{"after": null, "before": {"id": "bb37bc71-1e7e-42fc-9243-435693858a85", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 2.0000, "created_at": "2026-06-01T19:50:00.266186+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "updated_by": null, "price_local": 5.0000, "price_foreign": 5.0000, "line_total_local": 10.0000}, "changes": [{"new": null, "old": "2026-06-01T19:50:00.266186+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "bb37bc71-1e7e-42fc-9243-435693858a85", "field": "id"}, {"new": null, "old": "4972b0fd-3a26-4f01-8847-5c4afab7fed2", "field": "invoice_id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": 10.0000, "field": "line_total_local"}, {"new": null, "old": 5.0000, "field": "price_foreign"}, {"new": null, "old": 5.0000, "field": "price_local"}, {"new": null, "old": 2.0000, "field": "quantity"}, {"new": null, "old": null, "field": "updated_by"}]}
79defcfb-6d2f-4e11-94bb-a7fd0c11798d	purchase_invoices	6f46e176-60fb-48bb-ad78-06b71ccdcba7	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 19:53:10.052414+00	{"after": null, "before": {"id": "6f46e176-60fb-48bb-ad78-06b71ccdcba7", "notes": null, "created_at": "2026-06-01T19:36:36.203483+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "115", "updated_at": "2026-06-01T19:36:36.203483+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 21400.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 40.0000}, "changes": [{"new": null, "old": "2026-06-01T19:36:36.203483+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "USD", "field": "currency_code"}, {"new": null, "old": 535.000000, "field": "exchange_rate"}, {"new": null, "old": "6f46e176-60fb-48bb-ad78-06b71ccdcba7", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "115", "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": "credit", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 40.0000, "field": "total_foreign"}, {"new": null, "old": 21400.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T19:36:36.203483+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
463b9e36-1a98-4128-a776-e0ef8a221349	purchase_invoices	02658347-c4e7-4c42-bdd9-40329ed2b48f	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.886948+00	{"after": {"id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "notes": "تجريبي ", "created_at": "2026-06-01T20:00:18.886948+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "100", "updated_at": "2026-06-01T20:00:18.886948+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 80250.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 150.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:18.886948+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "100", "old": null, "field": "invoice_no"}, {"new": "تجريبي ", "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "c342befe-7a43-448e-aeb8-894768037270", "old": null, "field": "supplier_id"}, {"new": 150.0000, "old": null, "field": "total_foreign"}, {"new": 80250.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T20:00:18.886948+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
9f3dc9d3-fd0a-4ab3-9270-0bd26d87a6ff	purchase_invoice_items	7b4e58fd-ab41-4785-9229-003b6fd46a0b	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.917223+00	{"after": {"id": "7b4e58fd-ab41-4785-9229-003b6fd46a0b", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 5.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 26750.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:18.917223+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "7b4e58fd-ab41-4785-9229-003b6fd46a0b", "old": null, "field": "id"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 26750.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 5.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
9a2769be-bcf2-4b43-a188-ae93cff8ba62	stock_movements	f4842e61-f3a3-4e19-9eef-efb1009a2799	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.917223+00	{"after": {"id": "f4842e61-f3a3-4e19-9eef-efb1009a2799", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 5.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:18.917223+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "f4842e61-f3a3-4e19-9eef-efb1009a2799", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 5.0000, "old": null, "field": "quantity"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
a4730e89-8c9e-444a-971a-81a3d2aff0f7	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.917223+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:18.917223+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T19:52:19.44098+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "changes": [{"new": "2026-06-01T20:00:18.917223+00:00", "old": "2026-06-01T19:52:19.44098+00:00", "field": "updated_at"}]}
d337860e-e267-4d00-a088-7243bd2d8ec2	purchase_invoice_items	12468ff5-25d4-46cc-b585-8d5d18a8e5d2	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.917223+00	{"after": {"id": "12468ff5-25d4-46cc-b585-8d5d18a8e5d2", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 53500.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:18.917223+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "12468ff5-25d4-46cc-b585-8d5d18a8e5d2", "old": null, "field": "id"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 53500.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 10.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
3a2ee053-92a6-4a1b-95b6-69652e482788	stock_movements	a58180e1-33ae-4045-b64f-4af394bdc799	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.917223+00	{"after": {"id": "a58180e1-33ae-4045-b64f-4af394bdc799", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:18.917223+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "a58180e1-33ae-4045-b64f-4af394bdc799", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 10.0000, "old": null, "field": "quantity"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
37104358-5e97-49ed-90cd-54d174a00c1e	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:18.917223+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:18.917223+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:18.917223+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "changes": []}
265f025a-6230-43d1-b9ce-7aead260f0e7	purchase_invoices	02658347-c4e7-4c42-bdd9-40329ed2b48f	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.87602+00	{"after": {"id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "notes": "تجريبي ", "created_at": "2026-06-01T20:00:18.886948+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "100", "updated_at": "2026-06-01T20:00:52.87602+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 133750.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 250.0000}, "before": {"id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "notes": "تجريبي ", "created_at": "2026-06-01T20:00:18.886948+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "100", "updated_at": "2026-06-01T20:00:18.886948+00:00", "updated_by": null, "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 80250.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 150.0000}, "changes": [{"new": 250.0000, "old": 150.0000, "field": "total_foreign"}, {"new": 133750.0000, "old": 80250.0000, "field": "total_local"}, {"new": "2026-06-01T20:00:52.87602+00:00", "old": "2026-06-01T20:00:18.886948+00:00", "field": "updated_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
460b608c-375b-4bc4-9225-7e48c5803eb0	stock_movements	f4842e61-f3a3-4e19-9eef-efb1009a2799	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.903128+00	{"after": null, "before": {"id": "f4842e61-f3a3-4e19-9eef-efb1009a2799", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 5.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:18.917223+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "f4842e61-f3a3-4e19-9eef-efb1009a2799", "field": "id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": "2026-06-01", "field": "movement_date"}, {"new": null, "old": "purchase", "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": 5.0000, "field": "quantity"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "reference_id"}, {"new": null, "old": "purchase_invoices", "field": "reference_table"}, {"new": null, "old": 5350.0000, "field": "unit_price_local"}]}
a94c8a83-c481-452f-a6e2-64697067e15d	stock_movements	a58180e1-33ae-4045-b64f-4af394bdc799	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.903128+00	{"after": null, "before": {"id": "a58180e1-33ae-4045-b64f-4af394bdc799", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:18.917223+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "a58180e1-33ae-4045-b64f-4af394bdc799", "field": "id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": "2026-06-01", "field": "movement_date"}, {"new": null, "old": "purchase", "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": 10.0000, "field": "quantity"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "reference_id"}, {"new": null, "old": "purchase_invoices", "field": "reference_table"}, {"new": null, "old": 5350.0000, "field": "unit_price_local"}]}
e5ca86c2-8cbd-4742-a5d7-c46b6fbf253c	purchase_invoice_items	7b4e58fd-ab41-4785-9229-003b6fd46a0b	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.903128+00	{"after": null, "before": {"id": "7b4e58fd-ab41-4785-9229-003b6fd46a0b", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 5.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 26750.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:18.917223+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "7b4e58fd-ab41-4785-9229-003b6fd46a0b", "field": "id"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "invoice_id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": 26750.0000, "field": "line_total_local"}, {"new": null, "old": 10.0000, "field": "price_foreign"}, {"new": null, "old": 5350.0000, "field": "price_local"}, {"new": null, "old": 5.0000, "field": "quantity"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "updated_by"}]}
8997c095-ff99-4f5b-8de3-32ae63b44a99	purchase_invoice_items	12468ff5-25d4-46cc-b585-8d5d18a8e5d2	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.903128+00	{"after": null, "before": {"id": "12468ff5-25d4-46cc-b585-8d5d18a8e5d2", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:18.917223+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 53500.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:18.917223+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "12468ff5-25d4-46cc-b585-8d5d18a8e5d2", "field": "id"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "invoice_id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": 53500.0000, "field": "line_total_local"}, {"new": null, "old": 10.0000, "field": "price_foreign"}, {"new": null, "old": 5350.0000, "field": "price_local"}, {"new": null, "old": 10.0000, "field": "quantity"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "updated_by"}]}
9275875f-969a-46cc-8a0f-6cf1240238db	purchase_invoice_items	71af64c2-f413-4924-9c5a-baa06615ef90	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.930996+00	{"after": {"id": "71af64c2-f413-4924-9c5a-baa06615ef90", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 15.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 80250.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:52.930996+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "71af64c2-f413-4924-9c5a-baa06615ef90", "old": null, "field": "id"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 80250.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 15.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
528be7df-f599-4349-a810-171e80b62a0e	suppliers	c342befe-7a43-448e-aeb8-894768037270	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:15:45.514869+00	{"after": null, "before": {"id": "c342befe-7a43-448e-aeb8-894768037270", "name": "احمد الاشول", "notes": "تجريبي", "phone": "777777000", "created_at": "2026-05-30T20:26:36.833482+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-05-30T20:26:36.833482+00:00", "updated_by": null}, "changes": [{"new": null, "old": "2026-05-30T20:26:36.833482+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "id"}, {"new": null, "old": "احمد الاشول", "field": "name"}, {"new": null, "old": "تجريبي", "field": "notes"}, {"new": null, "old": "777777000", "field": "phone"}, {"new": null, "old": "2026-05-30T20:26:36.833482+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
15170bf8-77cf-4ed5-a61b-bf50997a3183	stock_movements	cc0223b8-b1d0-4c6c-8d9e-68371cbac567	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.930996+00	{"after": {"id": "cc0223b8-b1d0-4c6c-8d9e-68371cbac567", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 15.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:52.930996+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "cc0223b8-b1d0-4c6c-8d9e-68371cbac567", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 15.0000, "old": null, "field": "quantity"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
ed8c2639-6d87-465b-84fc-41519d0ff572	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.930996+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:52.930996+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:18.917223+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "changes": [{"new": "2026-06-01T20:00:52.930996+00:00", "old": "2026-06-01T20:00:18.917223+00:00", "field": "updated_at"}]}
c7582b6f-80ef-4a9b-8e38-e5f8463e51bc	purchase_invoice_items	5fb712f2-8608-4b08-9f78-1d6835d2eb31	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.930996+00	{"after": {"id": "5fb712f2-8608-4b08-9f78-1d6835d2eb31", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 53500.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:52.930996+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "5fb712f2-8608-4b08-9f78-1d6835d2eb31", "old": null, "field": "id"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 53500.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 10.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
6a02f5a1-6e95-4649-a9d2-785b927bff9a	stock_movements	aab8773b-e7fe-4532-995b-c3dc46607eb7	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.930996+00	{"after": {"id": "aab8773b-e7fe-4532-995b-c3dc46607eb7", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T20:00:52.930996+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "aab8773b-e7fe-4532-995b-c3dc46607eb7", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 10.0000, "old": null, "field": "quantity"}, {"new": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
0ecbc6e7-0a43-4269-93bb-16813555e112	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:00:52.930996+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:52.930996+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:52.930996+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "changes": []}
b85ecaa5-b73a-48a3-accc-c32a47f45915	stock_movements	cc0223b8-b1d0-4c6c-8d9e-68371cbac567	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:01:03.765101+00	{"after": null, "before": {"id": "cc0223b8-b1d0-4c6c-8d9e-68371cbac567", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 15.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:52.930996+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "cc0223b8-b1d0-4c6c-8d9e-68371cbac567", "field": "id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": "2026-06-01", "field": "movement_date"}, {"new": null, "old": "purchase", "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": 15.0000, "field": "quantity"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "reference_id"}, {"new": null, "old": "purchase_invoices", "field": "reference_table"}, {"new": null, "old": 5350.0000, "field": "unit_price_local"}]}
0c9b06c0-b437-4b03-8dd2-1a257cfd0919	stock_movements	aab8773b-e7fe-4532-995b-c3dc46607eb7	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:01:03.765101+00	{"after": null, "before": {"id": "aab8773b-e7fe-4532-995b-c3dc46607eb7", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:52.930996+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "aab8773b-e7fe-4532-995b-c3dc46607eb7", "field": "id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": "2026-06-01", "field": "movement_date"}, {"new": null, "old": "purchase", "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": null, "old": 10.0000, "field": "quantity"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "reference_id"}, {"new": null, "old": "purchase_invoices", "field": "reference_table"}, {"new": null, "old": 5350.0000, "field": "unit_price_local"}]}
00b6fca7-e06f-4776-9778-52895a378dca	purchase_invoices	02658347-c4e7-4c42-bdd9-40329ed2b48f	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:01:03.765101+00	{"after": null, "before": {"id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "notes": "تجريبي ", "created_at": "2026-06-01T20:00:18.886948+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "100", "updated_at": "2026-06-01T20:00:52.87602+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "supplier_id": "c342befe-7a43-448e-aeb8-894768037270", "total_local": 133750.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 250.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:18.886948+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "USD", "field": "currency_code"}, {"new": null, "old": 535.000000, "field": "exchange_rate"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "id"}, {"new": null, "old": "2026-06-01", "field": "invoice_date"}, {"new": null, "old": "100", "field": "invoice_no"}, {"new": null, "old": "تجريبي ", "field": "notes"}, {"new": null, "old": "credit", "field": "payment_type"}, {"new": null, "old": "c342befe-7a43-448e-aeb8-894768037270", "field": "supplier_id"}, {"new": null, "old": 250.0000, "field": "total_foreign"}, {"new": null, "old": 133750.0000, "field": "total_local"}, {"new": null, "old": "2026-06-01T20:00:52.87602+00:00", "field": "updated_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "updated_by"}]}
c18bce68-3635-49b3-97af-33cca11ee4a5	purchase_invoice_items	71af64c2-f413-4924-9c5a-baa06615ef90	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:01:03.765101+00	{"after": null, "before": {"id": "71af64c2-f413-4924-9c5a-baa06615ef90", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 15.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 80250.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:52.930996+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "71af64c2-f413-4924-9c5a-baa06615ef90", "field": "id"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "invoice_id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": 80250.0000, "field": "line_total_local"}, {"new": null, "old": 10.0000, "field": "price_foreign"}, {"new": null, "old": 5350.0000, "field": "price_local"}, {"new": null, "old": 15.0000, "field": "quantity"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "updated_by"}]}
57e9b1fa-3398-4835-b31f-d7a00232707a	purchase_invoice_items	5fb712f2-8608-4b08-9f78-1d6835d2eb31	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:01:03.765101+00	{"after": null, "before": {"id": "5fb712f2-8608-4b08-9f78-1d6835d2eb31", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 10.0000, "created_at": "2026-06-01T20:00:52.930996+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 53500.0000}, "changes": [{"new": null, "old": "2026-06-01T20:00:52.930996+00:00", "field": "created_at"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "5fb712f2-8608-4b08-9f78-1d6835d2eb31", "field": "id"}, {"new": null, "old": "02658347-c4e7-4c42-bdd9-40329ed2b48f", "field": "invoice_id"}, {"new": null, "old": "306a2174-24cb-4391-9413-4bb02927e59e", "field": "item_id"}, {"new": null, "old": 53500.0000, "field": "line_total_local"}, {"new": null, "old": 10.0000, "field": "price_foreign"}, {"new": null, "old": 5350.0000, "field": "price_local"}, {"new": null, "old": 10.0000, "field": "quantity"}, {"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "updated_by"}]}
65022f31-6059-450b-b7df-00e8436fe3ee	profiles	fcd49be9-d3ad-44bf-af22-2c3bca9599f2	update	\N	2026-06-01 22:00:57.138861+00	{"after": {"id": "fcd49be9-d3ad-44bf-af22-2c3bca9599f2", "locale": "ar", "username": "tarboosh", "full_name": "tarboosh alselwi", "is_active": true, "created_at": "2026-06-01T22:00:57.104971+00:00", "updated_at": "2026-06-01T22:00:57.138861+00:00"}, "before": {"id": "fcd49be9-d3ad-44bf-af22-2c3bca9599f2", "locale": "ar", "username": "tarboosh", "full_name": "tarboosh alselwi", "is_active": true, "created_at": "2026-06-01T22:00:57.104971+00:00", "updated_at": "2026-06-01T22:00:57.104971+00:00"}, "changes": [{"new": "2026-06-01T22:00:57.138861+00:00", "old": "2026-06-01T22:00:57.104971+00:00", "field": "updated_at"}]}
6043236b-88ee-4e78-aa4c-d6e46aba27f1	suppliers	2f8f8a60-e06b-40d0-beca-3bc648a1b953	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:25:44.198903+00	{"after": {"id": "2f8f8a60-e06b-40d0-beca-3bc648a1b953", "name": "Test Supplier", "notes": null, "phone": "05551234", "created_at": "2026-06-01T20:25:44.198903+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:25:44.198903+00:00", "updated_by": null, "default_currency": null, "default_payment_type": "cash"}, "before": null, "changes": [{"new": "2026-06-01T20:25:44.198903+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": null, "old": null, "field": "default_currency"}, {"new": "cash", "old": null, "field": "default_payment_type"}, {"new": "2f8f8a60-e06b-40d0-beca-3bc648a1b953", "old": null, "field": "id"}, {"new": "Test Supplier", "old": null, "field": "name"}, {"new": null, "old": null, "field": "notes"}, {"new": "05551234", "old": null, "field": "phone"}, {"new": "2026-06-01T20:25:44.198903+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
ca4c136d-f3bf-4bcf-9acd-1a64ae812e86	items	08cc757a-b266-4eb6-9fb4-efca7d24f454	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:29:50.22039+00	{"after": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "215", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:29:50.22039+00:00", "updated_by": null, "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 0.0000}, "before": null, "changes": [{"new": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "old": null, "field": "category_id"}, {"new": "215", "old": null, "field": "code"}, {"new": "2026-06-01T20:29:50.22039+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "old": null, "field": "id"}, {"new": 0.0000, "old": null, "field": "last_purchase_price_local"}, {"new": "تجريبي", "old": null, "field": "name_ar"}, {"new": "test", "old": null, "field": "name_en"}, {"new": "test", "old": null, "field": "notes"}, {"new": "571d6333-a466-48f1-bfc3-c38f755c71dd", "old": null, "field": "unit_id"}, {"new": "2026-06-01T20:29:50.22039+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
64a5cd2d-6572-43c3-b564-21283b252793	suppliers	2f8f8a60-e06b-40d0-beca-3bc648a1b953	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:30:06.260795+00	{"after": {"id": "2f8f8a60-e06b-40d0-beca-3bc648a1b953", "name": "Test Supplier", "notes": null, "phone": "05551234", "created_at": "2026-06-01T20:25:44.198903+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:30:06.260795+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "default_currency": "USD", "default_payment_type": "credit"}, "before": {"id": "2f8f8a60-e06b-40d0-beca-3bc648a1b953", "name": "Test Supplier", "notes": null, "phone": "05551234", "created_at": "2026-06-01T20:25:44.198903+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:25:44.198903+00:00", "updated_by": null, "default_currency": null, "default_payment_type": "cash"}, "changes": [{"new": "USD", "old": null, "field": "default_currency"}, {"new": "credit", "old": "cash", "field": "default_payment_type"}, {"new": "2026-06-01T20:30:06.260795+00:00", "old": "2026-06-01T20:25:44.198903+00:00", "field": "updated_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
bf1740c6-ed4a-4038-bfe5-607f4dfc4d97	purchase_invoices	4830cf13-0932-4731-992c-4432d629f228	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:30:30.328609+00	{"after": {"id": "4830cf13-0932-4731-992c-4432d629f228", "notes": null, "created_at": "2026-06-01T20:30:30.328609+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "110", "updated_at": "2026-06-01T20:30:30.328609+00:00", "updated_by": null, "supplier_id": "2f8f8a60-e06b-40d0-beca-3bc648a1b953", "total_local": 53500.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 100.0000}, "before": null, "changes": [{"new": "2026-06-01T20:30:30.328609+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "4830cf13-0932-4731-992c-4432d629f228", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "110", "old": null, "field": "invoice_no"}, {"new": null, "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "2f8f8a60-e06b-40d0-beca-3bc648a1b953", "old": null, "field": "supplier_id"}, {"new": 100.0000, "old": null, "field": "total_foreign"}, {"new": 53500.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T20:30:30.328609+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
0d948363-2c76-4799-b664-49ef2086f3bc	purchase_invoice_items	dd195164-f3bb-483b-ae76-7085f7c6697e	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:30:30.344064+00	{"after": {"id": "dd195164-f3bb-483b-ae76-7085f7c6697e", "item_id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "quantity": 10.0000, "created_at": "2026-06-01T20:30:30.344064+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "4830cf13-0932-4731-992c-4432d629f228", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 53500.0000}, "before": null, "changes": [{"new": "2026-06-01T20:30:30.344064+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "dd195164-f3bb-483b-ae76-7085f7c6697e", "old": null, "field": "id"}, {"new": "4830cf13-0932-4731-992c-4432d629f228", "old": null, "field": "invoice_id"}, {"new": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "old": null, "field": "item_id"}, {"new": 53500.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 10.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
5bae93ed-05f2-4078-bda2-a9699015d80f	profiles	98289d34-511f-4600-8f62-3b01a53a4f30	update	\N	2026-06-01 21:26:07.118861+00	{"after": {"id": "98289d34-511f-4600-8f62-3b01a53a4f30", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طرووش", "is_active": true, "created_at": "2026-06-01T21:26:07.083529+00:00", "updated_at": "2026-06-01T21:26:07.118861+00:00"}, "before": {"id": "98289d34-511f-4600-8f62-3b01a53a4f30", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طرووش", "is_active": true, "created_at": "2026-06-01T21:26:07.083529+00:00", "updated_at": "2026-06-01T21:26:07.083529+00:00"}, "changes": [{"new": "2026-06-01T21:26:07.118861+00:00", "old": "2026-06-01T21:26:07.083529+00:00", "field": "updated_at"}]}
f47af8a2-0c5f-4967-b72e-456b0fc03e4a	stock_movements	bed7e426-90a1-4f85-9a28-9cc8764febe7	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:30:30.344064+00	{"after": {"id": "bed7e426-90a1-4f85-9a28-9cc8764febe7", "notes": null, "item_id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "quantity": 10.0000, "created_at": "2026-06-01T20:30:30.344064+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "4830cf13-0932-4731-992c-4432d629f228", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T20:30:30.344064+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "bed7e426-90a1-4f85-9a28-9cc8764febe7", "old": null, "field": "id"}, {"new": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 10.0000, "old": null, "field": "quantity"}, {"new": "4830cf13-0932-4731-992c-4432d629f228", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
7a28ab4c-8728-4f6c-96b0-cf4dcf7391c3	items	08cc757a-b266-4eb6-9fb4-efca7d24f454	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:30:30.344064+00	{"after": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "215", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:30:30.344064+00:00", "updated_by": null, "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "before": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "215", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:29:50.22039+00:00", "updated_by": null, "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 0.0000}, "changes": [{"new": 5350.0000, "old": 0.0000, "field": "last_purchase_price_local"}, {"new": "2026-06-01T20:30:30.344064+00:00", "old": "2026-06-01T20:29:50.22039+00:00", "field": "updated_at"}]}
751c9f13-ee4c-4e1e-a5a0-613cf243d4c4	suppliers	9069ec45-3329-482f-a675-49aa97a30bf9	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:31:26.140998+00	{"after": {"id": "9069ec45-3329-482f-a675-49aa97a30bf9", "name": "احمد الاشول", "notes": "تجريبي", "phone": "777775555", "created_at": "2026-06-01T20:31:26.140998+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:31:26.140998+00:00", "updated_by": null, "default_currency": "USD", "default_payment_type": "credit"}, "before": null, "changes": [{"new": "2026-06-01T20:31:26.140998+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "default_currency"}, {"new": "credit", "old": null, "field": "default_payment_type"}, {"new": "9069ec45-3329-482f-a675-49aa97a30bf9", "old": null, "field": "id"}, {"new": "احمد الاشول", "old": null, "field": "name"}, {"new": "تجريبي", "old": null, "field": "notes"}, {"new": "777775555", "old": null, "field": "phone"}, {"new": "2026-06-01T20:31:26.140998+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
ecbb6653-3bf6-4f8a-9d2e-da7f27f378e8	purchase_invoices	5f0ec1f4-8ed0-402c-b11c-92647a5d157e	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.049524+00	{"after": {"id": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "notes": "تجريبي", "created_at": "2026-06-01T20:34:20.049524+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_no": "110", "updated_at": "2026-06-01T20:34:20.049524+00:00", "updated_by": null, "supplier_id": "9069ec45-3329-482f-a675-49aa97a30bf9", "total_local": 24075.0000, "invoice_date": "2026-06-01", "payment_type": "credit", "currency_code": "USD", "exchange_rate": 535.000000, "total_foreign": 45.0000}, "before": null, "changes": [{"new": "2026-06-01T20:34:20.049524+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "USD", "old": null, "field": "currency_code"}, {"new": 535.000000, "old": null, "field": "exchange_rate"}, {"new": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "old": null, "field": "id"}, {"new": "2026-06-01", "old": null, "field": "invoice_date"}, {"new": "110", "old": null, "field": "invoice_no"}, {"new": "تجريبي", "old": null, "field": "notes"}, {"new": "credit", "old": null, "field": "payment_type"}, {"new": "9069ec45-3329-482f-a675-49aa97a30bf9", "old": null, "field": "supplier_id"}, {"new": 45.0000, "old": null, "field": "total_foreign"}, {"new": 24075.0000, "old": null, "field": "total_local"}, {"new": "2026-06-01T20:34:20.049524+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}]}
a87388f6-90eb-4a29-b898-bc4bbb15042d	purchase_invoice_items	41e5a1e3-70b7-40b2-92dd-b3465bf5bf42	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00	{"after": {"id": "41e5a1e3-70b7-40b2-92dd-b3465bf5bf42", "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 5.0000, "created_at": "2026-06-01T20:34:20.067484+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 2675.0000, "price_foreign": 5.0000, "line_total_local": 13375.0000}, "before": null, "changes": [{"new": "2026-06-01T20:34:20.067484+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "41e5a1e3-70b7-40b2-92dd-b3465bf5bf42", "old": null, "field": "id"}, {"new": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "old": null, "field": "invoice_id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": 13375.0000, "old": null, "field": "line_total_local"}, {"new": 5.0000, "old": null, "field": "price_foreign"}, {"new": 2675.0000, "old": null, "field": "price_local"}, {"new": 5.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
60cbc353-471d-4118-8259-94a7d690dc31	profiles	c11a79d7-bb34-4320-8a7d-7a0f6be3d194	insert	\N	2026-06-01 21:30:56.859039+00	{"after": {"id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "locale": "ar", "username": "aboali", "full_name": "abo ali", "is_active": true, "created_at": "2026-06-01T21:30:56.859039+00:00", "updated_at": "2026-06-01T21:30:56.859039+00:00"}, "before": null, "changes": [{"new": "2026-06-01T21:30:56.859039+00:00", "old": null, "field": "created_at"}, {"new": "abo ali", "old": null, "field": "full_name"}, {"new": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-01T21:30:56.859039+00:00", "old": null, "field": "updated_at"}, {"new": "aboali", "old": null, "field": "username"}]}
826d641b-952b-476b-a9a6-7d9989ac86ec	stock_movements	45c0c039-7b84-46d9-a291-5b0e18291c8e	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00	{"after": {"id": "45c0c039-7b84-46d9-a291-5b0e18291c8e", "notes": null, "item_id": "306a2174-24cb-4391-9413-4bb02927e59e", "quantity": 5.0000, "created_at": "2026-06-01T20:34:20.067484+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 2675.0000}, "before": null, "changes": [{"new": "2026-06-01T20:34:20.067484+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "45c0c039-7b84-46d9-a291-5b0e18291c8e", "old": null, "field": "id"}, {"new": "306a2174-24cb-4391-9413-4bb02927e59e", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 5.0000, "old": null, "field": "quantity"}, {"new": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 2675.0000, "old": null, "field": "unit_price_local"}]}
6eb7e2fc-9117-4b41-87e3-ac9d4efffae6	items	306a2174-24cb-4391-9413-4bb02927e59e	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00	{"after": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:34:20.067484+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 2675.0000}, "before": {"id": "306a2174-24cb-4391-9413-4bb02927e59e", "code": null, "notes": null, "name_ar": "توصيلة ليتكس 5 فتحات 5 متر ", "name_en": null, "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-05-30T17:52:57.842588+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:00:52.930996+00:00", "updated_by": null, "category_id": "5b55843d-8774-403f-8afd-aa3a5cfbc4f5", "last_purchase_price_local": 5350.0000}, "changes": [{"new": 2675.0000, "old": 5350.0000, "field": "last_purchase_price_local"}, {"new": "2026-06-01T20:34:20.067484+00:00", "old": "2026-06-01T20:00:52.930996+00:00", "field": "updated_at"}]}
fc30cf96-4f6c-4fa3-a8ba-c2ec6fbebd1e	purchase_invoice_items	b6bb1010-a3fb-4310-af94-1633bf94dbfd	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00	{"after": {"id": "b6bb1010-a3fb-4310-af94-1633bf94dbfd", "item_id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "quantity": 2.0000, "created_at": "2026-06-01T20:34:20.067484+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "invoice_id": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "price_local": 5350.0000, "price_foreign": 10.0000, "line_total_local": 10700.0000}, "before": null, "changes": [{"new": "2026-06-01T20:34:20.067484+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "b6bb1010-a3fb-4310-af94-1633bf94dbfd", "old": null, "field": "id"}, {"new": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "old": null, "field": "invoice_id"}, {"new": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "old": null, "field": "item_id"}, {"new": 10700.0000, "old": null, "field": "line_total_local"}, {"new": 10.0000, "old": null, "field": "price_foreign"}, {"new": 5350.0000, "old": null, "field": "price_local"}, {"new": 2.0000, "old": null, "field": "quantity"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
956a55fd-712d-4328-8582-9ac83de4c51e	stock_movements	cab6fbdf-b00b-4ba0-89e1-1add1b445fea	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00	{"after": {"id": "cab6fbdf-b00b-4ba0-89e1-1add1b445fea", "notes": null, "item_id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "quantity": 2.0000, "created_at": "2026-06-01T20:34:20.067484+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "reference_id": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "movement_date": "2026-06-01", "movement_type": "purchase", "reference_table": "purchase_invoices", "unit_price_local": 5350.0000}, "before": null, "changes": [{"new": "2026-06-01T20:34:20.067484+00:00", "old": null, "field": "created_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "cab6fbdf-b00b-4ba0-89e1-1add1b445fea", "old": null, "field": "id"}, {"new": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "old": null, "field": "item_id"}, {"new": "2026-06-01", "old": null, "field": "movement_date"}, {"new": "purchase", "old": null, "field": "movement_type"}, {"new": null, "old": null, "field": "notes"}, {"new": 2.0000, "old": null, "field": "quantity"}, {"new": "5f0ec1f4-8ed0-402c-b11c-92647a5d157e", "old": null, "field": "reference_id"}, {"new": "purchase_invoices", "old": null, "field": "reference_table"}, {"new": 5350.0000, "old": null, "field": "unit_price_local"}]}
4d2ebf74-9958-46af-ad19-90d5023bc38b	items	08cc757a-b266-4eb6-9fb4-efca7d24f454	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00	{"after": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "215", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:34:20.067484+00:00", "updated_by": null, "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "before": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "215", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:30:30.344064+00:00", "updated_by": null, "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "changes": [{"new": "2026-06-01T20:34:20.067484+00:00", "old": "2026-06-01T20:30:30.344064+00:00", "field": "updated_at"}]}
9b3b564e-5bef-4f18-ba14-7be111734b32	profiles	98289d34-511f-4600-8f62-3b01a53a4f30	insert	\N	2026-06-01 21:26:07.083529+00	{"after": {"id": "98289d34-511f-4600-8f62-3b01a53a4f30", "locale": "ar", "username": "salah", "full_name": "صلاح الدين طرووش", "is_active": true, "created_at": "2026-06-01T21:26:07.083529+00:00", "updated_at": "2026-06-01T21:26:07.083529+00:00"}, "before": null, "changes": [{"new": "2026-06-01T21:26:07.083529+00:00", "old": null, "field": "created_at"}, {"new": "صلاح الدين طرووش", "old": null, "field": "full_name"}, {"new": "98289d34-511f-4600-8f62-3b01a53a4f30", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-01T21:26:07.083529+00:00", "old": null, "field": "updated_at"}, {"new": "salah", "old": null, "field": "username"}]}
ae7f23a3-f83e-4717-b741-7231876fe290	user_permission_groups	\N	insert	\N	2026-06-01 22:09:05.198769+00	{"after": {"user_id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "group_id": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a"}, "before": null, "changes": [{"new": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a", "old": null, "field": "group_id"}, {"new": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "old": null, "field": "user_id"}]}
f7027b92-57b3-4ca1-8012-6e6e6b39d025	profiles	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	insert	\N	2026-06-01 23:12:43.653354+00	{"after": {"id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "locale": "ar", "username": "alselwi", "full_name": "hussein alselwi", "is_active": true, "created_at": "2026-06-01T23:12:43.653354+00:00", "updated_at": "2026-06-01T23:12:43.653354+00:00"}, "before": null, "changes": [{"new": "2026-06-01T23:12:43.653354+00:00", "old": null, "field": "created_at"}, {"new": "hussein alselwi", "old": null, "field": "full_name"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-01T23:12:43.653354+00:00", "old": null, "field": "updated_at"}, {"new": "alselwi", "old": null, "field": "username"}]}
dd10f64e-3267-438f-944c-b0dcdec3a0fe	profiles	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	update	\N	2026-06-01 23:12:43.686096+00	{"after": {"id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "locale": "ar", "username": "alselwi", "full_name": "hussein alselwi", "is_active": true, "created_at": "2026-06-01T23:12:43.653354+00:00", "updated_at": "2026-06-01T23:12:43.686096+00:00"}, "before": {"id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "locale": "ar", "username": "alselwi", "full_name": "hussein alselwi", "is_active": true, "created_at": "2026-06-01T23:12:43.653354+00:00", "updated_at": "2026-06-01T23:12:43.653354+00:00"}, "changes": [{"new": "2026-06-01T23:12:43.686096+00:00", "old": "2026-06-01T23:12:43.653354+00:00", "field": "updated_at"}]}
89770dde-cae8-4e2b-94fe-b3f09ef22c05	items	08cc757a-b266-4eb6-9fb4-efca7d24f454	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 23:26:37.209335+00	{"after": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "200", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T23:26:37.209335+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "before": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "215", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T20:34:20.067484+00:00", "updated_by": null, "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "changes": [{"new": "200", "old": "215", "field": "code"}, {"new": "2026-06-01T23:26:37.209335+00:00", "old": "2026-06-01T20:34:20.067484+00:00", "field": "updated_at"}, {"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "updated_by"}]}
513e8ac6-c724-488a-9e6d-8c4ebdc1828e	profiles	38864ff1-f161-4ace-8919-2297a65286e6	insert	\N	2026-06-02 00:38:06.556426+00	{"after": {"id": "38864ff1-f161-4ace-8919-2297a65286e6", "locale": "ar", "username": "try", "full_name": "try", "is_active": true, "created_at": "2026-06-02T00:38:06.556426+00:00", "created_by": null, "updated_at": "2026-06-02T00:38:06.556426+00:00", "updated_by": null}, "before": null, "changes": [{"new": "2026-06-02T00:38:06.556426+00:00", "old": null, "field": "created_at"}, {"new": null, "old": null, "field": "created_by"}, {"new": "try", "old": null, "field": "full_name"}, {"new": "38864ff1-f161-4ace-8919-2297a65286e6", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-02T00:38:06.556426+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}, {"new": "try", "old": null, "field": "username"}]}
0c549541-35d7-4d9c-949b-0b18244b86c7	user_permission_groups	\N	insert	\N	2026-06-02 00:39:51.799411+00	{"after": {"user_id": "38864ff1-f161-4ace-8919-2297a65286e6", "group_id": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a"}, "before": null, "changes": [{"new": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a", "old": null, "field": "group_id"}, {"new": "38864ff1-f161-4ace-8919-2297a65286e6", "old": null, "field": "user_id"}]}
0f2dbf52-1b72-4c43-adf3-6dd0bee41477	user_permission_groups	\N	insert	\N	2026-06-03 23:13:16.615951+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7"}, "before": null, "changes": [{"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
9904f5dc-a384-4ab6-9b84-c0fdff951e18	user_permission_groups	\N	delete	\N	2026-06-03 23:14:22.924584+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7"}, "changes": [{"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
9bc6faa5-41b5-460f-b638-61a8192af6c4	user_permission_groups	\N	insert	\N	2026-06-03 23:14:22.980671+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4"}, "before": null, "changes": [{"new": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "old": null, "field": "group_id"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
99c35e4c-0af5-467d-9b6a-7eb6db8802e6	user_permission_groups	\N	delete	\N	2026-06-03 23:15:22.398835+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4"}, "changes": [{"new": null, "old": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "field": "group_id"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
6830d90e-e04b-48cd-9fce-b3b606c4e9ab	user_permission_groups	\N	insert	\N	2026-06-03 23:15:22.457816+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7"}, "before": null, "changes": [{"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
21ec874c-b7ba-40ca-bd07-0c1cc19e7734	user_permissions	\N	insert	\N	2026-06-03 23:15:22.518271+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "users.manage"}, "before": null, "changes": [{"new": "users.manage", "old": null, "field": "permission_key"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
f3c106d1-6d6d-4050-9832-75fda78e567e	user_permissions	\N	insert	\N	2026-06-03 23:15:22.518271+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "permissions.manage"}, "before": null, "changes": [{"new": "permissions.manage", "old": null, "field": "permission_key"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
d148d566-e61c-4a2c-bdd8-d426f41b62e4	user_permission_groups	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:29:36.833695+00	{"after": null, "before": {"user_id": "dbf26535-d542-4c77-9151-d39dbad967cd", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "changes": [{"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "field": "group_id"}, {"new": null, "old": "dbf26535-d542-4c77-9151-d39dbad967cd", "field": "user_id"}]}
60ac528c-0ed5-4ba7-921c-02005cd4f2b9	profiles	fcd49be9-d3ad-44bf-af22-2c3bca9599f2	delete	\N	2026-06-04 00:31:54.372153+00	{"after": null, "before": {"id": "fcd49be9-d3ad-44bf-af22-2c3bca9599f2", "locale": "ar", "username": "tarboosh", "full_name": "tarboosh alselwi", "is_active": true, "created_at": "2026-06-01T22:00:57.104971+00:00", "created_by": null, "updated_at": "2026-06-01T22:00:57.138861+00:00", "updated_by": null}, "changes": [{"new": null, "old": "2026-06-01T22:00:57.104971+00:00", "field": "created_at"}, {"new": null, "old": null, "field": "created_by"}, {"new": null, "old": "tarboosh alselwi", "field": "full_name"}, {"new": null, "old": "fcd49be9-d3ad-44bf-af22-2c3bca9599f2", "field": "id"}, {"new": null, "old": true, "field": "is_active"}, {"new": null, "old": "ar", "field": "locale"}, {"new": null, "old": "2026-06-01T22:00:57.138861+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}, {"new": null, "old": "tarboosh", "field": "username"}]}
4cdf62f6-2029-48a3-9846-cb22ccc42f13	user_permission_groups	\N	delete	\N	2026-06-04 00:33:32.882577+00	{"after": null, "before": {"user_id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "group_id": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a"}, "changes": [{"new": null, "old": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a", "field": "group_id"}, {"new": null, "old": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "field": "user_id"}]}
35534637-c8be-441a-85e5-d11b95b6e788	user_permission_groups	\N	insert	\N	2026-06-04 00:33:32.942173+00	{"after": {"user_id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4"}, "before": null, "changes": [{"new": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "old": null, "field": "group_id"}, {"new": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "old": null, "field": "user_id"}]}
bfe716dc-25ca-471d-a94b-6be012566367	profiles	38864ff1-f161-4ace-8919-2297a65286e6	delete	\N	2026-06-04 00:33:41.59895+00	{"after": null, "before": {"id": "38864ff1-f161-4ace-8919-2297a65286e6", "locale": "ar", "username": "try", "full_name": "try", "is_active": true, "created_at": "2026-06-02T00:38:06.556426+00:00", "created_by": null, "updated_at": "2026-06-02T00:38:06.556426+00:00", "updated_by": null}, "changes": [{"new": null, "old": "2026-06-02T00:38:06.556426+00:00", "field": "created_at"}, {"new": null, "old": null, "field": "created_by"}, {"new": null, "old": "try", "field": "full_name"}, {"new": null, "old": "38864ff1-f161-4ace-8919-2297a65286e6", "field": "id"}, {"new": null, "old": true, "field": "is_active"}, {"new": null, "old": "ar", "field": "locale"}, {"new": null, "old": "2026-06-02T00:38:06.556426+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}, {"new": null, "old": "try", "field": "username"}]}
2c8e8ada-a14a-4328-b7cd-c1174e8e40a1	user_permission_groups	\N	delete	\N	2026-06-04 00:33:41.59895+00	{"after": null, "before": {"user_id": "38864ff1-f161-4ace-8919-2297a65286e6", "group_id": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a"}, "changes": [{"new": null, "old": "0fe2a00e-a465-41c7-82e2-76a7b0877e1a", "field": "group_id"}, {"new": null, "old": "38864ff1-f161-4ace-8919-2297a65286e6", "field": "user_id"}]}
6523cd17-c9c1-4359-84dc-70a5d5d463bf	items	08cc757a-b266-4eb6-9fb4-efca7d24f454	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-04 00:35:03.597599+00	{"after": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "150", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-04T00:35:03.597599+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "before": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "200", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-01T23:26:37.209335+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "changes": [{"new": "150", "old": "200", "field": "code"}, {"new": "2026-06-04T00:35:03.597599+00:00", "old": "2026-06-01T23:26:37.209335+00:00", "field": "updated_at"}]}
6463ea10-05d8-400e-b4b2-4040f8bf1a88	items	08cc757a-b266-4eb6-9fb4-efca7d24f454	update	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 00:36:02.2843+00	{"after": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "200", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-04T00:36:02.2843+00:00", "updated_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "before": {"id": "08cc757a-b266-4eb6-9fb4-efca7d24f454", "code": "150", "notes": "test", "name_ar": "تجريبي", "name_en": "test", "unit_id": "571d6333-a466-48f1-bfc3-c38f755c71dd", "created_at": "2026-06-01T20:29:50.22039+00:00", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "updated_at": "2026-06-04T00:35:03.597599+00:00", "updated_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "category_id": "1c5d4cdb-6653-46d5-abac-e9526b2fd1c9", "last_purchase_price_local": 5350.0000}, "changes": [{"new": "200", "old": "150", "field": "code"}, {"new": "2026-06-04T00:36:02.2843+00:00", "old": "2026-06-04T00:35:03.597599+00:00", "field": "updated_at"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "updated_by"}]}
c8eba4d5-feb9-4ff5-91f2-a6b303c840c5	user_permission_groups	\N	delete	\N	2026-06-04 00:36:16.600818+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7"}, "changes": [{"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
c7707bc6-a79c-47b9-8a0a-83e378b2bdfd	user_permission_groups	\N	insert	\N	2026-06-04 00:36:16.67414+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "08209396-8e16-4850-900c-af01b125929f"}, "before": null, "changes": [{"new": "08209396-8e16-4850-900c-af01b125929f", "old": null, "field": "group_id"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
cd26dafa-1d0d-457e-9fc6-44befdd863ce	user_permission_groups	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 00:43:06.019242+00	{"after": null, "before": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7"}, "changes": [{"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "field": "user_id"}]}
b3398860-09f2-43e1-8fd9-7f869b8e8890	profiles	c11a79d7-bb34-4320-8a7d-7a0f6be3d194	delete	\N	2026-06-04 00:43:35.333817+00	{"after": null, "before": {"id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "locale": "ar", "username": "aboali", "full_name": "abo ali", "is_active": true, "created_at": "2026-06-01T21:30:56.859039+00:00", "created_by": null, "updated_at": "2026-06-01T21:30:56.8957+00:00", "updated_by": null}, "changes": [{"new": null, "old": "2026-06-01T21:30:56.859039+00:00", "field": "created_at"}, {"new": null, "old": null, "field": "created_by"}, {"new": null, "old": "abo ali", "field": "full_name"}, {"new": null, "old": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "field": "id"}, {"new": null, "old": true, "field": "is_active"}, {"new": null, "old": "ar", "field": "locale"}, {"new": null, "old": "2026-06-01T21:30:56.8957+00:00", "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}, {"new": null, "old": "aboali", "field": "username"}]}
a870acec-945e-4a87-a93f-993a210c03c9	user_permission_groups	\N	delete	\N	2026-06-04 00:43:35.333817+00	{"after": null, "before": {"user_id": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4"}, "changes": [{"new": null, "old": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "field": "group_id"}, {"new": null, "old": "c11a79d7-bb34-4320-8a7d-7a0f6be3d194", "field": "user_id"}]}
e055c91e-a9f0-4165-a1b8-300c0c96815a	profiles	dbf26535-d542-4c77-9151-d39dbad967cd	insert	\N	2026-06-04 21:35:31.201665+00	{"after": {"id": "dbf26535-d542-4c77-9151-d39dbad967cd", "locale": "ar", "username": "oshaip", "full_name": "oshaip alselwi", "is_active": true, "created_at": "2026-06-04T21:35:31.201665+00:00", "created_by": null, "updated_at": "2026-06-04T21:35:31.201665+00:00", "updated_by": null}, "before": null, "changes": [{"new": "2026-06-04T21:35:31.201665+00:00", "old": null, "field": "created_at"}, {"new": null, "old": null, "field": "created_by"}, {"new": "oshaip alselwi", "old": null, "field": "full_name"}, {"new": "dbf26535-d542-4c77-9151-d39dbad967cd", "old": null, "field": "id"}, {"new": true, "old": null, "field": "is_active"}, {"new": "ar", "old": null, "field": "locale"}, {"new": "2026-06-04T21:35:31.201665+00:00", "old": null, "field": "updated_at"}, {"new": null, "old": null, "field": "updated_by"}, {"new": "oshaip", "old": null, "field": "username"}]}
5efc8e33-7b38-4e66-81d9-07de8aa3d9f9	profiles	dbf26535-d542-4c77-9151-d39dbad967cd	update	\N	2026-06-04 21:35:31.255669+00	{"after": {"id": "dbf26535-d542-4c77-9151-d39dbad967cd", "locale": "ar", "username": "oshaip", "full_name": "oshaip alselwi", "is_active": true, "created_at": "2026-06-04T21:35:31.201665+00:00", "created_by": null, "updated_at": "2026-06-04T21:35:31.201665+00:00", "updated_by": null}, "before": {"id": "dbf26535-d542-4c77-9151-d39dbad967cd", "locale": "ar", "username": "oshaip", "full_name": "oshaip alselwi", "is_active": true, "created_at": "2026-06-04T21:35:31.201665+00:00", "created_by": null, "updated_at": "2026-06-04T21:35:31.201665+00:00", "updated_by": null}, "changes": []}
03b805a6-1731-429d-abc6-22dddeb0a7c1	user_permission_groups	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:19:00.917461+00	{"after": {"user_id": "dbf26535-d542-4c77-9151-d39dbad967cd", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "dbf26535-d542-4c77-9151-d39dbad967cd", "old": null, "field": "user_id"}]}
998601e3-1ee8-4219-8340-b69173cfec55	user_permission_groups	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:19:27.409105+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
9c8470d2-5e30-4498-a9ea-5a1217d0a4a8	user_permissions	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:19:27.617285+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "suppliers.view"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "suppliers.view", "old": null, "field": "permission_key"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
7f531c5b-3005-4202-a789-8bf71cabd092	user_permissions	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:19:27.617285+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "settings.manage"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "settings.manage", "old": null, "field": "permission_key"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
34d7aaf2-1b1b-41be-985f-e9dca977beec	user_permissions	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:19:27.617285+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "suppliers.manage"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "suppliers.manage", "old": null, "field": "permission_key"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
7d681620-7d56-441b-ab01-11080d152f51	user_permissions	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-04 22:19:27.617285+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "users.manage"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "users.manage", "old": null, "field": "permission_key"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
eea31adf-3e7b-4f79-8dfe-c9c47bd88ec0	user_permission_groups	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:29:23.69857+00	{"after": null, "before": {"user_id": "dbf26535-d542-4c77-9151-d39dbad967cd", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d"}, "changes": [{"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "created_by"}, {"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "dbf26535-d542-4c77-9151-d39dbad967cd", "field": "user_id"}]}
116aa603-90ce-4b81-ab88-19e0bcbefe2f	user_permission_groups	\N	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:29:23.81843+00	{"after": {"user_id": "dbf26535-d542-4c77-9151-d39dbad967cd", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "before": null, "changes": [{"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "old": null, "field": "group_id"}, {"new": "dbf26535-d542-4c77-9151-d39dbad967cd", "old": null, "field": "user_id"}]}
cd204e0d-0439-4cfa-bbd6-7267888487dd	user_permission_groups	\N	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 21:29:36.967716+00	{"after": {"user_id": "dbf26535-d542-4c77-9151-d39dbad967cd", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "before": null, "changes": [{"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "dbf26535-d542-4c77-9151-d39dbad967cd", "old": null, "field": "user_id"}]}
3a7de2bb-52dd-48a9-afba-5c3f9988dbfb	user_permission_groups	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:59:14.327795+00	{"after": null, "before": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d"}, "changes": [{"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "created_by"}, {"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "field": "user_id"}]}
50d2cc3f-07f6-4467-a0c1-31a6f686379b	user_permissions	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:59:14.355033+00	{"after": null, "before": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "settings.manage"}, "changes": [{"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "created_by"}, {"new": null, "old": "settings.manage", "field": "permission_key"}, {"new": null, "old": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "field": "user_id"}]}
358661f1-0c87-4dd0-b827-d6930b9a75fe	user_permissions	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:59:14.355033+00	{"after": null, "before": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "suppliers.manage"}, "changes": [{"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "created_by"}, {"new": null, "old": "suppliers.manage", "field": "permission_key"}, {"new": null, "old": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "field": "user_id"}]}
f502cd71-f8e3-4d38-a329-9bd4501ceb09	user_permissions	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:59:14.355033+00	{"after": null, "before": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "suppliers.view"}, "changes": [{"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "created_by"}, {"new": null, "old": "suppliers.view", "field": "permission_key"}, {"new": null, "old": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "field": "user_id"}]}
6c3b3a02-7929-42e0-a136-76f9df20d0bc	user_permissions	\N	delete	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:59:14.355033+00	{"after": null, "before": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "permission_key": "users.manage"}, "changes": [{"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "created_by"}, {"new": null, "old": "users.manage", "field": "permission_key"}, {"new": null, "old": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "field": "user_id"}]}
db368d8d-1b38-4fd3-b17d-df6529631bbc	user_permission_groups	\N	insert	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-17 21:59:14.481304+00	{"after": {"user_id": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "group_id": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "created_by": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d"}, "before": null, "changes": [{"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "created_by"}, {"new": "54f16aca-1775-45a2-b75d-9098abfdc0d4", "old": null, "field": "group_id"}, {"new": "a36f3f23-61d5-4b30-8573-23d6a3fc2273", "old": null, "field": "user_id"}]}
9fca03cd-7430-4d9c-8b25-954fbae28019	permission_groups	f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	update	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:14:51.845817+00	{"after": {"id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "name": "manager", "created_at": "2026-05-29T22:10:16.314754+00:00", "description": "مدير - كل العمليات عدا إدارة المستخدمين"}, "before": {"id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "name": "manager", "created_at": "2026-05-29T22:10:16.314754+00:00", "description": "مدير - كل العمليات عدا إدارة المستخدمين"}, "changes": []}
405755a5-2aa1-4c7e-b31f-6cc42e6c9ddf	permission_group_items	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:14:51.886672+00	{"after": null, "before": {"group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "permission_key": "suppliers.manage"}, "changes": [{"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "suppliers.manage", "field": "permission_key"}]}
42c6f991-b4b9-4dd8-8f66-2f75663cdcf5	permission_group_items	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:14:51.886672+00	{"after": null, "before": {"group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "permission_key": "suppliers.view"}, "changes": [{"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "suppliers.view", "field": "permission_key"}]}
4fb89b88-7413-450b-8332-9eafebbd8116	user_permission_groups	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:15:10.397179+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "08209396-8e16-4850-900c-af01b125929f", "created_by": null}, "changes": [{"new": null, "old": null, "field": "created_by"}, {"new": null, "old": "08209396-8e16-4850-900c-af01b125929f", "field": "group_id"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
6b8d00da-0b3f-4038-b155-f31b269bcf09	user_permissions	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:15:10.408113+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "created_by": null, "permission_key": "permissions.manage"}, "changes": [{"new": null, "old": null, "field": "created_by"}, {"new": null, "old": "permissions.manage", "field": "permission_key"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
eab4d542-fa76-4252-8d99-c78cbb23b6ef	user_permissions	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:15:10.408113+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "created_by": null, "permission_key": "users.manage"}, "changes": [{"new": null, "old": null, "field": "created_by"}, {"new": null, "old": "users.manage", "field": "permission_key"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
bd7b51f9-112f-4740-9794-75d93e0dc8b6	user_permission_groups	\N	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:15:10.514728+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "before": null, "changes": [{"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "old": null, "field": "group_id"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
8b4485dc-cfb2-463c-9cbd-94b9687be591	user_permission_groups	\N	delete	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:19:42.1466+00	{"after": null, "before": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "changes": [{"new": null, "old": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "field": "created_by"}, {"new": null, "old": "f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7", "field": "group_id"}, {"new": null, "old": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "field": "user_id"}]}
9d548876-38c5-450c-b035-4ef23463ebbc	user_permission_groups	\N	insert	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-17 22:19:42.261742+00	{"after": {"user_id": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "group_id": "08209396-8e16-4850-900c-af01b125929f", "created_by": "85d2a767-bae1-4a79-8dda-cbe035239f5a"}, "before": null, "changes": [{"new": "85d2a767-bae1-4a79-8dda-cbe035239f5a", "old": null, "field": "created_by"}, {"new": "08209396-8e16-4850-900c-af01b125929f", "old": null, "field": "group_id"}, {"new": "6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d", "old": null, "field": "user_id"}]}
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, name_ar, name_en, parent_id, created_by, updated_by, created_at, updated_at) FROM stdin;
206369dc-2969-4beb-a3ef-bd2d896a5fca	الكهرباء	\N	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 17:23:32.765043+00	2026-05-30 17:23:32.765043+00
b6cd8d4b-4c62-4d84-ba04-f9b55ccf5235	اللمبات	\N	206369dc-2969-4beb-a3ef-bd2d896a5fca	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 17:23:47.163217+00	2026-05-30 17:23:47.163217+00
42e9ed6d-0b26-4141-b20a-4932594da01b	لمبات 12 فولت	\N	b6cd8d4b-4c62-4d84-ba04-f9b55ccf5235	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 17:26:48.423916+00	2026-05-30 17:26:48.423916+00
1c5d4cdb-6653-46d5-abac-e9526b2fd1c9	لمبات 220 فولت	\N	b6cd8d4b-4c62-4d84-ba04-f9b55ccf5235	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 17:36:39.071455+00	2026-05-30 17:36:39.071455+00
5b55843d-8774-403f-8afd-aa3a5cfbc4f5	توصيلات كهرباء	\N	206369dc-2969-4beb-a3ef-bd2d896a5fca	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 17:50:08.748486+00	2026-05-30 17:50:08.748486+00
8a1364b1-95a1-44cc-98aa-dd7b43450ca1	السباكة	\N	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 18:20:26.046662+00	2026-05-30 18:20:26.046662+00
e69731fd-99a1-4627-ae3b-0a656129ddcb	ادوات النجارة ومعدات الورش ومستلزمات العمال	\N	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-05-30 17:27:24.473244+00	2026-05-30 18:22:10.04111+00
eec82ece-08e0-4d63-ad41-b758484d8832	Audit Test	\N	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-05-30 18:34:33.401+00	2026-05-30 19:57:01.435791+00
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currencies (code, name_ar, name_en, symbol, is_base) FROM stdin;
YER	ريال يمني	Yemeni Rial	ر.ي	t
USD	دولار أمريكي	US Dollar	$	f
SAR	ريال سعودي	Saudi Riyal	ر.س	f
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, name, phone, notes, created_by, updated_by, created_at, updated_at) FROM stdin;
be9e96dc-6493-487b-a5af-3fd05734753e	تجريبي	771310424	هذا العميل تجريبي	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 19:57:24.134029+00	2026-05-30 19:57:24.134029+00
\.


--
-- Data for Name: debt_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.debt_transactions (id, customer_id, transaction_type, amount, currency_code, exchange_rate, amount_local, invoice_ref, notes, transaction_date, created_by, updated_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: exchange_rates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exchange_rates (id, currency_code, rate_to_base, rate_date, created_by, created_at) FROM stdin;
b5cce50e-3e60-4737-8e9c-c61d7404ae91	YER	1.000000	2026-05-29	\N	2026-05-29 22:10:16.314754+00
fe280214-ada3-4927-827e-fb4b95ddc055	USD	535.000000	2026-05-29	\N	2026-05-29 22:10:16.314754+00
798f80e4-b547-4157-85e2-6c95fc31a607	SAR	142.000000	2026-05-29	\N	2026-05-29 22:10:16.314754+00
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (id, code, name_ar, name_en, category_id, unit_id, last_purchase_price_local, notes, created_by, updated_by, created_at, updated_at) FROM stdin;
306a2174-24cb-4391-9413-4bb02927e59e	\N	توصيلة ليتكس 5 فتحات 5 متر 	\N	5b55843d-8774-403f-8afd-aa3a5cfbc4f5	571d6333-a466-48f1-bfc3-c38f755c71dd	2675.0000	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-05-30 17:52:57.842588+00	2026-06-01 20:34:20.067484+00
08cc757a-b266-4eb6-9fb4-efca7d24f454	200	تجريبي	test	1c5d4cdb-6653-46d5-abac-e9526b2fd1c9	571d6333-a466-48f1-bfc3-c38f755c71dd	5350.0000	test	85d2a767-bae1-4a79-8dda-cbe035239f5a	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	2026-06-01 20:29:50.22039+00	2026-06-04 00:36:02.2843+00
\.


--
-- Data for Name: permission_group_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission_group_items (group_id, permission_key) FROM stdin;
08209396-8e16-4850-900c-af01b125929f	system.admin
08209396-8e16-4850-900c-af01b125929f	users.manage
08209396-8e16-4850-900c-af01b125929f	permissions.manage
08209396-8e16-4850-900c-af01b125929f	settings.view
08209396-8e16-4850-900c-af01b125929f	settings.manage
08209396-8e16-4850-900c-af01b125929f	items.view
08209396-8e16-4850-900c-af01b125929f	items.manage
08209396-8e16-4850-900c-af01b125929f	items.import
08209396-8e16-4850-900c-af01b125929f	suppliers.view
08209396-8e16-4850-900c-af01b125929f	suppliers.manage
08209396-8e16-4850-900c-af01b125929f	customers.view
08209396-8e16-4850-900c-af01b125929f	customers.manage
08209396-8e16-4850-900c-af01b125929f	invoices.view
08209396-8e16-4850-900c-af01b125929f	invoices.manage
08209396-8e16-4850-900c-af01b125929f	debts.view
08209396-8e16-4850-900c-af01b125929f	debts.manage
08209396-8e16-4850-900c-af01b125929f	reports.view
08209396-8e16-4850-900c-af01b125929f	reports.export
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	settings.view
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	settings.manage
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	items.view
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	items.manage
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	items.import
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	customers.view
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	customers.manage
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	invoices.view
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	invoices.manage
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	debts.view
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	debts.manage
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	reports.view
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	reports.export
54f16aca-1775-45a2-b75d-9098abfdc0d4	settings.view
54f16aca-1775-45a2-b75d-9098abfdc0d4	items.view
54f16aca-1775-45a2-b75d-9098abfdc0d4	items.manage
54f16aca-1775-45a2-b75d-9098abfdc0d4	items.import
54f16aca-1775-45a2-b75d-9098abfdc0d4	suppliers.view
54f16aca-1775-45a2-b75d-9098abfdc0d4	suppliers.manage
54f16aca-1775-45a2-b75d-9098abfdc0d4	customers.view
54f16aca-1775-45a2-b75d-9098abfdc0d4	customers.manage
54f16aca-1775-45a2-b75d-9098abfdc0d4	invoices.view
54f16aca-1775-45a2-b75d-9098abfdc0d4	invoices.manage
54f16aca-1775-45a2-b75d-9098abfdc0d4	debts.view
54f16aca-1775-45a2-b75d-9098abfdc0d4	debts.manage
54f16aca-1775-45a2-b75d-9098abfdc0d4	reports.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	settings.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	items.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	suppliers.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	customers.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	invoices.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	debts.view
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	reports.view
\.


--
-- Data for Name: permission_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permission_groups (id, name, description, created_at) FROM stdin;
08209396-8e16-4850-900c-af01b125929f	admin	صلاحيات كاملة	2026-05-29 22:10:16.314754+00
54f16aca-1775-45a2-b75d-9098abfdc0d4	data_entry	إدخال البيانات والفواتير	2026-05-29 22:10:16.314754+00
0fe2a00e-a465-41c7-82e2-76a7b0877e1a	viewer	عرض فقط	2026-05-29 22:10:16.314754+00
f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	manager	مدير - كل العمليات عدا إدارة المستخدمين	2026-05-29 22:10:16.314754+00
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (key, label_ar, label_en, category) FROM stdin;
system.admin	مسؤول النظام	System Admin	system
users.manage	إدارة المستخدمين	Manage Users	users
permissions.manage	إدارة الصلاحيات	Manage Permissions	users
settings.view	عرض الإعدادات	View Settings	settings
settings.manage	إدارة الإعدادات	Manage Settings	settings
items.view	عرض الأصناف	View Items	items
items.manage	إدارة الأصناف	Manage Items	items
items.import	استيراد أصناف من Excel	Import Items	items
suppliers.view	عرض الموردين	View Suppliers	suppliers
suppliers.manage	إدارة الموردين	Manage Suppliers	suppliers
customers.view	عرض العملاء	View Customers	customers
customers.manage	إدارة العملاء	Manage Customers	customers
invoices.view	عرض الفواتير	View Invoices	invoices
invoices.manage	إدارة الفواتير	Manage Invoices	invoices
debts.view	عرض كشوف الحسابات	View Debts	debts
debts.manage	إدارة الديون والقبض	Manage Debts	debts
reports.view	عرض التقارير	View Reports	reports
reports.export	تصدير التقارير	Export Reports	reports
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, username, full_name, is_active, locale, created_at, updated_at, created_by, updated_by) FROM stdin;
85d2a767-bae1-4a79-8dda-cbe035239f5a	admin	Admin	t	ar	2026-05-29 22:13:48.989503+00	2026-05-30 16:42:00.664448+00	\N	\N
a36f3f23-61d5-4b30-8573-23d6a3fc2273	salah	صلاح الدين طربوش	t	ar	2026-06-01 21:48:13.943211+00	2026-06-01 21:48:13.972822+00	\N	\N
6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	alselwi	hussein alselwi	t	ar	2026-06-01 23:12:43.653354+00	2026-06-01 23:12:43.686096+00	\N	\N
dbf26535-d542-4c77-9151-d39dbad967cd	oshaip	oshaip alselwi	t	ar	2026-06-04 21:35:31.201665+00	2026-06-04 21:35:31.201665+00	\N	\N
\.


--
-- Data for Name: purchase_invoice_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_invoice_items (id, invoice_id, item_id, quantity, price_foreign, price_local, line_total_local, created_at, created_by, updated_by) FROM stdin;
dd195164-f3bb-483b-ae76-7085f7c6697e	4830cf13-0932-4731-992c-4432d629f228	08cc757a-b266-4eb6-9fb4-efca7d24f454	10.0000	10.0000	5350.0000	53500.0000	2026-06-01 20:30:30.344064+00	85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a
41e5a1e3-70b7-40b2-92dd-b3465bf5bf42	5f0ec1f4-8ed0-402c-b11c-92647a5d157e	306a2174-24cb-4391-9413-4bb02927e59e	5.0000	5.0000	2675.0000	13375.0000	2026-06-01 20:34:20.067484+00	85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a
b6bb1010-a3fb-4310-af94-1633bf94dbfd	5f0ec1f4-8ed0-402c-b11c-92647a5d157e	08cc757a-b266-4eb6-9fb4-efca7d24f454	2.0000	10.0000	5350.0000	10700.0000	2026-06-01 20:34:20.067484+00	85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a
\.


--
-- Data for Name: purchase_invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchase_invoices (id, invoice_no, invoice_date, supplier_id, payment_type, currency_code, exchange_rate, total_foreign, total_local, notes, created_by, updated_by, created_at, updated_at) FROM stdin;
4830cf13-0932-4731-992c-4432d629f228	110	2026-06-01	2f8f8a60-e06b-40d0-beca-3bc648a1b953	credit	USD	535.000000	100.0000	53500.0000	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-06-01 20:30:30.328609+00	2026-06-01 20:30:30.328609+00
5f0ec1f4-8ed0-402c-b11c-92647a5d157e	110	2026-06-01	9069ec45-3329-482f-a675-49aa97a30bf9	credit	USD	535.000000	45.0000	24075.0000	تجريبي	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-06-01 20:34:20.049524+00	2026-06-01 20:34:20.049524+00
\.


--
-- Data for Name: stock_movements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_movements (id, item_id, movement_type, quantity, unit_price_local, reference_table, reference_id, movement_date, notes, created_by, created_at) FROM stdin;
bed7e426-90a1-4f85-9a28-9cc8764febe7	08cc757a-b266-4eb6-9fb4-efca7d24f454	purchase	10.0000	5350.0000	purchase_invoices	4830cf13-0932-4731-992c-4432d629f228	2026-06-01	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:30:30.344064+00
45c0c039-7b84-46d9-a291-5b0e18291c8e	306a2174-24cb-4391-9413-4bb02927e59e	purchase	5.0000	2675.0000	purchase_invoices	5f0ec1f4-8ed0-402c-b11c-92647a5d157e	2026-06-01	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00
cab6fbdf-b00b-4ba0-89e1-1add1b445fea	08cc757a-b266-4eb6-9fb4-efca7d24f454	purchase	2.0000	5350.0000	purchase_invoices	5f0ec1f4-8ed0-402c-b11c-92647a5d157e	2026-06-01	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:34:20.067484+00
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (id, name, phone, notes, created_by, updated_by, created_at, updated_at, default_currency, default_payment_type) FROM stdin;
2f8f8a60-e06b-40d0-beca-3bc648a1b953	Test Supplier	05551234	\N	85d2a767-bae1-4a79-8dda-cbe035239f5a	85d2a767-bae1-4a79-8dda-cbe035239f5a	2026-06-01 20:25:44.198903+00	2026-06-01 20:30:06.260795+00	USD	credit
9069ec45-3329-482f-a675-49aa97a30bf9	احمد الاشول	777775555	تجريبي	85d2a767-bae1-4a79-8dda-cbe035239f5a	\N	2026-06-01 20:31:26.140998+00	2026-06-01 20:31:26.140998+00	USD	credit
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.units (id, name_ar, name_en, created_at) FROM stdin;
633bfcea-7dac-4133-af8a-6567d5976329	كرتون	Carton	2026-05-29 22:10:16.314754+00
4a8b2f0f-1843-488b-aed1-9831dec8e144	كيلوغرام	Kilogram	2026-05-29 22:10:16.314754+00
c9490ddb-6b93-4f47-b96b-d1442f5d8507	لتر	Liter	2026-05-29 22:10:16.314754+00
8d77e3fb-8cb0-4945-bb9a-f90c7ed73ce3	متر	Meter	2026-05-29 22:10:16.314754+00
571d6333-a466-48f1-bfc3-c38f755c71dd	حبة	Piece	2026-05-29 22:10:16.314754+00
\.


--
-- Data for Name: user_permission_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permission_groups (user_id, group_id, created_by) FROM stdin;
85d2a767-bae1-4a79-8dda-cbe035239f5a	08209396-8e16-4850-900c-af01b125929f	\N
dbf26535-d542-4c77-9151-d39dbad967cd	f5b5b5fb-3952-4a23-bb49-bc6a71f2baf7	85d2a767-bae1-4a79-8dda-cbe035239f5a
a36f3f23-61d5-4b30-8573-23d6a3fc2273	54f16aca-1775-45a2-b75d-9098abfdc0d4	6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d
6bdd4a9f-79ce-4c95-8f24-680a9c53eb8d	08209396-8e16-4850-900c-af01b125929f	85d2a767-bae1-4a79-8dda-cbe035239f5a
\.


--
-- Data for Name: user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_permissions (user_id, permission_key, created_by) FROM stdin;
\.


--
-- Data for Name: messages_2026_06_16; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_06_16 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_06_17; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_06_17 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_06_18; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_06_18 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_06_19; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_06_19 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_06_20; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_06_20 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: messages_2026_06_21; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2026_06_21 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-05-29 22:10:08
20211116045059	2026-05-29 22:10:08
20211116050929	2026-05-29 22:10:08
20211116051442	2026-05-29 22:10:08
20211116212300	2026-05-29 22:10:08
20211116213355	2026-05-29 22:10:08
20211116213934	2026-05-29 22:10:08
20211116214523	2026-05-29 22:10:08
20211122062447	2026-05-29 22:10:08
20211124070109	2026-05-29 22:10:08
20211202204204	2026-05-29 22:10:08
20211202204605	2026-05-29 22:10:08
20211210212804	2026-05-29 22:10:08
20211228014915	2026-05-29 22:10:08
20220107221237	2026-05-29 22:10:08
20220228202821	2026-05-29 22:10:08
20220312004840	2026-05-29 22:10:08
20220603231003	2026-05-29 22:10:08
20220603232444	2026-05-29 22:10:08
20220615214548	2026-05-29 22:10:08
20220712093339	2026-05-29 22:10:08
20220908172859	2026-05-29 22:10:08
20220916233421	2026-05-29 22:10:08
20230119133233	2026-05-29 22:10:08
20230128025114	2026-05-29 22:10:08
20230128025212	2026-05-29 22:10:08
20230227211149	2026-05-29 22:10:08
20230228184745	2026-05-29 22:10:08
20230308225145	2026-05-29 22:10:08
20230328144023	2026-05-29 22:10:08
20231018144023	2026-05-29 22:10:08
20231204144023	2026-05-29 22:10:08
20231204144024	2026-05-29 22:10:08
20231204144025	2026-05-29 22:10:08
20240108234812	2026-05-29 22:10:08
20240109165339	2026-05-29 22:10:08
20240227174441	2026-05-29 22:10:08
20240311171622	2026-05-29 22:10:08
20240321100241	2026-05-29 22:10:08
20240401105812	2026-05-29 22:10:08
20240418121054	2026-05-29 22:10:08
20240523004032	2026-05-29 22:10:08
20240618124746	2026-05-29 22:10:08
20240801235015	2026-05-29 22:10:08
20240805133720	2026-05-29 22:10:08
20240827160934	2026-05-29 22:10:08
20240919163303	2026-05-29 22:10:08
20240919163305	2026-05-29 22:10:08
20241019105805	2026-05-29 22:10:08
20241030150047	2026-05-29 22:10:08
20241108114728	2026-05-29 22:10:08
20241121104152	2026-05-29 22:10:08
20241130184212	2026-05-29 22:10:08
20241220035512	2026-05-29 22:10:08
20241220123912	2026-05-29 22:10:08
20241224161212	2026-05-29 22:10:08
20250107150512	2026-05-29 22:10:08
20250110162412	2026-05-29 22:10:08
20250123174212	2026-05-29 22:10:08
20250128220012	2026-05-29 22:10:08
20250506224012	2026-05-29 22:10:08
20250523164012	2026-05-29 22:10:08
20250714121412	2026-05-29 22:10:08
20250905041441	2026-05-29 22:10:08
20251103001201	2026-05-29 22:10:08
20251120212548	2026-05-29 22:10:08
20251120215549	2026-05-29 22:10:08
20260218120000	2026-05-29 22:10:08
20260326120000	2026-05-29 22:10:08
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: iceberg_namespaces; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_namespaces (id, bucket_name, name, created_at, updated_at, metadata, catalog_id) FROM stdin;
\.


--
-- Data for Name: iceberg_tables; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.iceberg_tables (id, namespace_id, bucket_name, name, location, created_at, updated_at, remote_table_id, shard_key, shard_id, catalog_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-05-29 22:10:14.112327
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-05-29 22:10:14.120739
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-05-29 22:10:14.125208
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-05-29 22:10:14.136682
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-05-29 22:10:14.144356
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-05-29 22:10:14.148236
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-05-29 22:10:14.153524
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-05-29 22:10:14.157995
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-05-29 22:10:14.162103
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-05-29 22:10:14.165565
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-05-29 22:10:14.170138
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-05-29 22:10:14.174497
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-05-29 22:10:14.179078
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-05-29 22:10:14.182935
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-05-29 22:10:14.186928
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-05-29 22:10:14.200528
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-05-29 22:10:14.205623
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-05-29 22:10:14.20954
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-05-29 22:10:14.213366
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-05-29 22:10:14.218471
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-05-29 22:10:14.222661
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-05-29 22:10:14.227049
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-05-29 22:10:14.236886
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-05-29 22:10:14.24419
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-05-29 22:10:14.248909
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-05-29 22:10:14.252871
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-05-29 22:10:14.256867
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-05-29 22:10:14.260431
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-05-29 22:10:14.264527
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-05-29 22:10:14.267863
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-05-29 22:10:14.27167
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-05-29 22:10:14.27496
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-05-29 22:10:14.278821
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-05-29 22:10:14.282006
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-05-29 22:10:14.286258
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-05-29 22:10:14.289144
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-05-29 22:10:14.29296
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-05-29 22:10:14.295883
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-05-29 22:10:14.300981
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-05-29 22:10:14.314819
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-05-29 22:10:14.318593
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-05-29 22:10:14.32192
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-05-29 22:10:14.325423
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-05-29 22:10:14.328959
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-05-29 22:10:14.332544
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-05-29 22:10:14.336421
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-05-29 22:10:14.344213
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-05-29 22:10:14.348847
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-05-29 22:10:14.353277
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-05-29 22:10:14.375872
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-05-29 22:10:14.380244
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-05-29 22:10:14.398028
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-05-29 22:10:14.40019
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-05-29 22:10:14.417869
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-05-29 22:10:14.422638
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-05-29 22:10:14.42542
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-05-29 22:10:14.433435
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-05-29 22:10:14.44041
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-05-29 22:10:14.445028
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2026-05-29 22:09:57.65894+00
20210809183423_update_grants	2026-05-29 22:09:57.65894+00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20260527154130	{"-- =====================================================\r\n-- PROFILES & PERMISSIONS\r\n-- =====================================================\r\n\r\nCREATE TABLE public.profiles (\r\n  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,\r\n  username TEXT UNIQUE NOT NULL,\r\n  full_name TEXT,\r\n  is_active BOOLEAN NOT NULL DEFAULT true,\r\n  locale TEXT NOT NULL DEFAULT 'ar',\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE TABLE public.permissions (\r\n  key TEXT PRIMARY KEY,\r\n  label_ar TEXT NOT NULL,\r\n  label_en TEXT NOT NULL,\r\n  category TEXT NOT NULL\r\n)","CREATE TABLE public.permission_groups (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  name TEXT NOT NULL UNIQUE,\r\n  description TEXT,\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE TABLE public.permission_group_items (\r\n  group_id UUID NOT NULL REFERENCES public.permission_groups(id) ON DELETE CASCADE,\r\n  permission_key TEXT NOT NULL REFERENCES public.permissions(key) ON DELETE CASCADE,\r\n  PRIMARY KEY (group_id, permission_key)\r\n)","CREATE TABLE public.user_permissions (\r\n  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,\r\n  permission_key TEXT NOT NULL REFERENCES public.permissions(key) ON DELETE CASCADE,\r\n  PRIMARY KEY (user_id, permission_key)\r\n)","CREATE TABLE public.user_permission_groups (\r\n  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,\r\n  group_id UUID NOT NULL REFERENCES public.permission_groups(id) ON DELETE CASCADE,\r\n  PRIMARY KEY (user_id, group_id)\r\n)","-- Security definer permission check\r\nCREATE OR REPLACE FUNCTION public.has_permission(_user_id UUID, _permission TEXT)\r\nRETURNS BOOLEAN\r\nLANGUAGE SQL\r\nSTABLE\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\n  SELECT EXISTS (\r\n    SELECT 1 FROM public.user_permissions\r\n    WHERE user_id = _user_id AND permission_key = _permission\r\n  ) OR EXISTS (\r\n    SELECT 1 FROM public.user_permission_groups upg\r\n    JOIN public.permission_group_items pgi ON pgi.group_id = upg.group_id\r\n    WHERE upg.user_id = _user_id AND pgi.permission_key = _permission\r\n  );\r\n$$","CREATE OR REPLACE FUNCTION public.is_admin(_user_id UUID)\r\nRETURNS BOOLEAN\r\nLANGUAGE SQL STABLE SECURITY DEFINER SET search_path = public\r\nAS $$\r\n  SELECT public.has_permission(_user_id, 'system.admin');\r\n$$","-- =====================================================\r\n-- LOOKUP TABLES\r\n-- =====================================================\r\n\r\nCREATE TABLE public.currencies (\r\n  code TEXT PRIMARY KEY,\r\n  name_ar TEXT NOT NULL,\r\n  name_en TEXT NOT NULL,\r\n  symbol TEXT NOT NULL,\r\n  is_base BOOLEAN NOT NULL DEFAULT false\r\n)","CREATE TABLE public.exchange_rates (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  currency_code TEXT NOT NULL REFERENCES public.currencies(code),\r\n  rate_to_base NUMERIC(18, 6) NOT NULL,\r\n  rate_date DATE NOT NULL DEFAULT CURRENT_DATE,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  UNIQUE (currency_code, rate_date)\r\n)","CREATE TABLE public.units (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  name_ar TEXT NOT NULL,\r\n  name_en TEXT NOT NULL,\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE TABLE public.categories (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  name_ar TEXT NOT NULL,\r\n  name_en TEXT,\r\n  parent_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  updated_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","-- =====================================================\r\n-- ITEMS\r\n-- =====================================================\r\n\r\nCREATE TABLE public.items (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  code TEXT UNIQUE,\r\n  name_ar TEXT NOT NULL,\r\n  name_en TEXT,\r\n  category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,\r\n  unit_id UUID REFERENCES public.units(id) ON DELETE SET NULL,\r\n  last_purchase_price_local NUMERIC(18, 4) DEFAULT 0,\r\n  notes TEXT,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  updated_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE INDEX idx_items_category ON public.items(category_id)","CREATE INDEX idx_items_name_ar ON public.items(name_ar)","-- =====================================================\r\n-- SUPPLIERS & CUSTOMERS\r\n-- =====================================================\r\n\r\nCREATE TABLE public.suppliers (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  name TEXT NOT NULL,\r\n  phone TEXT,\r\n  notes TEXT,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  updated_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE TABLE public.customers (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  name TEXT NOT NULL,\r\n  phone TEXT,\r\n  notes TEXT,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  updated_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","-- =====================================================\r\n-- PURCHASE INVOICES\r\n-- =====================================================\r\n\r\nCREATE TABLE public.purchase_invoices (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  invoice_no TEXT NOT NULL,\r\n  invoice_date DATE NOT NULL DEFAULT CURRENT_DATE,\r\n  supplier_id UUID REFERENCES public.suppliers(id) ON DELETE SET NULL,\r\n  payment_type TEXT NOT NULL DEFAULT 'cash' CHECK (payment_type IN ('cash', 'credit')),\r\n  currency_code TEXT NOT NULL REFERENCES public.currencies(code),\r\n  exchange_rate NUMERIC(18, 6) NOT NULL DEFAULT 1,\r\n  total_foreign NUMERIC(18, 4) NOT NULL DEFAULT 0,\r\n  total_local NUMERIC(18, 4) NOT NULL DEFAULT 0,\r\n  notes TEXT,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  updated_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE INDEX idx_invoices_date ON public.purchase_invoices(invoice_date)","CREATE INDEX idx_invoices_supplier ON public.purchase_invoices(supplier_id)","CREATE TABLE public.purchase_invoice_items (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  invoice_id UUID NOT NULL REFERENCES public.purchase_invoices(id) ON DELETE CASCADE,\r\n  item_id UUID NOT NULL REFERENCES public.items(id) ON DELETE RESTRICT,\r\n  quantity NUMERIC(18, 4) NOT NULL,\r\n  price_foreign NUMERIC(18, 4) DEFAULT 0,\r\n  price_local NUMERIC(18, 4) NOT NULL,\r\n  line_total_local NUMERIC(18, 4) NOT NULL,\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE INDEX idx_invoice_items_invoice ON public.purchase_invoice_items(invoice_id)","CREATE INDEX idx_invoice_items_item ON public.purchase_invoice_items(item_id)","-- =====================================================\r\n-- STOCK MOVEMENTS\r\n-- =====================================================\r\n\r\nCREATE TABLE public.stock_movements (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  item_id UUID NOT NULL REFERENCES public.items(id) ON DELETE CASCADE,\r\n  movement_type TEXT NOT NULL CHECK (movement_type IN ('purchase', 'adjustment', 'opening')),\r\n  quantity NUMERIC(18, 4) NOT NULL,\r\n  unit_price_local NUMERIC(18, 4) NOT NULL DEFAULT 0,\r\n  reference_table TEXT,\r\n  reference_id UUID,\r\n  movement_date DATE NOT NULL DEFAULT CURRENT_DATE,\r\n  notes TEXT,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE INDEX idx_movements_item ON public.stock_movements(item_id)","CREATE INDEX idx_movements_date ON public.stock_movements(movement_date)","-- =====================================================\r\n-- DEBT TRANSACTIONS\r\n-- =====================================================\r\n\r\nCREATE TABLE public.debt_transactions (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  customer_id UUID NOT NULL REFERENCES public.customers(id) ON DELETE CASCADE,\r\n  transaction_type TEXT NOT NULL CHECK (transaction_type IN ('debit', 'credit')),\r\n  amount NUMERIC(18, 4) NOT NULL,\r\n  currency_code TEXT NOT NULL REFERENCES public.currencies(code),\r\n  exchange_rate NUMERIC(18, 6) NOT NULL DEFAULT 1,\r\n  amount_local NUMERIC(18, 4) NOT NULL,\r\n  invoice_ref TEXT,\r\n  notes TEXT,\r\n  transaction_date DATE NOT NULL DEFAULT CURRENT_DATE,\r\n  created_by UUID REFERENCES public.profiles(id),\r\n  updated_by UUID REFERENCES public.profiles(id),\r\n  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()\r\n)","CREATE INDEX idx_debt_customer ON public.debt_transactions(customer_id)","CREATE INDEX idx_debt_date ON public.debt_transactions(transaction_date)","-- =====================================================\r\n-- AUDIT LOG\r\n-- =====================================================\r\n\r\nCREATE TABLE public.audit_logs (\r\n  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),\r\n  table_name TEXT NOT NULL,\r\n  record_id UUID,\r\n  action TEXT NOT NULL,\r\n  changed_by UUID REFERENCES public.profiles(id),\r\n  changed_at TIMESTAMPTZ NOT NULL DEFAULT now(),\r\n  diff JSONB\r\n)","CREATE INDEX idx_audit_table ON public.audit_logs(table_name)","CREATE INDEX idx_audit_date ON public.audit_logs(changed_at)","-- =====================================================\r\n-- GRANTS\r\n-- =====================================================\r\n\r\nGRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO authenticated","GRANT SELECT ON public.permissions TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.permission_groups TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.permission_group_items TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_permissions TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.user_permission_groups TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.currencies TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.exchange_rates TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.units TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.categories TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.items TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.suppliers TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.customers TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.purchase_invoices TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.purchase_invoice_items TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.stock_movements TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.debt_transactions TO authenticated","GRANT SELECT, INSERT, UPDATE, DELETE ON public.audit_logs TO authenticated","GRANT ALL ON ALL TABLES IN SCHEMA public TO service_role","-- =====================================================\r\n-- ENABLE RLS\r\n-- =====================================================\r\n\r\nALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY","ALTER TABLE public.permissions ENABLE ROW LEVEL SECURITY","ALTER TABLE public.permission_groups ENABLE ROW LEVEL SECURITY","ALTER TABLE public.permission_group_items ENABLE ROW LEVEL SECURITY","ALTER TABLE public.user_permissions ENABLE ROW LEVEL SECURITY","ALTER TABLE public.user_permission_groups ENABLE ROW LEVEL SECURITY","ALTER TABLE public.currencies ENABLE ROW LEVEL SECURITY","ALTER TABLE public.exchange_rates ENABLE ROW LEVEL SECURITY","ALTER TABLE public.units ENABLE ROW LEVEL SECURITY","ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY","ALTER TABLE public.items ENABLE ROW LEVEL SECURITY","ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY","ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY","ALTER TABLE public.purchase_invoices ENABLE ROW LEVEL SECURITY","ALTER TABLE public.purchase_invoice_items ENABLE ROW LEVEL SECURITY","ALTER TABLE public.stock_movements ENABLE ROW LEVEL SECURITY","ALTER TABLE public.debt_transactions ENABLE ROW LEVEL SECURITY","ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY","-- =====================================================\r\n-- RLS POLICIES — All authenticated can read; permission-gated writes\r\n-- =====================================================\r\n\r\n-- Profiles\r\nCREATE POLICY \\"auth read profiles\\" ON public.profiles FOR SELECT TO authenticated USING (true)","CREATE POLICY \\"self update profile\\" ON public.profiles FOR UPDATE TO authenticated USING (id = auth.uid())","CREATE POLICY \\"admins manage profiles\\" ON public.profiles FOR ALL TO authenticated\r\n  USING (public.has_permission(auth.uid(), 'users.manage'))\r\n  WITH CHECK (public.has_permission(auth.uid(), 'users.manage'))","-- Permissions catalog (read-only)\r\nCREATE POLICY \\"auth read permissions\\" ON public.permissions FOR SELECT TO authenticated USING (true)","-- Permission groups\r\nCREATE POLICY \\"auth read pgroups\\" ON public.permission_groups FOR SELECT TO authenticated USING (true)","CREATE POLICY \\"manage pgroups\\" ON public.permission_groups FOR ALL TO authenticated\r\n  USING (public.has_permission(auth.uid(), 'permissions.manage'))\r\n  WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'))","CREATE POLICY \\"auth read pgi\\" ON public.permission_group_items FOR SELECT TO authenticated USING (true)","CREATE POLICY \\"manage pgi\\" ON public.permission_group_items FOR ALL TO authenticated\r\n  USING (public.has_permission(auth.uid(), 'permissions.manage'))\r\n  WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'))","CREATE POLICY \\"auth read up\\" ON public.user_permissions FOR SELECT TO authenticated USING (true)","CREATE POLICY \\"manage up\\" ON public.user_permissions FOR ALL TO authenticated\r\n  USING (public.has_permission(auth.uid(), 'permissions.manage'))\r\n  WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'))","CREATE POLICY \\"auth read upg\\" ON public.user_permission_groups FOR SELECT TO authenticated USING (true)","CREATE POLICY \\"manage upg\\" ON public.user_permission_groups FOR ALL TO authenticated\r\n  USING (public.has_permission(auth.uid(), 'permissions.manage'))\r\n  WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'))","-- Helper to make generic policies\r\n-- Generic read for everyone authenticated, perm-gated for writes\r\nDO $$\r\nDECLARE\r\n  t TEXT;\r\n  p_view TEXT;\r\n  p_manage TEXT;\r\nBEGIN\r\n  FOR t, p_view, p_manage IN\r\n    SELECT * FROM (VALUES\r\n      ('currencies', 'settings.view', 'settings.manage'),\r\n      ('exchange_rates', 'settings.view', 'settings.manage'),\r\n      ('units', 'settings.view', 'settings.manage'),\r\n      ('categories', 'items.view', 'items.manage'),\r\n      ('items', 'items.view', 'items.manage'),\r\n      ('suppliers', 'suppliers.view', 'suppliers.manage'),\r\n      ('customers', 'customers.view', 'customers.manage'),\r\n      ('purchase_invoices', 'invoices.view', 'invoices.manage'),\r\n      ('purchase_invoice_items', 'invoices.view', 'invoices.manage'),\r\n      ('stock_movements', 'items.view', 'invoices.manage'),\r\n      ('debt_transactions', 'debts.view', 'debts.manage'),\r\n      ('audit_logs', 'reports.view', 'system.admin')\r\n    ) AS x(t, v, m)\r\n  LOOP\r\n    EXECUTE format('CREATE POLICY \\"auth read %I\\" ON public.%I FOR SELECT TO authenticated USING (true)', t, t);\r\n    EXECUTE format('CREATE POLICY \\"perm write %I\\" ON public.%I FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), %L))', t, t, p_manage);\r\n    EXECUTE format('CREATE POLICY \\"perm update %I\\" ON public.%I FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), %L)) WITH CHECK (public.has_permission(auth.uid(), %L))', t, t, p_manage, p_manage);\r\n    EXECUTE format('CREATE POLICY \\"perm delete %I\\" ON public.%I FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), %L))', t, t, p_manage);\r\n  END LOOP;\r\nEND $$","-- =====================================================\r\n-- SEED DATA\r\n-- =====================================================\r\n\r\nINSERT INTO public.permissions (key, label_ar, label_en, category) VALUES\r\n  ('system.admin', 'مسؤول النظام', 'System Admin', 'system'),\r\n  ('users.manage', 'إدارة المستخدمين', 'Manage Users', 'users'),\r\n  ('permissions.manage', 'إدارة الصلاحيات', 'Manage Permissions', 'users'),\r\n  ('settings.view', 'عرض الإعدادات', 'View Settings', 'settings'),\r\n  ('settings.manage', 'إدارة الإعدادات', 'Manage Settings', 'settings'),\r\n  ('items.view', 'عرض الأصناف', 'View Items', 'items'),\r\n  ('items.manage', 'إدارة الأصناف', 'Manage Items', 'items'),\r\n  ('items.import', 'استيراد أصناف من Excel', 'Import Items', 'items'),\r\n  ('suppliers.view', 'عرض الموردين', 'View Suppliers', 'suppliers'),\r\n  ('suppliers.manage', 'إدارة الموردين', 'Manage Suppliers', 'suppliers'),\r\n  ('customers.view', 'عرض العملاء', 'View Customers', 'customers'),\r\n  ('customers.manage', 'إدارة العملاء', 'Manage Customers', 'customers'),\r\n  ('invoices.view', 'عرض الفواتير', 'View Invoices', 'invoices'),\r\n  ('invoices.manage', 'إدارة الفواتير', 'Manage Invoices', 'invoices'),\r\n  ('debts.view', 'عرض كشوف الحسابات', 'View Debts', 'debts'),\r\n  ('debts.manage', 'إدارة الديون والقبض', 'Manage Debts', 'debts'),\r\n  ('reports.view', 'عرض التقارير', 'View Reports', 'reports'),\r\n  ('reports.export', 'تصدير التقارير', 'Export Reports', 'reports')","INSERT INTO public.currencies (code, name_ar, name_en, symbol, is_base) VALUES\r\n  ('YER', 'ريال يمني', 'Yemeni Rial', 'ر.ي', true),\r\n  ('USD', 'دولار أمريكي', 'US Dollar', '$', false),\r\n  ('SAR', 'ريال سعودي', 'Saudi Riyal', 'ر.س', false)","INSERT INTO public.exchange_rates (currency_code, rate_to_base, rate_date) VALUES\r\n  ('YER', 1, CURRENT_DATE),\r\n  ('USD', 535, CURRENT_DATE),\r\n  ('SAR', 142, CURRENT_DATE)","INSERT INTO public.units (name_ar, name_en) VALUES\r\n  ('قطعة', 'Piece'),\r\n  ('كرتون', 'Carton'),\r\n  ('كيلوغرام', 'Kilogram'),\r\n  ('لتر', 'Liter'),\r\n  ('متر', 'Meter')","INSERT INTO public.permission_groups (name, description) VALUES\r\n  ('admin', 'صلاحيات كاملة'),\r\n  ('manager', 'مدير - كل العمليات عدا إدارة المستخدمين'),\r\n  ('data_entry', 'إدخال البيانات والفواتير'),\r\n  ('viewer', 'عرض فقط')","-- Seed group permissions\r\nINSERT INTO public.permission_group_items (group_id, permission_key)\r\nSELECT g.id, p.key FROM public.permission_groups g, public.permissions p WHERE g.name = 'admin'","INSERT INTO public.permission_group_items (group_id, permission_key)\r\nSELECT g.id, p.key FROM public.permission_groups g, public.permissions p\r\nWHERE g.name = 'manager' AND p.key NOT IN ('system.admin', 'users.manage', 'permissions.manage')","INSERT INTO public.permission_group_items (group_id, permission_key)\r\nSELECT g.id, p.key FROM public.permission_groups g, public.permissions p\r\nWHERE g.name = 'data_entry' AND p.key IN (\r\n  'items.view', 'items.manage', 'items.import',\r\n  'suppliers.view', 'suppliers.manage',\r\n  'customers.view', 'customers.manage',\r\n  'invoices.view', 'invoices.manage',\r\n  'debts.view', 'debts.manage',\r\n  'settings.view', 'reports.view'\r\n)","INSERT INTO public.permission_group_items (group_id, permission_key)\r\nSELECT g.id, p.key FROM public.permission_groups g, public.permissions p\r\nWHERE g.name = 'viewer' AND p.key IN (\r\n  'items.view', 'suppliers.view', 'customers.view',\r\n  'invoices.view', 'debts.view', 'reports.view', 'settings.view'\r\n)","-- =====================================================\r\n-- TRIGGERS\r\n-- =====================================================\r\n\r\nCREATE OR REPLACE FUNCTION public.set_updated_at()\r\nRETURNS TRIGGER LANGUAGE plpgsql AS $$\r\nBEGIN\r\n  NEW.updated_at = now();\r\n  RETURN NEW;\r\nEND $$","DO $$\r\nDECLARE t TEXT;\r\nBEGIN\r\n  FOR t IN SELECT unnest(ARRAY[\r\n    'profiles', 'categories', 'items', 'suppliers', 'customers',\r\n    'purchase_invoices', 'debt_transactions'\r\n  ]) LOOP\r\n    EXECUTE format('CREATE TRIGGER trg_%I_updated BEFORE UPDATE ON public.%I FOR EACH ROW EXECUTE FUNCTION public.set_updated_at()', t, t);\r\n  END LOOP;\r\nEND $$","-- Auto-create profile + first user gets admin\r\nCREATE OR REPLACE FUNCTION public.handle_new_user()\r\nRETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$\r\nDECLARE\r\n  v_username TEXT;\r\n  v_count INT;\r\n  v_admin_group UUID;\r\nBEGIN\r\n  v_username := COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1));\r\n\r\n  INSERT INTO public.profiles (id, username, full_name)\r\n  VALUES (NEW.id, v_username, COALESCE(NEW.raw_user_meta_data->>'full_name', v_username));\r\n\r\n  SELECT COUNT(*) INTO v_count FROM public.profiles;\r\n  IF v_count = 1 THEN\r\n    SELECT id INTO v_admin_group FROM public.permission_groups WHERE name = 'admin';\r\n    IF v_admin_group IS NOT NULL THEN\r\n      INSERT INTO public.user_permission_groups (user_id, group_id) VALUES (NEW.id, v_admin_group);\r\n    END IF;\r\n  END IF;\r\n\r\n  RETURN NEW;\r\nEND $$","CREATE TRIGGER on_auth_user_created\r\n  AFTER INSERT ON auth.users\r\n  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user()","-- Generate stock movements + update last price on invoice item insert\r\nCREATE OR REPLACE FUNCTION public.on_invoice_item_change()\r\nRETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$\r\nDECLARE\r\n  v_invoice public.purchase_invoices%ROWTYPE;\r\nBEGIN\r\n  SELECT * INTO v_invoice FROM public.purchase_invoices WHERE id = NEW.invoice_id;\r\n\r\n  INSERT INTO public.stock_movements (\r\n    item_id, movement_type, quantity, unit_price_local,\r\n    reference_table, reference_id, movement_date, created_by\r\n  ) VALUES (\r\n    NEW.item_id, 'purchase', NEW.quantity, NEW.price_local,\r\n    'purchase_invoices', NEW.invoice_id, v_invoice.invoice_date, v_invoice.created_by\r\n  );\r\n\r\n  UPDATE public.items\r\n    SET last_purchase_price_local = NEW.price_local, updated_at = now()\r\n    WHERE id = NEW.item_id;\r\n\r\n  RETURN NEW;\r\nEND $$","CREATE TRIGGER trg_invoice_item_stock\r\n  AFTER INSERT ON public.purchase_invoice_items\r\n  FOR EACH ROW EXECUTE FUNCTION public.on_invoice_item_change()","-- Remove stock movements when invoice item deleted\r\nCREATE OR REPLACE FUNCTION public.on_invoice_item_delete()\r\nRETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$\r\nBEGIN\r\n  DELETE FROM public.stock_movements\r\n  WHERE reference_table = 'purchase_invoices'\r\n    AND reference_id = OLD.invoice_id\r\n    AND item_id = OLD.item_id;\r\n  RETURN OLD;\r\nEND $$","CREATE TRIGGER trg_invoice_item_stock_del\r\n  BEFORE DELETE ON public.purchase_invoice_items\r\n  FOR EACH ROW EXECUTE FUNCTION public.on_invoice_item_delete()","-- Compute amount_local on debt transactions\r\nCREATE OR REPLACE FUNCTION public.compute_debt_local()\r\nRETURNS TRIGGER LANGUAGE plpgsql AS $$\r\nBEGIN\r\n  NEW.amount_local := NEW.amount * NEW.exchange_rate;\r\n  RETURN NEW;\r\nEND $$","CREATE TRIGGER trg_debt_local\r\n  BEFORE INSERT OR UPDATE ON public.debt_transactions\r\n  FOR EACH ROW EXECUTE FUNCTION public.compute_debt_local()","-- View for current stock quantities\r\nCREATE OR REPLACE VIEW public.item_stock AS\r\nSELECT\r\n  i.id AS item_id,\r\n  i.code,\r\n  i.name_ar,\r\n  i.name_en,\r\n  i.category_id,\r\n  i.unit_id,\r\n  i.last_purchase_price_local,\r\n  COALESCE(SUM(sm.quantity), 0) AS current_quantity,\r\n  COALESCE(SUM(sm.quantity), 0) * i.last_purchase_price_local AS stock_value\r\nFROM public.items i\r\nLEFT JOIN public.stock_movements sm ON sm.item_id = i.id\r\nGROUP BY i.id","GRANT SELECT ON public.item_stock TO authenticated","-- Customer balance view\r\nCREATE OR REPLACE VIEW public.customer_balances AS\r\nSELECT\r\n  c.id AS customer_id,\r\n  c.name,\r\n  c.phone,\r\n  COALESCE(SUM(CASE WHEN dt.transaction_type = 'debit' THEN dt.amount_local ELSE 0 END), 0) AS total_debit,\r\n  COALESCE(SUM(CASE WHEN dt.transaction_type = 'credit' THEN dt.amount_local ELSE 0 END), 0) AS total_credit,\r\n  COALESCE(SUM(CASE WHEN dt.transaction_type = 'debit' THEN dt.amount_local ELSE -dt.amount_local END), 0) AS balance\r\nFROM public.customers c\r\nLEFT JOIN public.debt_transactions dt ON dt.customer_id = c.id\r\nGROUP BY c.id","GRANT SELECT ON public.customer_balances TO authenticated"}	28d5e494-bc98-4026-aef0-b61da7e23c5f
20260527154146	{"ALTER VIEW public.item_stock SET (security_invoker = true)","ALTER VIEW public.customer_balances SET (security_invoker = true)","CREATE OR REPLACE FUNCTION public.set_updated_at()\r\nRETURNS TRIGGER LANGUAGE plpgsql SET search_path = public AS $$\r\nBEGIN\r\n  NEW.updated_at = now();\r\n  RETURN NEW;\r\nEND $$","CREATE OR REPLACE FUNCTION public.compute_debt_local()\r\nRETURNS TRIGGER LANGUAGE plpgsql SET search_path = public AS $$\r\nBEGIN\r\n  NEW.amount_local := NEW.amount * NEW.exchange_rate;\r\n  RETURN NEW;\r\nEND $$"}	fe578b1d-13bf-48af-89ef-f855e3826fa3
20260527154200	{"REVOKE EXECUTE ON FUNCTION public.has_permission(UUID, TEXT) FROM PUBLIC, anon","REVOKE EXECUTE ON FUNCTION public.is_admin(UUID) FROM PUBLIC, anon","REVOKE EXECUTE ON FUNCTION public.handle_new_user() FROM PUBLIC, anon, authenticated","REVOKE EXECUTE ON FUNCTION public.on_invoice_item_change() FROM PUBLIC, anon, authenticated","REVOKE EXECUTE ON FUNCTION public.on_invoice_item_delete() FROM PUBLIC, anon, authenticated","GRANT EXECUTE ON FUNCTION public.has_permission(UUID, TEXT) TO authenticated","GRANT EXECUTE ON FUNCTION public.is_admin(UUID) TO authenticated"}	eac94170-1096-414c-b67b-c8325bb35c6d
20260530100000	{"-- =====================================================\r\n-- AUDIT LOGGING\r\n-- =====================================================\r\n\r\nCREATE OR REPLACE FUNCTION public.audit_log_diff(old_row jsonb, new_row jsonb)\r\nRETURNS jsonb\r\nLANGUAGE plpgsql\r\nSTABLE\r\nAS $$\r\nDECLARE\r\n  result jsonb := '[]'::jsonb;\r\n  key_name text;\r\nBEGIN\r\n  FOR key_name IN\r\n    SELECT DISTINCT key\r\n    FROM (\r\n      SELECT key FROM jsonb_each(COALESCE(old_row, '{}'::jsonb))\r\n      UNION\r\n      SELECT key FROM jsonb_each(COALESCE(new_row, '{}'::jsonb))\r\n    ) keys\r\n    ORDER BY key\r\n  LOOP\r\n    IF (COALESCE(old_row, '{}'::jsonb) -> key_name) IS DISTINCT FROM (COALESCE(new_row, '{}'::jsonb) -> key_name) THEN\r\n      result := result || jsonb_build_array(\r\n        jsonb_build_object(\r\n          'field', key_name,\r\n          'old', COALESCE(old_row, '{}'::jsonb) -> key_name,\r\n          'new', COALESCE(new_row, '{}'::jsonb) -> key_name\r\n        )\r\n      );\r\n    END IF;\r\n  END LOOP;\r\n\r\n  RETURN result;\r\nEND;\r\n$$","CREATE OR REPLACE FUNCTION public.audit_log_row_change()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nDECLARE\r\n  actor_id uuid := NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid;\r\n  old_json jsonb;\r\n  new_json jsonb;\r\n  action_name text := lower(TG_OP);\r\nBEGIN\r\n  IF TG_OP = 'INSERT' THEN\r\n    new_json := to_jsonb(NEW);\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      NEW.id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', NULL,\r\n        'after', new_json,\r\n        'changes', public.audit_log_diff('{}'::jsonb, new_json)\r\n      )\r\n    );\r\n    RETURN NEW;\r\n  ELSIF TG_OP = 'UPDATE' THEN\r\n    old_json := to_jsonb(OLD);\r\n    new_json := to_jsonb(NEW);\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      NEW.id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', old_json,\r\n        'after', new_json,\r\n        'changes', public.audit_log_diff(old_json, new_json)\r\n      )\r\n    );\r\n    RETURN NEW;\r\n  ELSE\r\n    old_json := to_jsonb(OLD);\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      OLD.id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', old_json,\r\n        'after', NULL,\r\n        'changes', public.audit_log_diff(old_json, '{}'::jsonb)\r\n      )\r\n    );\r\n    RETURN OLD;\r\n  END IF;\r\nEND;\r\n$$","DO $$\r\nDECLARE\r\n  t text;\r\nBEGIN\r\n  FOR t IN\r\n    SELECT unnest(ARRAY[\r\n      'profiles',\r\n      'permissions',\r\n      'permission_groups',\r\n      'permission_group_items',\r\n      'user_permissions',\r\n      'user_permission_groups',\r\n      'currencies',\r\n      'exchange_rates',\r\n      'units',\r\n      'categories',\r\n      'items',\r\n      'suppliers',\r\n      'customers',\r\n      'purchase_invoices',\r\n      'purchase_invoice_items',\r\n      'stock_movements',\r\n      'debt_transactions'\r\n    ])\r\n  LOOP\r\n    EXECUTE format('DROP TRIGGER IF EXISTS audit_log_row_change ON public.%I', t);\r\n    EXECUTE format(\r\n      'CREATE TRIGGER audit_log_row_change AFTER INSERT OR UPDATE OR DELETE ON public.%I FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change()',\r\n      t\r\n    );\r\n  END LOOP;\r\nEND $$","-- Make audit logs read-only for authenticated users and keep writes internal.\r\nDO $$\r\nBEGIN\r\n  DROP POLICY IF EXISTS \\"auth read audit_logs\\" ON public.audit_logs;\r\n  DROP POLICY IF EXISTS \\"perm write audit_logs\\" ON public.audit_logs;\r\n  DROP POLICY IF EXISTS \\"perm update audit_logs\\" ON public.audit_logs;\r\n  DROP POLICY IF EXISTS \\"perm delete audit_logs\\" ON public.audit_logs;\r\nEND $$","REVOKE INSERT, UPDATE, DELETE ON public.audit_logs FROM authenticated","GRANT SELECT ON public.audit_logs TO authenticated"}	audit_log_triggers
20260530112000	{"-- =====================================================\r\n-- AUDIT LOG ACCESS + ACTOR RESOLUTION\r\n-- =====================================================\r\n\r\nCREATE OR REPLACE FUNCTION public.audit_log_row_change()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nDECLARE\r\n  actor_id uuid;\r\n  old_json jsonb;\r\n  new_json jsonb;\r\n  action_name text := lower(TG_OP);\r\nBEGIN\r\n  IF TG_OP = 'INSERT' THEN\r\n    new_json := to_jsonb(NEW);\r\n    actor_id := COALESCE(\r\n      NULLIF(new_json ->> 'updated_by', '')::uuid,\r\n      NULLIF(new_json ->> 'created_by', '')::uuid,\r\n      NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid\r\n    );\r\n\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      NEW.id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', NULL,\r\n        'after', new_json,\r\n        'changes', public.audit_log_diff('{}'::jsonb, new_json)\r\n      )\r\n    );\r\n    RETURN NEW;\r\n  ELSIF TG_OP = 'UPDATE' THEN\r\n    old_json := to_jsonb(OLD);\r\n    new_json := to_jsonb(NEW);\r\n    actor_id := COALESCE(\r\n      NULLIF(new_json ->> 'updated_by', '')::uuid,\r\n      NULLIF(new_json ->> 'created_by', '')::uuid,\r\n      NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid\r\n    );\r\n\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      NEW.id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', old_json,\r\n        'after', new_json,\r\n        'changes', public.audit_log_diff(old_json, new_json)\r\n      )\r\n    );\r\n    RETURN NEW;\r\n  ELSE\r\n    old_json := to_jsonb(OLD);\r\n    actor_id := COALESCE(\r\n      NULLIF(old_json ->> 'updated_by', '')::uuid,\r\n      NULLIF(old_json ->> 'created_by', '')::uuid,\r\n      NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid\r\n    );\r\n\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      OLD.id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', old_json,\r\n        'after', NULL,\r\n        'changes', public.audit_log_diff(old_json, '{}'::jsonb)\r\n      )\r\n    );\r\n    RETURN OLD;\r\n  END IF;\r\nEND;\r\n$$","DROP POLICY IF EXISTS \\"auth read audit_logs\\" ON public.audit_logs","CREATE POLICY \\"auth read audit_logs\\" ON public.audit_logs\r\n  FOR SELECT TO authenticated\r\n  USING (public.has_permission(auth.uid(), 'reports.view') OR public.has_permission(auth.uid(), 'system.admin'))"}	fix_audit_logs_access_and_actor
20260530113000	{"-- =====================================================\r\n-- AUDIT LOG READ ACCESS\r\n-- =====================================================\r\n\r\nDROP POLICY IF EXISTS \\"auth read audit_logs\\" ON public.audit_logs","CREATE POLICY \\"auth read audit_logs\\" ON public.audit_logs\r\n  FOR SELECT TO authenticated\r\n  USING (true)"}	open_audit_logs_select
20260601000000	{"ALTER TABLE public.purchase_invoice_items\r\n  ADD COLUMN IF NOT EXISTS created_by UUID REFERENCES public.profiles(id),\r\n  ADD COLUMN IF NOT EXISTS updated_by UUID REFERENCES public.profiles(id)"}	add_created_by_to_purchase_invoice_items
20260601001000	{"ALTER TABLE public.suppliers\r\n  ADD COLUMN IF NOT EXISTS default_currency TEXT REFERENCES public.currencies(code),\r\n  ADD COLUMN IF NOT EXISTS default_payment_type TEXT NOT NULL DEFAULT 'cash'"}	add_supplier_defaults
20260602001000	{"-- Grant execute on handle_new_user to allow auth insert triggers to run\r\nGRANT EXECUTE ON FUNCTION public.handle_new_user() TO anon, authenticated"}	grant_handle_new_user
20260602002000	{"-- Allow audit logs to have null `changed_by` for system actions\r\nALTER TABLE public.audit_logs ALTER COLUMN changed_by DROP NOT NULL"}	allow_null_audit_changed_by
20260602003000	{"-- Avoid assuming every audited table has an `id` column.\r\nCREATE OR REPLACE FUNCTION public.audit_log_row_change()\r\nRETURNS trigger\r\nLANGUAGE plpgsql\r\nSECURITY DEFINER\r\nSET search_path = public\r\nAS $$\r\nDECLARE\r\n  actor_id uuid;\r\n  old_json jsonb;\r\n  new_json jsonb;\r\n  action_name text := lower(TG_OP);\r\n  record_id uuid;\r\nBEGIN\r\n  IF TG_OP = 'INSERT' THEN\r\n    new_json := to_jsonb(NEW);\r\n    actor_id := COALESCE(\r\n      NULLIF(new_json ->> 'updated_by', '')::uuid,\r\n      NULLIF(new_json ->> 'created_by', '')::uuid,\r\n      NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid\r\n    );\r\n    record_id := CASE\r\n      WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid\r\n      ELSE NULL\r\n    END;\r\n\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      record_id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', NULL,\r\n        'after', new_json,\r\n        'changes', public.audit_log_diff('{}'::jsonb, new_json)\r\n      )\r\n    );\r\n    RETURN NEW;\r\n  ELSIF TG_OP = 'UPDATE' THEN\r\n    old_json := to_jsonb(OLD);\r\n    new_json := to_jsonb(NEW);\r\n    actor_id := COALESCE(\r\n      NULLIF(new_json ->> 'updated_by', '')::uuid,\r\n      NULLIF(new_json ->> 'created_by', '')::uuid,\r\n      NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid\r\n    );\r\n    record_id := CASE\r\n      WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid\r\n      ELSE NULL\r\n    END;\r\n\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      record_id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', old_json,\r\n        'after', new_json,\r\n        'changes', public.audit_log_diff(old_json, new_json)\r\n      )\r\n    );\r\n    RETURN NEW;\r\n  ELSE\r\n    old_json := to_jsonb(OLD);\r\n    actor_id := COALESCE(\r\n      NULLIF(old_json ->> 'updated_by', '')::uuid,\r\n      NULLIF(old_json ->> 'created_by', '')::uuid,\r\n      NULLIF(current_setting('request.jwt.claim.sub', true), '')::uuid\r\n    );\r\n    record_id := CASE\r\n      WHEN old_json ? 'id' THEN NULLIF(old_json ->> 'id', '')::uuid\r\n      ELSE NULL\r\n    END;\r\n\r\n    INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)\r\n    VALUES (\r\n      TG_TABLE_NAME,\r\n      record_id,\r\n      action_name,\r\n      actor_id,\r\n      jsonb_build_object(\r\n        'before', old_json,\r\n        'after', NULL,\r\n        'changes', public.audit_log_diff(old_json, '{}'::jsonb)\r\n      )\r\n    );\r\n    RETURN OLD;\r\n  END IF;\r\nEND;\r\n$$"}	fix_audit_log_row_change_record_id
20260603234334	{"-- ===================================================== -- RESTRICT AUDIT LOGS TO SYSTEM ADMINS -- =====================================================  DROP POLICY IF EXISTS \\"auth read audit_logs\\" ON public.audit_logs;  CREATE POLICY \\"auth read audit_logs\\" ON public.audit_logs   FOR SELECT TO authenticated   USING (public.has_permission(auth.uid(), 'system.admin'));"}	restrict_audit_logs_to_admins
20260603234518	{"-- PREVENT UPDATING currencies.code AFTER CREATION  CREATE OR REPLACE FUNCTION public.prevent_currency_code_update() RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER AS $$ BEGIN   IF TG_OP = 'UPDATE' AND NEW.code IS DISTINCT FROM OLD.code THEN     RAISE EXCEPTION 'currency code cannot be changed once created (old=% , new=%)', OLD.code, NEW.code;   END IF;   RETURN NEW; END; $$;  DO $$ BEGIN   -- Attach trigger if not exists   IF NOT EXISTS (     SELECT 1 FROM pg_trigger t JOIN pg_class c ON t.tgrelid = c.oid WHERE c.relname = 'currencies' AND t.tgname = 'prevent_currency_code_update'   ) THEN     CREATE TRIGGER prevent_currency_code_update BEFORE UPDATE ON public.currencies       FOR EACH ROW EXECUTE FUNCTION public.prevent_currency_code_update();   END IF; END$$;"}	prevent_currency_code_update
20260604003146	{"-- Migration: ensure audit trigger reads the correct JWT claim setting -- and supports a custom GUC `audit.changed_by` as a fallback. -- This helps populate `changed_by` when DB writes come from different contexts -- (client requests, server functions using service-role, or other agents).  CREATE OR REPLACE FUNCTION public.audit_log_row_change()  RETURNS trigger  LANGUAGE plpgsql  SECURITY DEFINER  SET search_path TO 'public' AS $function$ DECLARE   actor_id uuid;   old_json jsonb;   new_json jsonb;   action_name text := lower(TG_OP);   record_id uuid; BEGIN   IF TG_OP = 'INSERT' THEN     new_json := to_jsonb(NEW);     actor_id := COALESCE(       NULLIF(new_json ->> 'updated_by', '')::uuid,       NULLIF(new_json ->> 'created_by', '')::uuid,       NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('audit.changed_by', true), '')::uuid     );     record_id := CASE       WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid       ELSE NULL     END;      INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)     VALUES (       TG_TABLE_NAME,       record_id,       action_name,       actor_id,       jsonb_build_object(         'before', NULL,         'after', new_json,         'changes', public.audit_log_diff('{}'::jsonb, new_json)       )     );     RETURN NEW;   ELSIF TG_OP = 'UPDATE' THEN     old_json := to_jsonb(OLD);     new_json := to_jsonb(NEW);     actor_id := COALESCE(       NULLIF(new_json ->> 'updated_by', '')::uuid,       NULLIF(new_json ->> 'created_by', '')::uuid,       NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('audit.changed_by', true), '')::uuid     );     record_id := CASE       WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid       ELSE NULL     END;      INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)     VALUES (       TG_TABLE_NAME,       record_id,       action_name,       actor_id,       jsonb_build_object(         'before', old_json,         'after', new_json,         'changes', public.audit_log_diff(old_json, new_json)       )     );     RETURN NEW;   ELSE     old_json := to_jsonb(OLD);     actor_id := COALESCE(       NULLIF(old_json ->> 'updated_by', '')::uuid,       NULLIF(old_json ->> 'created_by', '')::uuid,       NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('audit.changed_by', true), '')::uuid     );     record_id := CASE       WHEN old_json ? 'id' THEN NULLIF(old_json ->> 'id', '')::uuid       ELSE NULL     END;      INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)     VALUES (       TG_TABLE_NAME,       record_id,       action_name,       actor_id,       jsonb_build_object(         'before', old_json,         'after', NULL,         'changes', public.audit_log_diff(old_json, '{}'::jsonb)       )     );     RETURN OLD;   END IF; END; $function$;  -- NOTE: After applying this migration, update any server-side admin code that -- performs direct DB writes with the service role to either: --  - include `created_by`/`updated_by` in inserted/updated rows, OR --  - set the session-level GUC `audit.changed_by` for the connection before --    performing the write: `SELECT set_config('audit.changed_by', '<uuid>', false);`"}	fix_audit_log_actor_setting
20260604003154	{"-- Create helper to set session-level audit.changed_by via RPC CREATE OR REPLACE FUNCTION public.set_audit_changed_by(audit_uid uuid)  RETURNS void  LANGUAGE sql  SECURITY DEFINER AS $function$ SELECT set_config('audit.changed_by', audit_uid::text, false); $function$;  COMMENT ON FUNCTION public.set_audit_changed_by(uuid) IS 'Helper to set session audit.changed_by GUC for RPC calls from supabase-js via service role client.';"}	create_set_audit_changed_by
20260604003936	{"-- Migration: extend audit trigger actor detection to parse JSON JWT claim GUCs -- Adds fallbacks for `request.jwt.claims` and `jwt.claims` JSON GUCs.  CREATE OR REPLACE FUNCTION public.audit_log_row_change()  RETURNS trigger  LANGUAGE plpgsql  SECURITY DEFINER  SET search_path TO 'public' AS $function$ DECLARE   actor_id uuid;   old_json jsonb;   new_json jsonb;   claims_text text;   action_name text := lower(TG_OP);   record_id uuid; BEGIN   -- helper to extract sub from JSON GUC safely   PERFORM 1;    IF TG_OP = 'INSERT' THEN     new_json := to_jsonb(NEW);     -- try direct fields, direct claim keys, JSON claim objects, and audit.changed_by     actor_id := COALESCE(       NULLIF(new_json ->> 'updated_by', '')::uuid,       NULLIF(new_json ->> 'created_by', '')::uuid,       NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,       (CASE WHEN current_setting('request.jwt.claims', true) IS NOT NULL         THEN NULLIF((current_setting('request.jwt.claims', true))::json->>'sub', '')::uuid         ELSE NULL END),       (CASE WHEN current_setting('jwt.claims', true) IS NOT NULL         THEN NULLIF((current_setting('jwt.claims', true))::json->>'sub', '')::uuid         ELSE NULL END),       NULLIF(current_setting('audit.changed_by', true), '')::uuid     );     record_id := CASE WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid ELSE NULL END;      INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)     VALUES (TG_TABLE_NAME, record_id, action_name, actor_id,       jsonb_build_object('before', NULL, 'after', new_json, 'changes', public.audit_log_diff('{}'::jsonb, new_json)));     RETURN NEW;    ELSIF TG_OP = 'UPDATE' THEN     old_json := to_jsonb(OLD);     new_json := to_jsonb(NEW);     actor_id := COALESCE(       NULLIF(new_json ->> 'updated_by', '')::uuid,       NULLIF(new_json ->> 'created_by', '')::uuid,       NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,       (CASE WHEN current_setting('request.jwt.claims', true) IS NOT NULL         THEN NULLIF((current_setting('request.jwt.claims', true))::json->>'sub', '')::uuid         ELSE NULL END),       (CASE WHEN current_setting('jwt.claims', true) IS NOT NULL         THEN NULLIF((current_setting('jwt.claims', true))::json->>'sub', '')::uuid         ELSE NULL END),       NULLIF(current_setting('audit.changed_by', true), '')::uuid     );     record_id := CASE WHEN new_json ? 'id' THEN NULLIF(new_json ->> 'id', '')::uuid ELSE NULL END;      INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)     VALUES (TG_TABLE_NAME, record_id, action_name, actor_id,       jsonb_build_object('before', old_json, 'after', new_json, 'changes', public.audit_log_diff(old_json, new_json)));     RETURN NEW;    ELSE     old_json := to_jsonb(OLD);     actor_id := COALESCE(       NULLIF(old_json ->> 'updated_by', '')::uuid,       NULLIF(old_json ->> 'created_by', '')::uuid,       NULLIF(current_setting('request.jwt.claims.sub', true), '')::uuid,       NULLIF(current_setting('jwt.claims.sub', true), '')::uuid,       (CASE WHEN current_setting('request.jwt.claims', true) IS NOT NULL         THEN NULLIF((current_setting('request.jwt.claims', true))::json->>'sub', '')::uuid         ELSE NULL END),       (CASE WHEN current_setting('jwt.claims', true) IS NOT NULL         THEN NULLIF((current_setting('jwt.claims', true))::json->>'sub', '')::uuid         ELSE NULL END),       NULLIF(current_setting('audit.changed_by', true), '')::uuid     );     record_id := CASE WHEN old_json ? 'id' THEN NULLIF(old_json ->> 'id', '')::uuid ELSE NULL END;      INSERT INTO public.audit_logs (table_name, record_id, action, changed_by, diff)     VALUES (TG_TABLE_NAME, record_id, action_name, actor_id,       jsonb_build_object('before', old_json, 'after', NULL, 'changes', public.audit_log_diff(old_json, '{}'::jsonb)));     RETURN OLD;   END IF; END; $function$;"}	fix_audit_log_claims_json_fallback
20260604214445	{"-- Add actor columns to permission link tables so client writes can be attributed -- and the schema cache matches the fields used by the UI.  ALTER TABLE public.user_permissions   ADD COLUMN IF NOT EXISTS created_by uuid REFERENCES public.profiles(id);  ALTER TABLE public.user_permission_groups   ADD COLUMN IF NOT EXISTS created_by uuid REFERENCES public.profiles(id); "}	add_created_by_to_permission_links
20260604214456	{"-- Admin-side database wrappers so service-role writes can run in one transaction -- with audit.changed_by set inside the database session.  CREATE OR REPLACE FUNCTION public.admin_update_profile(   p_user_id uuid,   p_actor_id uuid,   p_username text,   p_full_name text,   p_is_active boolean ) RETURNS public.profiles LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $function$ DECLARE   updated_profile public.profiles; BEGIN   PERFORM set_config('audit.changed_by', p_actor_id::text, false);    UPDATE public.profiles   SET     username = COALESCE(p_username, username),     full_name = COALESCE(p_full_name, full_name),     is_active = COALESCE(p_is_active, is_active),     updated_by = p_actor_id,     updated_at = now()   WHERE id = p_user_id   RETURNING * INTO updated_profile;    RETURN updated_profile; END; $function$;  CREATE OR REPLACE FUNCTION public.admin_delete_user_data(   p_user_id uuid,   p_actor_id uuid ) RETURNS void LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $function$ BEGIN   PERFORM set_config('audit.changed_by', p_actor_id::text, false);    DELETE FROM public.user_permissions WHERE user_id = p_user_id;   DELETE FROM public.profiles WHERE id = p_user_id; END; $function$;"}	admin_profile_wrappers_v2
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 171, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (code);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: debt_transactions debt_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_transactions
    ADD CONSTRAINT debt_transactions_pkey PRIMARY KEY (id);


--
-- Name: exchange_rates exchange_rates_currency_code_rate_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exchange_rates
    ADD CONSTRAINT exchange_rates_currency_code_rate_date_key UNIQUE (currency_code, rate_date);


--
-- Name: exchange_rates exchange_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exchange_rates
    ADD CONSTRAINT exchange_rates_pkey PRIMARY KEY (id);


--
-- Name: items items_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_code_key UNIQUE (code);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: permission_group_items permission_group_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_group_items
    ADD CONSTRAINT permission_group_items_pkey PRIMARY KEY (group_id, permission_key);


--
-- Name: permission_groups permission_groups_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_groups
    ADD CONSTRAINT permission_groups_name_key UNIQUE (name);


--
-- Name: permission_groups permission_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_groups
    ADD CONSTRAINT permission_groups_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (key);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_username_key UNIQUE (username);


--
-- Name: purchase_invoice_items purchase_invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice_items
    ADD CONSTRAINT purchase_invoice_items_pkey PRIMARY KEY (id);


--
-- Name: purchase_invoices purchase_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoices
    ADD CONSTRAINT purchase_invoices_pkey PRIMARY KEY (id);


--
-- Name: stock_movements stock_movements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_pkey PRIMARY KEY (id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


--
-- Name: user_permission_groups user_permission_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_groups
    ADD CONSTRAINT user_permission_groups_pkey PRIMARY KEY (user_id, group_id);


--
-- Name: user_permissions user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_pkey PRIMARY KEY (user_id, permission_key);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_06_16 messages_2026_06_16_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_06_16
    ADD CONSTRAINT messages_2026_06_16_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_06_17 messages_2026_06_17_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_06_17
    ADD CONSTRAINT messages_2026_06_17_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_06_18 messages_2026_06_18_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_06_18
    ADD CONSTRAINT messages_2026_06_18_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_06_19 messages_2026_06_19_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_06_19
    ADD CONSTRAINT messages_2026_06_19_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_06_20 messages_2026_06_20_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_06_20
    ADD CONSTRAINT messages_2026_06_20_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: messages_2026_06_21 messages_2026_06_21_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2026_06_21
    ADD CONSTRAINT messages_2026_06_21_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: iceberg_namespaces iceberg_namespaces_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_pkey PRIMARY KEY (id);


--
-- Name: iceberg_tables iceberg_tables_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


--
-- Name: idx_audit_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_audit_date ON public.audit_logs USING btree (changed_at);


--
-- Name: idx_audit_table; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_audit_table ON public.audit_logs USING btree (table_name);


--
-- Name: idx_debt_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_debt_customer ON public.debt_transactions USING btree (customer_id);


--
-- Name: idx_debt_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_debt_date ON public.debt_transactions USING btree (transaction_date);


--
-- Name: idx_invoice_items_invoice; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoice_items_invoice ON public.purchase_invoice_items USING btree (invoice_id);


--
-- Name: idx_invoice_items_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoice_items_item ON public.purchase_invoice_items USING btree (item_id);


--
-- Name: idx_invoices_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoices_date ON public.purchase_invoices USING btree (invoice_date);


--
-- Name: idx_invoices_supplier; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_invoices_supplier ON public.purchase_invoices USING btree (supplier_id);


--
-- Name: idx_items_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_items_category ON public.items USING btree (category_id);


--
-- Name: idx_items_name_ar; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_items_name_ar ON public.items USING btree (name_ar);


--
-- Name: idx_movements_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movements_date ON public.stock_movements USING btree (movement_date);


--
-- Name: idx_movements_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_movements_item ON public.stock_movements USING btree (item_id);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_06_16_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_06_16_inserted_at_topic_idx ON realtime.messages_2026_06_16 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_06_17_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_06_17_inserted_at_topic_idx ON realtime.messages_2026_06_17 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_06_18_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_06_18_inserted_at_topic_idx ON realtime.messages_2026_06_18 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_06_19_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_06_19_inserted_at_topic_idx ON realtime.messages_2026_06_19 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_06_20_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_06_20_inserted_at_topic_idx ON realtime.messages_2026_06_20 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: messages_2026_06_21_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2026_06_21_inserted_at_topic_idx ON realtime.messages_2026_06_21 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_key ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_iceberg_namespaces_bucket_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_namespaces_bucket_id ON storage.iceberg_namespaces USING btree (catalog_id, name);


--
-- Name: idx_iceberg_tables_location; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_location ON storage.iceberg_tables USING btree (location);


--
-- Name: idx_iceberg_tables_namespace_id; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_iceberg_tables_namespace_id ON storage.iceberg_tables USING btree (catalog_id, namespace_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- Name: messages_2026_06_16_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_06_16_inserted_at_topic_idx;


--
-- Name: messages_2026_06_16_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_06_16_pkey;


--
-- Name: messages_2026_06_17_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_06_17_inserted_at_topic_idx;


--
-- Name: messages_2026_06_17_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_06_17_pkey;


--
-- Name: messages_2026_06_18_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_06_18_inserted_at_topic_idx;


--
-- Name: messages_2026_06_18_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_06_18_pkey;


--
-- Name: messages_2026_06_19_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_06_19_inserted_at_topic_idx;


--
-- Name: messages_2026_06_19_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_06_19_pkey;


--
-- Name: messages_2026_06_20_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_06_20_inserted_at_topic_idx;


--
-- Name: messages_2026_06_20_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_06_20_pkey;


--
-- Name: messages_2026_06_21_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2026_06_21_inserted_at_topic_idx;


--
-- Name: messages_2026_06_21_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2026_06_21_pkey;


--
-- Name: customer_balances _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.customer_balances WITH (security_invoker='true') AS
 SELECT c.id AS customer_id,
    c.name,
    c.phone,
    COALESCE(sum(
        CASE
            WHEN (dt.transaction_type = 'debit'::text) THEN dt.amount_local
            ELSE (0)::numeric
        END), (0)::numeric) AS total_debit,
    COALESCE(sum(
        CASE
            WHEN (dt.transaction_type = 'credit'::text) THEN dt.amount_local
            ELSE (0)::numeric
        END), (0)::numeric) AS total_credit,
    COALESCE(sum(
        CASE
            WHEN (dt.transaction_type = 'debit'::text) THEN dt.amount_local
            ELSE (- dt.amount_local)
        END), (0)::numeric) AS balance
   FROM (public.customers c
     LEFT JOIN public.debt_transactions dt ON ((dt.customer_id = c.id)))
  GROUP BY c.id;


--
-- Name: item_stock _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.item_stock WITH (security_invoker='true') AS
 SELECT i.id AS item_id,
    i.code,
    i.name_ar,
    i.name_en,
    i.category_id,
    i.unit_id,
    i.last_purchase_price_local,
    COALESCE(sum(sm.quantity), (0)::numeric) AS current_quantity,
    (COALESCE(sum(sm.quantity), (0)::numeric) * i.last_purchase_price_local) AS stock_value
   FROM (public.items i
     LEFT JOIN public.stock_movements sm ON ((sm.item_id = i.id)))
  GROUP BY i.id;


--
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- Name: categories audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: currencies audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.currencies FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: customers audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: debt_transactions audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.debt_transactions FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: exchange_rates audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.exchange_rates FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: items audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.items FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: permission_group_items audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.permission_group_items FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: permission_groups audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.permission_groups FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: permissions audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.permissions FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: profiles audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: purchase_invoice_items audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.purchase_invoice_items FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: purchase_invoices audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.purchase_invoices FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: stock_movements audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.stock_movements FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: suppliers audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.suppliers FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: units audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.units FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: user_permission_groups audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.user_permission_groups FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: user_permissions audit_log_row_change; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER audit_log_row_change AFTER INSERT OR DELETE OR UPDATE ON public.user_permissions FOR EACH ROW EXECUTE FUNCTION public.audit_log_row_change();


--
-- Name: currencies prevent_currency_code_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER prevent_currency_code_update BEFORE UPDATE ON public.currencies FOR EACH ROW EXECUTE FUNCTION public.prevent_currency_code_update();


--
-- Name: categories trg_categories_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_categories_updated BEFORE UPDATE ON public.categories FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: customers trg_customers_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_customers_updated BEFORE UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: debt_transactions trg_debt_local; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_debt_local BEFORE INSERT OR UPDATE ON public.debt_transactions FOR EACH ROW EXECUTE FUNCTION public.compute_debt_local();


--
-- Name: debt_transactions trg_debt_transactions_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_debt_transactions_updated BEFORE UPDATE ON public.debt_transactions FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: purchase_invoice_items trg_invoice_item_stock; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_invoice_item_stock AFTER INSERT ON public.purchase_invoice_items FOR EACH ROW EXECUTE FUNCTION public.on_invoice_item_change();


--
-- Name: purchase_invoice_items trg_invoice_item_stock_del; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_invoice_item_stock_del BEFORE DELETE ON public.purchase_invoice_items FOR EACH ROW EXECUTE FUNCTION public.on_invoice_item_delete();


--
-- Name: items trg_items_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_items_updated BEFORE UPDATE ON public.items FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: profiles trg_profiles_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_profiles_updated BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

ALTER TABLE public.profiles DISABLE TRIGGER trg_profiles_updated;


--
-- Name: purchase_invoices trg_purchase_invoices_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_purchase_invoices_updated BEFORE UPDATE ON public.purchase_invoices FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: suppliers trg_suppliers_updated; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_suppliers_updated BEFORE UPDATE ON public.suppliers FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: audit_logs audit_logs_changed_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_changed_by_fkey FOREIGN KEY (changed_by) REFERENCES public.profiles(id);


--
-- Name: categories categories_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: categories categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: categories categories_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: customers customers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: customers customers_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: debt_transactions debt_transactions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_transactions
    ADD CONSTRAINT debt_transactions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: debt_transactions debt_transactions_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_transactions
    ADD CONSTRAINT debt_transactions_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currencies(code);


--
-- Name: debt_transactions debt_transactions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_transactions
    ADD CONSTRAINT debt_transactions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id) ON DELETE CASCADE;


--
-- Name: debt_transactions debt_transactions_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.debt_transactions
    ADD CONSTRAINT debt_transactions_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: exchange_rates exchange_rates_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exchange_rates
    ADD CONSTRAINT exchange_rates_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: exchange_rates exchange_rates_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exchange_rates
    ADD CONSTRAINT exchange_rates_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currencies(code);


--
-- Name: items items_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE SET NULL;


--
-- Name: items items_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: items items_unit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_unit_id_fkey FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE SET NULL;


--
-- Name: items items_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: permission_group_items permission_group_items_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_group_items
    ADD CONSTRAINT permission_group_items_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.permission_groups(id) ON DELETE CASCADE;


--
-- Name: permission_group_items permission_group_items_permission_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permission_group_items
    ADD CONSTRAINT permission_group_items_permission_key_fkey FOREIGN KEY (permission_key) REFERENCES public.permissions(key) ON DELETE CASCADE;


--
-- Name: profiles profiles_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: purchase_invoice_items purchase_invoice_items_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice_items
    ADD CONSTRAINT purchase_invoice_items_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: purchase_invoice_items purchase_invoice_items_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice_items
    ADD CONSTRAINT purchase_invoice_items_invoice_id_fkey FOREIGN KEY (invoice_id) REFERENCES public.purchase_invoices(id) ON DELETE CASCADE;


--
-- Name: purchase_invoice_items purchase_invoice_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice_items
    ADD CONSTRAINT purchase_invoice_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE RESTRICT;


--
-- Name: purchase_invoice_items purchase_invoice_items_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoice_items
    ADD CONSTRAINT purchase_invoice_items_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: purchase_invoices purchase_invoices_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoices
    ADD CONSTRAINT purchase_invoices_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: purchase_invoices purchase_invoices_currency_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoices
    ADD CONSTRAINT purchase_invoices_currency_code_fkey FOREIGN KEY (currency_code) REFERENCES public.currencies(code);


--
-- Name: purchase_invoices purchase_invoices_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoices
    ADD CONSTRAINT purchase_invoices_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(id) ON DELETE SET NULL;


--
-- Name: purchase_invoices purchase_invoices_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchase_invoices
    ADD CONSTRAINT purchase_invoices_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: stock_movements stock_movements_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: stock_movements stock_movements_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_movements
    ADD CONSTRAINT stock_movements_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id) ON DELETE CASCADE;


--
-- Name: suppliers suppliers_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: suppliers suppliers_default_currency_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_default_currency_fkey FOREIGN KEY (default_currency) REFERENCES public.currencies(code);


--
-- Name: suppliers suppliers_updated_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_updated_by_fkey FOREIGN KEY (updated_by) REFERENCES public.profiles(id);


--
-- Name: user_permission_groups user_permission_groups_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_groups
    ADD CONSTRAINT user_permission_groups_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: user_permission_groups user_permission_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_groups
    ADD CONSTRAINT user_permission_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.permission_groups(id) ON DELETE CASCADE;


--
-- Name: user_permission_groups user_permission_groups_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permission_groups
    ADD CONSTRAINT user_permission_groups_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: user_permissions user_permissions_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- Name: user_permissions user_permissions_permission_key_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_permission_key_fkey FOREIGN KEY (permission_key) REFERENCES public.permissions(key) ON DELETE CASCADE;


--
-- Name: user_permissions user_permissions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_permissions
    ADD CONSTRAINT user_permissions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- Name: iceberg_namespaces iceberg_namespaces_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_namespaces
    ADD CONSTRAINT iceberg_namespaces_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_catalog_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_catalog_id_fkey FOREIGN KEY (catalog_id) REFERENCES storage.buckets_analytics(id) ON DELETE CASCADE;


--
-- Name: iceberg_tables iceberg_tables_namespace_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.iceberg_tables
    ADD CONSTRAINT iceberg_tables_namespace_id_fkey FOREIGN KEY (namespace_id) REFERENCES storage.iceberg_namespaces(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles admins manage profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "admins manage profiles" ON public.profiles TO authenticated USING (public.has_permission(auth.uid(), 'users.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'users.manage'::text));


--
-- Name: audit_logs; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;

--
-- Name: audit_logs auth read audit_logs; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read audit_logs" ON public.audit_logs FOR SELECT TO authenticated USING (public.has_permission(auth.uid(), 'system.admin'::text));


--
-- Name: categories auth read categories; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read categories" ON public.categories FOR SELECT TO authenticated USING (true);


--
-- Name: currencies auth read currencies; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read currencies" ON public.currencies FOR SELECT TO authenticated USING (true);


--
-- Name: customers auth read customers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read customers" ON public.customers FOR SELECT TO authenticated USING (true);


--
-- Name: debt_transactions auth read debt_transactions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read debt_transactions" ON public.debt_transactions FOR SELECT TO authenticated USING (true);


--
-- Name: exchange_rates auth read exchange_rates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read exchange_rates" ON public.exchange_rates FOR SELECT TO authenticated USING (true);


--
-- Name: items auth read items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read items" ON public.items FOR SELECT TO authenticated USING (true);


--
-- Name: permissions auth read permissions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read permissions" ON public.permissions FOR SELECT TO authenticated USING (true);


--
-- Name: permission_group_items auth read pgi; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read pgi" ON public.permission_group_items FOR SELECT TO authenticated USING (true);


--
-- Name: permission_groups auth read pgroups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read pgroups" ON public.permission_groups FOR SELECT TO authenticated USING (true);


--
-- Name: profiles auth read profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read profiles" ON public.profiles FOR SELECT TO authenticated USING (true);


--
-- Name: purchase_invoice_items auth read purchase_invoice_items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read purchase_invoice_items" ON public.purchase_invoice_items FOR SELECT TO authenticated USING (true);


--
-- Name: purchase_invoices auth read purchase_invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read purchase_invoices" ON public.purchase_invoices FOR SELECT TO authenticated USING (true);


--
-- Name: stock_movements auth read stock_movements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read stock_movements" ON public.stock_movements FOR SELECT TO authenticated USING (true);


--
-- Name: suppliers auth read suppliers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read suppliers" ON public.suppliers FOR SELECT TO authenticated USING (true);


--
-- Name: units auth read units; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read units" ON public.units FOR SELECT TO authenticated USING (true);


--
-- Name: user_permissions auth read up; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read up" ON public.user_permissions FOR SELECT TO authenticated USING (true);


--
-- Name: user_permission_groups auth read upg; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "auth read upg" ON public.user_permission_groups FOR SELECT TO authenticated USING (true);


--
-- Name: categories; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

--
-- Name: currencies; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.currencies ENABLE ROW LEVEL SECURITY;

--
-- Name: customers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;

--
-- Name: debt_transactions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.debt_transactions ENABLE ROW LEVEL SECURITY;

--
-- Name: exchange_rates; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.exchange_rates ENABLE ROW LEVEL SECURITY;

--
-- Name: items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.items ENABLE ROW LEVEL SECURITY;

--
-- Name: permission_group_items manage pgi; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "manage pgi" ON public.permission_group_items TO authenticated USING (public.has_permission(auth.uid(), 'permissions.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'::text));


--
-- Name: permission_groups manage pgroups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "manage pgroups" ON public.permission_groups TO authenticated USING (public.has_permission(auth.uid(), 'permissions.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'::text));


--
-- Name: user_permissions manage up; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "manage up" ON public.user_permissions TO authenticated USING (public.has_permission(auth.uid(), 'permissions.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'::text));


--
-- Name: user_permission_groups manage upg; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "manage upg" ON public.user_permission_groups TO authenticated USING (public.has_permission(auth.uid(), 'permissions.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'permissions.manage'::text));


--
-- Name: categories perm delete categories; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete categories" ON public.categories FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'items.manage'::text));


--
-- Name: currencies perm delete currencies; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete currencies" ON public.currencies FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: customers perm delete customers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete customers" ON public.customers FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'customers.manage'::text));


--
-- Name: debt_transactions perm delete debt_transactions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete debt_transactions" ON public.debt_transactions FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'debts.manage'::text));


--
-- Name: exchange_rates perm delete exchange_rates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete exchange_rates" ON public.exchange_rates FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: items perm delete items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete items" ON public.items FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'items.manage'::text));


--
-- Name: purchase_invoice_items perm delete purchase_invoice_items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete purchase_invoice_items" ON public.purchase_invoice_items FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: purchase_invoices perm delete purchase_invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete purchase_invoices" ON public.purchase_invoices FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: stock_movements perm delete stock_movements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete stock_movements" ON public.stock_movements FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: suppliers perm delete suppliers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete suppliers" ON public.suppliers FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'suppliers.manage'::text));


--
-- Name: units perm delete units; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm delete units" ON public.units FOR DELETE TO authenticated USING (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: categories perm update categories; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update categories" ON public.categories FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'items.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'items.manage'::text));


--
-- Name: currencies perm update currencies; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update currencies" ON public.currencies FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'settings.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: customers perm update customers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update customers" ON public.customers FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'customers.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'customers.manage'::text));


--
-- Name: debt_transactions perm update debt_transactions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update debt_transactions" ON public.debt_transactions FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'debts.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'debts.manage'::text));


--
-- Name: exchange_rates perm update exchange_rates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update exchange_rates" ON public.exchange_rates FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'settings.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: items perm update items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update items" ON public.items FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'items.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'items.manage'::text));


--
-- Name: purchase_invoice_items perm update purchase_invoice_items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update purchase_invoice_items" ON public.purchase_invoice_items FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'invoices.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: purchase_invoices perm update purchase_invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update purchase_invoices" ON public.purchase_invoices FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'invoices.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: stock_movements perm update stock_movements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update stock_movements" ON public.stock_movements FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'invoices.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: suppliers perm update suppliers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update suppliers" ON public.suppliers FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'suppliers.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'suppliers.manage'::text));


--
-- Name: units perm update units; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm update units" ON public.units FOR UPDATE TO authenticated USING (public.has_permission(auth.uid(), 'settings.manage'::text)) WITH CHECK (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: categories perm write categories; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write categories" ON public.categories FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'items.manage'::text));


--
-- Name: currencies perm write currencies; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write currencies" ON public.currencies FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: customers perm write customers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write customers" ON public.customers FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'customers.manage'::text));


--
-- Name: debt_transactions perm write debt_transactions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write debt_transactions" ON public.debt_transactions FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'debts.manage'::text));


--
-- Name: exchange_rates perm write exchange_rates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write exchange_rates" ON public.exchange_rates FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: items perm write items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write items" ON public.items FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'items.manage'::text));


--
-- Name: purchase_invoice_items perm write purchase_invoice_items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write purchase_invoice_items" ON public.purchase_invoice_items FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: purchase_invoices perm write purchase_invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write purchase_invoices" ON public.purchase_invoices FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: stock_movements perm write stock_movements; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write stock_movements" ON public.stock_movements FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'invoices.manage'::text));


--
-- Name: suppliers perm write suppliers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write suppliers" ON public.suppliers FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'suppliers.manage'::text));


--
-- Name: units perm write units; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "perm write units" ON public.units FOR INSERT TO authenticated WITH CHECK (public.has_permission(auth.uid(), 'settings.manage'::text));


--
-- Name: permission_group_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.permission_group_items ENABLE ROW LEVEL SECURITY;

--
-- Name: permission_groups; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.permission_groups ENABLE ROW LEVEL SECURITY;

--
-- Name: permissions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.permissions ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: purchase_invoice_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_invoice_items ENABLE ROW LEVEL SECURITY;

--
-- Name: purchase_invoices; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.purchase_invoices ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles self update profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "self update profile" ON public.profiles FOR UPDATE TO authenticated USING ((id = auth.uid()));


--
-- Name: stock_movements; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.stock_movements ENABLE ROW LEVEL SECURITY;

--
-- Name: suppliers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;

--
-- Name: units; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.units ENABLE ROW LEVEL SECURITY;

--
-- Name: user_permission_groups; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_permission_groups ENABLE ROW LEVEL SECURITY;

--
-- Name: user_permissions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_permissions ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_namespaces; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_namespaces ENABLE ROW LEVEL SECURITY;

--
-- Name: iceberg_tables; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.iceberg_tables ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin WITH GRANT OPTION;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT shared_blk_read_time double precision, OUT shared_blk_write_time double precision, OUT local_blk_read_time double precision, OUT local_blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision, OUT jit_deform_count bigint, OUT jit_deform_time double precision, OUT stats_since timestamp with time zone, OUT minmax_stats_since timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint, minmax_only boolean) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- Name: FUNCTION pg_reload_conf(); Type: ACL; Schema: pg_catalog; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pg_catalog.pg_reload_conf() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;


--
-- Name: FUNCTION admin_delete_user_data(p_user_id uuid, p_actor_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.admin_delete_user_data(p_user_id uuid, p_actor_id uuid) TO anon;
GRANT ALL ON FUNCTION public.admin_delete_user_data(p_user_id uuid, p_actor_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.admin_delete_user_data(p_user_id uuid, p_actor_id uuid) TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- Name: FUNCTION admin_update_profile(p_user_id uuid, p_actor_id uuid, p_username text, p_full_name text, p_is_active boolean); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.admin_update_profile(p_user_id uuid, p_actor_id uuid, p_username text, p_full_name text, p_is_active boolean) TO anon;
GRANT ALL ON FUNCTION public.admin_update_profile(p_user_id uuid, p_actor_id uuid, p_username text, p_full_name text, p_is_active boolean) TO authenticated;
GRANT ALL ON FUNCTION public.admin_update_profile(p_user_id uuid, p_actor_id uuid, p_username text, p_full_name text, p_is_active boolean) TO service_role;


--
-- Name: FUNCTION audit_log_diff(old_row jsonb, new_row jsonb); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.audit_log_diff(old_row jsonb, new_row jsonb) TO anon;
GRANT ALL ON FUNCTION public.audit_log_diff(old_row jsonb, new_row jsonb) TO authenticated;
GRANT ALL ON FUNCTION public.audit_log_diff(old_row jsonb, new_row jsonb) TO service_role;


--
-- Name: FUNCTION audit_log_row_change(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.audit_log_row_change() TO anon;
GRANT ALL ON FUNCTION public.audit_log_row_change() TO authenticated;
GRANT ALL ON FUNCTION public.audit_log_row_change() TO service_role;


--
-- Name: FUNCTION compute_debt_local(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.compute_debt_local() TO anon;
GRANT ALL ON FUNCTION public.compute_debt_local() TO authenticated;
GRANT ALL ON FUNCTION public.compute_debt_local() TO service_role;


--
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.handle_new_user() FROM PUBLIC;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;
GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;


--
-- Name: FUNCTION has_permission(_user_id uuid, _permission text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.has_permission(_user_id uuid, _permission text) FROM PUBLIC;
GRANT ALL ON FUNCTION public.has_permission(_user_id uuid, _permission text) TO authenticated;
GRANT ALL ON FUNCTION public.has_permission(_user_id uuid, _permission text) TO service_role;


--
-- Name: FUNCTION is_admin(_user_id uuid); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.is_admin(_user_id uuid) FROM PUBLIC;
GRANT ALL ON FUNCTION public.is_admin(_user_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.is_admin(_user_id uuid) TO service_role;


--
-- Name: FUNCTION on_invoice_item_change(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.on_invoice_item_change() FROM PUBLIC;
GRANT ALL ON FUNCTION public.on_invoice_item_change() TO service_role;


--
-- Name: FUNCTION on_invoice_item_delete(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION public.on_invoice_item_delete() FROM PUBLIC;
GRANT ALL ON FUNCTION public.on_invoice_item_delete() TO service_role;


--
-- Name: FUNCTION prevent_currency_code_update(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.prevent_currency_code_update() TO anon;
GRANT ALL ON FUNCTION public.prevent_currency_code_update() TO authenticated;
GRANT ALL ON FUNCTION public.prevent_currency_code_update() TO service_role;


--
-- Name: FUNCTION set_audit_changed_by(audit_uid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_audit_changed_by(audit_uid uuid) TO anon;
GRANT ALL ON FUNCTION public.set_audit_changed_by(audit_uid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.set_audit_changed_by(audit_uid uuid) TO service_role;


--
-- Name: FUNCTION set_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.set_updated_at() TO anon;
GRANT ALL ON FUNCTION public.set_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.set_updated_at() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;


--
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE custom_oauth_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.custom_oauth_providers TO postgres;
GRANT ALL ON TABLE auth.custom_oauth_providers TO dashboard_user;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_authorizations TO postgres;
GRANT ALL ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- Name: TABLE oauth_client_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_client_states TO postgres;
GRANT ALL ON TABLE auth.oauth_client_states TO dashboard_user;


--
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_clients TO postgres;
GRANT ALL ON TABLE auth.oauth_clients TO dashboard_user;


--
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.oauth_consents TO postgres;
GRANT ALL ON TABLE auth.oauth_consents TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE webauthn_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_challenges TO postgres;
GRANT ALL ON TABLE auth.webauthn_challenges TO dashboard_user;


--
-- Name: TABLE webauthn_credentials; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.webauthn_credentials TO postgres;
GRANT ALL ON TABLE auth.webauthn_credentials TO dashboard_user;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- Name: TABLE audit_logs; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.audit_logs TO anon;
GRANT SELECT,REFERENCES,TRIGGER,TRUNCATE,MAINTAIN ON TABLE public.audit_logs TO authenticated;
GRANT ALL ON TABLE public.audit_logs TO service_role;


--
-- Name: TABLE categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.categories TO anon;
GRANT ALL ON TABLE public.categories TO authenticated;
GRANT ALL ON TABLE public.categories TO service_role;


--
-- Name: TABLE currencies; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.currencies TO anon;
GRANT ALL ON TABLE public.currencies TO authenticated;
GRANT ALL ON TABLE public.currencies TO service_role;


--
-- Name: TABLE customer_balances; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customer_balances TO anon;
GRANT ALL ON TABLE public.customer_balances TO authenticated;
GRANT ALL ON TABLE public.customer_balances TO service_role;


--
-- Name: TABLE customers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.customers TO anon;
GRANT ALL ON TABLE public.customers TO authenticated;
GRANT ALL ON TABLE public.customers TO service_role;


--
-- Name: TABLE debt_transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.debt_transactions TO anon;
GRANT ALL ON TABLE public.debt_transactions TO authenticated;
GRANT ALL ON TABLE public.debt_transactions TO service_role;


--
-- Name: TABLE exchange_rates; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.exchange_rates TO anon;
GRANT ALL ON TABLE public.exchange_rates TO authenticated;
GRANT ALL ON TABLE public.exchange_rates TO service_role;


--
-- Name: TABLE item_stock; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.item_stock TO anon;
GRANT ALL ON TABLE public.item_stock TO authenticated;
GRANT ALL ON TABLE public.item_stock TO service_role;


--
-- Name: TABLE items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.items TO anon;
GRANT ALL ON TABLE public.items TO authenticated;
GRANT ALL ON TABLE public.items TO service_role;


--
-- Name: TABLE permission_group_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.permission_group_items TO anon;
GRANT ALL ON TABLE public.permission_group_items TO authenticated;
GRANT ALL ON TABLE public.permission_group_items TO service_role;


--
-- Name: TABLE permission_groups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.permission_groups TO anon;
GRANT ALL ON TABLE public.permission_groups TO authenticated;
GRANT ALL ON TABLE public.permission_groups TO service_role;


--
-- Name: TABLE permissions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.permissions TO anon;
GRANT ALL ON TABLE public.permissions TO authenticated;
GRANT ALL ON TABLE public.permissions TO service_role;


--
-- Name: TABLE purchase_invoice_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.purchase_invoice_items TO anon;
GRANT ALL ON TABLE public.purchase_invoice_items TO authenticated;
GRANT ALL ON TABLE public.purchase_invoice_items TO service_role;


--
-- Name: TABLE purchase_invoices; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.purchase_invoices TO anon;
GRANT ALL ON TABLE public.purchase_invoices TO authenticated;
GRANT ALL ON TABLE public.purchase_invoices TO service_role;


--
-- Name: TABLE stock_movements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.stock_movements TO anon;
GRANT ALL ON TABLE public.stock_movements TO authenticated;
GRANT ALL ON TABLE public.stock_movements TO service_role;


--
-- Name: TABLE suppliers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suppliers TO anon;
GRANT ALL ON TABLE public.suppliers TO authenticated;
GRANT ALL ON TABLE public.suppliers TO service_role;


--
-- Name: TABLE units; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.units TO anon;
GRANT ALL ON TABLE public.units TO authenticated;
GRANT ALL ON TABLE public.units TO service_role;


--
-- Name: TABLE user_permission_groups; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_permission_groups TO anon;
GRANT ALL ON TABLE public.user_permission_groups TO authenticated;
GRANT ALL ON TABLE public.user_permission_groups TO service_role;


--
-- Name: TABLE user_permissions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_permissions TO anon;
GRANT ALL ON TABLE public.user_permissions TO authenticated;
GRANT ALL ON TABLE public.user_permissions TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE messages_2026_06_16; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_06_16 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_06_16 TO dashboard_user;


--
-- Name: TABLE messages_2026_06_17; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_06_17 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_06_17 TO dashboard_user;


--
-- Name: TABLE messages_2026_06_18; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_06_18 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_06_18 TO dashboard_user;


--
-- Name: TABLE messages_2026_06_19; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_06_19 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_06_19 TO dashboard_user;


--
-- Name: TABLE messages_2026_06_20; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_06_20 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_06_20 TO dashboard_user;


--
-- Name: TABLE messages_2026_06_21; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2026_06_21 TO postgres;
GRANT ALL ON TABLE realtime.messages_2026_06_21 TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO anon;


--
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets_analytics TO service_role;
GRANT ALL ON TABLE storage.buckets_analytics TO authenticated;
GRANT ALL ON TABLE storage.buckets_analytics TO anon;


--
-- Name: TABLE buckets_vectors; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.buckets_vectors TO service_role;
GRANT SELECT ON TABLE storage.buckets_vectors TO authenticated;
GRANT SELECT ON TABLE storage.buckets_vectors TO anon;


--
-- Name: TABLE iceberg_namespaces; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_namespaces TO service_role;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_namespaces TO anon;


--
-- Name: TABLE iceberg_tables; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.iceberg_tables TO service_role;
GRANT SELECT ON TABLE storage.iceberg_tables TO authenticated;
GRANT SELECT ON TABLE storage.iceberg_tables TO anon;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO anon;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- Name: TABLE vector_indexes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT ON TABLE storage.vector_indexes TO service_role;
GRANT SELECT ON TABLE storage.vector_indexes TO authenticated;
GRANT SELECT ON TABLE storage.vector_indexes TO anon;


--
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO postgres;
GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO postgres;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO postgres;
GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

\unrestrict RcFdCP7mAXHkiHIqlepPUiNzgcj1TLJSZPOi9dHWbJ8VT9Hc8EHsHF0MTtiWUhT

--
-- PostgreSQL database cluster dump complete
--

