--
-- PostgreSQL database dump
--

\restrict cZ9c6hvpxeKF6CTFZgNSHOucM4fJqWWcBQhAitl4Cg5jDbcJgFe9p1eaNhrAhsG

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.9 (Debian 17.9-1.pgdg13+1)

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

DROP EVENT TRIGGER IF EXISTS "pgrst_drop_watch";
DROP EVENT TRIGGER IF EXISTS "pgrst_ddl_watch";
DROP EVENT TRIGGER IF EXISTS "issue_pg_net_access";
DROP EVENT TRIGGER IF EXISTS "issue_pg_graphql_access";
DROP EVENT TRIGGER IF EXISTS "issue_pg_cron_access";
DROP EVENT TRIGGER IF EXISTS "issue_graphql_placeholder";
DROP PUBLICATION IF EXISTS "supabase_realtime";
ALTER TABLE IF EXISTS ONLY "storage"."vector_indexes" DROP CONSTRAINT IF EXISTS "vector_indexes_bucket_id_fkey";
ALTER TABLE IF EXISTS ONLY "storage"."s3_multipart_uploads_parts" DROP CONSTRAINT IF EXISTS "s3_multipart_uploads_parts_upload_id_fkey";
ALTER TABLE IF EXISTS ONLY "storage"."s3_multipart_uploads_parts" DROP CONSTRAINT IF EXISTS "s3_multipart_uploads_parts_bucket_id_fkey";
ALTER TABLE IF EXISTS ONLY "storage"."s3_multipart_uploads" DROP CONSTRAINT IF EXISTS "s3_multipart_uploads_bucket_id_fkey";
ALTER TABLE IF EXISTS ONLY "storage"."objects" DROP CONSTRAINT IF EXISTS "objects_bucketId_fkey";
ALTER TABLE IF EXISTS ONLY "public"."profil_vbt" DROP CONSTRAINT IF EXISTS "fk_vbt_utilisateur";
ALTER TABLE IF EXISTS ONLY "public"."profil_vbt" DROP CONSTRAINT IF EXISTS "fk_vbt_exercice";
ALTER TABLE IF EXISTS ONLY "public"."serie" DROP CONSTRAINT IF EXISTS "fk_serie_seance_exo";
ALTER TABLE IF EXISTS ONLY "public"."seance" DROP CONSTRAINT IF EXISTS "fk_seance_utilisateur";
ALTER TABLE IF EXISTS ONLY "public"."seance_exo" DROP CONSTRAINT IF EXISTS "fk_seance_exo_seance";
ALTER TABLE IF EXISTS ONLY "public"."seance_exo" DROP CONSTRAINT IF EXISTS "fk_seance_exo_exercice";
ALTER TABLE IF EXISTS ONLY "public"."repetition" DROP CONSTRAINT IF EXISTS "fk_repetition_serie";
ALTER TABLE IF EXISTS ONLY "public"."utilisateur" DROP CONSTRAINT IF EXISTS "fk_coach";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_credentials" DROP CONSTRAINT IF EXISTS "webauthn_credentials_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_challenges" DROP CONSTRAINT IF EXISTS "webauthn_challenges_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."sso_domains" DROP CONSTRAINT IF EXISTS "sso_domains_sso_provider_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."sessions" DROP CONSTRAINT IF EXISTS "sessions_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."sessions" DROP CONSTRAINT IF EXISTS "sessions_oauth_client_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_relay_states" DROP CONSTRAINT IF EXISTS "saml_relay_states_sso_provider_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_relay_states" DROP CONSTRAINT IF EXISTS "saml_relay_states_flow_state_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_providers" DROP CONSTRAINT IF EXISTS "saml_providers_sso_provider_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."refresh_tokens" DROP CONSTRAINT IF EXISTS "refresh_tokens_session_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."one_time_tokens" DROP CONSTRAINT IF EXISTS "one_time_tokens_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_client_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_client_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_factors" DROP CONSTRAINT IF EXISTS "mfa_factors_user_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_challenges" DROP CONSTRAINT IF EXISTS "mfa_challenges_auth_factor_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_amr_claims" DROP CONSTRAINT IF EXISTS "mfa_amr_claims_session_id_fkey";
ALTER TABLE IF EXISTS ONLY "auth"."identities" DROP CONSTRAINT IF EXISTS "identities_user_id_fkey";
DROP TRIGGER IF EXISTS "update_objects_updated_at" ON "storage"."objects";
DROP TRIGGER IF EXISTS "protect_objects_delete" ON "storage"."objects";
DROP TRIGGER IF EXISTS "protect_buckets_delete" ON "storage"."buckets";
DROP TRIGGER IF EXISTS "enforce_bucket_name_length_trigger" ON "storage"."buckets";
DROP TRIGGER IF EXISTS "tr_check_filters" ON "realtime"."subscription";
DROP INDEX IF EXISTS "storage"."vector_indexes_name_bucket_id_idx";
DROP INDEX IF EXISTS "storage"."name_prefix_search";
DROP INDEX IF EXISTS "storage"."idx_objects_bucket_id_name_lower";
DROP INDEX IF EXISTS "storage"."idx_objects_bucket_id_name";
DROP INDEX IF EXISTS "storage"."idx_multipart_uploads_list";
DROP INDEX IF EXISTS "storage"."buckets_analytics_unique_name_idx";
DROP INDEX IF EXISTS "storage"."bucketid_objname";
DROP INDEX IF EXISTS "storage"."bname";
DROP INDEX IF EXISTS "realtime"."subscription_subscription_id_entity_filters_key";
DROP INDEX IF EXISTS "realtime"."messages_inserted_at_topic_index";
DROP INDEX IF EXISTS "realtime"."ix_realtime_subscription_entity";
DROP INDEX IF EXISTS "auth"."webauthn_credentials_user_id_idx";
DROP INDEX IF EXISTS "auth"."webauthn_credentials_credential_id_key";
DROP INDEX IF EXISTS "auth"."webauthn_challenges_user_id_idx";
DROP INDEX IF EXISTS "auth"."webauthn_challenges_expires_at_idx";
DROP INDEX IF EXISTS "auth"."users_is_anonymous_idx";
DROP INDEX IF EXISTS "auth"."users_instance_id_idx";
DROP INDEX IF EXISTS "auth"."users_instance_id_email_idx";
DROP INDEX IF EXISTS "auth"."users_email_partial_key";
DROP INDEX IF EXISTS "auth"."user_id_created_at_idx";
DROP INDEX IF EXISTS "auth"."unique_phone_factor_per_user";
DROP INDEX IF EXISTS "auth"."sso_providers_resource_id_pattern_idx";
DROP INDEX IF EXISTS "auth"."sso_providers_resource_id_idx";
DROP INDEX IF EXISTS "auth"."sso_domains_sso_provider_id_idx";
DROP INDEX IF EXISTS "auth"."sso_domains_domain_idx";
DROP INDEX IF EXISTS "auth"."sessions_user_id_idx";
DROP INDEX IF EXISTS "auth"."sessions_oauth_client_id_idx";
DROP INDEX IF EXISTS "auth"."sessions_not_after_idx";
DROP INDEX IF EXISTS "auth"."saml_relay_states_sso_provider_id_idx";
DROP INDEX IF EXISTS "auth"."saml_relay_states_for_email_idx";
DROP INDEX IF EXISTS "auth"."saml_relay_states_created_at_idx";
DROP INDEX IF EXISTS "auth"."saml_providers_sso_provider_id_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_updated_at_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_session_id_revoked_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_parent_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_instance_id_user_id_idx";
DROP INDEX IF EXISTS "auth"."refresh_tokens_instance_id_idx";
DROP INDEX IF EXISTS "auth"."recovery_token_idx";
DROP INDEX IF EXISTS "auth"."reauthentication_token_idx";
DROP INDEX IF EXISTS "auth"."one_time_tokens_user_id_token_type_key";
DROP INDEX IF EXISTS "auth"."one_time_tokens_token_hash_hash_idx";
DROP INDEX IF EXISTS "auth"."one_time_tokens_relates_to_hash_idx";
DROP INDEX IF EXISTS "auth"."oauth_consents_user_order_idx";
DROP INDEX IF EXISTS "auth"."oauth_consents_active_user_client_idx";
DROP INDEX IF EXISTS "auth"."oauth_consents_active_client_idx";
DROP INDEX IF EXISTS "auth"."oauth_clients_deleted_at_idx";
DROP INDEX IF EXISTS "auth"."oauth_auth_pending_exp_idx";
DROP INDEX IF EXISTS "auth"."mfa_factors_user_id_idx";
DROP INDEX IF EXISTS "auth"."mfa_factors_user_friendly_name_unique";
DROP INDEX IF EXISTS "auth"."mfa_challenge_created_at_idx";
DROP INDEX IF EXISTS "auth"."idx_user_id_auth_method";
DROP INDEX IF EXISTS "auth"."idx_oauth_client_states_created_at";
DROP INDEX IF EXISTS "auth"."idx_auth_code";
DROP INDEX IF EXISTS "auth"."identities_user_id_idx";
DROP INDEX IF EXISTS "auth"."identities_email_idx";
DROP INDEX IF EXISTS "auth"."flow_state_created_at_idx";
DROP INDEX IF EXISTS "auth"."factor_id_created_at_idx";
DROP INDEX IF EXISTS "auth"."email_change_token_new_idx";
DROP INDEX IF EXISTS "auth"."email_change_token_current_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_provider_type_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_identifier_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_enabled_idx";
DROP INDEX IF EXISTS "auth"."custom_oauth_providers_created_at_idx";
DROP INDEX IF EXISTS "auth"."confirmation_token_idx";
DROP INDEX IF EXISTS "auth"."audit_logs_instance_id_idx";
ALTER TABLE IF EXISTS ONLY "storage"."vector_indexes" DROP CONSTRAINT IF EXISTS "vector_indexes_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."s3_multipart_uploads" DROP CONSTRAINT IF EXISTS "s3_multipart_uploads_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."s3_multipart_uploads_parts" DROP CONSTRAINT IF EXISTS "s3_multipart_uploads_parts_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."objects" DROP CONSTRAINT IF EXISTS "objects_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."migrations" DROP CONSTRAINT IF EXISTS "migrations_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."migrations" DROP CONSTRAINT IF EXISTS "migrations_name_key";
ALTER TABLE IF EXISTS ONLY "storage"."buckets_vectors" DROP CONSTRAINT IF EXISTS "buckets_vectors_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."buckets" DROP CONSTRAINT IF EXISTS "buckets_pkey";
ALTER TABLE IF EXISTS ONLY "storage"."buckets_analytics" DROP CONSTRAINT IF EXISTS "buckets_analytics_pkey";
ALTER TABLE IF EXISTS ONLY "realtime"."schema_migrations" DROP CONSTRAINT IF EXISTS "schema_migrations_pkey";
ALTER TABLE IF EXISTS ONLY "realtime"."subscription" DROP CONSTRAINT IF EXISTS "pk_subscription";
ALTER TABLE IF EXISTS ONLY "realtime"."messages" DROP CONSTRAINT IF EXISTS "messages_pkey";
ALTER TABLE IF EXISTS ONLY "public"."utilisateur" DROP CONSTRAINT IF EXISTS "utilisateur_pkey";
ALTER TABLE IF EXISTS ONLY "public"."utilisateur" DROP CONSTRAINT IF EXISTS "utilisateur_email_key";
ALTER TABLE IF EXISTS ONLY "public"."ref_rpe_table" DROP CONSTRAINT IF EXISTS "unique_reps_rpe";
ALTER TABLE IF EXISTS ONLY "public"."tweets" DROP CONSTRAINT IF EXISTS "tweets_raw_content_key";
ALTER TABLE IF EXISTS ONLY "public"."tweets_processed" DROP CONSTRAINT IF EXISTS "tweets_processed_pkey";
ALTER TABLE IF EXISTS ONLY "public"."tweets" DROP CONSTRAINT IF EXISTS "tweets_pkey";
ALTER TABLE IF EXISTS ONLY "public"."serie" DROP CONSTRAINT IF EXISTS "serie_pkey";
ALTER TABLE IF EXISTS ONLY "public"."seance" DROP CONSTRAINT IF EXISTS "seance_pkey";
ALTER TABLE IF EXISTS ONLY "public"."seance_exo" DROP CONSTRAINT IF EXISTS "seance_exo_pkey";
ALTER TABLE IF EXISTS ONLY "public"."seance_exo" DROP CONSTRAINT IF EXISTS "seance_exo_id_seance_id_exercice_key";
ALTER TABLE IF EXISTS ONLY "public"."repetition" DROP CONSTRAINT IF EXISTS "repetition_pkey";
ALTER TABLE IF EXISTS ONLY "public"."repetition" DROP CONSTRAINT IF EXISTS "repetition_id_serie_numero_rep_key";
ALTER TABLE IF EXISTS ONLY "public"."ref_rpe_table" DROP CONSTRAINT IF EXISTS "ref_rpe_table_pkey";
ALTER TABLE IF EXISTS ONLY "public"."profil_vbt" DROP CONSTRAINT IF EXISTS "profil_vbt_pkey";
ALTER TABLE IF EXISTS ONLY "public"."hot_metrics" DROP CONSTRAINT IF EXISTS "hot_metrics_pkey";
ALTER TABLE IF EXISTS ONLY "public"."exercice" DROP CONSTRAINT IF EXISTS "exercice_pkey";
ALTER TABLE IF EXISTS ONLY "public"."exercice" DROP CONSTRAINT IF EXISTS "exercice_nom_key";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_credentials" DROP CONSTRAINT IF EXISTS "webauthn_credentials_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."webauthn_challenges" DROP CONSTRAINT IF EXISTS "webauthn_challenges_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."users" DROP CONSTRAINT IF EXISTS "users_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."users" DROP CONSTRAINT IF EXISTS "users_phone_key";
ALTER TABLE IF EXISTS ONLY "auth"."sso_providers" DROP CONSTRAINT IF EXISTS "sso_providers_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."sso_domains" DROP CONSTRAINT IF EXISTS "sso_domains_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."sessions" DROP CONSTRAINT IF EXISTS "sessions_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."schema_migrations" DROP CONSTRAINT IF EXISTS "schema_migrations_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_relay_states" DROP CONSTRAINT IF EXISTS "saml_relay_states_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_providers" DROP CONSTRAINT IF EXISTS "saml_providers_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."saml_providers" DROP CONSTRAINT IF EXISTS "saml_providers_entity_id_key";
ALTER TABLE IF EXISTS ONLY "auth"."refresh_tokens" DROP CONSTRAINT IF EXISTS "refresh_tokens_token_unique";
ALTER TABLE IF EXISTS ONLY "auth"."refresh_tokens" DROP CONSTRAINT IF EXISTS "refresh_tokens_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."one_time_tokens" DROP CONSTRAINT IF EXISTS "one_time_tokens_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_user_client_unique";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_consents" DROP CONSTRAINT IF EXISTS "oauth_consents_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_clients" DROP CONSTRAINT IF EXISTS "oauth_clients_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_client_states" DROP CONSTRAINT IF EXISTS "oauth_client_states_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_authorization_id_key";
ALTER TABLE IF EXISTS ONLY "auth"."oauth_authorizations" DROP CONSTRAINT IF EXISTS "oauth_authorizations_authorization_code_key";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_factors" DROP CONSTRAINT IF EXISTS "mfa_factors_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_factors" DROP CONSTRAINT IF EXISTS "mfa_factors_last_challenged_at_key";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_challenges" DROP CONSTRAINT IF EXISTS "mfa_challenges_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_amr_claims" DROP CONSTRAINT IF EXISTS "mfa_amr_claims_session_id_authentication_method_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."instances" DROP CONSTRAINT IF EXISTS "instances_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."identities" DROP CONSTRAINT IF EXISTS "identities_provider_id_provider_unique";
ALTER TABLE IF EXISTS ONLY "auth"."identities" DROP CONSTRAINT IF EXISTS "identities_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."flow_state" DROP CONSTRAINT IF EXISTS "flow_state_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."custom_oauth_providers" DROP CONSTRAINT IF EXISTS "custom_oauth_providers_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."custom_oauth_providers" DROP CONSTRAINT IF EXISTS "custom_oauth_providers_identifier_key";
ALTER TABLE IF EXISTS ONLY "auth"."audit_log_entries" DROP CONSTRAINT IF EXISTS "audit_log_entries_pkey";
ALTER TABLE IF EXISTS ONLY "auth"."mfa_amr_claims" DROP CONSTRAINT IF EXISTS "amr_id_pk";
ALTER TABLE IF EXISTS "public"."utilisateur" ALTER COLUMN "id_utilisateur" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."tweets_processed" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."tweets" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."serie" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."seance_exo" ALTER COLUMN "id_seance_exo" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."seance" ALTER COLUMN "id_seance" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."repetition" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."ref_rpe_table" ALTER COLUMN "id" DROP DEFAULT;
ALTER TABLE IF EXISTS "public"."exercice" ALTER COLUMN "id_exercice" DROP DEFAULT;
ALTER TABLE IF EXISTS "auth"."refresh_tokens" ALTER COLUMN "id" DROP DEFAULT;
DROP TABLE IF EXISTS "storage"."vector_indexes";
DROP TABLE IF EXISTS "storage"."s3_multipart_uploads_parts";
DROP TABLE IF EXISTS "storage"."s3_multipart_uploads";
DROP TABLE IF EXISTS "storage"."objects";
DROP TABLE IF EXISTS "storage"."migrations";
DROP TABLE IF EXISTS "storage"."buckets_vectors";
DROP TABLE IF EXISTS "storage"."buckets_analytics";
DROP TABLE IF EXISTS "storage"."buckets";
DROP TABLE IF EXISTS "realtime"."subscription";
DROP TABLE IF EXISTS "realtime"."schema_migrations";
DROP TABLE IF EXISTS "realtime"."messages";
DROP SEQUENCE IF EXISTS "public"."utilisateur_id_utilisateur_seq";
DROP TABLE IF EXISTS "public"."utilisateur";
DROP SEQUENCE IF EXISTS "public"."tweets_processed_id_seq";
DROP TABLE IF EXISTS "public"."tweets_processed";
DROP SEQUENCE IF EXISTS "public"."tweets_id_seq";
DROP TABLE IF EXISTS "public"."tweets";
DROP SEQUENCE IF EXISTS "public"."serie_id_seq";
DROP TABLE IF EXISTS "public"."serie";
DROP SEQUENCE IF EXISTS "public"."seance_id_seance_seq";
DROP SEQUENCE IF EXISTS "public"."seance_exo_id_seance_exo_seq";
DROP TABLE IF EXISTS "public"."seance_exo";
DROP TABLE IF EXISTS "public"."seance";
DROP SEQUENCE IF EXISTS "public"."repetition_id_seq";
DROP TABLE IF EXISTS "public"."repetition";
DROP SEQUENCE IF EXISTS "public"."ref_rpe_table_id_seq";
DROP TABLE IF EXISTS "public"."ref_rpe_table";
DROP TABLE IF EXISTS "public"."profil_vbt";
DROP TABLE IF EXISTS "public"."hot_metrics";
DROP SEQUENCE IF EXISTS "public"."exercice_id_exercice_seq";
DROP TABLE IF EXISTS "public"."exercice";
DROP TABLE IF EXISTS "auth"."webauthn_credentials";
DROP TABLE IF EXISTS "auth"."webauthn_challenges";
DROP TABLE IF EXISTS "auth"."users";
DROP TABLE IF EXISTS "auth"."sso_providers";
DROP TABLE IF EXISTS "auth"."sso_domains";
DROP TABLE IF EXISTS "auth"."sessions";
DROP TABLE IF EXISTS "auth"."schema_migrations";
DROP TABLE IF EXISTS "auth"."saml_relay_states";
DROP TABLE IF EXISTS "auth"."saml_providers";
DROP SEQUENCE IF EXISTS "auth"."refresh_tokens_id_seq";
DROP TABLE IF EXISTS "auth"."refresh_tokens";
DROP TABLE IF EXISTS "auth"."one_time_tokens";
DROP TABLE IF EXISTS "auth"."oauth_consents";
DROP TABLE IF EXISTS "auth"."oauth_clients";
DROP TABLE IF EXISTS "auth"."oauth_client_states";
DROP TABLE IF EXISTS "auth"."oauth_authorizations";
DROP TABLE IF EXISTS "auth"."mfa_factors";
DROP TABLE IF EXISTS "auth"."mfa_challenges";
DROP TABLE IF EXISTS "auth"."mfa_amr_claims";
DROP TABLE IF EXISTS "auth"."instances";
DROP TABLE IF EXISTS "auth"."identities";
DROP TABLE IF EXISTS "auth"."flow_state";
DROP TABLE IF EXISTS "auth"."custom_oauth_providers";
DROP TABLE IF EXISTS "auth"."audit_log_entries";
DROP FUNCTION IF EXISTS "storage"."update_updated_at_column"();
DROP FUNCTION IF EXISTS "storage"."search_v2"("prefix" "text", "bucket_name" "text", "limits" integer, "levels" integer, "start_after" "text", "sort_order" "text", "sort_column" "text", "sort_column_after" "text");
DROP FUNCTION IF EXISTS "storage"."search_legacy_v1"("prefix" "text", "bucketname" "text", "limits" integer, "levels" integer, "offsets" integer, "search" "text", "sortcolumn" "text", "sortorder" "text");
DROP FUNCTION IF EXISTS "storage"."search_by_timestamp"("p_prefix" "text", "p_bucket_id" "text", "p_limit" integer, "p_level" integer, "p_start_after" "text", "p_sort_order" "text", "p_sort_column" "text", "p_sort_column_after" "text");
DROP FUNCTION IF EXISTS "storage"."search"("prefix" "text", "bucketname" "text", "limits" integer, "levels" integer, "offsets" integer, "search" "text", "sortcolumn" "text", "sortorder" "text");
DROP FUNCTION IF EXISTS "storage"."protect_delete"();
DROP FUNCTION IF EXISTS "storage"."operation"();
DROP FUNCTION IF EXISTS "storage"."list_objects_with_delimiter"("_bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer, "start_after" "text", "next_token" "text", "sort_order" "text");
DROP FUNCTION IF EXISTS "storage"."list_multipart_uploads_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer, "next_key_token" "text", "next_upload_token" "text");
DROP FUNCTION IF EXISTS "storage"."get_size_by_bucket"();
DROP FUNCTION IF EXISTS "storage"."get_prefixes"("name" "text");
DROP FUNCTION IF EXISTS "storage"."get_prefix"("name" "text");
DROP FUNCTION IF EXISTS "storage"."get_level"("name" "text");
DROP FUNCTION IF EXISTS "storage"."get_common_prefix"("p_key" "text", "p_prefix" "text", "p_delimiter" "text");
DROP FUNCTION IF EXISTS "storage"."foldername"("name" "text");
DROP FUNCTION IF EXISTS "storage"."filename"("name" "text");
DROP FUNCTION IF EXISTS "storage"."extension"("name" "text");
DROP FUNCTION IF EXISTS "storage"."enforce_bucket_name_length"();
DROP FUNCTION IF EXISTS "storage"."delete_leaf_prefixes"("bucket_ids" "text"[], "names" "text"[]);
DROP FUNCTION IF EXISTS "storage"."can_insert_object"("bucketid" "text", "name" "text", "owner" "uuid", "metadata" "jsonb");
DROP FUNCTION IF EXISTS "realtime"."topic"();
DROP FUNCTION IF EXISTS "realtime"."to_regrole"("role_name" "text");
DROP FUNCTION IF EXISTS "realtime"."subscription_check_filters"();
DROP FUNCTION IF EXISTS "realtime"."send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean);
DROP FUNCTION IF EXISTS "realtime"."quote_wal2json"("entity" "regclass");
DROP FUNCTION IF EXISTS "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer);
DROP FUNCTION IF EXISTS "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]);
DROP FUNCTION IF EXISTS "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text");
DROP FUNCTION IF EXISTS "realtime"."cast"("val" "text", "type_" "regtype");
DROP FUNCTION IF EXISTS "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]);
DROP FUNCTION IF EXISTS "realtime"."broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text");
DROP FUNCTION IF EXISTS "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer);
DROP FUNCTION IF EXISTS "pgbouncer"."get_auth"("p_usename" "text");
DROP FUNCTION IF EXISTS "extensions"."set_graphql_placeholder"();
DROP FUNCTION IF EXISTS "extensions"."pgrst_drop_watch"();
DROP FUNCTION IF EXISTS "extensions"."pgrst_ddl_watch"();
DROP FUNCTION IF EXISTS "extensions"."grant_pg_net_access"();
DROP FUNCTION IF EXISTS "extensions"."grant_pg_graphql_access"();
DROP FUNCTION IF EXISTS "extensions"."grant_pg_cron_access"();
DROP FUNCTION IF EXISTS "auth"."uid"();
DROP FUNCTION IF EXISTS "auth"."role"();
DROP FUNCTION IF EXISTS "auth"."jwt"();
DROP FUNCTION IF EXISTS "auth"."email"();
DROP TYPE IF EXISTS "storage"."buckettype";
DROP TYPE IF EXISTS "realtime"."wal_rls";
DROP TYPE IF EXISTS "realtime"."wal_column";
DROP TYPE IF EXISTS "realtime"."user_defined_filter";
DROP TYPE IF EXISTS "realtime"."equality_op";
DROP TYPE IF EXISTS "realtime"."action";
DROP TYPE IF EXISTS "auth"."one_time_token_type";
DROP TYPE IF EXISTS "auth"."oauth_response_type";
DROP TYPE IF EXISTS "auth"."oauth_registration_type";
DROP TYPE IF EXISTS "auth"."oauth_client_type";
DROP TYPE IF EXISTS "auth"."oauth_authorization_status";
DROP TYPE IF EXISTS "auth"."factor_type";
DROP TYPE IF EXISTS "auth"."factor_status";
DROP TYPE IF EXISTS "auth"."code_challenge_method";
DROP TYPE IF EXISTS "auth"."aal_level";
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS "supabase_vault";
DROP EXTENSION IF EXISTS "pgcrypto";
DROP EXTENSION IF EXISTS "pg_stat_statements";
DROP EXTENSION IF EXISTS "pg_graphql";
DROP SCHEMA IF EXISTS "vault";
DROP SCHEMA IF EXISTS "storage";
DROP SCHEMA IF EXISTS "realtime";
DROP SCHEMA IF EXISTS "pgbouncer";
DROP SCHEMA IF EXISTS "graphql_public";
DROP SCHEMA IF EXISTS "graphql";
DROP SCHEMA IF EXISTS "extensions";
DROP SCHEMA IF EXISTS "auth";
--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "auth";


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "extensions";


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "graphql";


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "graphql_public";


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "pgbouncer";


--
-- Name: SCHEMA "public"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA "public" IS 'standard public schema';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "realtime";


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "storage";


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "vault";


--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";


--
-- Name: EXTENSION "pg_graphql"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "pg_graphql" IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "pg_stat_statements"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "pg_stat_statements" IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "pgcrypto"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "pgcrypto" IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";


--
-- Name: EXTENSION "supabase_vault"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "supabase_vault" IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."aal_level" AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."code_challenge_method" AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."factor_status" AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."factor_type" AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."oauth_authorization_status" AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."oauth_client_type" AS ENUM (
    'public',
    'confidential'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."oauth_registration_type" AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."oauth_response_type" AS ENUM (
    'code'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE "auth"."one_time_token_type" AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE "realtime"."action" AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE "realtime"."equality_op" AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE "realtime"."user_defined_filter" AS (
	"column_name" "text",
	"op" "realtime"."equality_op",
	"value" "text"
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE "realtime"."wal_column" AS (
	"name" "text",
	"type_name" "text",
	"type_oid" "oid",
	"value" "jsonb",
	"is_pkey" boolean,
	"is_selectable" boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE "realtime"."wal_rls" AS (
	"wal" "jsonb",
	"is_rls_enabled" boolean,
	"subscription_ids" "uuid"[],
	"errors" "text"[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE "storage"."buckettype" AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION "auth"."email"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION "email"(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION "auth"."email"() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION "auth"."jwt"() RETURNS "jsonb"
    LANGUAGE "sql" STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION "auth"."role"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION "role"(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION "auth"."role"() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION "auth"."uid"() RETURNS "uuid"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION "uid"(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION "auth"."uid"() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION "extensions"."grant_pg_cron_access"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: FUNCTION "grant_pg_cron_access"(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION "extensions"."grant_pg_cron_access"() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION "extensions"."grant_pg_graphql_access"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: FUNCTION "grant_pg_graphql_access"(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION "extensions"."grant_pg_graphql_access"() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION "extensions"."grant_pg_net_access"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
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
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


--
-- Name: FUNCTION "grant_pg_net_access"(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION "extensions"."grant_pg_net_access"() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION "extensions"."pgrst_ddl_watch"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION "extensions"."pgrst_drop_watch"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION "extensions"."set_graphql_placeholder"() RETURNS "event_trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: FUNCTION "set_graphql_placeholder"(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION "extensions"."set_graphql_placeholder"() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth("text"); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION "pgbouncer"."get_auth"("p_usename" "text") RETURNS TABLE("username" "text", "password" "text")
    LANGUAGE "plpgsql" SECURITY DEFINER
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


--
-- Name: apply_rls("jsonb", integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."apply_rls"("wal" "jsonb", "max_record_bytes" integer DEFAULT (1024 * 1024)) RETURNS SETOF "realtime"."wal_rls"
    LANGUAGE "plpgsql"
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
        subs.entity = entity_;

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


--
-- Name: broadcast_changes("text", "text", "text", "text", "text", "record", "record", "text"); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."broadcast_changes"("topic_name" "text", "event_name" "text", "operation" "text", "table_name" "text", "table_schema" "text", "new" "record", "old" "record", "level" "text" DEFAULT 'ROW'::"text") RETURNS "void"
    LANGUAGE "plpgsql"
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


--
-- Name: build_prepared_statement_sql("text", "regclass", "realtime"."wal_column"[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."build_prepared_statement_sql"("prepared_statement_name" "text", "entity" "regclass", "columns" "realtime"."wal_column"[]) RETURNS "text"
    LANGUAGE "sql"
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


--
-- Name: cast("text", "regtype"); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."cast"("val" "text", "type_" "regtype") RETURNS "jsonb"
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


--
-- Name: check_equality_op("realtime"."equality_op", "regtype", "text", "text"); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."check_equality_op"("op" "realtime"."equality_op", "type_" "regtype", "val_1" "text", "val_2" "text") RETURNS boolean
    LANGUAGE "plpgsql" IMMUTABLE
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


--
-- Name: is_visible_through_filters("realtime"."wal_column"[], "realtime"."user_defined_filter"[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."is_visible_through_filters"("columns" "realtime"."wal_column"[], "filters" "realtime"."user_defined_filter"[]) RETURNS boolean
    LANGUAGE "sql" IMMUTABLE
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


--
-- Name: list_changes("name", "name", integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."list_changes"("publication" "name", "slot_name" "name", "max_changes" integer, "max_record_bytes" integer) RETURNS SETOF "realtime"."wal_rls"
    LANGUAGE "sql"
    SET "log_min_messages" TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
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
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


--
-- Name: quote_wal2json("regclass"); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."quote_wal2json"("entity" "regclass") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE STRICT
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


--
-- Name: send("jsonb", "text", "text", boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."send"("payload" "jsonb", "event" "text", "topic" "text", "private" boolean DEFAULT true) RETURNS "void"
    LANGUAGE "plpgsql"
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


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."subscription_check_filters"() RETURNS "trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: to_regrole("text"); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."to_regrole"("role_name" "text") RETURNS "regrole"
    LANGUAGE "sql" IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION "realtime"."topic"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: can_insert_object("text", "text", "uuid", "jsonb"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."can_insert_object"("bucketid" "text", "name" "text", "owner" "uuid", "metadata" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: delete_leaf_prefixes("text"[], "text"[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."delete_leaf_prefixes"("bucket_ids" "text"[], "names" "text"[]) RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."enforce_bucket_name_length"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension("text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."extension"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename("text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."filename"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername("text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."foldername"("name" "text") RETURNS "text"[]
    LANGUAGE "plpgsql" IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


--
-- Name: get_common_prefix("text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."get_common_prefix"("p_key" "text", "p_prefix" "text", "p_delimiter" "text") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


--
-- Name: get_level("text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."get_level"("name" "text") RETURNS integer
    LANGUAGE "sql" IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


--
-- Name: get_prefix("text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."get_prefix"("name" "text") RETURNS "text"
    LANGUAGE "sql" IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


--
-- Name: get_prefixes("text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."get_prefixes"("name" "text") RETURNS "text"[]
    LANGUAGE "plpgsql" IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."get_size_by_bucket"() RETURNS TABLE("size" bigint, "bucket_id" "text")
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter("text", "text", "text", integer, "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."list_multipart_uploads_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer DEFAULT 100, "next_key_token" "text" DEFAULT ''::"text", "next_upload_token" "text" DEFAULT ''::"text") RETURNS TABLE("key" "text", "id" "text", "created_at" timestamp with time zone)
    LANGUAGE "plpgsql"
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


--
-- Name: list_objects_with_delimiter("text", "text", "text", integer, "text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."list_objects_with_delimiter"("_bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer DEFAULT 100, "start_after" "text" DEFAULT ''::"text", "next_token" "text" DEFAULT ''::"text", "sort_order" "text" DEFAULT 'asc'::"text") RETURNS TABLE("name" "text", "id" "uuid", "metadata" "jsonb", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone)
    LANGUAGE "plpgsql" STABLE
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


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."operation"() RETURNS "text"
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."protect_delete"() RETURNS "trigger"
    LANGUAGE "plpgsql"
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


--
-- Name: search("text", "text", integer, integer, integer, "text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."search"("prefix" "text", "bucketname" "text", "limits" integer DEFAULT 100, "levels" integer DEFAULT 1, "offsets" integer DEFAULT 0, "search" "text" DEFAULT ''::"text", "sortcolumn" "text" DEFAULT 'name'::"text", "sortorder" "text" DEFAULT 'asc'::"text") RETURNS TABLE("name" "text", "id" "uuid", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone, "metadata" "jsonb")
    LANGUAGE "plpgsql" STABLE
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


--
-- Name: search_by_timestamp("text", "text", integer, integer, "text", "text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."search_by_timestamp"("p_prefix" "text", "p_bucket_id" "text", "p_limit" integer, "p_level" integer, "p_start_after" "text", "p_sort_order" "text", "p_sort_column" "text", "p_sort_column_after" "text") RETURNS TABLE("key" "text", "name" "text", "id" "uuid", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone, "metadata" "jsonb")
    LANGUAGE "plpgsql" STABLE
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


--
-- Name: search_legacy_v1("text", "text", integer, integer, integer, "text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."search_legacy_v1"("prefix" "text", "bucketname" "text", "limits" integer DEFAULT 100, "levels" integer DEFAULT 1, "offsets" integer DEFAULT 0, "search" "text" DEFAULT ''::"text", "sortcolumn" "text" DEFAULT 'name'::"text", "sortorder" "text" DEFAULT 'asc'::"text") RETURNS TABLE("name" "text", "id" "uuid", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone, "metadata" "jsonb")
    LANGUAGE "plpgsql" STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


--
-- Name: search_v2("text", "text", integer, integer, "text", "text", "text", "text"); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."search_v2"("prefix" "text", "bucket_name" "text", "limits" integer DEFAULT 100, "levels" integer DEFAULT 1, "start_after" "text" DEFAULT ''::"text", "sort_order" "text" DEFAULT 'asc'::"text", "sort_column" "text" DEFAULT 'name'::"text", "sort_column_after" "text" DEFAULT ''::"text") RETURNS TABLE("key" "text", "name" "text", "id" "uuid", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone, "metadata" "jsonb")
    LANGUAGE "plpgsql" STABLE
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


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION "storage"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."audit_log_entries" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "payload" json,
    "created_at" timestamp with time zone,
    "ip_address" character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE "audit_log_entries"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."audit_log_entries" IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."custom_oauth_providers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "provider_type" "text" NOT NULL,
    "identifier" "text" NOT NULL,
    "name" "text" NOT NULL,
    "client_id" "text" NOT NULL,
    "client_secret" "text" NOT NULL,
    "acceptable_client_ids" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "scopes" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "pkce_enabled" boolean DEFAULT true NOT NULL,
    "attribute_mapping" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "authorization_params" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "enabled" boolean DEFAULT true NOT NULL,
    "email_optional" boolean DEFAULT false NOT NULL,
    "issuer" "text",
    "discovery_url" "text",
    "skip_nonce_check" boolean DEFAULT false NOT NULL,
    "cached_discovery" "jsonb",
    "discovery_cached_at" timestamp with time zone,
    "authorization_url" "text",
    "token_url" "text",
    "userinfo_url" "text",
    "jwks_uri" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "custom_oauth_providers_authorization_url_https" CHECK ((("authorization_url" IS NULL) OR ("authorization_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_authorization_url_length" CHECK ((("authorization_url" IS NULL) OR ("char_length"("authorization_url") <= 2048))),
    CONSTRAINT "custom_oauth_providers_client_id_length" CHECK ((("char_length"("client_id") >= 1) AND ("char_length"("client_id") <= 512))),
    CONSTRAINT "custom_oauth_providers_discovery_url_length" CHECK ((("discovery_url" IS NULL) OR ("char_length"("discovery_url") <= 2048))),
    CONSTRAINT "custom_oauth_providers_identifier_format" CHECK (("identifier" ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::"text")),
    CONSTRAINT "custom_oauth_providers_issuer_length" CHECK ((("issuer" IS NULL) OR (("char_length"("issuer") >= 1) AND ("char_length"("issuer") <= 2048)))),
    CONSTRAINT "custom_oauth_providers_jwks_uri_https" CHECK ((("jwks_uri" IS NULL) OR ("jwks_uri" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_jwks_uri_length" CHECK ((("jwks_uri" IS NULL) OR ("char_length"("jwks_uri") <= 2048))),
    CONSTRAINT "custom_oauth_providers_name_length" CHECK ((("char_length"("name") >= 1) AND ("char_length"("name") <= 100))),
    CONSTRAINT "custom_oauth_providers_oauth2_requires_endpoints" CHECK ((("provider_type" <> 'oauth2'::"text") OR (("authorization_url" IS NOT NULL) AND ("token_url" IS NOT NULL) AND ("userinfo_url" IS NOT NULL)))),
    CONSTRAINT "custom_oauth_providers_oidc_discovery_url_https" CHECK ((("provider_type" <> 'oidc'::"text") OR ("discovery_url" IS NULL) OR ("discovery_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_oidc_issuer_https" CHECK ((("provider_type" <> 'oidc'::"text") OR ("issuer" IS NULL) OR ("issuer" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_oidc_requires_issuer" CHECK ((("provider_type" <> 'oidc'::"text") OR ("issuer" IS NOT NULL))),
    CONSTRAINT "custom_oauth_providers_provider_type_check" CHECK (("provider_type" = ANY (ARRAY['oauth2'::"text", 'oidc'::"text"]))),
    CONSTRAINT "custom_oauth_providers_token_url_https" CHECK ((("token_url" IS NULL) OR ("token_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_token_url_length" CHECK ((("token_url" IS NULL) OR ("char_length"("token_url") <= 2048))),
    CONSTRAINT "custom_oauth_providers_userinfo_url_https" CHECK ((("userinfo_url" IS NULL) OR ("userinfo_url" ~~ 'https://%'::"text"))),
    CONSTRAINT "custom_oauth_providers_userinfo_url_length" CHECK ((("userinfo_url" IS NULL) OR ("char_length"("userinfo_url") <= 2048)))
);


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."flow_state" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid",
    "auth_code" "text",
    "code_challenge_method" "auth"."code_challenge_method",
    "code_challenge" "text",
    "provider_type" "text" NOT NULL,
    "provider_access_token" "text",
    "provider_refresh_token" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "authentication_method" "text" NOT NULL,
    "auth_code_issued_at" timestamp with time zone,
    "invite_token" "text",
    "referrer" "text",
    "oauth_client_state_id" "uuid",
    "linking_target_id" "uuid",
    "email_optional" boolean DEFAULT false NOT NULL
);


--
-- Name: TABLE "flow_state"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."flow_state" IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."identities" (
    "provider_id" "text" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "identity_data" "jsonb" NOT NULL,
    "provider" "text" NOT NULL,
    "last_sign_in_at" timestamp with time zone,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "email" "text" GENERATED ALWAYS AS ("lower"(("identity_data" ->> 'email'::"text"))) STORED,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


--
-- Name: TABLE "identities"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."identities" IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN "identities"."email"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."identities"."email" IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."instances" (
    "id" "uuid" NOT NULL,
    "uuid" "uuid",
    "raw_base_config" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


--
-- Name: TABLE "instances"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."instances" IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."mfa_amr_claims" (
    "session_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "authentication_method" "text" NOT NULL,
    "id" "uuid" NOT NULL
);


--
-- Name: TABLE "mfa_amr_claims"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."mfa_amr_claims" IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."mfa_challenges" (
    "id" "uuid" NOT NULL,
    "factor_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "verified_at" timestamp with time zone,
    "ip_address" "inet" NOT NULL,
    "otp_code" "text",
    "web_authn_session_data" "jsonb"
);


--
-- Name: TABLE "mfa_challenges"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."mfa_challenges" IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."mfa_factors" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "friendly_name" "text",
    "factor_type" "auth"."factor_type" NOT NULL,
    "status" "auth"."factor_status" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "secret" "text",
    "phone" "text",
    "last_challenged_at" timestamp with time zone,
    "web_authn_credential" "jsonb",
    "web_authn_aaguid" "uuid",
    "last_webauthn_challenge_data" "jsonb"
);


--
-- Name: TABLE "mfa_factors"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."mfa_factors" IS 'auth: stores metadata about factors';


--
-- Name: COLUMN "mfa_factors"."last_webauthn_challenge_data"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."mfa_factors"."last_webauthn_challenge_data" IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."oauth_authorizations" (
    "id" "uuid" NOT NULL,
    "authorization_id" "text" NOT NULL,
    "client_id" "uuid" NOT NULL,
    "user_id" "uuid",
    "redirect_uri" "text" NOT NULL,
    "scope" "text" NOT NULL,
    "state" "text",
    "resource" "text",
    "code_challenge" "text",
    "code_challenge_method" "auth"."code_challenge_method",
    "response_type" "auth"."oauth_response_type" DEFAULT 'code'::"auth"."oauth_response_type" NOT NULL,
    "status" "auth"."oauth_authorization_status" DEFAULT 'pending'::"auth"."oauth_authorization_status" NOT NULL,
    "authorization_code" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "expires_at" timestamp with time zone DEFAULT ("now"() + '00:03:00'::interval) NOT NULL,
    "approved_at" timestamp with time zone,
    "nonce" "text",
    CONSTRAINT "oauth_authorizations_authorization_code_length" CHECK (("char_length"("authorization_code") <= 255)),
    CONSTRAINT "oauth_authorizations_code_challenge_length" CHECK (("char_length"("code_challenge") <= 128)),
    CONSTRAINT "oauth_authorizations_expires_at_future" CHECK (("expires_at" > "created_at")),
    CONSTRAINT "oauth_authorizations_nonce_length" CHECK (("char_length"("nonce") <= 255)),
    CONSTRAINT "oauth_authorizations_redirect_uri_length" CHECK (("char_length"("redirect_uri") <= 2048)),
    CONSTRAINT "oauth_authorizations_resource_length" CHECK (("char_length"("resource") <= 2048)),
    CONSTRAINT "oauth_authorizations_scope_length" CHECK (("char_length"("scope") <= 4096)),
    CONSTRAINT "oauth_authorizations_state_length" CHECK (("char_length"("state") <= 4096))
);


--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."oauth_client_states" (
    "id" "uuid" NOT NULL,
    "provider_type" "text" NOT NULL,
    "code_verifier" "text",
    "created_at" timestamp with time zone NOT NULL
);


--
-- Name: TABLE "oauth_client_states"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."oauth_client_states" IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."oauth_clients" (
    "id" "uuid" NOT NULL,
    "client_secret_hash" "text",
    "registration_type" "auth"."oauth_registration_type" NOT NULL,
    "redirect_uris" "text" NOT NULL,
    "grant_types" "text" NOT NULL,
    "client_name" "text",
    "client_uri" "text",
    "logo_uri" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "deleted_at" timestamp with time zone,
    "client_type" "auth"."oauth_client_type" DEFAULT 'confidential'::"auth"."oauth_client_type" NOT NULL,
    "token_endpoint_auth_method" "text" NOT NULL,
    CONSTRAINT "oauth_clients_client_name_length" CHECK (("char_length"("client_name") <= 1024)),
    CONSTRAINT "oauth_clients_client_uri_length" CHECK (("char_length"("client_uri") <= 2048)),
    CONSTRAINT "oauth_clients_logo_uri_length" CHECK (("char_length"("logo_uri") <= 2048)),
    CONSTRAINT "oauth_clients_token_endpoint_auth_method_check" CHECK (("token_endpoint_auth_method" = ANY (ARRAY['client_secret_basic'::"text", 'client_secret_post'::"text", 'none'::"text"])))
);


--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."oauth_consents" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "client_id" "uuid" NOT NULL,
    "scopes" "text" NOT NULL,
    "granted_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "revoked_at" timestamp with time zone,
    CONSTRAINT "oauth_consents_revoked_after_granted" CHECK ((("revoked_at" IS NULL) OR ("revoked_at" >= "granted_at"))),
    CONSTRAINT "oauth_consents_scopes_length" CHECK (("char_length"("scopes") <= 2048)),
    CONSTRAINT "oauth_consents_scopes_not_empty" CHECK (("char_length"(TRIM(BOTH FROM "scopes")) > 0))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."one_time_tokens" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "token_type" "auth"."one_time_token_type" NOT NULL,
    "token_hash" "text" NOT NULL,
    "relates_to" "text" NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "one_time_tokens_token_hash_check" CHECK (("char_length"("token_hash") > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."refresh_tokens" (
    "instance_id" "uuid",
    "id" bigint NOT NULL,
    "token" character varying(255),
    "user_id" character varying(255),
    "revoked" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "parent" character varying(255),
    "session_id" "uuid"
);


--
-- Name: TABLE "refresh_tokens"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."refresh_tokens" IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE "auth"."refresh_tokens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE "auth"."refresh_tokens_id_seq" OWNED BY "auth"."refresh_tokens"."id";


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."saml_providers" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "entity_id" "text" NOT NULL,
    "metadata_xml" "text" NOT NULL,
    "metadata_url" "text",
    "attribute_mapping" "jsonb",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "name_id_format" "text",
    CONSTRAINT "entity_id not empty" CHECK (("char_length"("entity_id") > 0)),
    CONSTRAINT "metadata_url not empty" CHECK ((("metadata_url" = NULL::"text") OR ("char_length"("metadata_url") > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK (("char_length"("metadata_xml") > 0))
);


--
-- Name: TABLE "saml_providers"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."saml_providers" IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."saml_relay_states" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "request_id" "text" NOT NULL,
    "for_email" "text",
    "redirect_to" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "flow_state_id" "uuid",
    CONSTRAINT "request_id not empty" CHECK (("char_length"("request_id") > 0))
);


--
-- Name: TABLE "saml_relay_states"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."saml_relay_states" IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."schema_migrations" (
    "version" character varying(255) NOT NULL
);


--
-- Name: TABLE "schema_migrations"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."schema_migrations" IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."sessions" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "factor_id" "uuid",
    "aal" "auth"."aal_level",
    "not_after" timestamp with time zone,
    "refreshed_at" timestamp without time zone,
    "user_agent" "text",
    "ip" "inet",
    "tag" "text",
    "oauth_client_id" "uuid",
    "refresh_token_hmac_key" "text",
    "refresh_token_counter" bigint,
    "scopes" "text",
    CONSTRAINT "sessions_scopes_length" CHECK (("char_length"("scopes") <= 4096))
);


--
-- Name: TABLE "sessions"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."sessions" IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN "sessions"."not_after"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."sessions"."not_after" IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN "sessions"."refresh_token_hmac_key"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."sessions"."refresh_token_hmac_key" IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN "sessions"."refresh_token_counter"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."sessions"."refresh_token_counter" IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."sso_domains" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "domain" "text" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK (("char_length"("domain") > 0))
);


--
-- Name: TABLE "sso_domains"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."sso_domains" IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."sso_providers" (
    "id" "uuid" NOT NULL,
    "resource_id" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "disabled" boolean,
    CONSTRAINT "resource_id not empty" CHECK ((("resource_id" = NULL::"text") OR ("char_length"("resource_id") > 0)))
);


--
-- Name: TABLE "sso_providers"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."sso_providers" IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN "sso_providers"."resource_id"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."sso_providers"."resource_id" IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."users" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "aud" character varying(255),
    "role" character varying(255),
    "email" character varying(255),
    "encrypted_password" character varying(255),
    "email_confirmed_at" timestamp with time zone,
    "invited_at" timestamp with time zone,
    "confirmation_token" character varying(255),
    "confirmation_sent_at" timestamp with time zone,
    "recovery_token" character varying(255),
    "recovery_sent_at" timestamp with time zone,
    "email_change_token_new" character varying(255),
    "email_change" character varying(255),
    "email_change_sent_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "raw_app_meta_data" "jsonb",
    "raw_user_meta_data" "jsonb",
    "is_super_admin" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "phone" "text" DEFAULT NULL::character varying,
    "phone_confirmed_at" timestamp with time zone,
    "phone_change" "text" DEFAULT ''::character varying,
    "phone_change_token" character varying(255) DEFAULT ''::character varying,
    "phone_change_sent_at" timestamp with time zone,
    "confirmed_at" timestamp with time zone GENERATED ALWAYS AS (LEAST("email_confirmed_at", "phone_confirmed_at")) STORED,
    "email_change_token_current" character varying(255) DEFAULT ''::character varying,
    "email_change_confirm_status" smallint DEFAULT 0,
    "banned_until" timestamp with time zone,
    "reauthentication_token" character varying(255) DEFAULT ''::character varying,
    "reauthentication_sent_at" timestamp with time zone,
    "is_sso_user" boolean DEFAULT false NOT NULL,
    "deleted_at" timestamp with time zone,
    "is_anonymous" boolean DEFAULT false NOT NULL,
    CONSTRAINT "users_email_change_confirm_status_check" CHECK ((("email_change_confirm_status" >= 0) AND ("email_change_confirm_status" <= 2)))
);


--
-- Name: TABLE "users"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE "auth"."users" IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN "users"."is_sso_user"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN "auth"."users"."is_sso_user" IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."webauthn_challenges" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid",
    "challenge_type" "text" NOT NULL,
    "session_data" "jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "expires_at" timestamp with time zone NOT NULL,
    CONSTRAINT "webauthn_challenges_challenge_type_check" CHECK (("challenge_type" = ANY (ARRAY['signup'::"text", 'registration'::"text", 'authentication'::"text"])))
);


--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE "auth"."webauthn_credentials" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "credential_id" "bytea" NOT NULL,
    "public_key" "bytea" NOT NULL,
    "attestation_type" "text" DEFAULT ''::"text" NOT NULL,
    "aaguid" "uuid",
    "sign_count" bigint DEFAULT 0 NOT NULL,
    "transports" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "backup_eligible" boolean DEFAULT false NOT NULL,
    "backed_up" boolean DEFAULT false NOT NULL,
    "friendly_name" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "last_used_at" timestamp with time zone
);


--
-- Name: exercice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."exercice" (
    "id_exercice" integer NOT NULL,
    "nom" character varying(255) NOT NULL
);


--
-- Name: exercice_id_exercice_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."exercice_id_exercice_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exercice_id_exercice_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."exercice_id_exercice_seq" OWNED BY "public"."exercice"."id_exercice";


--
-- Name: hot_metrics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."hot_metrics" (
    "sentiment_label" "text" NOT NULL,
    "tweet_count" integer DEFAULT 0
);


--
-- Name: profil_vbt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."profil_vbt" (
    "id_utilisateur" integer NOT NULL,
    "id_exercice" integer NOT NULL,
    "current_1rm" numeric(6,2),
    "slope" numeric(10,6),
    "intercept" numeric(10,6),
    "last_updated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: ref_rpe_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."ref_rpe_table" (
    "id" integer NOT NULL,
    "reps" integer NOT NULL,
    "rpe" numeric(3,1) NOT NULL,
    "percentage" numeric(5,4) NOT NULL
);


--
-- Name: ref_rpe_table_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."ref_rpe_table_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ref_rpe_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."ref_rpe_table_id_seq" OWNED BY "public"."ref_rpe_table"."id";


--
-- Name: repetition; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."repetition" (
    "id" integer NOT NULL,
    "id_serie" integer NOT NULL,
    "numero_rep" integer NOT NULL,
    "vitesse_mesuree" numeric(5,3) NOT NULL
);


--
-- Name: repetition_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."repetition_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: repetition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."repetition_id_seq" OWNED BY "public"."repetition"."id";


--
-- Name: seance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."seance" (
    "id_seance" integer NOT NULL,
    "id_utilisateur" integer NOT NULL,
    "date_seance" "date" DEFAULT CURRENT_DATE NOT NULL
);


--
-- Name: seance_exo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."seance_exo" (
    "id_seance_exo" integer NOT NULL,
    "id_seance" integer NOT NULL,
    "id_exercice" integer NOT NULL,
    "daily_1rm" numeric
);


--
-- Name: seance_exo_id_seance_exo_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."seance_exo_id_seance_exo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seance_exo_id_seance_exo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."seance_exo_id_seance_exo_seq" OWNED BY "public"."seance_exo"."id_seance_exo";


--
-- Name: seance_id_seance_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."seance_id_seance_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seance_id_seance_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."seance_id_seance_seq" OWNED BY "public"."seance"."id_seance";


--
-- Name: serie; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."serie" (
    "id" integer NOT NULL,
    "id_seance_exo" integer NOT NULL,
    "charge_kg" numeric(6,2) NOT NULL,
    "nombre_reps" integer NOT NULL,
    "vitesse_fin_serie" numeric(5,3),
    "rpe_estime" numeric(3,1),
    "rpe_reel" numeric(3,1),
    "echauffement" boolean NOT NULL
);


--
-- Name: serie_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."serie_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: serie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."serie_id_seq" OWNED BY "public"."serie"."id";


--
-- Name: tweets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."tweets" (
    "id" integer NOT NULL,
    "timestamp" timestamp with time zone,
    "raw_content" "text",
    "query" "text",
    "is_processed" integer DEFAULT 0
);


--
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."tweets_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."tweets_id_seq" OWNED BY "public"."tweets"."id";


--
-- Name: tweets_processed; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."tweets_processed" (
    "id" integer NOT NULL,
    "original_id" integer,
    "clean_text" "text",
    "lang" "text",
    "sentiment_label" "text"
);


--
-- Name: tweets_processed_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."tweets_processed_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tweets_processed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."tweets_processed_id_seq" OWNED BY "public"."tweets_processed"."id";


--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."utilisateur" (
    "id_utilisateur" integer NOT NULL,
    "nom" character varying(100) NOT NULL,
    "prenom" character varying(100) NOT NULL,
    "email" character varying(255) NOT NULL,
    "mot_de_passe" character varying(255) NOT NULL,
    "date_naissance" "date",
    "poids_corps" numeric(5,2),
    "sexe" character(1),
    "role" character varying(50) DEFAULT 'athlete'::character varying NOT NULL,
    "id_coach" integer,
    CONSTRAINT "utilisateur_role_check" CHECK ((("role")::"text" = ANY ((ARRAY['admin'::character varying, 'athlete'::character varying, 'coach'::character varying])::"text"[]))),
    CONSTRAINT "utilisateur_sexe_check" CHECK (("sexe" = ANY (ARRAY['M'::"bpchar", 'F'::"bpchar"])))
);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "public"."utilisateur_id_utilisateur_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "public"."utilisateur_id_utilisateur_seq" OWNED BY "public"."utilisateur"."id_utilisateur";


--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE "realtime"."messages" (
    "topic" "text" NOT NULL,
    "extension" "text" NOT NULL,
    "payload" "jsonb",
    "event" "text",
    "private" boolean DEFAULT false,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "inserted_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
)
PARTITION BY RANGE ("inserted_at");


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE "realtime"."schema_migrations" (
    "version" bigint NOT NULL,
    "inserted_at" timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE "realtime"."subscription" (
    "id" bigint NOT NULL,
    "subscription_id" "uuid" NOT NULL,
    "entity" "regclass" NOT NULL,
    "filters" "realtime"."user_defined_filter"[] DEFAULT '{}'::"realtime"."user_defined_filter"[] NOT NULL,
    "claims" "jsonb" NOT NULL,
    "claims_role" "regrole" GENERATED ALWAYS AS ("realtime"."to_regrole"(("claims" ->> 'role'::"text"))) STORED NOT NULL,
    "created_at" timestamp without time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE "realtime"."subscription" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "realtime"."subscription_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."buckets" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "owner" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "public" boolean DEFAULT false,
    "avif_autodetection" boolean DEFAULT false,
    "file_size_limit" bigint,
    "allowed_mime_types" "text"[],
    "owner_id" "text",
    "type" "storage"."buckettype" DEFAULT 'STANDARD'::"storage"."buckettype" NOT NULL
);


--
-- Name: COLUMN "buckets"."owner"; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN "storage"."buckets"."owner" IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."buckets_analytics" (
    "name" "text" NOT NULL,
    "type" "storage"."buckettype" DEFAULT 'ANALYTICS'::"storage"."buckettype" NOT NULL,
    "format" "text" DEFAULT 'ICEBERG'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "deleted_at" timestamp with time zone
);


--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."buckets_vectors" (
    "id" "text" NOT NULL,
    "type" "storage"."buckettype" DEFAULT 'VECTOR'::"storage"."buckettype" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."migrations" (
    "id" integer NOT NULL,
    "name" character varying(100) NOT NULL,
    "hash" character varying(40) NOT NULL,
    "executed_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."objects" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "bucket_id" "text",
    "name" "text",
    "owner" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "last_accessed_at" timestamp with time zone DEFAULT "now"(),
    "metadata" "jsonb",
    "path_tokens" "text"[] GENERATED ALWAYS AS ("string_to_array"("name", '/'::"text")) STORED,
    "version" "text",
    "owner_id" "text",
    "user_metadata" "jsonb"
);


--
-- Name: COLUMN "objects"."owner"; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN "storage"."objects"."owner" IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."s3_multipart_uploads" (
    "id" "text" NOT NULL,
    "in_progress_size" bigint DEFAULT 0 NOT NULL,
    "upload_signature" "text" NOT NULL,
    "bucket_id" "text" NOT NULL,
    "key" "text" NOT NULL COLLATE "pg_catalog"."C",
    "version" "text" NOT NULL,
    "owner_id" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "user_metadata" "jsonb"
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."s3_multipart_uploads_parts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "upload_id" "text" NOT NULL,
    "size" bigint DEFAULT 0 NOT NULL,
    "part_number" integer NOT NULL,
    "bucket_id" "text" NOT NULL,
    "key" "text" NOT NULL COLLATE "pg_catalog"."C",
    "etag" "text" NOT NULL,
    "owner_id" "text",
    "version" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE "storage"."vector_indexes" (
    "id" "text" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL COLLATE "pg_catalog"."C",
    "bucket_id" "text" NOT NULL,
    "data_type" "text" NOT NULL,
    "dimension" integer NOT NULL,
    "distance_metric" "text" NOT NULL,
    "metadata_configuration" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."refresh_tokens" ALTER COLUMN "id" SET DEFAULT "nextval"('"auth"."refresh_tokens_id_seq"'::"regclass");


--
-- Name: exercice id_exercice; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."exercice" ALTER COLUMN "id_exercice" SET DEFAULT "nextval"('"public"."exercice_id_exercice_seq"'::"regclass");


--
-- Name: ref_rpe_table id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."ref_rpe_table" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."ref_rpe_table_id_seq"'::"regclass");


--
-- Name: repetition id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."repetition" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."repetition_id_seq"'::"regclass");


--
-- Name: seance id_seance; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance" ALTER COLUMN "id_seance" SET DEFAULT "nextval"('"public"."seance_id_seance_seq"'::"regclass");


--
-- Name: seance_exo id_seance_exo; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance_exo" ALTER COLUMN "id_seance_exo" SET DEFAULT "nextval"('"public"."seance_exo_id_seance_exo_seq"'::"regclass");


--
-- Name: serie id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."serie" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."serie_id_seq"'::"regclass");


--
-- Name: tweets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tweets" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tweets_id_seq"'::"regclass");


--
-- Name: tweets_processed id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tweets_processed" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."tweets_processed_id_seq"'::"regclass");


--
-- Name: utilisateur id_utilisateur; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."utilisateur" ALTER COLUMN "id_utilisateur" SET DEFAULT "nextval"('"public"."utilisateur_id_utilisateur_seq"'::"regclass");


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."custom_oauth_providers" ("id", "provider_type", "identifier", "name", "client_id", "client_secret", "acceptable_client_ids", "scopes", "pkce_enabled", "attribute_mapping", "authorization_params", "enabled", "email_optional", "issuer", "discovery_url", "skip_nonce_check", "cached_discovery", "discovery_cached_at", "authorization_url", "token_url", "userinfo_url", "jwks_uri", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."schema_migrations" ("version") FROM stdin;
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
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."webauthn_challenges" ("id", "user_id", "challenge_type", "session_data", "created_at", "expires_at") FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY "auth"."webauthn_credentials" ("id", "user_id", "credential_id", "public_key", "attestation_type", "aaguid", "sign_count", "transports", "backup_eligible", "backed_up", "friendly_name", "created_at", "updated_at", "last_used_at") FROM stdin;
\.


--
-- Data for Name: exercice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."exercice" ("id_exercice", "nom") FROM stdin;
2	Bench
3	Soulevé de Terre
1	squat
5	Doggy style
\.


--
-- Data for Name: hot_metrics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."hot_metrics" ("sentiment_label", "tweet_count") FROM stdin;
positive	72
negative	53
neutral	134
\.


--
-- Data for Name: profil_vbt; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."profil_vbt" ("id_utilisateur", "id_exercice", "current_1rm", "slope", "intercept", "last_updated") FROM stdin;
1	1	140.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
1	2	110.00	-7.100000	11.500000	2025-11-26 14:58:12.41547+00
1	3	180.00	-7.500000	11.000000	2025-11-26 14:58:12.41547+00
2	1	90.00	-6.800000	11.200000	2025-11-26 14:58:12.41547+00
2	2	60.00	-6.500000	11.400000	2025-11-26 14:58:12.41547+00
2	3	115.00	-7.000000	11.000000	2025-11-26 14:58:12.41547+00
3	1	170.00	-8.500000	12.000000	2025-11-26 14:58:12.41547+00
3	2	130.00	-8.000000	11.800000	2025-11-26 14:58:12.41547+00
3	3	220.00	-9.000000	12.200000	2025-11-26 14:58:12.41547+00
4	1	80.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
4	2	70.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
4	3	100.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
5	1	60.00	-6.000000	11.000000	2025-11-26 14:58:12.41547+00
5	2	40.00	-6.000000	11.000000	2025-11-26 14:58:12.41547+00
5	3	85.00	-6.500000	11.100000	2025-11-26 14:58:12.41547+00
6	1	130.00	-9.000000	12.500000	2025-11-26 14:58:12.41547+00
6	2	80.00	-7.500000	11.500000	2025-11-26 14:58:12.41547+00
6	3	140.00	-8.000000	11.800000	2025-11-26 14:58:12.41547+00
7	1	75.00	-7.000000	11.200000	2025-11-26 14:58:12.41547+00
7	2	50.00	-6.800000	11.300000	2025-11-26 14:58:12.41547+00
7	3	95.00	-7.200000	11.100000	2025-11-26 14:58:12.41547+00
8	1	90.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
8	2	85.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
8	3	110.00	-7.300000	11.300000	2025-11-26 14:58:12.41547+00
9	1	70.00	-6.500000	11.200000	2025-11-26 14:58:12.41547+00
9	2	45.00	-6.200000	11.200000	2025-11-26 14:58:12.41547+00
9	3	90.00	-6.800000	11.100000	2025-11-26 14:58:12.41547+00
10	1	250.00	-10.000000	13.000000	2025-11-26 14:58:12.41547+00
10	2	180.00	-9.500000	12.500000	2025-11-26 14:58:12.41547+00
10	3	300.00	-10.500000	13.500000	2025-11-26 14:58:12.41547+00
11	1	180.00	-6.153846	8.923077	2025-12-17 13:13:51.708003+00
15	1	1000.00	\N	\N	2025-12-17 14:45:15.84884+00
24	1	100.00	-11.428571	10.714286	2026-03-04 13:38:26.600182+00
19	3	120.00	\N	\N	2026-03-25 08:16:45.98325+00
19	1	200.00	-9.323535	10.982932	2026-03-25 09:42:38.187107+00
19	2	200.00	\N	\N	2026-03-04 15:27:35.49725+00
19	5	300.00	\N	\N	2026-03-25 09:36:58.076721+00
\.


--
-- Data for Name: ref_rpe_table; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."ref_rpe_table" ("id", "reps", "rpe", "percentage") FROM stdin;
1	1	10.0	1.0000
2	1	9.5	0.9780
3	1	9.0	0.9550
4	1	8.5	0.9390
5	1	8.0	0.9220
6	1	7.5	0.9070
7	1	7.0	0.8920
8	1	6.5	0.8780
9	2	10.0	0.9550
10	2	9.5	0.9390
11	2	9.0	0.9220
12	2	8.5	0.9070
13	2	8.0	0.8920
14	2	7.5	0.8780
15	2	7.0	0.8630
16	2	6.5	0.8500
17	3	10.0	0.9220
18	3	9.5	0.9070
19	3	9.0	0.8920
20	3	8.5	0.8780
21	3	8.0	0.8630
22	3	7.5	0.8500
23	3	7.0	0.8370
24	3	6.5	0.8240
25	4	10.0	0.8920
26	4	9.5	0.8780
27	4	9.0	0.8630
28	4	8.5	0.8500
29	4	8.0	0.8370
30	4	7.5	0.8240
31	4	7.0	0.8110
32	4	6.5	0.7990
33	5	10.0	0.8630
34	5	9.5	0.8500
35	5	9.0	0.8370
36	5	8.5	0.8240
37	5	8.0	0.8110
38	5	7.5	0.7990
39	5	7.0	0.7860
40	5	6.5	0.7740
41	6	10.0	0.8370
42	6	9.5	0.8240
43	6	9.0	0.8110
44	6	8.5	0.7990
45	6	8.0	0.7860
46	6	7.5	0.7740
47	6	7.0	0.7620
48	6	6.5	0.7510
49	7	10.0	0.8110
50	7	9.5	0.7990
51	7	9.0	0.7860
52	7	8.5	0.7740
53	7	8.0	0.7620
54	7	7.5	0.7510
55	7	7.0	0.7390
56	7	6.5	0.7230
57	8	10.0	0.7860
58	8	9.5	0.7740
59	8	9.0	0.7620
60	8	8.5	0.7510
61	8	8.0	0.7390
62	8	7.5	0.7230
63	8	7.0	0.7070
64	8	6.5	0.6940
65	9	10.0	0.7620
66	9	9.5	0.7510
67	9	9.0	0.7390
68	9	8.5	0.7230
69	9	8.0	0.7070
70	9	7.5	0.6940
71	9	7.0	0.6800
72	9	6.5	0.6670
73	10	10.0	0.7390
74	10	9.5	0.7230
75	10	9.0	0.7070
76	10	8.5	0.6940
77	10	8.0	0.6800
78	10	7.5	0.6670
79	10	7.0	0.6530
80	10	6.5	0.6400
81	11	10.0	0.7070
82	11	9.5	0.6940
83	11	9.0	0.6800
84	11	8.5	0.6670
85	11	8.0	0.6530
86	11	7.5	0.6400
87	11	7.0	0.6260
88	11	6.5	0.6130
89	12	10.0	0.6800
90	12	9.5	0.6670
91	12	9.0	0.6530
92	12	8.5	0.6400
93	12	8.0	0.6260
94	12	7.5	0.6130
95	12	7.0	0.5990
96	12	6.5	0.5860
\.


--
-- Data for Name: repetition; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."repetition" ("id", "id_serie", "numero_rep", "vitesse_mesuree") FROM stdin;
1	1	1	0.400
2	2	1	0.380
3	2	2	0.330
4	2	3	0.400
5	2	4	0.310
6	2	5	0.390
7	3	1	0.650
8	3	2	0.630
9	3	3	0.630
10	3	4	0.580
11	3	5	0.600
12	4	1	0.780
13	4	2	0.790
14	4	3	0.720
15	4	4	0.730
16	4	5	0.770
17	5	1	0.390
18	5	2	0.400
19	5	3	0.390
20	5	4	0.360
21	5	5	0.340
22	6	1	0.380
23	6	2	0.380
24	6	3	0.400
25	6	4	0.430
26	6	5	0.470
27	7	1	0.590
28	7	2	0.590
29	7	3	0.520
30	7	4	0.600
31	7	5	0.600
32	8	1	0.450
33	8	2	0.420
34	8	3	0.420
35	8	4	0.490
36	8	5	0.450
37	9	1	0.440
38	9	2	0.400
39	9	3	0.420
40	9	4	0.470
41	9	5	0.390
42	10	1	0.790
43	10	2	0.780
44	10	3	0.800
45	10	4	0.790
46	10	5	0.800
47	11	1	0.620
48	11	2	0.620
49	11	3	0.630
50	11	4	0.600
51	11	5	0.600
52	12	1	0.510
53	12	2	0.520
54	12	3	0.520
55	12	4	0.550
56	12	5	0.480
57	13	1	0.670
58	13	2	0.770
59	13	3	0.720
60	13	4	0.710
61	13	5	0.700
62	14	1	0.520
63	14	2	0.510
64	14	3	0.560
65	14	4	0.500
66	14	5	0.530
67	15	1	0.500
68	15	2	0.530
69	15	3	0.520
70	16	1	0.650
71	16	2	0.670
72	16	3	0.690
73	16	4	0.690
74	16	5	0.660
75	17	1	0.540
76	17	2	0.550
77	17	3	0.620
78	17	4	0.610
79	17	5	0.550
80	19	1	0.720
81	19	2	0.760
82	19	3	0.780
83	19	4	0.700
84	19	5	0.780
85	20	1	0.780
86	20	2	0.710
87	20	3	0.770
88	20	4	0.730
89	20	5	0.740
90	21	1	0.760
91	21	2	0.720
92	21	3	0.720
93	21	4	0.750
94	21	5	0.750
95	22	1	0.520
96	22	2	0.560
97	22	3	0.520
98	22	4	0.550
99	22	5	0.530
100	23	1	0.330
101	23	2	0.360
102	23	3	0.310
103	23	4	0.380
104	23	5	0.350
105	24	1	0.630
106	24	2	0.590
107	24	3	0.600
108	24	4	0.550
109	24	5	0.610
110	25	1	0.750
111	25	2	0.660
112	25	3	0.670
113	25	4	0.750
114	25	5	0.660
115	26	1	0.460
116	26	2	0.480
117	26	3	0.470
118	26	4	0.500
119	26	5	0.450
120	27	1	0.550
121	27	2	0.540
122	27	3	0.570
123	27	4	0.550
124	27	5	0.570
125	28	1	0.780
126	28	2	0.760
127	28	3	0.800
128	28	4	0.810
129	28	5	0.760
130	29	1	0.460
131	29	2	0.400
132	29	3	0.450
133	29	4	0.480
134	29	5	0.390
135	30	1	0.560
136	30	2	0.510
137	30	3	0.570
138	30	4	0.480
139	30	5	0.480
140	31	1	0.720
141	31	2	0.660
142	31	3	0.700
143	31	4	0.680
144	31	5	0.740
145	32	1	0.690
146	32	2	0.670
147	32	3	0.700
148	32	4	0.670
149	32	5	0.750
150	33	1	0.710
151	33	2	0.690
152	33	3	0.700
153	33	4	0.710
154	33	5	0.720
155	34	1	0.660
156	34	2	0.590
157	34	3	0.620
158	34	4	0.620
159	34	5	0.630
160	35	1	0.700
161	35	2	0.740
162	35	3	0.700
163	35	4	0.690
164	35	5	0.740
165	36	1	0.630
166	36	2	0.610
167	36	3	0.590
168	36	4	0.660
169	36	5	0.640
170	37	1	0.770
171	37	2	0.840
172	37	3	0.840
173	37	4	0.840
174	37	5	0.820
175	38	1	0.680
176	38	2	0.630
177	38	3	0.620
178	38	4	0.650
179	38	5	0.610
180	39	1	0.600
181	39	2	0.630
182	39	3	0.660
183	39	4	0.630
184	39	5	0.700
185	40	1	0.360
186	40	2	0.390
187	40	3	0.380
188	40	4	0.370
189	40	5	0.430
190	41	1	0.370
191	41	2	0.330
192	41	3	0.340
193	41	4	0.410
194	41	5	0.370
195	42	1	0.470
196	42	2	0.480
197	42	3	0.480
198	42	4	0.450
199	42	5	0.490
200	43	1	0.500
201	43	2	0.490
202	43	3	0.470
203	43	4	0.520
204	43	5	0.460
205	44	1	0.420
206	44	2	0.430
207	44	3	0.390
208	44	4	0.440
209	44	5	0.460
210	45	1	0.440
211	45	2	0.420
212	45	3	0.450
213	45	4	0.400
214	45	5	0.420
215	46	1	0.640
216	46	2	0.700
217	46	3	0.700
218	46	4	0.700
219	46	5	0.640
220	47	1	0.470
221	47	2	0.440
222	47	3	0.450
223	47	4	0.500
224	47	5	0.530
225	48	1	0.780
226	48	2	0.730
227	48	3	0.740
228	48	4	0.820
229	48	5	0.750
230	49	1	0.440
231	49	2	0.440
232	49	3	0.440
233	49	4	0.440
234	49	5	0.440
235	50	1	0.510
236	50	2	0.510
237	50	3	0.510
238	50	4	0.510
239	50	5	0.510
240	51	1	0.210
241	51	2	0.210
242	51	3	0.210
243	51	4	0.210
244	51	5	0.210
245	52	1	0.440
246	52	2	0.440
247	52	3	0.440
248	52	4	0.440
249	52	5	0.440
250	53	1	0.320
251	53	2	0.320
252	53	3	0.320
253	53	4	0.320
254	53	5	0.320
255	54	1	0.520
256	54	2	0.520
257	54	3	0.520
258	54	4	0.520
259	54	5	0.520
260	55	1	0.520
261	55	2	0.520
262	55	3	0.520
263	55	4	0.520
264	55	5	0.520
265	56	1	0.310
266	56	2	0.310
267	56	3	0.310
268	56	4	0.310
269	56	5	0.310
270	57	1	0.330
271	57	2	0.330
272	57	3	0.330
273	57	4	0.330
274	57	5	0.330
275	58	1	0.340
276	58	2	0.340
277	58	3	0.340
278	58	4	0.340
279	58	5	0.340
280	59	1	0.540
281	59	2	0.540
282	59	3	0.540
283	59	4	0.540
284	59	5	0.540
285	60	1	0.520
286	60	2	0.520
287	60	3	0.520
288	60	4	0.520
289	60	5	0.520
290	61	1	0.410
291	61	2	0.410
292	61	3	0.410
293	61	4	0.410
294	61	5	0.410
295	62	1	0.220
296	62	2	0.220
297	62	3	0.220
298	62	4	0.220
299	62	5	0.220
300	63	1	0.350
301	63	2	0.350
302	63	3	0.350
303	63	4	0.350
304	63	5	0.350
305	64	1	0.450
306	64	2	0.450
307	64	3	0.450
308	64	4	0.450
309	64	5	0.450
310	65	1	0.330
311	65	2	0.330
312	65	3	0.330
313	65	4	0.330
314	65	5	0.330
315	66	1	0.250
316	66	2	0.250
317	66	3	0.250
318	66	4	0.250
319	66	5	0.250
320	67	1	0.220
321	67	2	0.220
322	67	3	0.220
323	67	4	0.220
324	67	5	0.220
325	68	1	0.200
326	68	2	0.200
327	68	3	0.200
328	68	4	0.200
329	68	5	0.200
330	69	1	0.310
331	69	2	0.310
332	69	3	0.310
333	69	4	0.310
334	69	5	0.310
335	70	1	0.210
336	70	2	0.210
337	70	3	0.210
338	70	4	0.210
339	70	5	0.210
340	71	1	0.410
341	71	2	0.410
342	71	3	0.410
343	71	4	0.410
344	71	5	0.410
345	72	1	0.540
346	72	2	0.540
347	72	3	0.540
348	72	4	0.540
349	72	5	0.540
350	73	1	0.440
351	73	2	0.440
352	73	3	0.440
353	73	4	0.440
354	73	5	0.440
355	74	1	0.410
356	74	2	0.410
357	74	3	0.410
358	74	4	0.410
359	74	5	0.410
360	75	1	0.430
361	75	2	0.430
362	75	3	0.430
363	75	4	0.430
364	75	5	0.430
365	76	1	0.530
366	76	2	0.530
367	76	3	0.530
368	76	4	0.530
369	76	5	0.530
370	77	1	0.220
371	77	2	0.220
372	77	3	0.220
373	77	4	0.220
374	77	5	0.220
375	78	1	0.410
376	78	2	0.410
377	78	3	0.410
378	78	4	0.410
379	78	5	0.410
380	79	1	0.530
381	79	2	0.530
382	79	3	0.530
383	79	4	0.530
384	79	5	0.530
385	80	1	0.300
386	80	2	0.300
387	80	3	0.300
388	80	4	0.300
389	80	5	0.300
390	81	1	0.340
391	81	2	0.340
392	81	3	0.340
393	81	4	0.340
394	81	5	0.340
395	82	1	0.330
396	82	2	0.330
397	82	3	0.330
398	82	4	0.330
399	82	5	0.330
400	83	1	0.440
401	83	2	0.440
402	83	3	0.440
403	83	4	0.440
404	83	5	0.440
405	84	1	0.340
406	84	2	0.340
407	84	3	0.340
408	84	4	0.340
409	84	5	0.340
410	85	1	0.300
411	85	2	0.300
412	85	3	0.300
413	85	4	0.300
414	85	5	0.300
415	86	1	0.220
416	86	2	0.220
417	86	3	0.220
418	86	4	0.220
419	86	5	0.220
420	87	1	0.340
421	87	2	0.340
422	87	3	0.340
423	87	4	0.340
424	87	5	0.340
425	88	1	0.440
426	88	2	0.440
427	88	3	0.440
428	88	4	0.440
429	88	5	0.440
430	89	1	0.200
431	89	2	0.200
432	89	3	0.200
433	89	4	0.200
434	89	5	0.200
435	90	1	0.330
436	90	2	0.330
437	90	3	0.330
438	90	4	0.330
439	90	5	0.330
440	91	1	0.410
441	91	2	0.410
442	91	3	0.410
443	91	4	0.410
444	91	5	0.410
445	92	1	0.230
446	92	2	0.230
447	92	3	0.230
448	92	4	0.230
449	92	5	0.230
450	93	1	0.310
451	93	2	0.310
452	93	3	0.310
453	93	4	0.310
454	93	5	0.310
455	94	1	0.320
456	94	2	0.320
457	94	3	0.320
458	94	4	0.320
459	94	5	0.320
460	95	1	0.240
461	95	2	0.240
462	95	3	0.240
463	95	4	0.240
464	95	5	0.240
465	96	1	0.420
466	96	2	0.420
467	96	3	0.420
468	96	4	0.420
469	96	5	0.420
470	97	1	0.310
471	97	2	0.310
472	97	3	0.310
473	97	4	0.310
474	97	5	0.310
475	98	1	0.320
476	98	2	0.320
477	98	3	0.320
478	98	4	0.320
479	98	5	0.320
480	99	1	0.250
481	99	2	0.250
482	99	3	0.250
483	99	4	0.250
484	99	5	0.250
\.


--
-- Data for Name: seance; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."seance" ("id_seance", "id_utilisateur", "date_seance") FROM stdin;
1	24	2026-03-04
2	19	2026-03-25
3	19	2026-02-24
4	19	2026-02-27
5	19	2026-03-02
6	19	2026-03-05
7	19	2026-03-08
8	19	2026-02-24
9	19	2026-02-24
10	19	2026-02-27
11	19	2026-03-02
12	19	2026-03-05
13	19	2026-03-08
14	19	2026-03-11
15	19	2026-03-14
16	19	2026-03-17
17	19	2026-03-20
18	19	2026-03-23
\.


--
-- Data for Name: seance_exo; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."seance_exo" ("id_seance_exo", "id_seance", "id_exercice", "daily_1rm") FROM stdin;
1	2	1	150
2	3	2	93
3	4	2	103.8
4	5	2	91.3
5	6	2	97.9
6	7	2	93.7
8	9	2	102.3
9	10	2	103.5
10	11	2	94.8
11	12	2	95.6
12	13	2	99
13	14	2	98.4
14	15	2	106.7
15	16	2	95.6
16	17	2	103.7
17	18	2	100.4
18	3	1	80
19	4	1	80
20	5	1	80
21	6	1	80
22	7	1	80
23	8	1	80
24	9	1	80
25	10	1	80
26	11	1	80
27	12	1	80
28	13	1	80
29	14	1	80
30	15	1	80
31	16	1	80
32	17	1	80
33	18	1	80
\.


--
-- Data for Name: serie; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."serie" ("id", "id_seance_exo", "charge_kg", "nombre_reps", "vitesse_fin_serie", "rpe_estime", "rpe_reel", "echauffement") FROM stdin;
1	1	150.00	12	0.200	8.0	8.0	f
2	2	80.00	5	0.310	9.5	9.5	f
3	2	80.00	5	0.560	7.5	7.5	f
4	2	80.00	5	0.700	6.5	6.5	f
5	3	80.00	5	0.310	9.5	9.5	f
6	3	80.00	5	0.380	9.5	9.5	f
7	3	80.00	5	0.500	7.5	7.5	f
8	4	80.00	5	0.400	9.0	9.0	f
9	4	80.00	5	0.380	9.0	9.0	f
10	4	80.00	5	0.720	6.0	6.0	f
11	5	80.00	5	0.590	7.5	7.5	f
12	5	80.00	5	0.480	8.0	8.0	f
13	5	80.00	5	0.670	6.0	6.0	f
14	6	80.00	5	0.480	8.5	8.5	f
15	6	80.00	5	0.490	8.5	8.5	f
16	2	80.00	5	0.600	6.5	6.5	f
17	2	80.00	5	0.520	8.0	8.0	f
18	2	80.00	5	0.380	9.5	9.5	f
19	8	80.00	5	0.700	6.0	6.0	f
20	8	80.00	5	0.700	6.0	6.0	f
21	8	80.00	5	0.660	6.0	6.0	f
22	9	80.00	5	0.510	8.0	8.0	f
23	9	80.00	5	0.300	9.5	9.5	f
24	9	80.00	5	0.540	7.5	7.5	f
25	10	80.00	5	0.650	6.0	6.0	f
26	10	80.00	5	0.430	8.5	8.5	f
27	10	80.00	5	0.540	8.0	8.0	f
28	11	80.00	5	0.740	6.0	6.0	f
29	11	80.00	5	0.390	9.0	9.0	f
30	11	80.00	5	0.470	8.5	8.5	f
31	12	80.00	5	0.640	6.5	6.5	f
32	12	80.00	5	0.660	6.5	6.5	f
33	12	80.00	5	0.660	6.0	6.0	f
34	13	80.00	5	0.590	7.0	7.0	f
35	13	80.00	5	0.680	6.5	6.5	f
36	13	80.00	5	0.570	7.5	7.5	f
37	14	80.00	5	0.750	6.0	6.0	f
38	14	80.00	5	0.600	7.0	7.0	f
39	14	80.00	5	0.600	7.0	7.0	f
40	15	80.00	5	0.350	9.5	9.5	f
41	15	80.00	5	0.310	9.5	9.5	f
42	15	80.00	5	0.420	8.5	8.5	f
43	16	80.00	5	0.450	9.0	9.0	f
44	16	80.00	5	0.390	9.5	9.5	f
45	16	80.00	5	0.380	9.5	9.5	f
46	17	80.00	5	0.630	6.5	6.5	f
47	17	80.00	5	0.440	9.0	9.0	f
48	17	80.00	5	0.730	6.0	6.0	f
49	1	70.00	5	0.440	7.0	7.0	f
50	1	70.00	5	0.510	6.0	6.0	f
51	1	70.00	5	0.210	9.0	9.0	f
52	18	70.00	5	0.440	7.0	7.0	f
53	18	70.00	5	0.320	8.0	8.0	f
54	18	70.00	5	0.520	6.0	6.0	f
55	19	70.00	5	0.520	6.0	6.0	f
56	19	70.00	5	0.310	8.0	8.0	f
57	19	70.00	5	0.330	8.0	8.0	f
58	20	70.00	5	0.340	8.0	8.0	f
59	20	70.00	5	0.540	6.0	6.0	f
60	20	70.00	5	0.520	6.0	6.0	f
61	21	70.00	5	0.410	7.0	7.0	f
62	21	70.00	5	0.220	9.0	9.0	f
63	21	70.00	5	0.350	8.0	8.0	f
64	22	70.00	5	0.450	7.0	7.0	f
65	22	70.00	5	0.330	8.0	8.0	f
66	22	70.00	5	0.250	9.0	9.0	f
67	23	70.00	5	0.220	9.0	9.0	f
68	23	70.00	5	0.200	9.0	9.0	f
69	23	70.00	5	0.310	8.0	8.0	f
70	24	70.00	5	0.210	9.0	9.0	f
71	24	70.00	5	0.410	7.0	7.0	f
72	24	70.00	5	0.540	6.0	6.0	f
73	25	70.00	5	0.440	7.0	7.0	f
74	25	70.00	5	0.410	7.0	7.0	f
75	25	70.00	5	0.430	7.0	7.0	f
76	26	70.00	5	0.530	6.0	6.0	f
77	26	70.00	5	0.220	9.0	9.0	f
78	26	70.00	5	0.410	7.0	7.0	f
79	27	70.00	5	0.530	6.0	6.0	f
80	27	70.00	5	0.300	8.0	8.0	f
81	27	70.00	5	0.340	8.0	8.0	f
82	28	70.00	5	0.330	8.0	8.0	f
83	28	70.00	5	0.440	7.0	7.0	f
84	28	70.00	5	0.340	8.0	8.0	f
85	29	70.00	5	0.300	8.0	8.0	f
86	29	70.00	5	0.220	9.0	9.0	f
87	29	70.00	5	0.340	8.0	8.0	f
88	30	70.00	5	0.440	7.0	7.0	f
89	30	70.00	5	0.200	9.0	9.0	f
90	30	70.00	5	0.330	8.0	8.0	f
91	31	70.00	5	0.410	7.0	7.0	f
92	31	70.00	5	0.230	9.0	9.0	f
93	31	70.00	5	0.310	8.0	8.0	f
94	32	70.00	5	0.320	8.0	8.0	f
95	32	70.00	5	0.240	9.0	9.0	f
96	32	70.00	5	0.420	7.0	7.0	f
97	33	70.00	5	0.310	8.0	8.0	f
98	33	70.00	5	0.320	8.0	8.0	f
99	33	70.00	5	0.250	9.0	9.0	f
\.


--
-- Data for Name: tweets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."tweets" ("id", "timestamp", "raw_content", "query", "is_processed") FROM stdin;
1	2026-03-24 10:54:48+00	Steven Gerrard heran Trent Alexander-Arnold diabaikan Thomas Tuchel https:// pialadunia.tvrinews.com/read/pd_b7qmd8 q1rc/gerrard-gagal-paham-tuchel-gak-panggil-alexander-arnold … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
2	2026-03-24 10:54:48+00	Przywieźcie puchar do polskiej ziemi! https:// youtu.be/xSIxGjAQLlE?si =ttHsiMjdJlt_bVl- … #polska #worldcup2026 #polalb #mundial #laczynaspilka @LaczyNasPilka #hymnnamundial @GrosickiKamil @lewy_official #pzpn @pzpn_pl	#WorldCup2026	1
3	2026-03-24 10:54:48+00	'But there has always been a footballer in Troy. I am so happy now that it is shining and showing how good he is' #rtesport @IrelandFootball #COYBIG #worldcup2026	#WorldCup2026	1
4	2026-03-24 10:54:48+00	80 hari menjelang @FIFAWorldCup 2026, seperti apa perkembangannya https:// pialadunia.tvrinews.com/read/pd_jaqh3e lyin/80-hari-menuju-piala-dunia-2026-kondisi-italia-hingga-sikap-fifa … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
5	2026-03-24 10:54:50+00	Scott mctominay with new Scotland away kit. #WorldCup2026	#WorldCup2026	1
6	2026-03-24 10:54:50+00	رسميا الكشف عن قميص #منتخب_البرتغال الأساسي #كأس_العالم_2026. #worldcup2026	#WorldCup2026	1
7	2026-03-24 10:54:50+00	With the expanded format, the dream is closer than ever for these countries.Which team do you want to see make their FIRST World Cup appearance in 2026 the most? Drop your answer below! #WorldCup2026 #NeverPlayed #FirstTimers #FIFAWorldCup	#WorldCup2026	1
8	2026-03-24 10:54:50+00	Sambil ngabubu..... Eh udah lewat, mohon maaf lahir batin TVRISportsters TVRISportsters bisa tebak skuat juara Piala Dunia dari negara mana dan tahun berapa ini? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
9	2026-03-24 10:54:50+00	Harambee Stars Head Coach Benni McCarthy on 8-0 loss in last friendly match against Senegal as focus now shifts to FIFA Series frendlies against Estonia and Grenada/Rwanda. #HarambeeStars #betshack #WorldCup2026 #sportsnews	#WorldCup2026	1
10	2026-03-24 10:54:52+00	From the streets of Lisbon to the stadiums in North America, a whole nation breathed as one today. Portugal isn’t just a team; it’s a family. Today, the Seleção das Quinas showed the world that heart beats talent every single time. . #Seleção #PortugalWin #WorldCup2026 #ForçaPort	#WorldCup2026	1
11	2026-03-24 10:54:52+00	@PUMA just dropped its 2026 World Cup kits 11 nations. One global statement. https:// onefootball.com/en/news/puma-u nveil-their-world-cup-kits-heres-what-portugal-will-wear-42587720 … #Puma #WorldCup2026 #Football #FIFAWorldCup	#WorldCup2026	1
12	2026-03-24 10:54:52+00	FIFA a fost reclamată la Comisia Europeană pentru prețurile biletelor la Cupa Mondială 2026 și pentru lipsa de transparență la vânzare. #FIFA #WorldCup2026 #ComisiaEuropeana #Fotbal #stiri #findnews https:// findnews.ro/fifa-reclamata -la-comisia-europeana-din-cauza-biletelor-la-mondial-2000660 …	#WorldCup2026	1
13	2026-03-24 10:54:55+00	Mexico Ready To Shine As 2026 World Cup Counts Down... FIND OUT MORE: https:// envio.international/mexico-ready-t o-shine-as-2026-world-cup-counts-down/ … #WorldCup2026 #Mexico #logistics #Envio	#WorldCup2026	1
14	2026-03-24 10:54:55+00	For Sale: http:// FRA.BET - http:// ITA.BET http:// ARG.BET - http:// GER.BET Three letters. FIFA’s official country code. Positioned for the 2026 global football cycle. Rare inventory. Strategic asset. #WorldCup2026	#WorldCup2026	1
15	2026-03-24 10:54:55+00	Who will score the most goals at the 2026 FIFA World Cup?	#WorldCup2026	1
16	2026-03-24 10:54:55+00	I just decided that Uruguay is my pick 2 win World Cup @talkSPORT cos they got Valverde. The best plyr in the World #WorldCup2026 plus they got Cape Verde and Saudi Arabia in their group & they will breeze to qualification to next stage frm their group along with Spain	#WorldCup2026	1
17	2026-03-24 10:54:55+00	New Era New Kits France unveil their 2026 World Cup kits Inspired by strong ties with the USA Style meets legacy on the world stage #France #WorldCup2026 #NikeFootball #NewKit #BJ88	#WorldCup2026	1
18	2026-03-24 10:54:57+00	Abro hilo sobre por qué el repechaje en México contra Surinam será el fin del "milagro" de La Verde. #WorldCup2026 #Bolivia #Suriname #AnálisisDeÉlite #repechaje #mundial	#WorldCup2026	1
19	2026-03-24 10:54:57+00	I’m outside New York!!!! #fanaticfest2026 #fypシ゚ #worldcup2026 #celebritylookalike	#WorldCup2026	1
20	2026-03-24 10:54:57+00	Tak bisa dipungkiri kondisi mental bisa sangat berpengaruh pada performa. Pelatih Italia, Gennaro Gattuso, dibantu kapten tim harus bisa membantu para pemain untuk mengelola kepercayaan diri dan ketenangan. #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
21	2026-03-24 10:54:59+00	Fiston Mayele has joined the DR Congo camp in Mexico ahead of the 2026 World Cup playoffs. The striker links up with the squad as preparations intensify for the crucial fixtures. #WorldCup2026 #AfricanFootball #DRCongo	#WorldCup2026	1
22	2026-03-24 10:54:59+00	Goal Tercepat? #WorldCup2026 #PialaDunia2026 #SepakbolaDunia #HighlightsWC2026 #PialaDuniaUpdate #Bola88 #Chundai #GolSpektakuler	#WorldCup2026	1
23	2026-03-24 10:54:59+00	#letsgo #worldcup2026 #soccer #messi #Messi #USA #Argentina #tuesdayMotivation #MLS	#WorldCup2026	1
24	2026-03-24 10:54:59+00	Can you imagine training like a madman for 25 years and being called lazy just because you don't post anything on social media? x.com/magicalpep/sta…	#WorldCup2026	1
25	2026-03-24 10:54:59+00	We calibrated 30 years of World Cup data against prediction markets. Here's what we found: - Croatia: +536% undervalued - Morocco: +137% undervalued - Brazil: -78% overpriced Markets aren't as smart as you think @Zerve_AI #ZerveHack #WorldCup2026	#WorldCup2026	1
26	2026-03-24 10:54:59+00	El Mundial 2026 todavía no empezó… pero ya se está jugando. Hinchas Estadios Emoción real Todo en un solo lugar. Vivilo antes que nadie https://multiideasweb.com/mundial2026/simulador-mundial-2026.php… #Mundial2026 #WorldCup2026 #Fútbol #Simulador #Argentina #Soccer	#WorldCup2026	1
27	2026-03-24 10:54:59+00	#WorldCup2026	#WorldCup2026	1
28	2026-03-24 10:54:59+00	¡Por fin! Tras años de crímenes contra la humanidad y presión de la opinión pública, la FIFA se decidió a sancionar a los israelíes… Aunque no celebren todavía, que aún no les hemos contado en qué consisten esas ‘sanciones’	#WorldCup2026	1
29	2026-03-24 10:55:01+00	El Mundial 2026 todavía no empezó… pero ya se está jugando. Hinchas Estadios Emoción real Todo en un solo lugar. Vivilo antes que nadie https:// multiideasweb.com/mundial2026/si mulador-mundial-2026.php … #Mundial2026 #WorldCup2026 #Fútbol #Simulador #Argentina #Soccer	#WorldCup2026	1
30	2026-03-24 10:55:01+00	Get the your team customized Soccer Jersey of world Cup Soccer. “Three Nations. One Dream. Customize Your World Cup Pride with Melash Sports.” #MelashSports #WorldCup2026 #USA #Mexico #Canada #SoccerUnity #CustomJersey #NorthAmericaFootball #GameOn #FootballPride	#WorldCup2026	1
31	2026-03-24 10:55:03+00	Listos para el jueves, ya me siento Jamaiquino #WorldCup2026	#WorldCup2026	1
32	2026-03-24 10:55:03+00	@UNHumanRights @bchrc @bchrc @hrw Where are these ? #WorldCup2026 @MorePerfectUS @uber and @lyft are still exploiting harassing abusing humanities The Gig Trap	#WorldCup2026	1
33	2026-03-24 10:55:04+00	FIFA World Cup 2026 Playoffs: Final Battle for Global Glory Begins @FIFA @UEFA @CONMEBOL @AFC @CAF #WorldCup2026 #FIFAWorldCup #FootballPlayoffs #SoccerNews #WorldCupQualifiers #FootballFans #TrendingSports	#WorldCup2026	1
34	2026-03-24 10:55:04+00	Quick WC2026 seat check before you buy: 1. Go to http:// seatsun.com 2. Pick your stadium 3. Enter game date + kickoff time 4. See exactly which sections are shaded Takes 60 seconds. Potentially saves you 90 minutes of misery. Free, no signup. #WC2026 #WorldCup2026	#WorldCup2026	1
35	2026-03-24 10:55:06+00	WC2026 is 79 days away. If you have tickets for an afternoon game in Miami, Monterrey, or Kansas City and haven't checked your section's sun exposure — do it now. http:// seatsun.com → all 16 venues, section-level shade by kickoff time #WorldCup2026 #WC2026	#WorldCup2026	1
36	2026-03-24 10:55:06+00	Italy could miss another World Cup. Let that sink in. #WCQ #WorldCup2026 #Azzurri	#WorldCup2026	1
37	2026-03-24 10:55:06+00	FIFA World Cup 2026 Playoffs: Final Qualification Matches Explained https:// theelitereview.com/fifa-world-cup -2026-playoffs/ … @FIFAcom @UEFAcom @CONMEBOL @AFC @CAF_Online #WorldCup2026 #FIFAWorldCup #FootballPlayoffs #SoccerNews #WorldCupQualifiers #FootballFans #TrendingSports	#WorldCup2026	1
38	2026-03-24 10:55:06+00	イタリア代表vs北アイルランド代表の試合が近づいてきた #worldcup2026	#WorldCup2026	1
39	2026-03-24 10:55:06+00	The stage is set. The colors are louder. @Nike unveils all 2026 World Cup™ kits. https:// sports.yahoo.com/articles/nike- kits-2026-world-cup-105900472.html … #WorldCup2026 #NikeFootball #Nike #FIFAWorldCup	#WorldCup2026	1
40	2026-03-24 10:55:06+00	Reggae Boyz on the brink. Jamaica’s World Cup dream faces a fearless New Caledonia in a huge inter-confederation playoff. Leon Bailey could be the difference, but the pressure is all on Jamaica. Full story https:// worldinsport.com/reggae-boyz-on -the-brink/ … #ReggaeBoyz #Jamaica #WorldCup2026	#WorldCup2026	1
41	2026-03-24 10:55:08+00	Is the 2026 World Cup America’s game-changer? Get ready for a cultural revolution in soccer! Don’t miss out! #WorldCup2026 #SoccerInUSA https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	1
42	2026-03-24 10:55:08+00	Get ready for a soccer revolution! The 2026 World Cup will redefine America's game. Don't miss out! #WorldCup2026 #SoccerInUSA https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	1
43	2026-03-24 10:55:08+00	Is the 2026 World Cup America's grand awakening for soccer? Even Tom Brady thinks so! Don't miss out! #WorldCup2026 #SoccerInUSA https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	1
44	2026-03-24 10:55:08+00	"Get ready, America! The 2026 World Cup will elevate soccer to new heights, uniting cultures like never before. #WorldCup2026 #CulturalUnity" https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	1
45	2026-03-24 10:55:12+00	El mundial de Brasil 2014 fue una oda al fútbol, estadios míticos, el fin de un ciclo para España, resultados históricos y la 4ta estrella para Alemania . A meses de la #WorldCup2026, recordamos la última gran cita en Sudamérica. [18 XI's y otros referentes/promesas]	#WorldCup2026	1
46	2026-03-24 10:55:12+00	Only Ghana and Nigeria that’s even hyping the World Cup on Twitter, the rest just silent. Unfortunately my dear 9ja no qualify, if not this hype for too mad. #worldcup2026	#WorldCup2026	1
47	2026-03-24 10:55:12+00	Te invitamos al 4º ciclo de conferencias sobre diplomacia deportiva en Eurasia. Analizaremos la participación de países de la Gran Eurasia rumbo a la Copa Mundial 2026 y su impacto político, económico y social. ¡No te lo pierdas! #WorldCup2026 #CopaMundial #Mundial2026 #futbol	#WorldCup2026	1
48	2026-03-24 10:55:12+00	It’s time to #boycottFIFA and cancel #worldcup2026 #ClaudiaShenibaum . FIFA is a part of Trump‘s “peace“ coalition. Stop being subservient to your oppressor.	#WorldCup2026	1
49	2026-03-24 10:55:12+00	The US government collected over $1 billion in immigration fees then refused to process the applications. No denials. No refunds. Just silence. This is the largest fee fraud in the history of the American immigration system. Here's what's happening.	#WorldCup2026	1
50	2026-03-24 10:55:12+00	Estadio BBVA in Monterrey averages 100°F+ in June. It's one of 10 open-air WC2026 venues. Know which sections are shaded before you buy → http:// seatsun.com #WorldCup2026 #Monterrey #WC2026	#WorldCup2026	1
51	2026-03-24 10:55:14+00	Takéto niečo vie len Stanislav Lobotka. Ale treba pripomenúť, že to bol dlhý večer a toto bolo počas jeho už Xtého rozhovoru. Preto ho chápem, ale o to vtipnejšie to celé bolo. Stano je super #repreSR #FutbalistaRoka #WorldCup2026 #SSCNapoli	#WorldCup2026	1
52	2026-03-24 10:55:14+00	Première sélection : Samir El Mourabet entre émotion et énorme défi https:// csport.ma/premiers-mots- samir-el-mourabet-maroc/ … #Maroc #Football #WorldCup2026	#WorldCup2026	1
53	2026-03-24 10:55:14+00	on 31st March 6 of these teams will Qualify for #WorldCup2026 1 : Wales, Bosnia, Italy, N.Ireland 2 : Ukraine, Sweden, Poland, Albania 3 : Slovakia, Kosovo, Turkey, Romania 4 : Czech, Ireland, Denmark, Macedonia 5 : Jamaica, New Caledonia, DR Congo 6 : Bolivia, Suriname, Iraq	#WorldCup2026	1
54	2026-03-24 10:55:14+00	Bugün 23 Mart. Wilson firması daha 3 gün sonraki Romanya ile playoff maçı oynanmadan piyasaya sürdüğü Dünya kupası toplarında Türk bayrağına da yer vermiş. Turu geçeceğimize garatinti gözüyle bakıyorlar demek ki (Sam's Club, Atalanta, ABD) #dünyakupası #worldcup2026 #worldcup	#WorldCup2026	1
55	2026-03-24 10:55:17+00	No se olviden de comprar la bandera de Uruguay #WorldCup2026	#WorldCup2026	1
56	2026-03-24 10:55:17+00	Zidane Sets His Sights on France – Oui, It’s Official! #Zidane #FrenchFootball #WorldCup2026	#WorldCup2026	1
57	2026-03-24 10:55:17+00	Austria vs Ghana loading… International friendly this Friday at 17:00! Black Stars gearing up for #WorldCup2026 Who’s winning this one? #BlackStars #GhanaFootball	#WorldCup2026	1
58	2026-03-24 10:55:17+00	Houston's Asia Town and Chinatown delivers an authentic experience when it comes to food, people, and culture. If your coming to Houston for World Cup 2026, take a trip west of downtown and check this part of the city out! #HoustonTX #Houston2026 #WorldCup2026 #SoccerMatters	#WorldCup2026	1
59	2026-03-24 10:55:19+00	World Cup Playoffs: The Final Battle for Europe’s Last Spots! #WorldCup2026 #WCQ #UEFA #Playoffs #RoadTo2026	#WorldCup2026	1
60	2026-03-24 10:55:19+00	Italy. 4 time World Cup winners. They are 90 minutes away from missing the World Cup on home soil. Italy vs Northern Ireland. March 26. Single leg. No second chances. The most dangerous night in Italian football history. #WorldCup2026 #Azzurri	#WorldCup2026	1
61	2026-03-24 10:55:19+00	It’s the summer we’re all waiting for and in 80 days time we’re finally getting the greatest football competition in the world. The #WorldCup2026 is on the way and millions of eyes will be glued on the Mexico/South Africa game. For the love of the game @FIFAWorldCup	#WorldCup2026	1
62	2026-03-24 10:55:19+00	Mexico City's government has created an #AI to help tourists navigate easily the city during #WorldCup2026	#WorldCup2026	1
63	2026-03-24 10:55:19+00	ASIA x H-TOWN Houston’s Asia Town and Chinatown delivers an authentic experience when it comes to food, people, culture. If you’re coming to Houston for World Cup 2026, take a trip out West and check out this part of the city. #HoustonTX #Houston2026 #WorldCup2026	#WorldCup2026	1
64	2026-03-24 10:55:21+00	Llegan Cartas Legendarias a Panini ADRENALYN XL World Cup 2026, Aquí los Detalles: https:// youtu.be/9xLlxEKsMWM https:// efootballnews.com.mx/2026/03/llegan -cartas-legendarias-panini.html … #adrenalyn #adrenalyn2026 #worldcup2026 #panini #videojuegos #efootballnewsmx	#WorldCup2026	1
65	2026-03-24 10:55:23+00	Italy. Wales. Republic of Ireland. Poland. Ukraine. All of them could MISS the World Cup in 3 days time. Single-leg knockouts. No second chances. One bad night and you’re watching from your sofa. March 26 is going to be absolutely BRUTAL. #WorldCup2026	#WorldCup2026	1
66	2026-03-24 10:55:23+00	All smiles and hugs in the France National Team #France #WorldCup2026	#WorldCup2026	1
67	2026-03-24 10:55:23+00	¿Hasta cuándo las playas de #Acapulco estarán "conce$ionada$" por LACROSOS en complicidad con autoridades de todos los niveles? ¡ @SEMARNAT_mx @PROFEPA_Mx @ZOFEMATAcapulco @FonaturMX @PromotoraPlayas son una FARSA! Los estamos esperando @FIFAWorldCup #WorldCup2026 @VisitMex .	#WorldCup2026	1
68	2026-03-24 10:55:23+00	Estadio BBVA in Monterrey regularly hits 100°F+ in June. It's one of 3 WC2026 venues in Mexico. Open air. No AC. If you're going, you need to know which sections have shade before you buy. http:// seatsun.com → Monterrey shade map, free #WorldCup2026 #WC2026 #Monterrey	#WorldCup2026	1
69	2026-03-24 10:55:26+00	FIFA released the first official song for the 2026 World Cup on Monday, ahead of the tournament which will be hosted by the United States, Canada and Mexico. The track, titled “Lighter,” features Jelly Roll and Carin Leon and is produced by Cirkut. #WorldCup2026 #FIFA #Lighter	#WorldCup2026	1
70	2026-03-24 10:55:26+00	Have you heard the song made for France National team 2026 ? “Dembele Cherki “ E loud …….. #France #worldcup2026	#WorldCup2026	1
71	2026-03-24 10:55:26+00	Before the midterms there's something that will test for real that "involvement" above all things: #WorldCup2026	#WorldCup2026	1
72	2026-03-24 10:55:26+00	#WorldCup2026 #Futbol #SoccerWordCup #AlienCardsHQ #ToppsChrome #Football	#WorldCup2026	1
73	2026-03-24 10:55:26+00	İngiliz yıldızlar Dünya Kupası 2026’da İngiliz tarzı bir kır evi otelinde kalıyorlar #England #WorldCup2026 Orkun İcardi Göztepe Neymar Montella Cherki	#WorldCup2026	1
74	2026-03-24 10:55:28+00	Estadio BBVA in Monterrey is hosting WC2026 matches in June. Average temperature: 100°F+ It has a partial canopy. Upper sections = shade. Lower bowl = full sun. Check your section before you buy: http:// seatsun.com/stadiums/bbva #WorldCup2026 #Monterrey #WC2026	#WorldCup2026	1
75	2026-03-24 10:55:28+00	80 DAYS START OF THE WORLD CUP 2026 #worldcup2026	#WorldCup2026	1
76	2026-03-24 10:55:28+00	90 DAYS START OF THE WORLD CUP 2026 #worldcup2026 x.com/10msb/status/2…	#WorldCup2026	1
77	2026-03-24 10:55:28+00	England calls up Ben White, passes over Trent Alexander-Arnold #WorldCup #WorldCup2026	#WorldCup2026	1
78	2026-03-24 10:55:28+00	Dünya Kupası; 11 Haziran/19 Temmuz 2026 USA,Kanada,Meksika İzlerim diye çok heveslenmeyin Türkiye saatiyle maç başlama saatleri. 22.00 23.00 01.00 02.00 04.00 07.00 #worldcup2026	#WorldCup2026	1
79	2026-03-24 10:55:30+00	ATENCION, Alex, Desafortunadamente.. Murio. #Espn #futbolpicante #worldcup2026 #Canal12 #Snapdragonstadium #UnitedstatesFootballClub #Ligamx	#WorldCup2026	1
80	2026-03-24 10:55:30+00	Can I plead with all my friends in #TheHobby if anyone gets these and wishes to get rid of/flip/gift/trade any Scotland players they find (particularly Scott McTominay), I am here @CardPurchaser @Get_BIG_Cards #WorldCup2026 #Scotland #panini	#WorldCup2026	1
81	2026-03-24 10:55:30+00	FIRST LOOK: @PaniniAmerica Prizm @FIFAWorldCup 2026™ The world’s biggest stage meets the hobby’s biggest brand as Prizm World Cup returns bigger than ever featuring all 48 qualified nations in one global chase! New parallels incoming: Aguila /70, Maple Leaf /86, Old	#WorldCup2026	1
82	2026-03-24 10:55:30+00	Morocco, I’m here What if Morocco /Puma dropped that kind of shoot? كون دار هذا النوع ديال الفوتوشوت غادي يكون تسويق مختلف #morocco #worldcup2026 #jersey #photoshoot #المغرب	#WorldCup2026	1
83	2026-03-24 10:55:32+00	El #Mundial2026 se va transmitir por YouTube #fifaworldcup2026 #worldcup2026 #youtube #copadelmundo	#WorldCup2026	1
84	2026-03-24 10:55:32+00	Yeni Türkiye formalarımız gayet güzel #WorldCup2026	#WorldCup2026	1
85	2026-03-24 10:55:32+00	Here's what's making headlines in the world of sports: Read more: http:// channelonnewsonline.com Powered by Channel One Research Desk #ChannelOneSports #BlackStars #WorldCup2026 #GhanaFootball #ICCT20 #Cricket #SportsNews #Newswrap	#WorldCup2026	1
86	2026-03-24 10:55:37+00	Italia 90.... I was only 8 and the first match i remember is the Romania game.... " A nation holds its breath " #WorldCup2026	#WorldCup2026	1
87	2026-03-24 10:55:37+00	Italy face a WC playoff semifinal March 26 - if they qualify, UEFA Playoff B winner meets Tunisia at Monterrey Stadium (BBVA), June 14. June temps 32-36°C - book a hotel with a pool. http:// monterreystadium.com #WC2026Europe #WorldCup2026 #Monterrey	#WorldCup2026	1
88	2026-03-24 10:55:37+00	Group J decider: Jordan vs Algeria at San Francisco Stadium (Levi's), June 22 at 8pm PT. Algeria's squad is largely European-based - strong technical side. Bay Area evenings drop to 15-18°C; bring a layer. http:// sanfranciscobayareastadium.com #WC2026Europe #WorldCup2026 #BayArea	#WorldCup2026	1
89	2026-03-24 10:55:37+00	Mpanse Anvan #WorldCup2026 lan ! Leta AK @fhfhaiti - Fédération Haïtienne De Football lan dwe òganize yon vwayaj AK jwè seleksyon pou vini Okap ! Òganize yo vizite Citadelle LaFerrière AK jwè yo ! Anpil nan jwè yo Bezwen enèji @Ayibo_Sport sa ! #Haiti #WorldCup2026	#WorldCup2026	1
90	2026-03-24 10:55:39+00	@RIFIBAND https:// youtu.be/ovGkS5LM73w?si =x16c97xHbIOqJxk3 … #england #anthem #worldcup2026 #mentalhealth #Standtogether	#WorldCup2026	1
91	2026-03-24 10:55:39+00	A 48-team World Cup across 3 countries means fans will need more than just tickets. @KarnFromGoldon joined SDH AM to talk about Fan Path and its effort to bring travel planning, housing, & fan communities into one place ahead of #WorldCup2026.	#WorldCup2026	1
123	2026-03-24 10:56:03+00	The 2026 FIFA World Cup is THIS SUMMER and the whole football world is buzzing International squads are being named, friendlies are lined up, and the stakes couldn't be higher. It's almost time #WorldCup2026 #Football	#WorldCup2026	1
92	2026-03-24 10:55:39+00	@fifamedia #WorldCup2026 dear turist, as a person that deeply love Jalisco, please, don't come. We have security and infraestructure major issues and The Cherry on the pay is this water supply that @GobiernoJalisco has been incompetent to supply clean it enough for human use.	#WorldCup2026	1
93	2026-03-24 10:55:39+00	Tengo un anuncio importante que compartirles. Aunque desde hace muchos años el @siapagdl vive una crisis institucional y de presupuesto, asumo mi responsabilidad histórica en el rescate del organismo operador del agua, dedicando todos los recursos posibles para su recuperación y	#WorldCup2026	1
94	2026-03-24 10:55:39+00	O sea, no esta bien en ninguna colonia!! Pero pues ahí viene el #WorldCup2026 y la ciudad se ve increíble y su seguridad de 1er mundo... Spoiler, is noooot! @FIFAWorldCup	#WorldCup2026	1
95	2026-03-24 10:55:41+00	#WorldCup2026 Anulad el viaje! Cancel your travel plans!	#WorldCup2026	1
96	2026-03-24 10:55:41+00	And that's how the champions celebrated tonight. India India #WorldCup2026 #T20WorldCup2026final	#WorldCup2026	1
97	2026-03-24 10:55:41+00	@paulpogba Il vous faut garder espoir, faire preuve de patience et vous battre pour atteindre la Coupe du Monde et la Ligue des Nations de l'UEFA. Nous sommes avec vous et nous vous attendons. #worldcup2026	#WorldCup2026	1
98	2026-03-24 10:55:43+00	Las nuevas equipaciones de Croacia para la Copa del Mundo de 2026. A la primera le favorece la franja blanca de en medio, mientras que a la segunda, en mi modesta opinión, no le favorece tanto. ¿Vosotros qué opináis, camaradas? #HNS #Vatreni #WorldCup2026	#WorldCup2026	1
99	2026-03-24 10:55:43+00	Adidas.. The BEST SaudiNT #WorldCup2026	#WorldCup2026	1
100	2026-03-24 10:55:43+00	Over the last few days, 18 national teams have already unveiled their uniforms for the 2026 World Cup, and the rivalry for the best kit is already on ! What's your #1 so far? https:// flashscore.com/news/soccer-wo rld-cup-which-teams-have-already-released-their-kits-for-the-2026-world-cup/fakLHRrB/ … #WorldCup2026	#WorldCup2026	1
101	2026-03-24 10:55:45+00	¡ÚLTIMA HORA! Zinedine Zidane ha dicho SÍ a convertirse en el nuevo seleccionador de Francia! Didier Deschamps afirma que quiere retirarse después del Mundial de 2026. #MarketDeportivo #WorldCup2026	#WorldCup2026	1
102	2026-03-24 10:55:45+00	¡FALTAN 100 DÍAS PARA EL INICIO DE LA COPA MUNDIAL 2026! Los 5 favoritos a ganarla según las casas de apuesta España 5.50/1 Inglaterra 6.50/1 Francia 9/1 Argentina 9/1 Brasil 9/1 #MarketDeportivo #WorldCup2026	#WorldCup2026	1
103	2026-03-24 10:55:45+00	The World Cup is coming and so is the demand Discover Airbnb’s latest incentive announcement for local residents! Read more at the link below https:// bergenrealestate.com/world-cup-2026 -airbnb-offers-750-usd-to-new-bergen-county-hosts/ … #BergenCounty #WorldCup2026 #NJRealEstate #AirbnbOpportunity #MetLifeStadium	#WorldCup2026	1
104	2026-03-24 10:55:47+00	Discours franc de notre légendaire « Waddle » concernant les playoffs « On se bat juste pour une chose, la KANAKY ! » « C’est sur un match, le petit peut toujours gagner comme en Coupe de France. » #WorldCup2026 #Kanaky #NouvelleCalédonie	#WorldCup2026	1
105	2026-03-24 10:55:47+00	#BREAKING ICE AGENTS NOW ON THE GROUND AT AIRPORTS! While Democrats keep TSA workers unpaid and lines stretch for hours, @POTUS and Tom Homan just deployed ICE officers to keep airports moving. This is what real leadership looks like: stepping in to help American workers	#WorldCup2026	1
106	2026-03-24 10:55:53+00	Who’s the player- World Cup Edition Answer to last Q Ernst Happel . . . . Daily quiz, every evening.. Thanks for your interactions #footballnerd #worldcup #worldcup2026	#WorldCup2026	1
107	2026-03-24 10:55:53+00	Get Ahead of the Game! #WorldCup2026 Travel #CarHire #Flights #UKAirportParking https:// bit.ly/3VZWxUK Supporting @SSAFA & @Blesma #travel #Canada #Mexico #USA #football #soccer #holidays #forces #expat #forcescarhire #MHHSBD	#WorldCup2026	1
108	2026-03-24 10:55:53+00	Umpan dengan 200 IQ! Bukan cuma skill, tapi visi permainan yang bikin lawan benar-benar terkecoh. #Dewacash #PialaDunia2026 #WorldCup2026 #FIFAWorldCup2026 #WC2026 #RoadTo2026 #GarudaMendunia	#WorldCup2026	1
109	2026-03-24 10:55:55+00	This should be fun during #WorldCup2026 @FIFAWorldCup	#WorldCup2026	1
110	2026-03-24 10:55:55+00	If you are from another country I urge you not to come to America. It's not safe for you here. Psycho Trump and his private army of ICE soldiers have taken over airports. They can decide to arrest you without cause and keep you in a cage for months. America is NOT SAFE!	#WorldCup2026	1
111	2026-03-24 10:55:55+00	| مباريات المنتخبات العربية في مارس استعداداً لكأس العالم 2026 | Arab national teams' matches in March in preparation for the 2026 World Cup #WorldCup2026	#WorldCup2026	1
112	2026-03-24 10:55:55+00	You think #tourism in America is already bad? It's about to get a lot worse. #WorldCup2026 #ICE #TerrorizingVisitors #SFO #MAGA	#WorldCup2026	1
113	2026-03-24 10:55:58+00	"International window vibes: With injuries piling up (Saliba, Gabriel out), which club gets hit hardest right now? A) Arsenal B) Chelsea C) Man City D) Other (reply!) drop your take! #Football #WorldCup2026"	#WorldCup2026	1
114	2026-03-24 10:55:58+00	USMNT upcoming schedule - Friendly vs Uruguay to close out 2025; World Cup next summer - NBC Sports Read more → https:// newzly.ai/article/127128 -usmnt-upcoming-schedule-friendly … #USMNT #WorldCup2026 #UruguayFriendly	#WorldCup2026	1
115	2026-03-24 10:55:58+00	Congress, Republicans and Democrats together, presented a deal to Trump to end the airport nightmares. Trump rejected it. He's demanding the SAVE Act be passed as a condition. He's also sending ICE to airports, though it's unclear what exactly they'd be doing. America. 2026.	#WorldCup2026	1
116	2026-03-24 10:55:58+00	قائمة منتخب أوروغواي المُستدعاة للتوقف الدولي لمواجهة إنجلترا والجزائر. #news #كأس_العالم_2026 #WorldCup2026	#WorldCup2026	1
117	2026-03-24 10:56:01+00	Cancel #WorldCup2026	#WorldCup2026	1
118	2026-03-24 10:56:01+00	Slovenskí futbalisti pred tréningom s víťazmi ME 1976, ktorí im zaželali veľa šťastia v baráži o MS 2026 #repreSR #WorldCup2026	#WorldCup2026	1
119	2026-03-24 10:56:01+00	France have had a lot of bangers through the years. This one is no different . #France #WorldCup2026	#WorldCup2026	1
120	2026-03-24 10:56:01+00	YouTube makes #WorldCup2026 deal with #FIFA that lets broadcasters show parts of games live. #FYI #football #media #voetbal	#WorldCup2026	1
121	2026-03-24 10:56:01+00	#Macedonia's final and open training session in Skopje ahead of tomorrow's departure for Copenhagen. No sign of Ezgjan Alioski, but a dozen kids came to meet their idols and great vibes all around! #WorldCup2026	#WorldCup2026	1
122	2026-03-24 10:56:03+00	Most football agents cover a handful of leagues. Baller covers 299. 4,685 teams. 40,000+ injury records. Form, fixtures, vulnerability flags and predicted XIs. Built for betting agents, fantasy tools, traders and analysts. https:// ballerintel.com #WorldCup2026 #AIAgents	#WorldCup2026	1
124	2026-03-24 10:56:03+00	Phil Foden terancam di Timnas Inggris #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira https:// pialadunia.tvrinews.com/read/pd_cmnzz8 hzcs/posisi-phil-foden-terancam-oleh-max-dowman …	#WorldCup2026	1
125	2026-03-24 10:56:03+00	Gol Andres Iniesta di @FIFAWorldCup https:// pialadunia.tvrinews.com/read/pd_hcqjbo czn2/final-afsel-2010-gol-iniesta-markahi-kejayaan-eropa … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
126	2026-03-24 10:56:05+00	Titel @FIFAWorldCup 2010, puncak kejayaan Timnas Spanyol #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira https:// pialadunia.tvrinews.com/read/pd_gtgyld gjqm/gelar-piala-dunia-2010-puncak-era-keemasan-sepak-bola-spanyol …	#WorldCup2026	1
127	2026-03-24 10:56:07+00	Thomas Tuchel tak sengaja bocorkan skuat inti Timnas Inggris https:// pialadunia.tvrinews.com/read/pd_u4eveu rcfz/thomas-tuchel-diduga-tak-sengaja-bocorkan-pemain-inti-inggris … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
128	2026-03-24 10:56:07+00	COPA DO MUNDO - Hasbro lança MONOPOLY Panini Prizm: FIFA World Cup 2026 Edition com cartas colecionáveis da Copa do Mundo #worldcup #worldcup2026 #copadomundo #panini	#WorldCup2026	1
129	2026-03-24 10:56:07+00	Spain opens its World Cup in Atlanta Cape Verde gets the spotlight, Mercedes-Benz gets the stage, and this one could be trickier than people think. #WorldCup2026 #Spain #CapeVerde	#WorldCup2026	1
130	2026-03-24 10:56:07+00	Fernando Hierro não vestiu a camisa da Espanha em 2010, mas foi fundamental para a mudança de mentalidade dos jogadores espanhóis que havia perdido na estreia da Copa e sofreram com as críticas externas. #fifaworldcup #worldcup2026 #worldcup2026	#WorldCup2026	1
131	2026-03-24 10:56:09+00	Kostum kuning Brasil bikin ngeri https:// pialadunia.tvrinews.com/read/pd_lzdz5y xf1j/kostum-kuning-anyar-brasil-mau-senang-sekaligus-bikin-ngeri … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
132	2026-03-24 10:56:09+00	https:// instagram.com/reel/DWOh8IfCF B7/ … Special guest revealed！Keung To from HK boyband MIRROR is here to celebrate the World Cup 2026 with us ！ To celebrate this, Keung To x 2026 World Cup limited edition products will be launched. #姜濤 #keungto #worldcup2026 #football	#WorldCup2026	1
133	2026-03-24 10:56:09+00	82/365 80 days to the World Cup #Worldcup2026 #FIFAworldcup Psalms 89:46	#WorldCup2026	1
134	2026-03-24 10:56:09+00	#Paraguay​ #Albirroja​ #WorldCup2026​ #FIFA2026​ #PumaFootball​ #PumaKits​ #FootballShirt​ #SoccerJersey​ #KitCollector​ #KitCulture​ #FootballCulture​ #MatchDayVibes​ #HomeKit​	#WorldCup2026	1
135	2026-03-24 10:56:09+00	France 2026 kits just landed The classic blue kit gets a copper twist inspired by the Statue of Liberty, and the mint away kit brings a fresh World Cup vibe for North America! Available 3/25 at all Pelé Soccer locations! #Worldcup2026 #france #francejersey	#WorldCup2026	1
136	2026-03-24 10:56:11+00	The legendary Asamoah Gyan is pushing the next generation to eclipse his historic tally of 6 World Cup goals! Who is most likely to catch Baby Jet? #AsamoahGyan #BlackStars #WorldCup2026 #GhanaFootball #SportyBetGhana	#WorldCup2026	1
137	2026-03-24 10:56:11+00	http:// soccertease.beehiiv.com #WorldCup2026 #Dallas	#WorldCup2026	1
138	2026-03-24 10:56:11+00	The Mid-Island is by no means in the FIFA World Cup spotlight, but tourism reps are working to lure people to the region. #nanaimo #worldcup2026 #tourism	#WorldCup2026	1
139	2026-03-24 10:56:11+00	All football players should be endorsing this. #FIFA #WorldCup2026 Also, #Israel should be banned from all international sports competitions.	#WorldCup2026	1
140	2026-03-24 10:56:12+00	Football legend Gary Lineker endorsed a call demanding that Israel be suspended from international football until it ends its grave violations of international law, particularly its apartheid rule, and the crime of genocide in Gaza.	#WorldCup2026	1
141	2026-03-24 10:56:14+00	Wait, who put this here? Just a custom jersey for a US team! Soft, skin-friendly, and no-fade patterns. With the World Cup around the corner, get that pro look straight from our factory in China. #SoccerJersey #CustomJersey #WorldCup2026 #FootballJersey	#WorldCup2026	1
142	2026-03-24 10:56:14+00	The WC2026 Final is at MetLife Stadium on July 19. Open-air bowl. No roof. New Jersey summer sun. If you're buying tickets, check which sections are shaded before you commit. http:// seatsun.com — free, all 16 venues, section-level shade by kickoff time #WorldCup2026	#WorldCup2026	1
143	2026-03-24 10:56:14+00	Denmark in crisis at the back without Schmeichel & Christensen, but Parken Stadium magic gives them the edge! North Macedonia threaten on counters with Elmas, yet the Danes should grind out a nervy win to reach the playoff final! [#Denmark - #NorthMacedonia, 3-0] #WorldCup2026	#WorldCup2026	1
144	2026-03-24 10:56:16+00	Venues across Moray will be able to stay open later during the World Cup to show live matches. https:// thehighlandtimes.com/late-opening-h ours-approved-in-moray-for-world-cup-matches/ … #Moray #WorldCup2026 #Hospitality #Licensing #Football #Scotland #Nightlife #LocalBusiness #Community #TheHighlandTimes	#WorldCup2026	1
145	2026-03-24 10:56:16+00	تذكير بالملحق العالمي المؤهل لكأس العالم هذا الصيف و الذي سيكون هذا الشهر. #كأس_العالم_2026 #WorldCup2026	#WorldCup2026	1
146	2026-03-24 10:56:16+00	Just listed @BallerIntel on @virtuals_io ACP We now have 167 leagues covered. $1.50/query — 10x the league coverage of any competitor. Twice-daily refresh. Betting agents, fantasy agents, trading agents — your edge starts here https:// app.virtuals.io/acp/agents/ld1 x2z9ku4uwhbqiw5a2jcv7 … #WorldCup2026	#WorldCup2026	1
147	2026-03-24 10:56:16+00	We were wrong! 209 leagues covered. $1.50/query — 10x the league coverage of any competitor. Twice-daily refresh. Betting agents, fantasy agents, trading agents — your edge starts here https:// app.virtuals.io/acp/agents/ld1 x2z9ku4uwhbqiw5a2jcv7 … #WorldCup2026 #AIAgents #Football #VirtualsProtocol #ACP	#WorldCup2026	1
148	2026-03-24 10:56:18+00	Have you got your promotional world cup bags? https:// promotrends.co.uk/branded-promot ional-bags/ … #WorldCup2026 #PromotionalProducts #BrandedMerch #EventMarketing #CorporateGifts	#WorldCup2026	1
149	2026-03-24 10:56:18+00	Portugal x PUMA just dropped the 2026 World Cup away kit. Clean lines. Bold look. Does it hit different without CR7 in it? #Portugal #WorldCup2026	#WorldCup2026	1
150	2026-03-24 10:56:18+00	Buying WC2026 tickets is already stressful. Don't also guess whether you'll be baking in the sun for 90 minutes. SeatSun shows sun vs shade by section — free, no signup, all 16 venues: http:// seatsun.com #WorldCup2026 #WC2026Tickets	#WorldCup2026	1
151	2026-03-24 10:56:18+00	FIFA World Cup Playoffs begin this week in Mexico. See Tahoma 31 in action at Stadium Monterrey! #FIFA #WorldCup2026 #tahoma31 #worldcup #FIFAWorldCup https:// tahoma31.com/portfolio/worl d-cup/ … @Rayados	#WorldCup2026	1
506	2026-03-24 11:00:23+00	MESDAMES ET MESSIEURS : LE NOUVEAU MAILLOT EXTERIEUR DE L'ALLEMAGNE ! #DFB #Mannschaft #WorldCup2026	#WorldCup2026	1
152	2026-03-24 10:56:20+00	Antonio Rudiger (Real Madrid), N'Golo Kante (Fenerbahce), Mohamed Salah (Liverpool), dan Abdukodir Khusanov (Manchester City) harus menempuh ribuan kilometer (km) untuk mudik. TVRISportsters mudik ke mana? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
153	2026-03-24 10:56:20+00	The President has spoken Dial *899# and stand a chance to fly with the Black Stars to the World Cup #PlayToWin #BlackStars #WorldCup2026 #Ghana	#WorldCup2026	1
154	2026-03-24 10:56:20+00	¿Gasto o inversión? #Mundial2026 #WorldCup2026 #FIFAWorldCup #VIX #LATINUSDIARIO #PpConCarr#HechoConLasPATAS	#WorldCup2026	1
155	2026-03-24 10:56:22+00	#Italy’s #WorldCup2026 dream https:// planetsoccer.substack.com/p/soccer-monda y-italys-world-cup-dream …	#WorldCup2026	1
156	2026-03-24 10:56:22+00	২০২৬ বিশ্বকাপ স্কোয়াড থেকে ‘কার্যত’ ছিটকে গেলেন নেইমার জুনিয়র... #NeymarJr #Brazil #WorldCup2026 https:// rtvonline.com/sports/373364	#WorldCup2026	1
157	2026-03-24 10:56:22+00	Are you ready for your WIN? Dial *899# now and stand a chance to fly with the Black Stars Big prizes. Real opportunities. #PlayToWin #BlackStars #WorldCup2026 #WinBig	#WorldCup2026	1
158	2026-03-24 10:56:22+00	قمصة المنتخب الفرنسي في جميع نسخ كأس العالم من 1998/2026 #فرنسا #كأس_العالم_2026 #WorldCup2026	#WorldCup2026	1
159	2026-03-24 10:56:25+00	Mooie nieuwe tricots Oranje richting het #WORLDCUP2026	#WorldCup2026	1
160	2026-03-24 10:56:25+00	What do you think if World Cup 2026 tickets started with a collectible not a queue? FIFA Collect’s RTTs give you the right to buy tickets, then you decide. Could this cut resale chaos and make access fairer or just add a layer? Thoughts/agree? #WorldCup2026 #FIFACollect	#WorldCup2026	1
161	2026-03-24 10:56:25+00	Italia ke Piala Dunia 2026... atau jadi penonton lagi? Kali ini Syamsir Alam dan Betrand Putra Onsu kasih pendapat mereka Menurut TVRISportsters gimana? Italia bakal lolos atau gagal? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
162	2026-03-24 10:56:27+00	اشتراك مع رسيفر beIN SPORTS وقسم دفعاتك حتى ٤ اشهر العرض متوفر على باقات مختارة فقط العرض متاح اونلاين فقط https:// nhe-group.com/category.php?i d=1191 … للاستفسار 97208400 #beINSPORTS #NHE #worldcup2026 #deema	#WorldCup2026	1
163	2026-03-24 10:56:29+00	AxiumAI launches conversational AI engine to redefine World Cup sportsbook UX http:// dlvr.it/TRf7GM #Sportsbook #WorldCup2026 #AI #Betting #Gambling	#WorldCup2026	1
164	2026-03-24 10:56:29+00	رسميا الكشف عن قميص #منتخب_فرنسا الأساسي والاحتياطي #كأس_العالم_2026. #worldcup2026	#WorldCup2026	1
165	2026-03-24 10:56:29+00	Carlo Ancelotti has dropped Neymar from Brazil's 2026 World Cup squad. The forward's ambition for one final tournament will not materialize. Is this the right move? Follow world soccer with us: http:// soccerplayer.co #WorldCup2026 #Neymar #Brazil	#WorldCup2026	1
166	2026-03-24 10:56:31+00	Monterrey in June: 100°F+ heat, high humidity, open-air stadium. Estadio BBVA has canopy coverage over the upper tiers — but the lower bowl is fully exposed. Know before you buy → http:// seatsun.com/stadiums/bbva #WorldCup2026 #Monterrey #WC2026	#WorldCup2026	1
167	2026-03-24 10:56:31+00	Plan reprezentacji Polski przed najważniejszym meczem wiosny: 23 marca - początek zgrupowania i I trening (bardziej rozruch) 24 marca - II trening 25 marca - III trening (oficjalny) 26 marca - mecz z Albanią na Stadionie Narodowym #WorldCupQualifiers #WorldCup2026 #baraże	#WorldCup2026	1
168	2026-03-24 10:56:31+00	Les nouveaux maillots de l’équipe de France pour la Coupe du monde 2026 dévoilés, avec une couleur inédite inspirée de la Statue de la Liberté. #France #WorldCup2026 #Football #LesBleus	#WorldCup2026	1
169	2026-03-24 10:56:31+00	Maret hampir habis. Apa artinya TVRISportsters? Itu berarti Piala Dunia 2026 makin dekat. Tinggal 80 hari lagi! Sabar ya TVRISportsters, enggak lama lagi pesta sepak bola ini akan bisa disaksikan di TVRI. #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
170	2026-03-24 10:56:34+00	Absolument HIDEUX @EquipeFRA @nikefootball On se rend compte Nike va nous faire jouer en VERT à la Coupe du Monde… WTF Il faut les faire annuler ces maillot à vomir c’est IMPOSSIBLE #EquipeFrance #FIFA #WorldCup2026	#WorldCup2026	1
171	2026-03-24 10:56:34+00	https:// youtu.be/GF5Nu9YEk7k An 80s dance pop version of our #ScotlandWorldCupSong, celebrating @ScotlandNT being back at the @FIFAWorldCup ! Listen and compare to the original. #Scottishfootball #WorldCup2026 #TartanArmy #Scotland #bringthetrophyhame	#WorldCup2026	1
172	2026-03-24 10:56:36+00	NOUVEAU MAILLOT ! Le nouveau maillot de la Corée du Sud pour la Coupe du Monde 2026 est disponible sur le site ! : 24,99€ : 5-10 jours ! : -10% avec le code « 2k26 » ! https:// elite-fanstore.com/products/maill ot-coree-du-sud-exterieur-version-joueur-coupe-du-monde-2026 … #SouthKorea #KFA #WorldCup2026 #WC2026	#WorldCup2026	1
173	2026-03-24 10:56:36+00	FIFA WORLD CUP 2026 80 DAYS TO GO! The countdown continues… Watch every moment LIVE on WLive+ http:// wclub666.com #WorldCup2026 #WC2026 #Football #Countdown #FIFAWorldCup2026 #FIFA #Wclub	#WorldCup2026	1
174	2026-03-24 10:56:36+00	India is the World Champion, and my code is celebrating! Built a special T20 World Cup tribute using HTML/CSS. Digital celebration for a historic win! #WorldCup2026 #TeamIndia #Developer #CodingLife #HTML #CSS #Cricket	#WorldCup2026	1
175	2026-03-24 10:56:36+00	Adidas me va a dejar en la quiebra con las camisetas del mundial y las originals de los equipos de premier league #adidasoriginals #Adidas #WorldCup2026	#WorldCup2026	1
176	2026-03-24 10:56:38+00	Pengalaman Zinedine Zidane yang panjang sebagai pemain dan pelatih membuatnya pantas menggantikan Didier Deschamps. TVRISportsters, seperti apa wajah Timnas Prancis di bawah asuhan Zidane? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
177	2026-03-24 10:56:38+00	新アウェイユニ、デザインが良すぎて普段使いもできそう。 どんなコーデにも合いそうで可愛い！ #日本代表 #サッカー日本代表 #WorldCup2026 #adidasFootball #JFA @jfa_samuraiblue @adidasJP @adidasfootball	#WorldCup2026	1
178	2026-03-24 10:56:38+00	Buying WC2026 tickets without checking sun exposure is like booking a hotel without checking reviews. A noon kickoff at Hard Rock Stadium in July puts some sections in direct sun for 90+ minutes. We mapped every section at all 16 venues → http:// seatsun.com #WorldCup2026	#WorldCup2026	1
179	2026-03-24 10:56:38+00	Mari kita berjuang bersama lagi untuk bisa lolos ke World Cup... Kita usahakan #seputarbola #timnasindonesia #worldcup2026 #fifaworldcup2026	#WorldCup2026	1
180	2026-03-24 10:56:40+00	Portugal Rilis Jersey Tandang Terbaru untuk Piala Dunia 2026 Timnas Portugal resmi memperkenalkan jersey tandang terbaru yang akan mereka gunakan pada ajang Piala Dunia 2026. #CR7 #Portugal #WorldCup2026	#WorldCup2026	1
181	2026-03-24 10:56:40+00	Situs Dewabet sedang bagi-bagi jackpot. Yuk segera bergabung bersaama dewabet, Situs Paling ahli meberikan CUAN! https:// garasimobilku.website/worldcup2026/ #worldcup2026 #pialadunia2026 #dewabet #mexico #Canada #timnasindonesia #indonesia	#WorldCup2026	1
182	2026-03-24 10:56:43+00	#Lighter by Jelly Roll & Carín León for #WorldCup2026 feels completely soulless—no passion, no fire, no calor at all. Toss it in the bin. Praying Coca-Cola saves us with a real banger this time. #FIFA #Mundial2026	#WorldCup2026	1
183	2026-03-24 10:56:47+00	Hollanda’nın 2026 Dünya Kupası için iç saha ve deplasman formaları #Netherlands #WorldCup2026 Pep Guardiola Barcelona Real Madrid Kaya Çilingiroğlu Bedri Lookman Cherki	#WorldCup2026	1
184	2026-03-24 10:56:47+00	The Best World Cup Songs #worldcup #FIFAWorldCup #worldcup2026 #FIFAWorldCup2026 #FIFA #music @FIFAWorldCup	#WorldCup2026	1
185	2026-03-24 10:56:47+00	The biggest stars will shine on the world stage From rising talents to global icons Who will dominate the World Cup 2026? Mbappé Messi Vinícius Bellingham Who are you watching? Follow @WorldCupUSA_Hub for more #WorldCup2026 #FIFAWorldCup	#WorldCup2026	1
186	2026-03-24 10:56:49+00	Geopolitics crashing into football — this could reshape Group G and the whole tournament! Read the full breakdown: https:// tamingalphaman.wordpress.com/2026/03/22/wor ld-cup-2026-iran-controversy-security-fears-everything-you-need-to-know-right-now/ … What do you think — should Iran play, relocate, or withdraw? #WorldCup2026 #Iran #FIFA #Football	#WorldCup2026	1
187	2026-03-24 10:56:49+00	Huge drama brewing for #WorldCup2026: Iran demands FIFA move their group games from USA to Mexico over security fears after US/Israel strikes & Trump's "safety concerns" comments. "We'll boycott America, but not the World Cup" – Iranian FA chief. https:// tamingalphaman.wordpress.com/2026/03/22/wor ld-cup-2026-iran-controversy-security-fears-everything-you-need-to-know-right-now/ …	#WorldCup2026	1
188	2026-03-24 10:56:49+00	Real time , Market impact Demand and supply m Such things don’t work in BC Canada Host to #WorldCup2026 There’s self employed agency that employs self employed uber and Lyft drivers here	#WorldCup2026	1
189	2026-03-24 10:56:49+00	79 hari Lagi Menjelang Piala Dunia 2026, debaran semakin terasa Tuan Rumah: #pialadunia2026 #fifaworldcup2026 #worldcup2026 #canada #mexico #usa #2026 #worldcup	#WorldCup2026	1
190	2026-03-24 10:56:51+00	Estadio BBVA in Monterrey is one of the most underrated heat traps at WC2026. June temperatures regularly hit 100°F+. The upper deck canopy covers you — the lower bowl does not. Check your section before you buy: http:// seatsun.com/stadiums/bbva #WorldCup2026 #WC2026 #Monterrey	#WorldCup2026	1
191	2026-03-24 10:56:51+00	#Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa	#WorldCup2026	1
192	2026-03-24 10:56:51+00	“Wisdom that Sticks” (#70) are daily insights to cultivate love, wisdom, and intentional living, based on a Wisdom Tool exercise in Cultivating Love: Wisdom for Life by Dr. Ken McGill https:// amazon.com/Cultivating-Lo ve-Dr-Ken-McGill-ebook/dp/B0G1V7R3YZ?ref_=ast_author_mpb … #WorldCup #FIFAWorldCup #WorldCup2026 #WorldCupFootball #RoadToWorldCup	#WorldCup2026	1
193	2026-03-24 10:56:53+00	#Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa #UAE	#WorldCup2026	1
194	2026-03-24 10:56:53+00	5000 fishes #Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa #backtothefuture #lulz	#WorldCup2026	1
195	2026-03-24 10:56:53+00	#Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa #backtothefuture #lulz	#WorldCup2026	1
196	2026-03-24 10:56:53+00	https:// btselem.org/publications/2 02601_living_hell … They took his leg off wtf #Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa #backtothefuture #lulz	#WorldCup2026	1
197	2026-03-24 10:56:56+00	#no #Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa #backtothefuture #lulz	#WorldCup2026	1
198	2026-03-24 10:56:56+00	80 days to World Cup 2026! 52+ players earning KICK points 44,600 KICK distributed Play daily quiz & penalty shootout — earn points convertible to WC26 token! https:// t.me/wc26viral_bot #WorldCup2026 #WC26 #FIFA #Web3	#WorldCup2026	1
199	2026-03-24 10:56:56+00	Boycott The World Cup Link in bio #worldcup #2026worldcup #worldcup2026 #fifaworldcup #fifa #trump #netanyahu #epstein #epsteinfiles #potus #flotus #israel #pedofiles #jetten #knvb	#WorldCup2026	1
200	2026-03-24 10:56:58+00	ICE agents in airline terminals, #foreigntourists please don’t come here. #WorldCup2026	#WorldCup2026	1
201	2026-03-24 10:56:58+00	I would be surprised if Thomas Tuchel includes Bukayo Saka in his starting 11 for the #WorldCup2026 . SAKA has been so bad this season. #COYG	#WorldCup2026	1
202	2026-03-24 10:57:00+00	Name a better time to stage a mass casualty false flag attack than during the #WorldCup2026 in the US. @UEFA @FIFAWorldCup	#WorldCup2026	1
203	2026-03-24 10:57:00+00	BREAKING: It’s over.. Cristiano Ronaldo’s injury is more serious than expected. #Ronaldo #CR7 #WorldCup2026 #Portugal #coupedumonde2026	#WorldCup2026	1
204	2026-03-24 10:57:00+00	Wow! Stole Dimitrievski kept a clean sheet yesterday and definitely made one of the saves of the season across the Europe's top 5 leagues. Just look at his reaction, incredible from the #Macedonia goalkeeper and much needed ahead of the #WorldCup2026 play-offs! #VCF	#WorldCup2026	1
205	2026-03-24 10:57:00+00	Mission #WorldCup2026 begins today in Skopje as the #Macedonia national team gathered and the newly appointed coach, Goce Sedloski, held the first training session. Here is the Colombia-born, Sebastián Herrera, speaking in fluent Macedonian. https:// youtu.be/TFFgvl_35tU?si =f94mv92UUnyLgI24 …	#WorldCup2026	1
206	2026-03-24 10:57:03+00	#USMNT​ #USMNT2026​ #WorldCup2026​ #FIFA2026​ #USA​ #NikeFootball​ #NikeKits​ #FootballShirt​ #SoccerJersey​ #KitCollector​ #KitCulture​ #FootballCulture​ #MatchDayVibes​ #AwayKit​	#WorldCup2026	1
207	2026-03-24 10:57:03+00	¡HOY! Sigue el camino al Mundial con “Stories from the Cities” de la FIFA World Cup 2026 Episodio 8: Filadelfia 8:00 PM Por Tigo Sports Canal 300 | App y Web #StoriesFromTheCities #WorldCup2026	#WorldCup2026	1
208	2026-03-24 10:57:03+00	Norway's 2026 home kit is clean Red base, that bold Nordic cross with subtle patterns—pure heritage vibes. Haaland & co. about to dominate! #Norway #WorldCup2026 #FIFAWorldCup #NikeFootball #Haaland #Norge	#WorldCup2026	1
209	2026-03-24 10:57:03+00	https:// stadiumjourney.com/stadiums/no-pa rking-no-tailgating-at-metlife-stadium-2026-fifa-world-cup … @StadiumJourney @BallparkHunter @FIFAWorldCup @MetLifeStadium #worldcup2026 #fifa #metlifestadium #usasoccer #newjersey	#WorldCup2026	1
210	2026-03-24 10:57:05+00	BC Canada One on One exploitation despatch ! Low pay , private chauffeuring Basically Slavery Welcome to #WorldCup2026 with @Uber_Canada and @lyft Canada Inc.	#WorldCup2026	1
211	2026-03-24 10:57:05+00	Love your concert posters vis-à-vis the #WorldCup2026 countdown, but if I were your publicist, I’d use posters of former Olympics, WC & other world intl. competitions. May I request that you use this poster for day 79 coming up on Tuesday of my hometown, San Juan? Gracias!	#WorldCup2026	1
212	2026-03-24 10:57:05+00	adidas curaçao'nun deplasman forması efso yapmış. #worldcup2026	#WorldCup2026	1
213	2026-03-24 10:57:05+00	LIVE Stonebwoy spotted at Kempinski, Accra #Ghana #BlackStars #WorldCup2026 #Stonebwoy #NewsPoint247Live	#WorldCup2026	1
214	2026-03-24 10:57:07+00	#Worldcup2026	#WorldCup2026	1
215	2026-03-24 10:57:07+00	MetLife Stadium has NO roof. If you're going to a WC2026 match in New Jersey, you're sitting in full summer sun — unless you pick the right section. We mapped exactly which seats stay shaded (and when): http:// seatsun.com #WorldCup2026 #MetLife #WC2026	#WorldCup2026	1
216	2026-03-24 10:57:07+00	World Cup 2026 may drive $10.5B in ads — but brands now want ROI, not just reach. : https:// theenterprise.news #WorldCup2026 #AdvertisingTrends #MediaStrategy #DigitalAdvertising #SportsMarketing	#WorldCup2026	1
217	2026-03-24 10:57:09+00	Aquí temenos a los dos balones oficiales del mundial #WorldCup2026 en México un es para regalar y el otro es para patearlo	#WorldCup2026	1
218	2026-03-24 10:57:09+00	Co-host advantage is real this summer. Which group do you think produces the biggest upset? Tell me! #WorldCup2026 #Groups #FIFAWorldCup	#WorldCup2026	1
219	2026-03-24 10:57:09+00	. In another language The Afcon winners En route vers STADEFRANCE #Worldcup2026 #AFCON2025	#WorldCup2026	1
220	2026-03-24 10:57:09+00	Carlo Parola jogou apenas um jogo de Copa do Mundo, em 1950. Entretanto, deve ser a figurinha que mais apareceu nos álbuns dos Mundiais -e aparece até hoje. Ele é o jogador por trás da foto que se tornou ícone da Panini. Parola faleceu em 22 de março de 2000. #worldcup2026	#WorldCup2026	1
221	2026-03-24 10:57:12+00	TVRISportsters, yuk ikutan tebak peringkat pemain tercepat, sambil nyemil nastar Tebakan TVRISportsters benar semua, mendekati, atau malah salah semua? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
222	2026-03-24 10:57:12+00	The #WorldCup2026 going to be wild. Can’t wait.	#WorldCup2026	1
223	2026-03-24 10:57:12+00	Undercover Journalist’s Shocking Football Hooligan Exposé	#WorldCup2026	1
224	2026-03-24 10:57:12+00	Scotland world cup top shopping. Think I’m going to get it. #TartanArmy #WorldCup2026	#WorldCup2026	1
225	2026-03-24 10:57:15+00	جدد اشتراكك او اشترك مع رسيفر beIN SPORTS وقسم دفعاتك حتى ٤ اشهر العرض متوفر على باقات مختارة فقط العرض متاح اونلاين فقط https:// nhe-group.com/category.php?i d=1191 … للاستفسار 97208400 #beINSPORTS #NHE #worldcup2026 #deema	#WorldCup2026	1
226	2026-03-24 10:57:17+00	WORLD CUP COUNTDOWN http:// bit.ly/45Um7A5 With 81 days remaining, focus shifts to tactics and identity. First Deposit Match Sport Bonus up to R200 #Interbet #WorldCup2026 #FootballFever #SoccerFans #Countdown #SoccerWC26	#WorldCup2026	1
227	2026-03-24 10:57:17+00	Daftar dan Menangkan Maxwin DISINI : https:// garasimobilku.website/worldcup2026/ #worldcup2026 #pialadunia2026 #dewabet #mexico #Canada #timnasindonesia #indonesia	#WorldCup2026	1
228	2026-03-24 10:57:19+00	I’m all ready disappointed at all the goals I’m going to miss by boycotting the World Cup matches held in the USA. #worldcup2026	#WorldCup2026	1
229	2026-03-24 10:57:19+00	Ghana, US discuss preparations towards 2026 World Cup as Ablakwa commends visa process improvements https:// 3news.com/news/ghana-us- discuss-preparations-towards-2026-world-cup-as-ablakwa-commends-visa-process-improvements?utm_source=dlvr.it&utm_medium=twitter … #Ghana #WorldCup2026 #USRelations	#WorldCup2026	1
230	2026-03-24 10:57:21+00	Kalau TVRISportsters bagaimana keseruannya merayakan Idulfitri tahun ini? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
231	2026-03-24 10:57:21+00	One more ticket to the biggest party in football history. Who makes it? Who gets the shock qualification? Your prediction? Drop it below! #WorldCup2026 #PlayOffs #81DaysToGo	#WorldCup2026	1
232	2026-03-24 10:57:21+00	. @JDMahama launches $30m World Cup fundraising campaign Details here: https:// myjoyonline.com/mahama-launche s-30m-world-cup-fundraising-campaign/ … #JoyNews #GhanaNews #WorldCup2026 #WorldCup #Joy997FM	#WorldCup2026	1
233	2026-03-24 10:57:24+00	Lebaran keliling komplek versi Piala Dunia Bayangin TVRISportsters cuma boleh mampir ke 2 rumah aja... Rumah Kylian Mbappe atau Cristiano Ronaldo? Ke kediaman Vinicius, Lionel Messi, atau Mo Salah? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
234	2026-03-24 10:57:24+00	81/365 81 days to the World Cup #FIFAworldcup #Worldcup2026 Psalms 89:45	#WorldCup2026	1
235	2026-03-24 10:57:24+00	Fans disappointed but budget matters: Mahama says gov’t won’t fund travel to 2026 World Cup. #FanHeartbreak #WorldCup2026 #MahamaDecision	#WorldCup2026	1
236	2026-03-24 10:57:24+00	Don’t sleep on Portugal FIFA World Cup 2026 might be their moment… A perfect mix of young stars & experience. This could finally be their year. What’s your thoughts? #WorldCup2026 #cr7 #cristiano	#WorldCup2026	1
237	2026-03-24 10:57:28+00	No estaría demasiado seguro de que va a haber #worldcup2026. En ningún país.	#WorldCup2026	1
238	2026-03-24 10:57:28+00	Jelly roll outta all ppl 🫩 #Worldcup2026	#WorldCup2026	1
239	2026-03-24 10:57:28+00	𝗢𝗙𝗙𝗜𝗖𝗜𝗔𝗟: The first song of the 2026 World Cup: Lighter by Jelly Roll and Carín León. ( @FIFAWorldCup)	#WorldCup2026	1
240	2026-03-24 10:57:28+00	Calling up injured Jude Bellingham and leaving out Trent is diabolical. 5 Keepers for what? Welbeck deserved to be there. We are finished #England #WorldCup2026	#WorldCup2026	1
241	2026-03-24 10:57:28+00	“Wisdom that Sticks” (#69) is inspired by a Wisdom Tool in Cultivating Love: Wisdom for Life by Dr. Ken McGill https:// amazon.com/Cultivating-Lo ve-Dr-Ken-McGill-ebook/dp/B0G1V7R3YZ?ref_=ast_author_mpb … #WorldCup #FIFAWorldCup #WorldCup2026 #WorldCupFootball #RoadToWorldCup #WorldCupFinal #WorldCupQualifiers #WorldCupGoals #WorldCupMatch	#WorldCup2026	1
242	2026-03-24 10:57:28+00	As we head toward the 2026 World Cup, AI isn't just a "side window"—it’s the engine room. From 3D player avatars to real-time tactical bots, the game is changing forever. Here are 5 ways AI is redefining soccer right now. #AI #Soccer #WorldCup2026	#WorldCup2026	1
243	2026-03-24 10:57:28+00	Van Dijk tunjukkan levelnya ke Trent Tenang, kuat, dan penuh pengalaman. Inilah kelas bek top dunia! #Dewacash #PialaDunia2026 #WorldCup2026 #FIFAWorldCup2026 #WC2026 #RoadTo2026 #GarudaMendunia	#WorldCup2026	1
866	2026-03-24 14:19:06+00	i’m outside new york!!!! #fanaticfest2026 #fypシ゚ #worldcup2026 #celebritylookalike	#WorldCup2026	0
244	2026-03-24 10:57:30+00	El mundial USA, MEX Y CANADA 2026... Lo paga Trump el pedófilo. Lo promociona Messi el títere del sionismo genocida. Y lo presentan y comentan en Caracol Televisión Ricardo Orrego, César Augusto Londoño y Jorge Alfredo Vargas, acosadores sexuales. Qué mundial. #WorldCup2026	#WorldCup2026	1
245	2026-03-24 10:57:30+00	good luck to South Korea in #WorldCup2026	#WorldCup2026	1
246	2026-03-24 10:57:30+00	Mind you JUNE #worldcup2026 a 20 year old MBOKAZI will be making these insane passes while the whole world is watching	#WorldCup2026	1
247	2026-03-24 10:57:30+00	Can you predict this match? USA vs Paraguay I got 2–1 What’s your prediction? Try it in the app (link in comments) #WorldCup2026 #FootballFans #SoccerPredictions #FootballApp #Matchday	#WorldCup2026	1
248	2026-03-24 10:57:33+00	Just ran a 40,000-simulation AI World Cup 2026 predictor and: Morocco beat France on penalties in the Final Mbappé Golden Boot The simulator does not care about reputations Run it yourself http:// fifaworldcup2026simulator.com #WorldCup2026 #FIFAWorldCup #WC2026 #Morocco #France	#WorldCup2026	1
249	2026-03-24 10:57:33+00	Germany and Ecuador already have their World Cup date in New York MetLife gets one of those group-stage games that could get tricky fast. #WorldCup2026 #Germany #Ecuador	#WorldCup2026	1
250	2026-03-24 10:57:33+00	Confused about the World Cup format? Here’s a simple explanation: • Group stage • Knockout rounds • Quarter finals • Final The best teams fight until one becomes champion. Are you ready for World Cup 2026? #WorldCup2026 #FIFAWorldCup #FootballFans	#WorldCup2026	1
251	2026-03-24 10:57:36+00	The 2026 World Cup is coming to Boston! Expecting guests or just want to join the festivities? Rent the gear you need or list your extra equipment for the fans. Download the Chartrflex App and Start Earning #WorldCup2026 #BostonEvents #GearRental	#WorldCup2026	1
252	2026-03-24 10:57:36+00	Planning to attend the World Cup 2026? Here’s how to buy tickets safely: • Register on official platforms • Follow ticket sale announcements • Avoid unofficial sellers Don’t rush. Stay informed. DM us “USA” for ticket updates #WorldCup2026 #WorldCupTickets	#WorldCup2026	1
253	2026-03-24 10:57:36+00	Chulada de camisa #eltri #mexico #worldcup2026	#WorldCup2026	1
254	2026-03-24 10:57:39+00	Bojan Miovski found the back of the net vs. #Aberdeen, but the goal was ruled out by VAR for handball in the build-up. Nevertheless, encouraging signs from the #Macedonia striker ahead of the #WorldCup2026 play-off semi-final, should definitely play more for #RangersFC!	#WorldCup2026	1
255	2026-03-24 10:57:39+00	NFF appeals FIFA ruling over DR Congo eligibility dispute Super Eagles not giving up on 2026 World Cup hopes Full story https:// hotsportsscoops.com/nigeria-vs-dr- congo-nff-rejects-fifa-verdict-files-fresh-appeal/ … #SuperEagles #NFF #WorldCup2026	#WorldCup2026	1
256	2026-03-24 10:57:39+00	I don't even support Argentina but this kit is WINNING. #WORLDCUP2026 #FIFA	#WorldCup2026	1
257	2026-03-24 10:57:39+00	adidas unveil Argentina’s 2026 away kit.	#WorldCup2026	1
258	2026-03-24 10:57:41+00	The World Cup is becoming a national embarrassment. The tailgate is half the point of an international event. @FIFAWorldCup #WeAre26 #WorldCup2026	#WorldCup2026	1
259	2026-03-24 10:57:42+00	There will be NO PARKING OR TAILGATING before all World Cup matches at #MetLife Stadium! Good thing Gameday will be hosting our pre-match hospitality experience before every match at American Dream!	#WorldCup2026	1
260	2026-03-24 10:57:42+00	82 Days to the World Cup & CHAOS has arrived! Legend injury scares + a massive FIFA financial shake-up just dropped. The road to 2026 just took a wild turn. Full details here: https:// fifaworldcupnews.com/breaking-news- of-fifa-on-21-march-2026/ … #FIFA #WorldCup2026 #Football #SoccerNews #Breaking #FIFA26	#WorldCup2026	1
261	2026-03-24 10:57:42+00	اا القميص الرسمي لمنتخب البرازيل في كاس العالم اا / اا #SeleçãoBrasileira #worldcup2026	#WorldCup2026	1
262	2026-03-24 10:57:42+00	ITALIA @adidasfootball #Nazionale #Azzurri #VivoAzzurro	#WorldCup2026	1
263	2026-03-24 10:57:42+00	World Cup 2026 countdown: 81 days! Who will win? Predict, play & earn KICK points: Daily football quiz Penalty shootout game 500 KICK welcome bonus KICK → WC26 token https:// t.me/wc26viral_bot #WorldCup2026 #WC26 #Football	#WorldCup2026	1
264	2026-03-24 10:57:42+00	ICYMI #Canada OUT of #WorldCup2026 No #ICE in #football #soccer NO to #USA NO to	#WorldCup2026	1
265	2026-03-24 10:57:42+00	FIFA SHOULD DEMAND INFANTINO'S RESIGNATION TODAY AND AMERICA SHOULD NOT HOST THE WORLD CUP BOYCOTT AMERICA	#WorldCup2026	1
266	2026-03-24 10:57:46+00	Which fact blew your mind the most? Drop it below #football #worldcup2026	#WorldCup2026	1
267	2026-03-24 10:57:46+00	The USA could be playing a World Cup knockout game on JULY 4TH. Independence Day. In front of 70,000+ fans. Imagine the atmosphere!! #WorldCup2026	#WorldCup2026	1
268	2026-03-24 10:57:46+00	This could genuinely be the LAST World Cup for both Messi AND Ronaldo. Two generational talents. One final stage. Soak. It. In. #WorldCup2026 #GOAT	#WorldCup2026	1
269	2026-03-24 10:57:46+00	USA + Mexico + Canada hosting together for the first time EVER. Mexico hasn’t hosted since 1986. 40 years in the making. #WorldCup2026	#WorldCup2026	1
270	2026-03-24 10:57:46+00	The 2026 World Cup has 104 matches. ONE HUNDRED AND FOUR. That’s 40 more than Qatar. Your sleep schedule is not ready. #WorldCup2026	#WorldCup2026	1
271	2026-03-24 10:57:46+00	With the World Cup 2026 just around the corner, here are some WILD facts you need to know #WorldCup2026	#WorldCup2026	1
272	2026-03-24 10:57:48+00	Those 2026 World Cup away jerseys, uuff Kwanza ya Spain na Argentina. #worldcup2026	#WorldCup2026	1
273	2026-03-24 10:57:48+00	Brighton’s Pascal Gross gets a huge boost! The midfielder has been recalled to Germany’s squad ahead of the World Cup 2026. https:// flyingeze.com/pascal-gross-d eniz-undav-brighton-germany-midfielder-world-cup … #Football #WorldCup2026 #PascalGross #Germany #Brighton	#WorldCup2026	1
274	2026-03-24 10:57:48+00	Quer criar uma Selfie com seu jogador preferido pra copa do mundo 2026? #worldcup2026 #ai ...	#WorldCup2026	1
275	2026-03-24 10:57:48+00	More of this please! #Neymar #Brazil #WorldCup2026	#WorldCup2026	1
276	2026-03-24 10:57:48+00	Igor Thiago: “My dream is to play with Neymar, i grew up watching him as a kid and fell in love with the game because of him, i hope we both get a call up to the World Cup” 24 years old wonderkid Igor Thiago expresses	#WorldCup2026	1
277	2026-03-24 10:57:51+00	Wann wacht America endlich auf. @DOGE hat mit der @PalantirTech Software von #Karp und #Thiel die Daten aller Amerikaner und USA-Besucher durchforstet und für jeden ein Profil erstellt. Jetzt vor der #worldcup2026 wird die Flugsicherung der USA, @TSA , so zurück gefahren, dass...1	#WorldCup2026	1
278	2026-03-24 10:57:51+00	These 5 will be on every highlight reel. Mark my words! Who’s YOUR breakout star for 2026? Drop the name #WorldCup2026 #NextGeneration #FootballStars	#WorldCup2026	1
279	2026-03-24 10:57:51+00	Don’t care about your Gibbs-Whites, Watkins, Bowens etc … Danny Wellbeck deserves to go … #england #threelions #worldcup2026 #EnglandFootball	#WorldCup2026	1
280	2026-03-24 10:57:56+00	"America's Calling (2026 World Cup Anthem) Waka Waka USA FIFA Song" https:// youtu.be/8Mr7MkYHN9A?si =zPdPEd6iFoHkefcE … #worldcupfinal #worldcup2026 #worldcupchampions #worldcupsemis	#WorldCup2026	1
281	2026-03-24 10:57:57+00	El fútbol mundial volverá a mirar al Estadio Azteca, uno de los escenarios más históricos del planeta. Muy pronto, este icónico estadio será el punto de partida de una nueva Copa del Mundo. #Mundial2026 #WorldCup2026 #EstadioAzteca #FIFAWorldCup #Futbol	#WorldCup2026	1
282	2026-03-24 10:57:57+00	Cuándo empieza la #WorldCup2026 exactamente...?	#WorldCup2026	1
283	2026-03-24 10:57:57+00	New York comme terrain de jeu. @PUMA / @pumafootball lance ses maillots pour la #WorldCup2026 en mode "streetwear". Une activation stratégique pour connecter la marque à la culture urbaine. Décryptage ici : https:// sportsmarketing.fr/maillots-puma- 2026-new-york/ … #SportsMarketing #PUMA #FIFAWC	#WorldCup2026	1
284	2026-03-24 10:57:59+00	Yes, the new Adidas-designed shirt will only and exclusively be used for the upcoming matches in the #WorldCup2026 play-offs, and complete and probably new equipment will be unveiled in May according to the Football Federation of #Macedonia. https:// ffm.mk/en/makedonskat a-reprezentacija-e-nastapuva-so-adidas-oprema-na-plej-of-natprevarite-za-sp/ …	#WorldCup2026	1
285	2026-03-24 10:57:59+00	So, we are getting New Jerseys after the matches?	#WorldCup2026	1
286	2026-03-24 10:57:59+00	Iran want to play at WC2026. FIFA want them there. So why is nobody budging? Games must move from US to Mexico — FIFA say no. 82 days to go & still unresolved Could a nation miss a World Cup they QUALIFIED for? Who blinks first? #WorldCup2026 #FIFA #SixYardScoop #global	#WorldCup2026	1
287	2026-03-24 10:57:59+00	80/366 82 days to the World Cup #fifaworldcup #worldcup2026 Psalms 89:44	#WorldCup2026	1
288	2026-03-24 10:57:59+00	Americans crave instant gratification — 10 goals in 10 minutes, constant action. But soccer is poetry. It's a buildup, a chess match where players dictate the game, not coaches. Here's why the world's #1 sport doesn't click in the US. #worldcup2026	#WorldCup2026	1
289	2026-03-24 10:57:59+00	Am guessing Messi is going to take this trophy again #worldcup2026	#WorldCup2026	1
290	2026-03-24 10:58:01+00	Mbappe Dembele Olise Cherki Duoe Barcola France eating good this World cup #Worldcup2026	#WorldCup2026	1
291	2026-03-24 10:58:01+00	79/365 83 days to the World Cup #FIFAworldcup #worldcup2026 Psalms 89:43	#WorldCup2026	1
292	2026-03-24 10:58:01+00	https:// youtube.com/shorts/PbTt48k pxQY … Skuad Iran di #WorldCup2026 ada pemain #naturalisasi	#WorldCup2026	1
293	2026-03-24 10:58:01+00	Daftar 28 pemain yang dipanggil Mister Gattuso untuk babak play-off Piala Dunia. #WorldCup2026 #ForzaAzzurri #VivoAzzurro	#WorldCup2026	1
294	2026-03-24 10:58:03+00	ファンブルッフェン、ファンヘッケ、ファンダイク、フリンポン、グラーフェンベルフみんな上手すぎ。オランダ代表守備力世界最強すぎ。 ただし、ガクポイマイチなのと、CFは相変わらずメンフィスなのか気になる。 三笘は本当に凄すぎ。 あとキエーザを召集したイタリア代表が心配。 #WorldCup2026	#WorldCup2026	1
295	2026-03-24 10:58:03+00	Sanju Samson Worldcup journey #SanjuSamson #WorldCup #WorldCup2026 #T20 #India #BCCI #IndianTeam #IndianCricketTeam #CricketTeam	#WorldCup2026	1
296	2026-03-24 10:58:03+00	If Ireland can get through the playoffs, we have a great chance of actually qualifying from the group itself. Mexico would be a tough one, but South Africa and South Korea are on our level. Interesting few weeks ahead! #WorldCup2026	#WorldCup2026	1
297	2026-03-24 10:58:03+00	The winner of European Play-Off Path D has been drawn into Group A alongside Mexico, South Africa & Korea Republic at the #FIFAWorldCup2026draw	#WorldCup2026	1
298	2026-03-24 10:58:03+00	The draw is set for #WorldCup2026 Spain & Argentina should top their groups Tough one for Colombia & Portugal. James vs CR7 Potential pitfalls for Brazil with tough games against Morocco & Scotland Fingers crossed Italy can qualify through the playoffs	#WorldCup2026	1
299	2026-03-24 10:58:05+00	مجموعة أديداس الجديدة للمونديال القادم. #WorldCup2026 #كأس_العالم_2026	#WorldCup2026	1
300	2026-03-24 10:58:05+00	¡Grandes noticias para New Jersey! Se están terminando dos puentes peatonales nuevos que conectarán el MetLife Stadium con el American Dream Mall. Esto mejorará el flujo de visitantes y la seguridad. #NewJersey #MetLifeStadium #WorldCup2026	#WorldCup2026	1
301	2026-03-24 10:58:07+00	Best adidas 2026 World Cup away kit so far? Vote & reply your ranking! #adidas #WorldCup2026"	#WorldCup2026	1
302	2026-03-24 10:58:07+00	#USMNT​ #USMNT2026​ #WorldCup2026​ #FIFA2026​ #USA​ #NikeFootball​ #NikeKits​ #FootballShirt​ #SoccerJersey​ #KitCollector​ #KitCulture​ #FootballCulture​ #MatchDayVibes​ #HomeKit​ #SoccerBible​ #Score90​ #FootballEdit​	#WorldCup2026	1
303	2026-03-24 10:58:07+00	Who are you most excited to see? The opening party in Mexico? The final in New York? Or your team going all the way? Drop your answer below #WorldCup2026 #3MonthsToGo #FootballIsComingHome	#WorldCup2026	1
304	2026-03-24 10:58:07+00	81 days to World Cup 2026! 51+ players earning KICK points 43,050 KICK distributed Play daily quiz & penalty shootout — earn points convertible to WC26 token! https:// t.me/wc26viral_bot #WorldCup2026 #WC26 #FIFA #Web3	#WorldCup2026	1
305	2026-03-24 10:58:07+00	$625M in delayed security funding has left World Cup 2026 planning under pressure—amid warnings of terror threats and unrest. “It will be extremely tight.” Are leaders reacting fast enough to protect global events? #WorldCup2026 #Security Don’t miss out — follow now.	#WorldCup2026	1
306	2026-03-24 10:58:10+00	#FIFAWorldCup #FIFAWorldCup2026 #WorldCup2026 #CopaDoMundo #SeleçãoBrasileira #CopaDoMundo2026 #BrazilNaCopa #Brazil	#WorldCup2026	1
307	2026-03-24 10:58:10+00	Masuk ke SPORTBOOK DEWABET, dukung tim kesayanganmu sekarang juga! DEWABET: Terbukti Terpercaya, Terpilih Jadi yang Terbaik! https:// hopp.bio/togeldewabet #worldcup2026 #pialadunia2026 #dewabet #mexico #Canada #timnasindonesia #indonesia	#WorldCup2026	1
308	2026-03-24 10:58:10+00	#WorldCup of Losers Led by @FIFAcom #WorldCup2026 in #ICE Land	#WorldCup2026	1
309	2026-03-24 10:58:10+00	FIFA have disqualified all the teams from the World Cup and handed the trophy to Israel as it was promised to them 3000 years ago.	#WorldCup2026	1
310	2026-03-24 10:58:12+00	Welcome to custom-made football jerseys. Support home delivery, welcome to place an order and enjoy preferential discount activities.Check my homepage and contact me.#shirt #WorldCup2026 #NewJersey #worldcup #vinijr #méxico #España #England #fyp #jersey #Madrid #Football #brazil	#WorldCup2026	1
311	2026-03-24 10:58:15+00	Y'all niggas buy replicas all you like... BUT NOT MEH! @BafanaBafana @adidasZA @adidasfootball #BafanaBafana #worldcup2026	#WorldCup2026	1
312	2026-03-24 10:58:15+00	Norway 2026 World Cup home & away kits just dropped. Clean. Bold. Ready for the biggest stage. Which one are you wearing? Home or away? #Norway #WorldCup2026 #HomeKit #AwayKit #NewJersey #Norge #FootballFashion #KitLaunch #SoccerShirt #Landslaget	#WorldCup2026	1
313	2026-03-24 10:58:15+00	Lendário jogador alemão, Lothar Matthäus é o recordista de partidas em Copas do Mundo, além de um dos poucos que estiveram em 5 edições do torneio. Capitão em 1990, foi o primeiro a levantar a taça do mundo, com medo de derrubá-la. #fifaworldcup #worldcup2026 #worldcup2026	#WorldCup2026	1
314	2026-03-24 10:58:15+00	I’m not seeing Nigeria’s World Cup jersey #worldcup2026 #worldcup #jerseys	#WorldCup2026	1
315	2026-03-24 10:58:15+00	Italia kala itu sangat digdaya, bertolak belakang dengan era Gli Azzurri setelahnya. Apa kesan TVRISportsters dengan tim besutan Marcello Lippi di Piala Dunia 2006? Siapa pemain jagoan TVRISportsters? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
316	2026-03-24 10:58:18+00	"El futbol debe construir puentes de paz": Gianni Infantino ante tensiones geopolíticas. La FIFA responde indirectamente a la advertencia de #Irán de no asistir al Mundial en EE. UU. si no hay garantías de seguridad. #FIFA #WorldCup2026	#WorldCup2026	1
317	2026-03-24 10:58:18+00	ONLY 81 DAYS TO GO to #worldcup2026 GET THE #TAMRINGTONE BY DOWNLOADING 'THE TARTAN ARMY'S MARCH' HERE: https:// caberfeidhmusic.bandcamp.com/track/the-tart an-armys-march … #Scottish #ringtone @ScotNational @MusicNewsScot @FamousTartan @ScotlandNT @TartanArmyGroup @broadcastscot @weatherblether	#WorldCup2026	1
318	2026-03-24 10:58:18+00	With the World Cup on the horizon… Here’s our ‘international collection’ designs teaser for youfans (Don’t worry, we got you Scots covered too) #worldcup2026 #wearethemods #troubadourvintage	#WorldCup2026	1
319	2026-03-24 10:58:20+00	Iran draws a firm line ahead of the FIFA World Cup 2026. It will boycott matches in the United States but will still play in the tournament. Read more: https:// insightfultake.com/details/iran-t o-boycott-us-but-continue-in-fifa-world-cup-2026 … #Iran #WorldCup2026 #FIFA #FootballNews #USIran #SportsPolitics	#WorldCup2026	1
320	2026-03-24 10:58:20+00	Fucking Tuchel is a Cunt. We lose and get knocked out of World Cup in group stage. But knowing my luck the cunt will win it #WorldCup2026	#WorldCup2026	1
321	2026-03-24 10:58:20+00	For Sale: http:// GER.BET http:// FRA.BET http:// ITA.BET http:// ARG.BET Three letters. FIFA’s official country code. Positioned for the 2026 global football cycle. Rare inventory. Strategic asset. #WorldCup2026	#WorldCup2026	1
322	2026-03-24 10:58:20+00	Grizi #FIFAWorldCup	#WorldCup2026	1
323	2026-03-24 10:58:21+00	Adidas wameachia jezi za ugenini za timu za taifa zinazoenda kushiriki Kombe la Dunia mwaka huu 2026 na zimepokelewa vizuri mno na mashabiki. Jezi ya taifa lipi umeipenda zaidi hapa? #WorldCup2026 #WorldCup #Adidas #NewKit #Spain #Germany	#WorldCup2026	1
324	2026-03-24 10:58:21+00	A Woman that got 100k of people to say men are "Useless" to perform at a men's football tournament is beyond "bonkers" #WorldCup2026 #FootballTwitter	#WorldCup2026	1
325	2026-03-24 10:58:21+00	Sabrina Carpenter will have a live performance at the World Cup opening ceremony	#WorldCup2026	1
326	2026-03-24 10:58:21+00	No state funding for 2026 World Cup fans – President Mahama https://3news.com/sports/football/no-state-funding-for-2026-world-cup-fans-president-mahama?utm_source=dlvr.it&utm_medium=twitter… #WorldCup2026 #PresidentMahama #SportsNews	#WorldCup2026	1
327	2026-03-24 10:58:21+00	USA just unveiled the Star-Spangled 2026 kits — American energy on another level! Clutch the mascot (and $Clutch token) was born for this moment. Dip? Nah, this is your entry ticket. Load the nest now! CA: BUF3TvvZfCMMWaPZJMTGm5WWVmi2arQ9Swze4CPEbonk #ClutchCrypto #WorldCup2026	#WorldCup2026	1
328	2026-03-24 10:58:21+00	Уважно передивився всю лінійку @adidas Trefoil до #worldcup2026. Наша футболка вийшла кращою за грецьку, угорську, японську, шотландську, ірландську... Та взагалі в топ-5 спокійно. Але кращої за аргентинську нема. Це повний розрив.	#WorldCup2026	1
329	2026-03-24 10:58:23+00	No state funding for 2026 World Cup fans – President Mahama https:// 3news.com/sports/footbal l/no-state-funding-for-2026-world-cup-fans-president-mahama?utm_source=dlvr.it&utm_medium=twitter … #WorldCup2026 #PresidentMahama #SportsNews	#WorldCup2026	1
330	2026-03-24 10:58:25+00	#scotland #worldcup2026 https:// etsy.com/shop/Substitut eTees?ref=dashboard-header …	#WorldCup2026	1
331	2026-03-24 10:58:27+00	Lebaran di tiap negara = beda menu, beda vibes Tim-tim dari negara muslim di Piala Dunia 2026 punya hidangan khas masing-masing. Ada yang manis kayak kahk & baklava, atau yang berat kayak kabsa & mansaf. #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
332	2026-03-24 10:58:27+00	FIFA rejects Iran’s request to play World Cup matches in Mexico FIFA has denied Iran’s request to play its 2026 World Cup matches in Mexico, making it clear that there are no plans to change the official schedule. #SportsUpdate #worldcup2026	#WorldCup2026	1
333	2026-03-24 10:58:27+00	Matchday ’26 Your companion for the 2026 World Cup. Track matches, explore host cities, and stay ready for kickoff. Built by Trovyn Tech Follow the journey #WorldCup2026 #Matchday26 #FootballApp #TrovynTech	#WorldCup2026	1
334	2026-03-24 10:58:30+00	Valverde & Darwin Núñez lead Uruguay under Bielsa - both expected vs Spain at Guadalajara Stadium (Akron), June 26. Venue is in Zapopan, not downtown GDL. Plan transport early: http:// guadalajarastadium.com #WC2026Europe #WorldCup2026	#WorldCup2026	1
335	2026-03-24 10:58:30+00	$Clutch is READY! #FIFAWorldCup #WorldCup2026 #WeAre26	#WorldCup2026	1
336	2026-03-24 10:58:30+00	Donald J. Trump Truth Social 03.12.26 07:05 PM EST The United States of America looks very much forward to hosting the FIFA World Cup. Ticket sales are “through the roof!” It will be the Greatest and Safest Sporting Event in American History. All Players, Officials, and Fans	#WorldCup2026	1
337	2026-03-24 10:58:30+00	@adidas just dropped the official jerseys for FIFA World Cup 2026™ Every kit tells a story of culture, heritage & football history. Oh, and the Adidas Trefoil is BACK on the World Cup stage! #FIFAWorldCup2026 #WorldCup2026 #Adidas #WorldCupJerseys #FootballKits	#WorldCup2026	1
338	2026-03-24 10:58:32+00	Barcelona 7-2 Newcastle. Absolute MADNESS. Lamine Yamal is only 18 and already destroying UCL defenses. Who's winning the World Cup 2026? Drop your pick below Test your football knowledge in our free quiz game #UCL #Barcelona #WorldCup2026 #Football	#WorldCup2026	1
339	2026-03-24 10:58:32+00	Argentina vence a Alemania 2 a 1 en la final de la #worldcup2026	#WorldCup2026	1
340	2026-03-24 10:58:32+00	@FIFAWorldCup #WorldCup2026 #Mexico this is WhatsApp you are going to	#WorldCup2026	1
341	2026-03-24 10:58:32+00	Satu momen kecil… tapi membuat perbedaan besar di lapangan #Dewacash #PialaDunia2026 #WorldCup2026 #FIFAWorldCup2026 #WC2026 #RoadTo2026 #GarudaMendunia	#WorldCup2026	1
342	2026-03-24 10:58:32+00	Ronaldo/Portugal-themed World Cup 2026 custom AF1 for my guy @jc_campos #mcflys_customdesigns #mcflys_customkicks #worldcup2026 #cristianoronaldo #portugal @cristiano @shawndesman @portugal @ishowspeed	#WorldCup2026	1
343	2026-03-24 10:58:36+00	**Lamine Yamal Models Spain’s New 2026 World Cup Home Kit** Barcelona superstar Lamine Yamal (19) stars in the official reveal of Spain’s adidas 2026 World Cup home jersey. The classic red design with Climacool technology is already trending. #Yamal #SpainNT #WorldCup2026	#WorldCup2026	1
344	2026-03-24 10:58:36+00	FIFA presento las mascotas de Fauna de cada squadra para el #worldcup2026 ..el Lobo de Tunisia y el chango narigon de Ambrientina	#WorldCup2026	1
345	2026-03-24 10:58:36+00	Flying out to ATL for the World Cup. I can’t believe this is real. VIVA ESPANÁ #worldcup2026	#WorldCup2026	1
346	2026-03-24 10:58:36+00	MARCH INTERNATIONAL WINDOW HOT TAKES @windowintlpod @FIFAcom @11Yanks @ManagerTactical @StarsStripesFC @Eyesandvibes @usmntaut @usmntonly @USMNTOtaku @FOXSoccer @USMNT #USMNT #WorldCup2026 USA : Unbeaten streak ends this window USA is unbeaten in their last 5	#WorldCup2026	1
347	2026-03-24 10:58:36+00	When FIFA refused to move the Iranian World Cup games to Mexico from a country that brutally killed their leaders, FIFA is ultimately sending the players to their death. #FIFA #WorldCup2026 #Iranfootball #IranWar	#WorldCup2026	1
348	2026-03-24 10:58:36+00	I still believe that EA tried to partner with FIFA, but only to have the World Cup. We will soon find out if they were successful in the negotiation. #WorldCup2026 #FC26 #FIFA : @business	#WorldCup2026	1
349	2026-03-24 10:58:36+00	Major OG by Tuchel omitting Trent from his 35 man squad. Bar injuries TAA won't be going to the World Cup.Reece James will be the starting RB but are Livramento, Spence, Qansah, Tomori better than Trent...Not even close.Shocker of a call from the Manager #WorldCup2026	#WorldCup2026	1
350	2026-03-24 10:58:38+00	England 2026 Home&Away Banner Concept For Social Media Platforms! :: @England #england #worldcup2026 #Football #nike - A fun branding project in order to celebrate the release of the new England Home & Away kits!	#WorldCup2026	1
351	2026-03-24 10:58:38+00	Sports • Tuchel's England Squad: A Chance for Redemption or a Tactical Puzzle? #Englandsquad #Worldcup2026 #Football #Tuchel	#WorldCup2026	1
352	2026-03-24 10:58:38+00	President @JDMahama request @shattawalegh and @stonebwoy share a moment on stage at the World Cup 2026 fundraiser #WorldCup2026 #MahamaFundraiser #ShattaWale #Stonebwoy #GhanaMusic #FootballMeetsMusic #GlobalFundraiser #AfricanStarsUnite	#WorldCup2026	1
353	2026-03-24 10:58:41+00	¡Histórico! El gobernador @huachodiazmena encabezó el recorrido del Trofeo de la Copa Mundial @FIFAWorldCup en Chichén Itzá. Junto a Hugo Sánchez y Fernando Llorente, Yucatán brilla ante el mundo. #WorldCup2026 https:// tinyurl.com/3rxuhz2u	#WorldCup2026	1
354	2026-03-24 10:58:41+00	It’s the summer we’re all waiting for and in 83 days time we’re finally getting the greatest football competition in the world. The #WorldCup2026 is on the way and millions of eyes will be glued on the Mexico/South Africa game. For the love of the game @FIFAWorldCup	#WorldCup2026	1
355	2026-03-24 10:58:41+00	Trump put $625M for World Cup security in his own bill. DHS held it up for months. The money is now technically "approved" — but California still hasn't received it, and the first match is in 83 days. #WorldCup2026 #TruthOverSpin	#WorldCup2026	1
356	2026-03-24 10:58:43+00	MARCH INTERNATIONAL WINDOW HOT TAKES @windowintlpod @FIFAcom #WorldCup2026 Cyprus : 2+ points this window Cyprus registered draws against Bosnia , Bulgaria , and Romania in 2025. They've shown the ability to hang with better competition. It's possible they	#WorldCup2026	1
357	2026-03-24 10:58:43+00	https:// youtu.be/yyv4t8zmE6Q @ScotlandNT are getting set to rock the @FIFAWorldCup this summer. Get in the mood by listening to the rock version of our #ScotlandWorldCupSong! #Scottishfootball #WorldCup2026 #TartanArmy #Scotland #bringthetrophyhame	#WorldCup2026	1
358	2026-03-24 10:58:43+00	Honestly with all these new kits coming out for the World Cup my account maybe taking a hit #worldcup2026	#WorldCup2026	1
359	2026-03-24 10:58:43+00	World Cup 2026 loading .. I’m backing my GOAT Lionel Andres Messi and Spain . No switching sides when the pressure hits .. I wish my country had qualified but Nothing spoil. We move . #WorldCup2026 #argentina #spain #messi	#WorldCup2026	1
360	2026-03-24 10:58:45+00	فیفا ورلڈکپ 2026 شیڈول کے مطابق ہی ہوگا: جیانی انفینٹینو | بڑا اعلان | Red Eye News #FIFA #WorldCup2026 #Football #SportsNews #BreakingNews #GlobalSports #RedEyeNews	#WorldCup2026	1
361	2026-03-24 10:58:45+00	Guys ada yang mau jastip Jersey WC26 yang uda di rilis Adidas? Jastip dari UAE yaaa. #jersey #worldcup2026	#WorldCup2026	1
362	2026-03-24 10:58:45+00	No state funds for World Cup supporters - President Mahama Read more: https:// citisportsonline.com/2026/03/no-sta te-funds-for-world-cup-supporters-president-mahama … #CitiSports #Mahama #WorldCup2026	#WorldCup2026	1
363	2026-03-24 10:58:45+00	Does that include "memberships" fees that give you first access and higher odds at ticket access the more you overpay? Like Canada Soccer did with the #WorldCup2026 tickets? *Including a tax slip... **Which you still haven't looked into . @CanRevAgency	#WorldCup2026	1
364	2026-03-24 10:58:46+00	#CanadaSoccer​ #CanMNT​ #WorldCup2026​ #FIFA2026​ #Canada​ #NikeFootball​ #NikeKits​ #FootballShirt​ #SoccerJersey​ #KitCollector​ #KitCulture​ #FootballCulture​ #MatchDayVibes​ #AlphonsoDavies​ #JonathanDavid​ #HomeKit​	#WorldCup2026	1
365	2026-03-24 10:58:48+00	Shatta wale & Stonebwoy #Gtv #worldcup2026 #fundraising #gbcnews	#WorldCup2026	1
366	2026-03-24 10:58:48+00	Portugal and CR7 already have the date circled in Houston The opponent is still missing… and that only makes this one more tempting #WorldCup2026 #Portugal #CristianoRonaldo	#WorldCup2026	1
367	2026-03-24 10:58:50+00	Where to eat near Estadio Azteca Before the match. After the match. Late night tacos. World Cup 2026 is coming. http:// gonativecity.com #WorldCup2026 #CDMX #MexicoCity #Tacos #FoodInMexico #TravelMexico	#WorldCup2026	1
368	2026-03-24 10:58:50+00	Nigeria’s official 2026 outfit: a comfy couch fit to watch Ghana’s Black Stars shine at the World Cup #BlackStars #Ghana #WorldCup2026 #QatarVibes #Naija #Nigeria #Rivalry #AfricanFootball #No1Blogga #FootballTwitter #Soccer #AFCON #WC2026 #GhanaVsNigeria #Banters	#WorldCup2026	1
369	2026-03-24 10:58:50+00	Shatta Wale and Stonebwoy spotted at the Ghana World Cup 2026 fundraising launch event . #gtv #worldcup2026 #Ghmusic	#WorldCup2026	1
370	2026-03-24 10:58:52+00	This kit is too clean Gold. Black Star. PUMA. This is the year we prove everyone wrong. Group stage exit predictions aging badly in July. Screenshot this. #BlackStars #WorldCup2026	#WorldCup2026	1
371	2026-03-24 10:58:52+00	#Soccer with Doug: Meet Jason, who can help you with your World Cup travel plans from or to Atlanta https:// open.substack.com/pub/soccerwith doug/p/soccer-with-doug-meet-jason-who-can?r=2yjpde&utm_campaign=post&utm_medium=web … #WorldCup2026	#WorldCup2026	1
372	2026-03-24 10:58:52+00	Biggest night for Ghana’s football fans! Stonebwoy and Shatta Wale repping hard for a cause that could spark the next generation. Ghana rising! #WorldCup2026	#WorldCup2026	1
373	2026-03-24 10:58:52+00	Government targets $30m fundraising drive for Black Stars’ 2026 World Cup campaign https:// 3news.com/sports/footbal l/government-targets-30m-fundraising-drive-for-black-stars-2026-world-cup-campaign?utm_source=dlvr.it&utm_medium=twitter … #Ghana #BlackStars #WorldCup2026	#WorldCup2026	1
374	2026-03-24 10:58:52+00	#Adidas this is sensational #WorldCup2026	#WorldCup2026	1
375	2026-03-24 10:58:52+00	@SAFA_net and @adidasZA have dropped the new Bafana Bafana & Banyana Banyana away kit for the 2026 #FIFAWorldCup. That retro collar is everything. https:// savarsitynewz.co.za/2026/03/20/baf ana-bafana-unveil-retro-inspired-away-kit-for-2026-world-cup/ … #BafanaBafana #WorldCup2026 #SouthAfrica #AdidasFootball #BanyanaBanyana	#WorldCup2026	1
376	2026-03-24 10:58:52+00	#ChuckNorris #WorldCup2026 #Panamá507	#WorldCup2026	1
377	2026-03-24 10:58:55+00	England's away kit is RED Red like the faces of their fans after penalties. Bellingham and Kane look incredible though. The drip will always outscore the team. #England #WorldCup2026	#WorldCup2026	1
378	2026-03-24 10:58:55+00	Me tocó venir a la T1 del AICM… dudo muchísimo que esté medianamente presentable para el #WorldCup2026 … ¿el plan B será recibir a los visitantes por la Tapo?	#WorldCup2026	1
379	2026-03-24 10:58:55+00	Fuera por MALO!!! @FCF_Oficial @FCFSeleccionCol #FutbolColombiano #SeleccionColombia #WorldCup2026 #Colombia #FIFA #Futbol	#WorldCup2026	1
380	2026-03-24 10:58:55+00	Blanc et rouge. Simple. Classique. L'Angleterre n'a pas besoin de révolution sur le maillot juste sur le terrain #WorldCup2026	#WorldCup2026	1
381	2026-03-24 10:58:57+00	New Episode @Sid_Seixeiro discusses: Concern for Matthew Knies #LeafsForever Concern for Trey Yesavage #BlueJays Concern for Italy v Canada in Toronto #WorldCup2026 & more! Full pod Watch: https:// youtube.com/live/T76WFPMR7 IM … Listen: https:// traffic.megaphone.fm/SICMED13413999 50.mp3 … #sick	#WorldCup2026	1
382	2026-03-24 10:58:59+00	Just pathetic from @FIFAcom Join me and BOYCOTT #WorldCup2026	#WorldCup2026	1
383	2026-03-24 10:58:59+00	By refusing to take action against clubs based in Israeli settlements, FIFA has failed to enforce its own rules and is blatantly flouting international law. FIFA had a clear opportunity to stand up for Palestinians’ rights and international law – with this decision it has	#WorldCup2026	1
384	2026-03-24 10:59:00+00	Hear me out on this one. We've revived Dominic Calvert-Lewin's career Why can't we go and do the same with others. Dele Alli? Kalvin Phillips? #LUFC #MOT #WorldCup2026	#WorldCup2026	1
385	2026-03-24 10:59:00+00	England dropped their 2026 World Cup kit. Beautiful kit. The jersey will always be better than the tournament result. #England #WorldCup2026	#WorldCup2026	1
386	2026-03-24 10:59:00+00	Houston is getting ready to welcome the world for the FIFA World Cup 2026! Scenic Houston’s SRG 3.0 helps ensure Houston looks its best on the global stage. See link in bio. #WorldCup2026 #ScenicHouston #HoustonReady	#WorldCup2026	1
387	2026-03-24 10:59:00+00	ini top 4 world cup 2026 jersey versi lativi 1 Venezuela 2 Wales 3 swedia 4 Norge adidas semua , dah nike 1 aja @frdftw #worldcup2026	#WorldCup2026	1
388	2026-03-24 10:59:02+00	https:// zarpado.com/puma-presento- en-las-calles-de-nueva-york-su-coleccion-de-camisetas-de-selecciones-nacionales/ … @PUMAArgentina @fifaworldcup_es #WorldCup #WorldCup2026 @FIFAWorldCup @ClubFootball @fifacom_ar @fifacom_ar @pumafootball @PUMA	#WorldCup2026	1
389	2026-03-24 10:59:02+00	Iran Boikot Amerika di Piala Dunia 2026? Ini Alasannya! #Shorts #WorldCup2026 #TimnasIran https:// youtube.com/shorts/OQEIpAd c4jk …	#WorldCup2026	1
390	2026-03-24 10:59:02+00	¡Se presenta la nueva piel! México revela su uniforme de visitante para la Copa del Mundo 2026. #WorldCup2026	#WorldCup2026	1
391	2026-03-24 10:59:05+00	André Carrillo #WorldCup2026	#WorldCup2026	1
392	2026-03-24 10:59:05+00	Shatta Wale arrives at Kempinski for the Ghana World Cup 2026 fundraising launch. #Gtv #worldcup2026 #fundraising	#WorldCup2026	1
393	2026-03-24 10:59:05+00	Μουντιάλ 2026- Σε κυκλοφορία το «Lighter», το πρώτο τραγούδι από το επίσημο άλμπουμ του τουρνουά (p) #FIFA #WorldCup2026 https:// amna.gr/sport/article/ 979586/Mountial-2026--Se-kukloforia-to-Lighter--to-proto-tragoudi-apo-to-episimo--almpoum-tou-tournoua-p …	#WorldCup2026	1
394	2026-03-24 10:59:07+00	¡Ya está aquí! La primera canción del Mundial fue lanzada hoy por la FIFA: “Lighter” de Carín León junto a Jelly Roll. #WorldCup2026	#WorldCup2026	1
395	2026-03-24 10:59:07+00	Resmi: Spain’ın 2026 Dünya Kupası için deplasman forması. #Spain #WorldCup2026 Icardi Barış Alper Fatih Terim Futbol Çanakkale Avrupa'da Orkun Arda Turan	#WorldCup2026	1
396	2026-03-24 10:59:07+00	Resmi: Argentina'nın Dünya Kupası 2026 için deplasman forması. #Argentina #WorldCup2026 Icardi Barış Alper Fatih Terim Futbol Çanakkale Avrupa'da Orkun Arda Turan	#WorldCup2026	1
397	2026-03-24 10:59:07+00	Resmi: İtalya'nın World Cup 2026 için deplasman forması. #İtalya #WorldCup2026 Icardi Barış Alper Fatih Terim Futbol Çanakkale Avrupa'da Orkun Arda Turan	#WorldCup2026	1
398	2026-03-24 10:59:09+00	#WorldCup2026 #Atlanta #Soccer	#WorldCup2026	1
399	2026-03-24 10:59:09+00	Harry Wilson #WorldCup2026	#WorldCup2026	1
400	2026-03-24 10:59:09+00	African football writing its own Netflix script. #WorldCup2026 #AFCON2025	#WorldCup2026	1
401	2026-03-24 10:59:09+00	28 RED DEVILS LOCKED IN! March Madness incoming Rudi Garcia’s squad geared up for USA clash (28th) & World Cup prep. De Bruyne pulling strings, Doku ready to fly, Courtois in goal – who’s unstoppable? #RedDevils #Belgium #WorldCup2026	#WorldCup2026	1
402	2026-03-24 10:59:09+00	Kaizer Chiefs players must winbgames to stand a chance of going to the World Cup #KaizerChiefs #WorldCup2026 #amabhincanation #ingoma #BetwayPremiership	#WorldCup2026	1
403	2026-03-24 10:59:11+00	KYLIAN IS BACK! Mbappé included in France squad post-injury Captain leads Les Bleus vs Brazil & Colombia in USA friendlies. World Cup 2026 prep just got REAL. Who’s ready to see him destroy? #LesBleus #Mbappe #WorldCup2026	#WorldCup2026	1
404	2026-03-24 10:59:11+00	adidas have released some stunning national team kits ahead of the FIFA World Cup 2026 this summer #adidas #WorldCup2026 #Football #Soccer #NationalTeamKits #NewKits #FIFA	#WorldCup2026	1
405	2026-03-24 10:59:14+00	The Football Federation of #Macedonia unveil the shirt exclusively made by Adidas only for the upcoming matches in the #WorldCup2026 play-offs. Perfect colours, beautiful design, well done Adidas!	#WorldCup2026	1
406	2026-03-24 10:59:14+00	𝗡𝗘𝗪: Portugal national football team’s away kit for FIFA World Cup 2026 #Portugal #Seleção #WorldCup2026 #Football #Soccer #NewKit #FIFAWorldCup	#WorldCup2026	1
407	2026-03-24 10:59:14+00	Broos drops shock Bafana omissions, prioritising form, fitness, and mental strength ahead of World Cup friendlies. #BafanaBafana #HugoBroos #WorldCup2026 #SoccerSelection #IOLSport Read on: https:// tinyurl.com/3px6rzbr	#WorldCup2026	1
408	2026-03-24 10:59:14+00	#IRAN WANT VENUE CHANGE Talks ongoing to move games from USA to Mexico #WorldCup2026 #WorldCup #FIFA #FootballNews	#WorldCup2026	1
409	2026-03-24 10:59:16+00	Which teams dominate the World Cup scoring charts? Get to know the national teams with the most goals ahead of the 2026 tournament #WorldCup2026 #FIFA	#WorldCup2026	1
410	2026-03-24 10:59:16+00	𝙊𝙉𝙀 𝙒𝙀𝙀𝙆 𝙏𝙊 𝙂𝙊! #WorldCup2026 The @adidasfootball Trionda replica ball has arrived - how many goals will be scored with this across the 104 games at the tournament? 𝗙𝗿𝗶𝗱𝗮𝘆 𝟮𝟳 𝗠𝗮𝗿𝗰𝗵 𝟮𝟬𝟮𝟲: 𝗠𝗲𝘅𝗶𝗰𝗼 𝘃 𝗜𝗿𝗮𝗾, 𝟮𝟭:𝟬𝟬 #subbuteo	#WorldCup2026	1
411	2026-03-24 10:59:16+00	A taça Jules Rimet foi roubada em 20 de março de 1966, poucos meses antes da disputa da Copa do Mundo. Mesmo com toda investigação, a polícia local não conseguiu localizar o objeto. Coube a um cachorro encontrar a taça e se tornar um herói. #fifaworldcup #worldcup2026	#WorldCup2026	1
412	2026-03-24 10:59:18+00	Which upset shocked you the most? Drop it below! #WorldCup2026 #Qualifiers #ShockingResults #FIFAWorldCup	#WorldCup2026	1
413	2026-03-24 10:59:18+00	Les nouveaux maillots du Sénégal pour la Coupe du monde 2026 sont officiellement dévoilés. #Senegal #WorldCup2026 #Match360	#WorldCup2026	1
414	2026-03-24 10:59:18+00	Game on. Your brand, centre stage. Our World Cup 2026 collection is designed to keep your name in play long after the final whistle... Make your brand part of the world’s biggest conversation. Explore the full range: https:// shorturl.at/1b9OZ #WorldCup2026	#WorldCup2026	1
415	2026-03-24 10:59:18+00	“Wisdom that Sticks” (#68) is inspired by a Wisdom Tool in Cultivating Love: Wisdom for Life by Dr. Ken McGill https:// amazon.com/Cultivating-Lo ve-Dr-Ken-McGill-ebook/dp/B0G1V7R3YZ?ref_=ast_author_mpb … #WorldCup #FIFAWorldCup #WorldCup2026 #WorldCupFootball #RoadToWorldCup #WorldCupFinal #WorldCupQualifiers #WorldCupGoals #WorldCupMatch	#WorldCup2026	1
416	2026-03-24 10:59:20+00	*#WorldCup2026	#WorldCup2026	1
417	2026-03-24 10:59:20+00	İtalya’nın 2026 Dünya Kupası için deplasman forması açıklandı. Mamma mia. #Italy #WorldCup2026 #Football Icardi Barış Alper Fatih Terim Futbol Çanakkale Avrupa'da Orkun Arda Turan	#WorldCup2026	1
418	2026-03-24 10:59:20+00	Proud to continue our collaboration with the @TFF_Org For national teams, analysis means tracking players across leagues, styles and tactical contexts: all in one consistent view. Road to @FIFAWorldCup ... we’re right there! #SportAnalytics #TFF #WorldCup2026	#WorldCup2026	1
419	2026-03-24 10:59:20+00	#DFB #WorldCup2026 #Germany	#WorldCup2026	1
420	2026-03-24 10:59:20+00	Germany's away kit for the 2026 FIFA World Cup has been released	#WorldCup2026	1
421	2026-03-24 10:59:22+00	PUMA just dropped the new national team kits in NYC and they did not miss. The Morocco, Ghana, and Senegal designs are easily the best shirts we've seen for the 2026 World Cup so far. Africa is winning the kit game once again. #WorldCup2026 #PumaFootball #Ghana #Morocco	#WorldCup2026	1
422	2026-03-24 10:59:22+00	78/365 84 days to the World Cup #Fifaworldcup #worldcup2026 Psalms 89:42	#WorldCup2026	1
423	2026-03-24 10:59:22+00	With the 2026 World Cup on the horizon, SBC Summit Malta will put sports betting strategy front and centre, helping the industry gear up for the upcoming tournament. Read More: https:// f.mtr.cool/raqvwmzecj #igaming #worldcup2026 #sbc #sbcsummitmalta #2026	#WorldCup2026	1
424	2026-03-24 10:59:22+00	Kraft gets back 1.5M in GAM and Trump secures 46.6M for #ForeverFoxboro World Cup security. #NERevs #WorldCup2026	#WorldCup2026	1
425	2026-03-24 10:59:22+00	Boston gets $46.6 million in federal funding to support safety, security during FIFA World Cup https:// boston25news.com/news/local/bos ton-gets-466-million-federal-funding-support-safety-security-during-fifa-world/GMZXMOXUP5BHJMA47ROHZ3DBPA/?taid=69bc40baa072250001e9a921&utm_campaign=trueanthem&utm_medium=trueanthem&utm_source=twitter …	#WorldCup2026	1
426	2026-03-24 10:59:22+00	SPORTS | Iran's top striker Sardar Azmoun expelled from the national team for perceived disloyalty to the government, ruling him out of the 2026 World Cup . Tehran, Iran Confirmed #Football #WorldCup2026 #Iran Full report: https:// cnn.it/4bCH97Y via @CNN	#WorldCup2026	1
427	2026-03-24 10:59:22+00	“ बड़ा अलर्ट! 2026 FIFA World Cup की तैयारी में देरी US अधिकारियों ने चेतावनी दी: सिक्योरिटी फंडिंग में डिले, टाइमलाइन टाइट। 11 होस्ट सिटीज (Miami, LA, NY आदि) में फेडरल फंड्स ($625 मिलियन) देर से मिल रहे थे। क्या होगा World Cup का? #WorldCup2026 #FIFA #SecurityDelay #USA”	#WorldCup2026	1
428	2026-03-24 10:59:24+00	Manca solo un piccolo dettaglio, a meno che l'aggettivo "away" non sia a doppio senso... #Italia #WorldCup2026	#WorldCup2026	1
429	2026-03-24 10:59:24+00	𝗢𝗙𝗙𝗜𝗖𝗜𝗔𝗟: Italy's away kit for World Cup 2026. Mamma mia.	#WorldCup2026	1
430	2026-03-24 10:59:24+00	Yho! The World Cup Jerseys are so beautiful! Especially the Adidas ones! #WorldCup2026	#WorldCup2026	1
431	2026-03-24 10:59:24+00	FIFA and YouTube strike landmark deal for 2026 World Cup streaming https:// insideworldsoccer.com/2026/03/fifa-y outube-2026-world-cup-streaming-deal.html … #fifawc2026 #wc2026 #worldcup2026 #fifawc	#WorldCup2026	1
432	2026-03-24 10:59:24+00	@troyparrot9 @FAIreland @Paulmcgrath5 please help @AMLaCassePhoto with tickets for the #DenmarkVIreland Qualifier on March 31st for ALAN & His 3 Boys #VIP if you please! #WorldCup2026	#WorldCup2026	1
433	2026-03-24 10:59:24+00	Celebrating different cultures, stories, and identities through football this is more than just kits, it’s art on the pitch Every country shining in its own unique way This might be one of the cleanest collections we’ve ever seen #Adidas #WorldCup2026 #Football	#WorldCup2026	1
434	2026-03-24 10:59:26+00	But the best jersey award has already been decided. Japan . Not even a conversation. #WorldCup2026 #Adidas #FIFA	#WorldCup2026	1
435	2026-03-24 10:59:26+00	A thread of the new adidas national team away kits, dropped just before the World Cup: Spain Japan Chile Scotland	#WorldCup2026	1
436	2026-03-24 10:59:26+00	Two nations. One trophy. Zero clarity. #WorldCup2026 #AFCON2025	#WorldCup2026	1
437	2026-03-24 10:59:26+00	I couldn’t give a flying fuck about @FIFAWorldCup #WorldCup2026 I won’t be watching a second of their Genocidal, Zionist, paedophile, supporting charade.	#WorldCup2026	1
438	2026-03-24 10:59:27+00	#TurkishNationalTeam squad for #WorldCup2026 play-off games has been announced:	#WorldCup2026	1
439	2026-03-24 10:59:29+00	I HAVE A DREAM @selecaoportugal #Worldcup2026 @07RQuaresma	#WorldCup2026	1
440	2026-03-24 10:59:29+00	@adidas absolutely cooked with these World Cup 2026 kits Which WC26 kit is the best drop today? Argentina ,Germany,Spain or Belgium ??Vote below! #WorldCup2026 #Adidas #AdidasKits #FIFAWorldCup	#WorldCup2026	1
441	2026-03-24 10:59:33+00	For full details head over to Facebook: https:// facebook.com/photo/?fbid=12 58358643103930&set=a.421062246833578 … #worldcup2026 #noscotlandnoparty #johnmcginn #billygilmour #tartanarmy	#WorldCup2026	1
442	2026-03-24 10:59:33+00	What a collection. My BEST JERSEY pick? JAPAN. No debate. Clean, Creative and Iconic. That's how you OWN the global stage. England & Portugal fans waiting (im)patiently. Your fave kit? Drop it below! #FIFA2026 #WorldCup2026 #Adidas #KitLaunch	#WorldCup2026	1
443	2026-03-24 10:59:33+00	Augie Fantinus pilih pemain top Piala Dunia Dari sekian banyak negara besar, mana yang paling layak disebut GOAT di Piala Dunia? Setuju sama pilihan Augie? Atau punya versi sendiri TVRISportsters? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
444	2026-03-24 10:59:35+00	Almost that time again and sooo excited #worldcup2026	#WorldCup2026	1
445	2026-03-24 10:59:35+00	Spain have Lamine Yamal at 18, Pau Cubarsí at 18, Fermín at 22... England have Maguire and J.Henderson. One nation is building a dynasty, the other is running a retirement home. #WorldCup2026	#WorldCup2026	1
446	2026-03-24 10:59:37+00	Adidas, Dünya Kupası 2026 için never-seen-before forma ve retro Arjantin topunu içeriyor; ikonik özellik yeniden ortaya çıkıyor #Adidas #WorldCup2026 Icardi Barış Alper Fatih Terim Futbol Çanakkale Avrupa'da Orkun Arda Turan	#WorldCup2026	1
447	2026-03-24 10:59:37+00	Trio @ManUtd diharapkan kembali bela Timnas Inggris https:// pialadunia.tvrinews.com/read/pd_66a8wo qnwp/carrick-ingin-trio-manchester-united-kembali-berseragam-inggris … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
448	2026-03-24 10:59:37+00	Sorry, but I just can't see anyone stopping this French national team in the World Cup. #equipedefrance #worldcup2026	#WorldCup2026	1
449	2026-03-24 10:59:37+00	Coupe du Monde 2026 L’ANPS prolonge la date d’inscription pour l’attribution des codes d’accréditation jusqu’au 27 mars. Dernier délai à ne pas manquer. Passé cette date, aucune demande ne sera acceptée. #anps #WorldCup2026	#WorldCup2026	1
450	2026-03-24 10:59:39+00	Emiliano Martínez’s last-minute save against French striker Randal Kolo Muani in the Qatar World Cup final likely secured the title for Argentina. #worldcup #worldcup2026 #worldcupfinal #worldcupchampions #soccer #futbol #championsleague	#WorldCup2026	1
451	2026-03-24 10:59:39+00	@ScotlandNT #HarveyBarnes #WorldCup2026	#WorldCup2026	1
452	2026-03-24 10:59:41+00	This team can easily win the world cup. Strongest Squad. England, France, Portugal and Brazil have Strongest teams going to America, Canada and Mexico. #worldcup2026. But eish!!! these warmongers want to spoil the beautiful game.	#WorldCup2026	1
453	2026-03-24 10:59:41+00	An important point to note on the England squad... Jude Bellingham is now clearly classified as a midfielder. No longer lined up in direct competition with Rogers, Palmer, Eze and Foden. This decision - classification - is not done without thought. #Tuchel #WorldCup2026	#WorldCup2026	1
454	2026-03-24 10:59:41+00	@TCL_Global @TCLArg en serio dejas de andar sin ningún motivo justo antes del mundial? #TCL #WorldCup2026 #Mundial2026	#WorldCup2026	1
455	2026-03-24 10:59:41+00	Could have been an English Lamine Yamal if given proper chances. Club & national coaches are hesitant to give that @NgumohaRio #threelions #worldcup2026	#WorldCup2026	1
456	2026-03-24 10:59:43+00	Lightning speed ! Skills like art ! Goals that rewrite history Kylian Mbappé — unstoppable! #KylianMbappe #Football #WorldCup2026 #Soccer #Goals #RealMadrid #Viral #FYP #SportsFans #Trending #8jjgroup	#WorldCup2026	1
457	2026-03-24 10:59:43+00	If you have tickets for the @FIFAWorldCup 2026: specific seats have already been assigned for some matches (presumably only in the fan sections). You can check the following link: https:// fwc26-refunds-mgmt.tickets.fifa.com/account/tickets #WorldCup2026 #FIFA #FIFAWorldCup	#WorldCup2026	1
458	2026-03-24 10:59:43+00	This is not a "geopolitical conflict." It is a brutal crime committed by two deranged individuals, Trump and Netanyahu. It is a massacre of civilians. #FIFA #worldcup2026	#WorldCup2026	1
459	2026-03-24 10:59:43+00	Kwasi Nyantakyi shows support Former meets present as Kurt Edwin Simeon-Okraku receives a goodwill visit ahead of Ghana’s 2026 World Cup journey #BlackStars #GFA #WorldCup2026	#WorldCup2026	1
460	2026-03-24 10:59:43+00	Why is Argentina and Colombia World Cup away kits looking the same #worldcup2026	#WorldCup2026	1
461	2026-03-24 10:59:48+00	Plus que quelques mois avant la CDM 2026 ! Adidas et Puma lancent les premiers maillots des sélections partenaires #WorldCup2026 #Football #Adidas #Puma #KitReveal #Foot	#WorldCup2026	1
462	2026-03-24 10:59:48+00	Er det her en kommende VM-vinder? #worldcup2026 #England #vmdk	#WorldCup2026	1
463	2026-03-24 10:59:48+00	TVRISportsters masih ingat vuvuzela? https:// pialadunia.tvrinews.com/read/pd_fhpzgt mtjs/serba-serbi-piala-dunia-2010-dua-sisi-vuvuzela … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
464	2026-03-24 10:59:50+00	Argentina kit clean but Germany still elite Who's winning the kit battle? #WorldCup2026	#WorldCup2026	1
465	2026-03-24 10:59:50+00	ICYMI There are 87 days until New Zealand's opening #WorldCup2026 match - @braintreetownfc manager Steve Pitt has detailed how the latest team news for the #Iron will benefit defender Tommy Smith's hopes of being part of the squad this summer. https:// bbc.co.uk/sounds/play/p0 n7jq7q …	#WorldCup2026	1
466	2026-03-24 10:59:50+00	World Cup 2026 Trends: Why Custom Wristbands Are a Must-Have Product for Sellers Low cost, high demand, easy to customize—wristbands are a fan favorite during global events. Are you adding them to your lineup? https:// hqfulfillment.com/cms/index/news d.html?id=145 … #WorldCup2026 #Dropshipping	#WorldCup2026	1
467	2026-03-24 10:59:50+00	World Cup 2026 is closer than you think - and there’s no better time to upgrade your setup. From laid-back evenings outdoors to full match-day hosting, our bespoke audio and visual compositions bring every moment to life right in your garden. #WorldCup2026 #SmartHome	#WorldCup2026	1
468	2026-03-24 10:59:52+00	A MUST for ALL #SCOTLAND #WORLDCUP2026 WELL DONE @Jgs_x	#WorldCup2026	1
469	2026-03-24 10:59:52+00	Black with sky blue magic This 2026 away kit is pure fire, Fileteado vibes + Trefoil classic! Argentina looking unstoppable #WorldCup2026 #Albiceleste	#WorldCup2026	1
470	2026-03-24 10:59:52+00	Begini cara Lionel Messi capai gol ke-900 #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira https:// pialadunia.tvrinews.com/read/pd_ri13bi gclj/lionel-messi-900-gol-persebaran-dan-cara-la-pulga-meraihnya …	#WorldCup2026	1
505	2026-03-24 11:00:20+00	World Cup Tour | Switzerland Exploring Switzerland Till I Drop The Ball . @Twitch | Saintjidz . #switzerland #worldcup2026 #football	#WorldCup2026	1
471	2026-03-24 10:59:52+00	FIFA DECISION: Iran WILL Play in USA? Despite tensions, FIFA has not changed the schedule — But here’s the twist… Iran says they may boycott games in the U.S. and want matches moved. : https:// fifaworldcupnews.com/fifas-final-de cision-iran-2026-world-cup/ … #WorldCup2026 #FIFAWorldCup #Iran #USA #Soccer	#WorldCup2026	1
472	2026-03-24 10:59:54+00	24 Jersey Tandang Buatan Adidas untuk Piala Dunia 2026, Ada Timnas Italia hingga Jerman https:// kaltim.tribunnews.com/superball/1141 540/24-jersey-tandang-buatan-adidas-untuk-piala-dunia-2026-ada-timnas-italia-hingga-jerman … lewat @tribunnews #jersey #adidas #worldcup2026 #pialadunia	#WorldCup2026	1
473	2026-03-24 10:59:54+00	Win a trip to the FIFA World Cup 2026 Final! Be part of the biggest match in the world. #WorldCup2026 #WinTrip #SoccerGiveaway #FIFA #Sweepstakes Enter here:	#WorldCup2026	1
474	2026-03-24 10:59:54+00	Meski belum jelas, Timnas Iran melanjutkan persiapan Piala Dunia https:// pialadunia.tvrinews.com/read/pd_5vrfiq jfio/timnas-iran-melanjutkan-persiapan-menuju-piala-dunia-2026 … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
475	2026-03-24 10:59:56+00	Michael Hartono Wafat, Como Mampu Pasok Pemain Kelas Piala Dunia #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira https:// pialadunia.tvrinews.com/read/pd_quomu8 b82z/michael-hartono-wafat-como-mampu-pasok-pemain-kelas-piala-dunia …	#WorldCup2026	1
476	2026-03-24 10:59:56+00	The Scotland World Cup 2026 away kit is out - and it's a real conversation starter #WorldCup2026	#WorldCup2026	1
477	2026-03-24 10:59:56+00	http:// Fifa.sale FIFA Tickets 2026 Internal Special-Price #FIFA #Worldcup2026 #tickets • Uruguay vs Spain — Estadio BBVA, Guadalajara • Egypt vs Iran — SoFi Stadium, Los Angeles • New Zealand vs Belgium — BC Place, Vancouver	#WorldCup2026	1
478	2026-03-24 10:59:56+00	The Mexico World Cup 2026 away kit is out - and it's absolutely stunning #WorldCup2026	#WorldCup2026	1
479	2026-03-24 10:59:58+00	Get ready for the 2026 World Cup New era, new designs, same passion for the game. Every jersey tells a story — which one will you wear? Drop your favorite team below #WorldCup2026 #Football #Soccer #NewJersey #FootballFans #GameDay	#WorldCup2026	1
480	2026-03-24 10:59:58+00	The Japan World Cup 2026 away kit is out - and it's a contender for kit of the year #WorldCup2026	#WorldCup2026	1
481	2026-03-24 11:00:03+00	Argentina just dropped their FIFA World Cup away kits	#WorldCup2026	1
482	2026-03-24 11:00:03+00	The Germany World Cup 2026 away kit is out - and the FINAL ever Adidas release is a triumph #WorldCup2026	#WorldCup2026	1
483	2026-03-24 11:00:03+00	NEW: ADIDAS OFFICIALLY PRESENTS MEXICO’S NEW AWAY JERSEY FOR THE 2026 WORLD CUP! Thoughts?	#WorldCup2026	1
484	2026-03-24 11:00:05+00	The Spain World Cup 2026 away kit is out - and it's their best change strip EVER #WorldCup2026	#WorldCup2026	1
485	2026-03-24 11:00:05+00	The Argentina World Cup 2026 away kit is out - and it's an artistic MASTERPIECE #WorldCup2026	#WorldCup2026	1
486	2026-03-24 11:00:05+00	Bagaimana pun, FIFA harus memberi rasa aman untuk semua peserta. Semoga Piala Dunia 2026 bisa membantu perdamaian meski dalam skala kecil ya, TVRISportsters… #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
487	2026-03-24 11:00:07+00	NEWS UPDATE: World Cup 2026 kits dropping left & right! USMNT Stars & Stripes home/away just unveiled , Canada/Mexico too. Adidas away kits (Argentina, Germany, Spain) hitting today/tomorrow. Hosts looking sharp! Who's got the best? Can't wait for June! #WorldCup2026	#WorldCup2026	1
488	2026-03-24 11:00:07+00	OFFICIAL: Germany unveil their new away kit for the World Cup . Since Nigeria didn’t qualify, I’m rolling with Germany this time… and I’m definitely grabbing one of these Clean kit. #worldcup2026	#WorldCup2026	1
489	2026-03-24 11:00:09+00	http:// Fifa.sale FIFA Tickets 2026 Internal Special-Price #FIFA #Worldcup2026 #tickets	#WorldCup2026	1
490	2026-03-24 11:00:09+00	They released World Cup Prizm 2026 news earlier this week... My god, we are going to have to throw it back one time? Right? #sportscards #panini #worldcup2026	#WorldCup2026	1
491	2026-03-24 11:00:09+00	NOUVEAU MAILLOT ! Le nouveau maillot concept du Japon en version joueur est disponible sur le site ! : 29,99€ : 5-10 jours ! : -10% avec le code « 2k26 » ! https:// elite-fanstore.com/products/maill ot-japon-y-3-version-joueur-coupe-du-monde-2026 … #SamuraiBlue #JFA #WorldCup2026 #Japan #WC2026	#WorldCup2026	1
492	2026-03-24 11:00:11+00	Toughest? Groups with France+Senegal+Norway, Argentina+strong sides, or Brazil+Morocco.Who do you think has the easiest ride to the knockouts? Drop your pick! #WorldCup2026 #EasiestGroup #FIFAWorldCup #USA2026	#WorldCup2026	1
493	2026-03-24 11:00:11+00	@SAFA_net reveals the away kit for the #Worldcup2026 @Balltime_ @BafanaBafana @adidasZA	#WorldCup2026	1
494	2026-03-24 11:00:11+00	http:// fifa.sale FIFA Tickets 2026 Internal Special-Price #FIFA #Worldcup2026 #tickets	#WorldCup2026	1
495	2026-03-24 11:00:13+00	#SautiYaMnyongeSenegal should keep the AFCON Trophy in their military barracks, and when CAF & FIFA threaten with a ban, other African team should stand with Senegal, pull out of all tournaments including #WorldCup2026 Football is won on the pitch! #Brekko	#WorldCup2026	1
496	2026-03-24 11:00:13+00	@DFB_Team have released their away @FIFAWorldCup kit. @adidasfootball A little Schalke touch as they have gone with blue. What does everyone think? #DFBTeam #Worldcup2026	#WorldCup2026	1
497	2026-03-24 11:00:15+00	Spain new away jersey #spain #lamineyamal #worldcup2026	#WorldCup2026	1
498	2026-03-24 11:00:16+00	‘#FIFA can’t solve geopolitical conflicts’: President Infantino rules out changes in #WorldCup2026 schedule #IranWar‌	#WorldCup2026	1
499	2026-03-24 11:00:16+00	TROPI PIALA DUNIA Napoleon Oceanus https:// s.shopee.co.id/8phBn7EsLq #worldcup #worldcup2026 #julesrimet #soccer #football #napoleonparfum #napoleonoceanus	#WorldCup2026	1
500	2026-03-24 11:00:16+00	FIFA President Gianni Infantino confirmed that the World Cup in Mexico, the USA, and Canada will proceed as scheduled, with all teams participating despite concerns over Iran's involvement due to geopolitical tensions. To read more: https:// hindustantimes.com/sports/footbal l/fifa-president-gianni-infantino-breaks-silence-on-whether-irans-world-cup-matches-will-be-shifted-from-the-us-101773967888240.html … #FIFA #WorldCup2026	#WorldCup2026	1
501	2026-03-24 11:00:16+00	Tak semua orang bisa takbiran di rumah… Termasuk Hugo Ekitike Di saat banyak orang kumpul bareng keluarga, dia justru harus terbang ke kandang lawan untuk menghadapi Brighton & Hove Albion. #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
502	2026-03-24 11:00:16+00	We’re 83 days away from the World Cup. #WorldCup2026	#WorldCup2026	1
503	2026-03-24 11:00:16+00	#fifa #worldcup2026	#WorldCup2026	1
504	2026-03-24 11:00:20+00	The best World Cup experiences don’t happen inside the stadium. They happen in the city. Mexico is going to prove that. http:// gonativecity.com #WorldCup2026 #MexicoCity	#WorldCup2026	1
507	2026-03-24 11:00:23+00	I'm glad he finally saw the light. Let Rele show the world his brilliance. #SAconquerWorld #BafanaBafana #WorldCup2026	#WorldCup2026	1
508	2026-03-24 11:00:23+00	‘𝗥𝗘𝗟𝗘 𝗜𝗦 𝗡𝗢𝗧 𝗔 𝗪𝗜𝗡𝗚𝗘𝗥’ Bafana Bafana coach Hugo Broos says Relebohile Mofokeng does “not have the qualities to be a good winger” but can help the national team in the no.10 role.	#WorldCup2026	1
509	2026-03-24 11:00:23+00	USA Home Jersey – World Cup 2026 is live at gogoalshop Clean look. Elite comfort. Built for game day. Limited stock — don’t miss out #USMNT #USAJersey #WorldCup2026 #SoccerJersey #gogoalshop #WC2026	#WorldCup2026	1
510	2026-03-24 11:00:23+00	Have we given this monstrosity a name yet? #Worldcup2026	#WorldCup2026	1
511	2026-03-24 11:00:25+00	FIFA World Cup 2026 is predicted to drive $10.5 billion surge in ad spend but ad impact diminishes amid a shifting media landscape #FIFA #WorldCup2026	#WorldCup2026	1
512	2026-03-24 11:00:25+00	Copa America 2028 Host Battle! The USA wants to host again… but it’s not alone. Ecuador (next in rotation) Argentina (with partners) United States (strong favorite) Who should get it? https:// fifaworldcupnews.com/2028-copa-amer ica/ … #CopaAmerica #WorldCup2026 #Soccer	#WorldCup2026	1
513	2026-03-24 11:00:25+00	What used to be a leak from @uber and @lyft is like an official day time new normal in the #WorldCup2026 host BC Canada Restricting drivers to exploit and deducting huge amount from their pay in addition to the low paid trips	#WorldCup2026	1
514	2026-03-24 11:00:25+00	MAFYA SYLE @Uber_Canada and @lyft Canada Inc. is no different Uber Leak EXPOSES Mafia Style Corruption https:// youtu.be/Q5kwvCZ26cA?si =JudE26tsTwIEqYUe … via @YouTube	#WorldCup2026	1
515	2026-03-24 11:00:27+00	Momen penuh respek Ronaldo berterima kasih kepada Bruno setelah assist indah yang berujung gol. Chemistry mereka benar-benar luar biasa! #Dewacash #PialaDunia2026 #WorldCup2026 #FIFAWorldCup2026 #WC2026 #RoadTo2026 #GarudaMendunia	#WorldCup2026	1
516	2026-03-24 11:00:27+00	The Decatur Ripple Effect: A $142 Million World Cup Windfall Decatur projects a $142M economic impact from the 2026 World Cup! Get the details on WatchFest '26, featuring Big Boi and the Indigo Girls. #Decatur #WorldCup2026 #WatchFest26 #AtlantaSoccerNews	#WorldCup2026	1
517	2026-03-24 11:00:27+00	Portugal unveil away jersey for World Cup 2026 #portugal #selecao #worldcup2026	#WorldCup2026	1
518	2026-03-24 11:00:27+00	Das raízes marítimas ao Sonho Mundial: #VaiDarPortugal @pumafootball	#WorldCup2026	1
519	2026-03-24 11:00:27+00	GOAL!!! Which country are you supporting in 2026? Feel the energy #Worldcup2026 #soccer #Football GOAL!!! World Cup 2026 ENERGY – Feel this? #shorts https:// youtu.be/F7GUj0pKcJI?si =8prmALXpzp_EX60B … via @YouTube	#WorldCup2026	1
520	2026-03-24 11:00:32+00	OCTAVOS VUELTA RESULTADOS UEFA CHAMPIONS LEAGUE #worldcup2026 #fifa #championsleague #futbol	#WorldCup2026	1
521	2026-03-24 11:00:32+00	¿En serio este tronco va a ser el portero titular de @miseleccionmx para la copa del mundo? #WorldCup2026 #Fifa	#WorldCup2026	1
522	2026-03-24 11:00:32+00	The 2026 World Cup is coming and the U.S. Embassy is already making moves! Media training now = world-class coverage later. Who else is counting down the days?! #FIFA2026 #WorldCup2026	#WorldCup2026	1
523	2026-03-24 11:00:32+00	It’s the summer we’re all waiting for and in 84 days time we’re finally getting the greatest football competition in the world. The #WorldCup2026 is on the way and millions of eyes will be glued on the Mexico/South Africa game. For the love of the game @FIFAWorldCup	#WorldCup2026	1
524	2026-03-24 11:00:34+00	Sports • USMNT's Striker Lineup: A Game-Changer for the World Cup? #Usmnt #Worldcup2026 #Soccer #Sports	#WorldCup2026	1
525	2026-03-24 11:00:34+00	Chaos in football: World Cup 2026 build-up heats up as FIFA navigates security tensions, playoff drama, and major global ticket demand. 48 teams, massive stakes—this tournament is shaping up to be the biggest ever. #FIFA #WorldCup2026	#WorldCup2026	1
526	2026-03-24 11:00:34+00	Sports • Tuchel's Tough Choices: England's World Cup Number 10 Dilemma #Worldcup2026 #Englandfootball #Tucheltactics #Number10battle	#WorldCup2026	1
527	2026-03-24 11:00:34+00	MEXICO CITY LAUNCHES #XOLI A TOURISM CHATBOT FOR WORLD CUP 2026 #FIFA2026 #WORLDCUP2026	#WorldCup2026	1
528	2026-03-24 11:00:34+00	| CDMX LANZA “XOLI”, CHATBOT TURÍSTICO PARA EL MUNDIAL 2026 La jefa de Gobierno, Clara Brugada, @ClaraBrugadaM presentó “Xoli”, el chatbot oficial de la Ciudad de México rumbo al Mundial 2026, disponible 24/7 en español e inglés vía WhatsApp y web. La herramienta permitirá	#WorldCup2026	1
529	2026-03-24 11:00:38+00	FIFA inzistira na planiranom domaćinstvu, dok Mehdi Taj traži rješenje za utakmice Irana izvan SAD-a #FIFA #WorldCup2026 #GianniInfantino #MehdiTaj	#WorldCup2026	1
530	2026-03-24 11:00:38+00	L’Ambassadeur explique que son soutien aux éléphants a ses limites #Football #WorldCup2026 #UKinCIV	#WorldCup2026	1
531	2026-03-24 11:00:38+00	3-0 Y AL MUNDIAL DE ALEMANIA #SelFEM @BaloncestoESP #WorldCup2026 https:// lokosxelbaloncestofemenino.com/index.php/sele cciones/senior/20515-3-0-y-al-mundial-de-alemania … vía @BaloncestoESP	#WorldCup2026	1
532	2026-03-24 11:00:38+00	𝗡𝗢 𝗥𝗢𝗢𝗠 𝗙𝗢𝗥 𝗥𝗔𝗬𝗡𝗘𝗥𝗦 𝗜𝗡 𝗕𝗔𝗙𝗔𝗡𝗔 𝗕𝗔𝗙𝗔𝗡𝗔! Hugo Broos has revealed South Africa’s final squad for 2026 FIFA World Cup preps, & Iqraam Rayners has been left out again. #WorldCup2026 #AFCON2025 #Football More Details	#WorldCup2026	1
533	2026-03-24 11:00:40+00	Your hotel can shine on a global stage during the 2026 World Cup Partner with us to access training and tools that elevate the guest experience and attract repeat visitors at http:// info.ahlei.org/soccer. #WorldCup2026 #HospitalityReady #HotelExcellence#AHLEI	#WorldCup2026	1
534	2026-03-24 11:00:40+00	POLL: Who wins World Cup 2026? Brazil France Argentina Germany Reply with your pick! 83 days! Earn free KICK points on WC26 Fantasy: https:// t.me/wc26viral_bot @goal #WorldCup2026	#WorldCup2026	1
535	2026-03-24 11:00:40+00	According to #WARCMedia, the 2026 FIFA World Cup will generate $10.5 billion in advertising revenue But in a fragmented ecosystem, the key is to connect before, during, and after the match #Marketing #WorldCup2026 #Strategy	#WorldCup2026	1
536	2026-03-24 11:00:40+00	Boycott #FIFA Boycott #Infantino Boycott #worldcup2026 Boycott #israel	#WorldCup2026	1
537	2026-03-24 11:00:40+00	NEW: FIFA rejects calls to ban Israel: "Should take no action given that, in the context of the interpretation of the relevant provisions of the FIFA Statutes, the final legal status of the West Bank remains an unresolved & highly complex matter under public international law"	#WorldCup2026	1
538	2026-03-24 11:00:40+00	FIFA President Infantino expects Iran’s national team to participate in the 2026 World Cup, — media reports. #Iran #FIFA #WorldCup2026	#WorldCup2026	1
596	2026-03-24 11:01:20+00	FIFA x YouTube partnerschap aangekondigd voor het WK 2026! Volledige streams van geselecteerde wedstrijden en toegang tot "elke hoek" voor creators. #WorldCup2026 #FIFA #YouTube #SoccerNews	#WorldCup2026	1
539	2026-03-24 11:00:45+00	“Wisdom that Sticks” (#67) is inspired by a Wisdom Tool in Cultivating Love: Wisdom for Life by Dr. Ken McGill https:// amazon.com/Cultivating-Lo ve-Dr-Ken-McGill-ebook/dp/B0G1V7R3YZ?ref_=ast_author_mpb … #WorldCup #FIFAWorldCup #WorldCup2026 #WorldCupFootball #RoadToWorldCup #WorldCupFinal #WorldCupQualifiers #WorldCupGoals #WorldCupMatch	#WorldCup2026	1
540	2026-03-24 11:00:45+00	Canadá revela novos equipamentos para o Mundial 2026 --- Canada unveils bold 2026 World Cup kits #CanadaSoccer #WorldCup2026 #Soccer #Canada #Football #Toronto #Vancouver #CanadaSoccer #Mundial2026 #Futebol #Canadá #WorldCup #Soccer	#WorldCup2026	1
541	2026-03-24 11:00:45+00	GOAL! MAVITTO – World Cup 2026 Song | Football Anthem (Soccer) https:// youtu.be/rYgGoa6CYL4?si =FcnLXP5as7su0-mf … via @YouTube Use this sound for your GOAL World Cup 2026 energy starts here. GOAL! – MAVITTO #WorldCup2026 #Footballworldcup #GOAL #Viral	#WorldCup2026	1
542	2026-03-24 11:00:45+00	Bangladesh ki Shame on team TMC #worldcup2026	#WorldCup2026	1
543	2026-03-24 11:00:47+00	In a major shift for the upcoming tournament, Iran is officially exploring options to move its group stage matches to North American host cities. https:// nextclicknews.com/2026/03/19/ira n-seeks-to-relocate-2026-world-cup-group-matches-to-north-american-host-cities/ … #WorldCup2026 #FIFA #IranFootball #SoccerNews #NextClickNews #SportsUpdate	#WorldCup2026	1
544	2026-03-24 11:00:47+00	LET’s GO WATCH THE #BLACKSTARS LIVE at the WORLD CUP #worldcup2026 Dial * 899 # to enter the DRAW!!! Imagine us all watching the game we love FEEELI FEEELI with everything paid for with as little as 10GHC.	#WorldCup2026	1
545	2026-03-24 11:00:47+00	Breakings ; Beautiful Barcelona fan and a Ghanaian influence @theberneese joins the U.S Embassy 2026 World Cup Media Training #trendingtopic #worldcup2026 #virałpost	#WorldCup2026	1
546	2026-03-24 11:00:49+00	PREPPING FOR THE WORLD STAGE! ​The @CANMNT roster is locked in for a massive double-header! Facing the grit of Iceland and the flair of Tunisia is the perfect blueprint to get ready for 2026. ​From Toronto to the world, the journey continues. ​#CANMNT #WorldCup2026	#WorldCup2026	1
547	2026-03-24 11:00:49+00	Pripremaju se u Turskoj #Iran #WorldCup2026	#WorldCup2026	1
548	2026-03-24 11:00:49+00	Landon Donovan is trending again with his new memoir and World Cup 2026 insights From family life to honest personal stories. #LandonDonovan #USMNT #WorldCup2026 #Soccer #Football #SportsNews #TrendingNow #Memoir	#WorldCup2026	1
549	2026-03-24 11:00:49+00	World Cup 2026 is coming. Who’s winning it? #WorldCup2026	#WorldCup2026	1
550	2026-03-24 11:00:51+00	Nominácia Slovenska na baráž o postup na MS 2026. V #repreSR je späť aj Martin Valjent! #WorldCup2026	#WorldCup2026	1
551	2026-03-24 11:00:51+00	#Imperdible Puebla es sede del World Trophy Tour 2026, una experiencia inmersiva que permite a los aficionados del fútbol vivir de cerca la emoción de la Copa del Mundo. #Puebla #WorldCup2026 #Fútbol	#WorldCup2026	1
552	2026-03-24 11:00:51+00	Atílio Demaría é, ao lado de Luis Monti, o único jogador a estar presentes nas finais da Copa de 1930 e de 1934, por duas seleções. Diferentemente do conterrâneo, Demaría não jogou nenhuma das finais, e tem apenas dois jogos em Copas. #fifaworldcup #worldcup2026	#WorldCup2026	1
553	2026-03-24 11:00:53+00	#WorldCup2026 Group L teams & kits Predicted final standings: GERMANY CROATIA NIGERIA JAMAICA #subbuteo	#WorldCup2026	1
554	2026-03-24 11:00:53+00	Turn the stadium into your personal showroom with embroidered fan shirts that look just as good on a social media feed as they do in the stands. #WorldCup2026 #SportswearFactory #BrandMarketing #CustomApparel #WalkingBillboard #SoccerJersey #FootballJersey #Fanshirt	#WorldCup2026	1
555	2026-03-24 11:00:53+00	GOOOOAL: @DiegoGutierrez joins ⁦ @fox4kc ⁩ ⁦ @FIFAWorldCup ⁩ coverage! #WorldCup2026	#WorldCup2026	1
556	2026-03-24 11:00:53+00	Yuvi Ka Magic Touch #Abhishek #Sharma #WorldCup2026	#WorldCup2026	1
557	2026-03-24 11:00:55+00	Didier Deschamps vient de communiquer sa liste de 26 joueurs convoqués pour les deux prochains matchs amicaux de l'équipe de France en vue de la Coupe du monde 2026. Pas de Gorby Jean-Baptiste, ni d'Odsonne Edouard ! #FFF #Worldcup2026	#WorldCup2026	1
558	2026-03-24 11:00:55+00	Israel just targeted RT journalist Steve Sweeney and his crew while doing their jobs in Southern Lebanon. USA shouldn’t host the #WorldCup2026	#WorldCup2026	1
559	2026-03-24 11:00:55+00	Stinker and hooked!!! That World Cup changed lives, man!!! #WorldCup2026	#WorldCup2026	1
560	2026-03-24 11:00:55+00	𝗡𝗘𝗪: Wayne Rooney: "You are not getting a WORSE World Cup than South Africa in 2010. That tournament NEVER felt like a World Cup." — @WeAreTheOverlap	#WorldCup2026	1
561	2026-03-24 11:00:58+00	Sudah lama tak memperkuat Timnas Swedia, Zlatan Ibrahimovic akan kembali ke Piala Dunia 2026 sebagai analis pertandingan di televisi. Pemain arogan kayak dia bakal jago menganalisis pertandingan nggak ya? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
562	2026-03-24 11:00:58+00	77/365 85 days to the World Cup #Fifaworldcup #worldcup2026 Psalms 89:41	#WorldCup2026	1
563	2026-03-24 11:00:58+00	GR8 Tech Unveils Major Platform Enhancements Ahead of the World Cup http:// dlvr.it/TRZqK1 #WorldCup2026 #SportsTech #BettingTrends #CryptoGaming #OperatorPerformance	#WorldCup2026	1
564	2026-03-24 11:00:58+00	DEWABET: Terbukti Terpercaya, Terpilih Jadi yang Terbaik! https:// hopp.bio/togeldewabet #worldcup2026 #pialadunia2026 #dewabet #mexico #Canada #timnasindonesia #indonesia	#WorldCup2026	1
565	2026-03-24 11:01:01+00	| إيران ستشارك في كأس العالم 2026 لكنها تطلب نقل مبارياتها من الولايات المتحدة إلى المكسيك لأسباب أمنية، دون موافقة الفيفا حتى الآن. #WorldCup2026 #Iran #FIFA #USA #Mexico	#WorldCup2026	1
566	2026-03-24 11:01:03+00	Iran to compete in 2026 World Cup but seeks to move US matches to Mexico over security concerns. Officials ask FIFA to relocate group games scheduled in America. Follow for updates. #Iran #WorldCup2026	#WorldCup2026	1
567	2026-03-24 11:01:03+00	Iran will continue preparations for the FIFA World Cup 2026 but will not play matches in the United States, with officials negotiating to shift games to another host country due to ongoing tensions. #IranFootball #WorldCup2026 #FootballNews #FIFA	#WorldCup2026	1
568	2026-03-24 11:01:03+00	LISTEN @braintreetownfc manager Steve Pitt has detailed how the latest team news for the #Iron will benefit defender Tommy Smith's hopes of being part of New Zealand's #WorldCup2026 squad this summer & has hinted at a new arrival. https:// bbc.co.uk/sounds/play/p0 n7jq7q …	#WorldCup2026	1
569	2026-03-24 11:01:03+00	India's first 400+ runs in ODI #ODI #SachinTendulkar #WorldCup2026 #CricketGuru	#WorldCup2026	1
597	2026-03-24 11:01:20+00	FIFA x YouTube Partnerschaft für die WM 2026 angekündigt! Komplette Livestreams ausgewählter Spiele und Zugriff auf „jeden Winkel“ für Content Creator. #WorldCup2026 #FIFA #YouTube #SoccerNews	#WorldCup2026	1
570	2026-03-24 11:01:05+00	ईरान के 'फीफा वर्ल्ड कप 2026' में खेलने पर गहराया संकट, मैच शिफ्ट करने पर बातचीत https:// deshbandhump.com/post/crisis-de epens-over-iran-playing-in-fifa-world-cup-2026-talks-on-shifting-the-match … #FIFAWorldCup2026 #WorldCup2026 #FootballNews #TeamMelli #IranFootball #FIFA #SoccerUpdates #RoadTo2026 @FIFAWorldCup	#WorldCup2026	1
571	2026-03-24 11:01:05+00	FIFA secara mengejutkan memangkas anggaran operasional Piala Dunia 2026 lebih dari 100 juta dolar AS. Kebijakan efisiensi ini mulai memengaruhi persiapan turnamen di kawasan Amerika Utara. #FIFAWorldCup26 #WorldCup2026 #FIFAWorldCup26	#WorldCup2026	1
572	2026-03-24 11:01:05+00	Free rewards for football fans! 83 days to #WorldCup2026 WC26 Fantasy on Telegram: Free KICK points daily Football quiz + penalty game 500 KICK welcome bonus KICK points → WC26 token! @AirdropAlert @Web3Daily https:// t.me/wc26viral_bot #WC2026 #Crypto	#WorldCup2026	1
573	2026-03-24 11:01:07+00	Selain Neymar, ada Richarlison yang juga tidak dibawa Carlo Ancelotti. Semangat pemulihan dan upgrade performa ya, Bang Neymar. TVRISportsters, punya gambaran formasi lini depan Brasil agar tetap gacor? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
574	2026-03-24 11:01:07+00	विश्व कप की तैयारियों पर फुल्टन ने कहा, विस्तृत रणनीति के साथ तैयार रहेंगे #FocusNews #SportsNews #WorldCup2026 #FultonStrategy #SportsPreparation #TeamReadiness #GamePlan #WinningMindset #AthleteFocus #ChampionshipGoals	#WorldCup2026	1
575	2026-03-24 11:01:07+00	Game Day Sod® for the 2026 FIFA World Cup! : @nerevolution #2026worldcup #fifaworldcup #worldcup2026 #gamedaysod	#WorldCup2026	1
576	2026-03-24 11:01:10+00	#WorldCup2026 Group K teams & kits Predicted final standings: PORTUGAL JAPAN PARAGUAY ANGOLA #subbuteo	#WorldCup2026	1
577	2026-03-24 11:01:10+00	Nigeria anxiously awaits FIFA’s decision on its World Cup 2026 petition, a verdict that could shape qualification hopes and redefine its campaign amid growing anticipation from fans and stakeholders nationwide. Follow @GuardianNigeria for more updates #WorldCup2026	#WorldCup2026	1
578	2026-03-24 11:01:10+00	Iran might be sending a "spy team" to the World Cup in the USA. This is getting very interesting! #WorldCup2026 #FIFA #Iran	#WorldCup2026	1
579	2026-03-24 11:01:12+00	Soccer fans are notoriously horrible people. They're legitimately claiming that $625 million won't be enough to keep them under control. Any perceived economic benefit, is not worth it. Make them go somewhere else. #WorldCup2026	#WorldCup2026	1
580	2026-03-24 11:01:12+00	JUST IN: The USA released $625,000,000.00 in security funding to World Cup host cities. This is the least a country has spent on this since South Africa in 2010. (No estimates on 2018 Russia)	#WorldCup2026	1
581	2026-03-24 11:01:12+00	लग्नानंतर बायकोचा एक प्रश्न काळजाला भिडला, त्यानंतर सूर्यकुमार टीम इंडियाचा थेट कॅप्टन झाला; संपूर्ण प्रवास जाणून घ्या #SuryakumarYadav #teamindiavictory #WorldCup2026 #MarathiNews	#WorldCup2026	1
582	2026-03-24 11:01:12+00	Gabriel Sara, opsi bagus untuk lini tengah Brasil https:// pialadunia.tvrinews.com/read/pd_ic7kcy op7w/profil-gabriel-sara-opsi-brilian-untuk-lini-tengah-timnas-brasil … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
583	2026-03-24 11:01:14+00	2026 World Cup Squad Projections: Who makes the cut? We’re breaking down the locks and bubble players for the USMNT. The road to 2026 starts now. Subscribe: http:// sportsmedia.news Which young star do you think is a lock for the final roster? #WorldCup2026 #USMNT #Soccer	#WorldCup2026	1
584	2026-03-24 11:01:14+00	FIFA rejects Iran’s request to move World Cup 2026 matches from the US to Mexico. Matches will proceed as scheduled despite security concerns and boycott hints. #FIFA #WorldCup2026 #Iran #Football #ConnectedPakistan	#WorldCup2026	1
585	2026-03-24 11:01:14+00	BREAKING Iran will not withdraw from 2026 World Cup but plans to "boycott" matches in the US due to security concerns, negotiating with FIFA to move games to Mexico. Source: Al Jazeera #WorldCup2026 #PulseHub	#WorldCup2026	1
586	2026-03-24 11:01:14+00	YouTube and FIFA have formed a historic partnership to stream World Cup 2026! Fans can access 10-minute live match previews plus exclusive historic digital archival content for free across all mobile and smart devices. 19/03/2026 #WorldCup2026 #FIFA #YouTube #Football #Soccer	#WorldCup2026	1
587	2026-03-24 11:01:16+00	3 मैच में 0… और फाइनल में 52 रन! अभिषेक शर्मा का जबरदस्त comeback, टीम इंडिया को दिलाई जीत... #AbhishekSharma #TeamIndia #WorldCup2026 #Cricket #ComebackStory	#WorldCup2026	1
588	2026-03-24 11:01:16+00	Sports • Socceroos Unveil New Talent: Ante Suto Makes Squad for World Cup Warm-Ups #Socceroos #Antesuto #Worldcup2026 #Football	#WorldCup2026	1
589	2026-03-24 11:01:16+00	Win a trip to the FIFA World Cup 2026 Final! Be there for the biggest match in the world. #WorldCup2026 #WinTrip #SoccerGiveaway #FIFA #Sweepstakes Enter Here:	#WorldCup2026	1
590	2026-03-24 11:01:16+00	ブラジル代表はアンチェロッティ体制になって面白くなっています W杯2026の優勝候補の一つです https:// trepri.com/team-brazil-7- interesting-point/ … #WorldCup2026 #Brazil	#WorldCup2026	1
591	2026-03-24 11:01:18+00	Despite missing some big names, this Japan squad is filled with experience, adding to the speed, energy and technical skill that has them as contenders for the #WorldCup2026 this summer. Both Scotland and England will face a tough test when they play the #SamuraiBlue this month.	#WorldCup2026	1
592	2026-03-24 11:01:18+00	𝗦𝗔𝗠𝗨𝗥𝗔𝗜 𝗕𝗟𝗨𝗘 メンバー発表 キリンワールドチャレンジ2026 スコットランド代表 イングランド代表 𝗚𝗞 早川友基 鹿島アントラーズ 大迫敬介 サンフレッチェ広島 鈴木彩艶 パルマ・カルチョ 𝗗𝗙 谷口彰悟 シントトロイデンVV 渡辺剛 フェイエノールト	#WorldCup2026	1
593	2026-03-24 11:01:18+00	Senegal dapat kabar mengecewakan jelang @FIFAWorldCup 2026 https:// pialadunia.tvrinews.com/read/pd_gsytph wdtz/timnas-senegal-dapat-kabar-buruk-jelang-piala-dunia-2026 … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
594	2026-03-24 11:01:18+00	Annonce d'un partenariat FIFA x YouTube pour la Coupe du Monde 2026 ! Diffusion intégrale de certains matchs et accès à « tous les angles » pour les créateurs de contenu. #WorldCup2026 #FIFA #YouTube #SoccerNews	#WorldCup2026	1
595	2026-03-24 11:01:20+00	FIFA x YouTube partnership announced for the 2026 World Cup! Full match streams for select games and "every angle" access for creators. #WorldCup2026 #FIFA #YouTube #SoccerNews	#WorldCup2026	1
1112	2026-03-24 15:22:23+00	the duration of the film spider-man brand new day will be 3 hours and 20 minutes. #spiderman	#Spiderman	0
598	2026-03-24 11:01:20+00	FIFA partners with @YouTube as a preferred platform for the FIFA World Cup 2026, expanding digital coverage with creator-led content and wider access for global fans. More here: https:// afaqs.com/news/digital/f ifa-partners-with-youtube-for-2026-world-cup-11226930?utm_source=TwitterCompanyPage&utm_medium=TwitterCompanyPage … #SportsMarketing #FIFA #WorldCup2026 #YouTube #DigitalMedia #CreatorEconomy	#WorldCup2026	1
599	2026-03-24 11:01:23+00	#RonOlDo pulls my fave play: #TheDummy #WorldCup2026;#WorldCup	#WorldCup2026	1
600	2026-03-24 11:01:23+00	The Iran national football team is pushing to shift its FIFA World Cup 2026 matches from the United States to Mexico over safety concerns amid rising tensions. Read more: https:// insightfultake.com/details/iran-s eeks-to-move-world-cup-matches-out-of-the-usa … #WorldCup2026 #Iran #FIFA #Football #Geopolitics #SportsNews	#WorldCup2026	1
601	2026-03-24 11:01:23+00	#VanDijk vs #HaaLand #WorldCup2026;#WorldCup	#WorldCup2026	1
602	2026-03-24 11:01:23+00	#Messi pulls my fave play: #TheDummy #WorldCup2026;#WorldCup	#WorldCup2026	1
603	2026-03-24 11:01:23+00	#FIFA #worldcup2026 公式グッズ登場 #クラッチ #ザユ #メープル の公式マスコットミニフィギュア3個セットになります！ #サッカー #ワールドカップ #日本代表 #サムライブルー #森保ジャパン https:// item.rakuten.co.jp/mundial/100054 76/ … https:// store.shopping.yahoo.co.jp/mundial/100054 76.html …	#WorldCup2026	1
604	2026-03-24 11:01:25+00	#RobertoCarlos #WorldCup2026;#WorldCup	#WorldCup2026	1
605	2026-03-24 11:01:25+00	Boldly predict who do you think will be the champion of the 2026 World Cup? #WorldCup2026 #FIFAWorldCup #WorldCup	#WorldCup2026	1
606	2026-03-24 11:01:25+00	Rekor ini udah aman… lebih dari 60 tahun Cuma Italia & Brasil yang pernah back to back juara Piala Dunia Sejak 1962? Nggak ada yang bisa nyentuh lagi Sekarang… Argentina di depan pintu #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira-	#WorldCup2026	1
607	2026-03-24 11:01:27+00	#Iran withdraws #WorldCup2026 boycott threat, but refuses to play in the USA	#WorldCup2026	1
608	2026-03-24 11:01:27+00	In view of the current situation, there is a perfect "unpopular dark horse" candidate: the Ukrainian team #WorldCup2026 #FIFAWorldCup #WorldCup	#WorldCup2026	1
609	2026-03-24 11:01:27+00	NOUVEAU MAILLOT ! Le nouveau maillot du Japon pour la coupe du monde 2026 est disponible sur le site ! : 29,99€ : 5-10 jours ! : -10% avec le code « 2k26 » ! https:// elite-fanstore.com/products/maill ot-japon-domicile-coupe-du-monde-2026 … #SamuraiBlue #JFA #WorldCup2026 #Japan #WC2026	#WorldCup2026	1
610	2026-03-24 11:01:29+00	TVRI akan menayangkan uji coba antara Brasil, Prancis, Kroasia, Skotlandia, Pantai Gading https:// pialadunia.tvrinews.com/read/pd_zzb69l akgj/cuma-di-tvri-mulai-akhir-maret-pemanasan-piala-dunia-2026-langsung-panas … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
611	2026-03-24 11:01:29+00	Pasukan kebangsaan Iran meneruskan persiapan bagi pusingan akhir Piala Dunia dan tidak berniat menarik diri daripada kejohanan itu walaupun mereka tidak akan ke Amerika Syarikat (AS), kata ketua bola sepak Mehdi Taj semalam. https:// flashsukan.com.my/kami-boikot-as -kami-tidak-boikot-piala-dunia-iran/ … #Iran #WorldCup2026	#WorldCup2026	1
612	2026-03-24 11:01:31+00	IrIran continue their World Cup preparations but uncertainty remains, as the federation confirms the team will not play matches in the United States amid ongoing political and security concerns. () #Iran #WorldCup2026 #Football #كأس_العالم #كرة_القدم https:// omanobserver.om/article/118639 7/sports/iran-continuing-world-cup-preparations-but-will-not-play-in-us-says-soccer-chief … via	#WorldCup2026	1
613	2026-03-24 11:01:31+00	#WorldCup;#WorldCup2026	#WorldCup2026	1
614	2026-03-24 11:01:31+00	India ready for the FIH Women's Hockey World Cup Campaign starts on 16th August vs China #FIHHockeyWorldcup #WorldCup2026 #HockeyIndia	#WorldCup2026	1
615	2026-03-24 11:01:33+00	Kesempatan yang ditunggu-tunggu… akhirnya datang juga Igor Thiago tiba-tiba masuk radar Timnas Brasil. Berkat performanya yang tajam dan konsisten musim ini, ia dilirik banyak orang #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
616	2026-03-24 11:01:33+00	FIFA MOTTO "Football Unites the World War" #WorldCup2026 #FIFAWorldCup26	#WorldCup2026	1
617	2026-03-24 11:01:33+00	वर्ल्ड कप जिंकताच पहाटेच्या गाडीने पत्नीसोबत मुंबई गाठणाऱ्या शिवम दुबेने सांगितलं कारण, Video समोर #WorldCup2026 #Marathinews #shivamdube	#WorldCup2026	1
618	2026-03-24 11:01:33+00	Neymar Left Out Of Brazil Squad; Star Admits Being "Sad And Upset" As Retirement Hints Grow https:// 8pmnews.com/neymar-admits- being-sad-and-upset-retire-hints-grow/ … #Neymar #Brasil #WorldCup2026 #Ancelotti #SantosFC #SeleçãoBrasileira #Football #LastDance	#WorldCup2026	1
619	2026-03-24 11:01:35+00	USA RELEASES $625M IN WORLD CUP SECURITY FUNDING DHS awards money to 11 host cities — the lowest amount since South Africa 2010. Less than 3 months until kickoff. Biggest sporting event in U.S. history gets final prep boost #WorldCup2026 #SecurityFunding	#WorldCup2026	1
620	2026-03-24 11:01:35+00	Everyone is planning for the stadium. Almost no one is planning for the city. That’s where the real World Cup experience happens. Discover Mexico beyond the stadium. http:// gonativecity.com #WorldCup2026 #MexicoCity	#WorldCup2026	1
621	2026-03-24 11:01:35+00	The World Cup is three months away. How to make money? What should I do to cross the rich and poor? I haven't thought of it yet... #WorldCup2026 #FIFA #FootballvsSoccer	#WorldCup2026	1
622	2026-03-24 11:01:37+00	#WorldCup Iran football chief Mehdi Taj confirms "Team Melli" will not withdraw from World Cup 2026 . Negotiations with FIFA are ongoing to move their group stage matches from USA to Mexico due to political conflict. #WorldCup2026 #Iran #FIFA #TeamMelli	#WorldCup2026	1
623	2026-03-24 11:01:37+00	What if you could plan World Cup 2026 tickets instead of battling last-minute queues? My take: @FIFACollect “Right to Tickets” (RTTs) make access limited + tradable on a marketplace. Would you hold an RTT or roll the dice? Reply below. #WorldCup2026	#WorldCup2026	1
624	2026-03-24 11:01:37+00	El maquillaje para ‘engalanar’ Tlalpan para el #mundialfifa2026 #Worldcup2026	#WorldCup2026	1
625	2026-03-24 11:01:37+00	Cuánto habrá costado la #ciclovía de #Tlalpan, primeras lluvias del año y así quedó el tramo de #Xotepingo, es una burla que se hagan obras de tan pésima calidad en la #CDMX por parte del @GobCDMX, los pocos ciclistas que la usan estarán en peligro, viva el #mundialfifa2026	#WorldCup2026	1
626	2026-03-24 11:01:40+00	Iran step back from World Cup boycott—but draw a hard line on USA Team Melli confirm participation in 2026, yet demand venue change amid rising tensions. #WorldCup2026 #Iran #FIFA #Football	#WorldCup2026	1
658	2026-03-24 11:02:02+00	After the AFCON decision, put yer money on the USA winning the 2026 World Cup .. once Trump realises it can be won in a courtroom #WorldCup2026	#WorldCup2026	1
627	2026-03-24 11:01:40+00	Uncertainty in Group B: Iran Negotiates to Move World Cup Matches to Mexico Iran is negotiating with FIFA to move its 2026 World Cup matches from the U.S. to Mexico due to security concerns. #WorldCup2026 #Iran #FIFA #SoccerNews #Mexico2026	#WorldCup2026	1
628	2026-03-24 11:01:40+00	USMNT Descends on Atlanta for High-Stakes World Cup Warm-ups USMNT head coach Mauricio Pochettino names 27-man roster for March friendlies in Atlanta vs. Belgium and Portugal. #USMNT #WorldCup2026 #AtlantaSoccerNews #Pochettino #SoccerNews	#WorldCup2026	1
629	2026-03-24 11:01:40+00	Breaking News la CAF a décidé d'attribuer la #worldcup2026 au USA avant même le début de la competition parce qu'Infentino l'a décidé #fifa	#WorldCup2026	1
630	2026-03-24 11:01:42+00	The World’s Game, Now on Your Screen: FIFA and YouTube Team Up for 2026 FIFA names YouTube a "Preferred Platform" for the 2026 World Cup! Get ready for live match previews. #WorldCup2026 #FIFA #YouTubeSoccer #AtlantaSoccerNews #SoccerHighlights	#WorldCup2026	1
631	2026-03-24 11:01:42+00	GOAT needs the rest for the summer. #WorldCup2026	#WorldCup2026	1
632	2026-03-24 11:01:42+00	@FIFAcom @FIFAWorldCup @fifacom_es #FifaWorldCup #WorldCup2026 @fifamedia @GianniInfantin3	#WorldCup2026	1
633	2026-03-24 11:01:42+00	Akhirnya terjadi juga! Güler mencetak gol spektakuler dari setengah lapangan — kiper cuma bisa terpaku lihat bola masuk! #Dewacash #PialaDunia2026 #WorldCup2026 #FIFAWorldCup2026 #WC2026 #RoadTo2026 #GarudaMendunia	#WorldCup2026	1
634	2026-03-24 11:01:45+00	I love our new home kit that resembles the iconic Where's Waldo kit only better. I do wish the away kit was a lighter navy but if the boys like it? Good for them. #USMNT #NIKE #WorldCup2026	#WorldCup2026	1
635	2026-03-24 11:01:45+00	USMNT and Bournemouth midfielder Tyler Adams revealed that the USMNT players told both U.S. Soccer and Nike that they wouldn’t partake in a photoshoot of the World Cup kit, unless they had some say in the design, following their disappointment in the 2022 World Cup kit “The	#WorldCup2026	1
636	2026-03-24 11:01:45+00	¡Justo a tiempo! Para acudir con una mejor posición a las mesas #TMEC y para estar preparados para #WorldCup2026 #MundialFutbol2026	#WorldCup2026	1
637	2026-03-24 11:01:45+00	#ALMOMENTO | Las y los diputados aprueban el dictamen que reforma, adiciona y deroga diversas disposiciones de la Ley Federal de Protección a la Propiedad Industrial. Consúltalo en: https:// gaceta.diputados.gob.mx/PDF/66/2026/ma r/20260318-IV.pdf …	#WorldCup2026	1
638	2026-03-24 11:01:45+00	Excited for #worldcup2026 @pulisic @usmnt #captainamerica Art by yours truly	#WorldCup2026	1
639	2026-03-24 11:01:47+00	#Worldcup2026 #Worldcup2030 #Worldcup2034 #Worldcup2038 #Worldcup2042 #Worldcup2046 #Worldcup2050 #fifa #football #soccer #worldcup #uefa #occupation	#WorldCup2026	1
640	2026-03-24 11:01:49+00	16 Cities. 48 Nations. 104 Matches. The countdown to June 11 is getting REAL. This isn’t just a tournament; it’s a takeover of North America. #FIFAWorldCup #WorldCup2026 #WeAre26 #Soccer #Futbol #RoadTo2026 #WorldCup	#WorldCup2026	1
641	2026-03-24 11:01:49+00	At this rate, there won't be enough fuel for aaaaaaaalllllllll those "fly-machines" that are meant to transport people to the #WorldCup2026 Angithi you lot didn't want to boycott? Iran is helping you to not be unethical fucknuggets, while also giving FIFA a big "fuck you"	#WorldCup2026	1
642	2026-03-24 11:01:49+00	It’s the summer we’re all waiting for and in 85 days time we’re finally getting the greatest football competition in the world. The #WorldCup2026 is on the way and millions of eyes will be glued on the Mexico/South Africa game. For the love of the game @FIFAWorldCup	#WorldCup2026	1
643	2026-03-24 11:01:49+00	エムバペに続く新世代のフランス https:// trepri.com/france-5-young -players/ … #WorldCup2026 #France #Mbappe #フランス #エムバペ	#WorldCup2026	1
644	2026-03-24 11:01:52+00	Portugal and CR7 are in. The rival is still a mystery… and Houston gets one of the weirdest games on the schedule #WorldCup2026 #Portugal #CristianoRonaldo	#WorldCup2026	1
645	2026-03-24 11:01:52+00	Kombinira elemente countryja, rocka i hip-hopa (VIDEO) #FIFA #WorldCup2026	#WorldCup2026	1
646	2026-03-24 11:01:52+00	Global football shaken as the Iran war puts the 2026 World Cup in doubt Iran’s officials say it’s “not possible” to participate due to safety concerns after U.S. strikes. #WorldCup2026 #Football #Breaking	#WorldCup2026	1
647	2026-03-24 11:01:52+00	Neymar’s World Cup dream in doubt after Ancelotti excludes him from Brazil’s final friendlies. A seismic shift for the Selecao. #WorldCup2026 #BrazilFootball	#WorldCup2026	1
648	2026-03-24 11:01:52+00	Neymar’s World Cup hopes fade as Ancelotti omits him from Brazil’s final friendlies. A seismic shift for the Selecao. #WorldCup2026 #Brazil	#WorldCup2026	1
649	2026-03-24 11:01:54+00	The World Cup is coming to North America! get your tickets so that you do not miss the biggest sports event of the year! #worldcup2026 #canada #mexico #northamerica	#WorldCup2026	1
650	2026-03-24 11:01:54+00	MEXICO OFFERS TO HOST IRAN’S WORLD CUP MATCHES President Claudia Sheinbaum: “Yes” — open to moving games from USA due to safety fears. Iran negotiating with FIFA right now. 2026 tournament twist amid the war #MexicoIran #WorldCup2026 #FIFA	#WorldCup2026	1
651	2026-03-24 11:01:54+00	Neymar’s World Cup dream in jeopardy as Ancelotti omits him from Brazil’s final friendlies. A seismic shift for the Selecao. #WorldCup2026 #BrazilFootball	#WorldCup2026	1
652	2026-03-24 11:01:54+00	https:// youtu.be/_T6Ec6WMFas?is =DLi4la4ylIgye_k5 … Another version of our #ScotlandWorldCupSong, celebrating @ScotlandNT being back at the @FIFAWorldCup ! Listen and compare to the original. #Scottishfootball #WorldCup2026 #TartanArmy #Scotland #bringthetrophyhame	#WorldCup2026	1
653	2026-03-24 11:01:56+00	How about this What’s the difference @UFCWCanada @Uber_Canada @Uber The public & media @CBCNews deserves full information & it’s constitutional right During very heavy rain Why are drivers and passengers having difficulty getting matched ? Host #WorldCup2026	#WorldCup2026	1
654	2026-03-24 11:01:56+00	US Soccer’s 2026 Nike kits unite all 27 teams under one badge—bold stripes vs. minimalist stars. A viral design for a historic home tournament. #USMNT #WorldCup2026	#WorldCup2026	1
655	2026-03-24 11:01:56+00	El gobernador @armentapuebla_ presentó el Trophy Tour de la @FIFAWorldCup 2026 en el Centro Expositor de Puebla, acompañado del exfutbolista y leyenda española @llorentefer19 #Puebla #WorldCup2026 #FIFA #Futbol	#WorldCup2026	1
656	2026-03-24 11:01:58+00	Qatar vs Switzerland opens at San Francisco Stadium (Levi's), June 13 at 12pm PT. Ronaldo's Portugal also play Group K here - his confirmed final World Cup. http:// sanfranciscobayareastadium.com #WC2026Europe #WorldCup2026 #LevisStadium	#WorldCup2026	1
657	2026-03-24 11:01:58+00	Neymar reacts angrily to Brazil snub ahead of World Cup warm-ups, with Ancelotti citing fitness concerns. The forward remains determined to earn a recall before the final squad is announced. #Neymar #Brazil #WorldCup2026 #Football #Ancelotti #Selecao #InternationalFootball	#WorldCup2026	1
659	2026-03-24 11:02:02+00	FIFA says it expects Iran to play at the 2026 World Cup as scheduled despite reports the Iranian FA wants matches moved from the USA to Mexico due to security concerns. Iran could withdraw if no change is made, with group games set in the United States. #FIFA #WorldCup2026 #Iran	#WorldCup2026	1
660	2026-03-24 11:02:02+00	Lamine Yamal & Rodri at Guadalajara Stadium (Estadio Akron), June 26. Spain vs Uruguay kicks off 8pm local - FIFA scheduled it at night to avoid peak Jalisco heat. Stadium is in Zapopan: 30-40 min from central GDL. http:// guadalajarastadium.com #WC2026Europe #WorldCup2026 #Guadalajara	#WorldCup2026	1
661	2026-03-24 11:02:02+00	THERE IS A STRAIN OF MENINGITIS OUTBREAK IN CANTERBURY' ENGLAND. IT HAS CLAIMED 2 LIVES OF TWO [18 & 21 ] YEAR OLDS WHILE 13 OTHERS ARE HOSPITALIZED THINGS ARE OCCURING #BoycottAFCON #WorldCup2026 #IsraelIranConflict #politicslive Sporting NATO #SPOARS gyokeres Trafalgar	#WorldCup2026	1
662	2026-03-24 11:02:04+00	Live the 2026 FIFA World Cup in luxury at Shoreline Olympic Drive—waterfront, monthly stays, near Seattle events! #WorldCup2026	#WorldCup2026	1
663	2026-03-24 11:02:04+00	As preparations intensify for the 2026 FIFA World Cup, Morocco's embassy in Washington DC has released an informational video to help Moroccan supporters plan their trip to the United States. #UnitedStates #Morocco #WorldCup2026 #AtlasLions #TravelGuide	#WorldCup2026	1
664	2026-03-24 11:02:04+00	ESTA SERÁ LA INTRO DEL MUNDIAL 2026 ¿Qué os parece? #WorldCup2026	#WorldCup2026	1
665	2026-03-24 11:02:04+00	It’s gonna be BST then #WorldCup2026	#WorldCup2026	1
666	2026-03-24 11:02:04+00	Colombia vs Portugal = MOST WANTED MATCH! This World Cup 2026 clash is already the #1 most requested ticket globally Prices crossing $2,000+ Miami showdown Get ticket details: https:// fifaworldcupnews.com/colombia-vs-po rtugal-tickets-fwc-2026/ … #WorldCup2026 #FIFAWorldCup #Portugal #Colombia	#WorldCup2026	1
667	2026-03-24 11:02:06+00	104 matches, 16 venues, 3 countries. And one very powerful man with his name all over it. The biggest show on earth — or the biggest deal? #WorldCup2026	#WorldCup2026	1
668	2026-03-24 11:02:07+00	FIFA has turned down Mexico’s proposal to host Iran’s World Cup games, reaffirming that matches will proceed as scheduled in the United States despite rising tensions. The decision #WorldCup2026 #FIFA #FootballPolitics Sunday Alabi for OGM News FC https:// ogmnewsfc.com/fifa-rejects-m exico-proposal-reaffirms-irans-partici …	#WorldCup2026	1
669	2026-03-24 11:02:07+00	Estamos peor que en el 68? Que en el 70 y el 86? Será por esto que la presirmierda con A no va a asistir a la inauguración? @FMF @fifacom_es @FIFAWorldCup @FIFAcom #WorldCup2026 #estadofallido	#WorldCup2026	1
670	2026-03-24 11:02:07+00	End of an era for NJR10 magic! Heartbreaking to hear him talk about the finish line, but what a journey it's been. Really hoping he finds 100% fitness for one last dance in the World Cup. O Jogo Bonito won't be the same! #Neymar #Brasil #WorldCup2026 #VVHDaily	#WorldCup2026	1
671	2026-03-24 11:02:09+00	FIFA Rejects Iran Match Relocation from USA to Mexico https:// thecownews.com/world/fifa-rej ects-iran-match-relocation-from-usa-to-mexico/ … #FIFA #WorldCup2026 #TheCOWNews	#WorldCup2026	1
672	2026-03-24 11:02:09+00	FIFA refuses to bow to U.S. demands and isn't changing any fixtures to accommodate geopolitical pressures. #FIFA #WorldCup2026 #FIFAvsUSA #Football #Iran Missed kickoff? No problem. Click the LIVE icon to jump in and stake on your favorite fixture with live in-play	#WorldCup2026	1
673	2026-03-24 11:02:09+00	فیفا کا ایران کے میچز منتقل کرنے سے انکار، کرکٹ و پی ایس ایل میں بھی نئی پیشرفت #FIFA #WorldCup2026 #IranFootball #DonaldTrump #Mexico #USA #Canada #AbrarAhmed #TheHundred #SunrisersLeeds #SunilGavaskar #Cricket #PSL11 #QuettaGladiators #SaudShakeel #SarfarazAhmed #MoinKhan	#WorldCup2026	1
674	2026-03-24 11:02:11+00	RESULTADOS OCTAVOS VUELTA UEFA CHAMPIONS LEAGUE #worldcup2026 #fifa #championsleague #futbol	#WorldCup2026	1
675	2026-03-24 11:02:11+00	“Wisdom that Sticks” (#66) is inspired by a Wisdom Tool in Cultivating Love: Wisdom for Life by Dr. Ken McGill https:// amazon.com/Cultivating-Lo ve-Dr-Ken-McGill-ebook/dp/B0G1V7R3YZ?ref_=ast_author_mpb … #WorldCup #FIFAWorldCup #WorldCup2026 #WorldCupFootball #RoadToWorldCup #WorldCupFinal #WorldCupQualifiers #WorldCupGoals #WorldCupMatch	#WorldCup2026	1
676	2026-03-24 11:02:11+00	Who’s leading the digital ticket market right now? South American fans are on top, Ecuador supporters were last week’s top traders, locking in World Cup 2026 seats. Track the action on the official @FIFACollect marketplace, Drop a if you saw it #WorldCup2026 #FIFACollect	#WorldCup2026	1
677	2026-03-24 11:02:11+00	Here is the South American team that dominated the Right-To-Tickets trades last week https:// collect.fifa.com/blog/ecuador-r ight-to-tickets-la-tri-is-running-the-show-on-fifa-collect?utm_source=social&utm_medium=instagram&utm_campaign=rtt&referrer=Social_rtt …	#WorldCup2026	1
678	2026-03-24 11:02:13+00	POLL: Who wins World Cup 2026? Brazil France Argentina Germany Reply with your pick! 84 days! Earn free KICK points on WC26 Fantasy: https:// t.me/wc26viral_bot @goal #WorldCup2026	#WorldCup2026	1
679	2026-03-24 11:02:15+00	#Iran declare NOT to participate in the #Worldcup2026 if its matches are located in the #USA	#WorldCup2026	1
680	2026-03-24 11:02:15+00	FIFA rejected Iran’s request to play its World Cup matches in Mexico. One of the countries hosting the World Cup, the United States, is bombing Iran, and FIFA’s solution is to reject Iran’s request. A disgraceful institution @FIFAcom.	#WorldCup2026	1
681	2026-03-24 11:02:15+00	Few days to the FIFA World Cup 2026 Who wins it all? Starting a series analysing every team — players, history & predictions. Stay tuned. check comment section to watch more #WorldCup2026 #Football #Ibadanpikin	#WorldCup2026	1
682	2026-03-24 11:02:15+00	The USMNT’s 2026 World Cup kits unite all 27 national teams under one design—Stripes or Stars. A bold move for home soil pride. #USMNT #WorldCup2026	#WorldCup2026	1
683	2026-03-24 11:02:17+00	9,500 People Turn Mexico City's Zócalo Into the World's Largest Soccer Class https:// thegoodpress.news/article/mexico -city-zocalo-largest-soccer-class-guinness-world-record-2026 … #WorldCup2026 #Mexico #Soccer #GoodNews #TheGoodPress	#WorldCup2026	1
684	2026-03-24 11:02:17+00	New blog: “Word Cup 2026: Promotional Gifting in Focus” With global attention turning to one of the biggest sporting events in the world, brands have a unique opportunity to connect with audiences. . Head to https:// shorturl.at/XKXlQ to read the blog #WorldCup2026	#WorldCup2026	1
685	2026-03-24 11:02:17+00	Cesur çıktı: Zlatan Ibrahimovic, 2026 Dünya Kupası yorumcusu olarak duyuruldu #ZlatanIbrahimovic #WorldCup2026 Manchester City Şampiyonlar Ligi'nde Kante Asensio Real Madrid Antep #BugünGünlerdenGALATASARAY #LIVvGS	#WorldCup2026	1
716	2026-03-24 11:02:34+00	85 Days to the World Cup! The road to the knockout stage is never easy! Even undefeated teams can face elimination. Get ready for the drama and surprises! #WorldCup2026 #Football #FootballFans #BJ88	#WorldCup2026	1
686	2026-03-24 11:02:19+00	ศึกลูกหนังคืนนี้ ลิเวอร์พูล VS กาลาตาซาราย ห้ามพลาด โปรแรงสำหรับสมาชิกใหม่ https:// lin.ee/MWHFxqqM ฝากเพียง 100 บาท วันนี้ เข้ากลุ่มฟรีทันที!รับเสื้อบอล+ช่องดูบอล ฟรีไม่มีเทิร์น แคปโพสต์ แล้วทักหาเราเลย #บอล #WorldCup2026 #แทงบอล #เว็บแทงบอล #จ่ายจริง #เว็บตรง	#WorldCup2026	1
687	2026-03-24 11:02:19+00	Suas comemorações ganharam destaque e repercussão durante a Copa de 2014. Mas, Miguel Herrera estava apenas demonstrando toda sua paixão pelo futebol de forma efusiva, no maior palco do esporte. #fifaworldcup #worldcup2026 #worldcup2026	#WorldCup2026	1
688	2026-03-24 11:02:19+00	#FIFA #WorldCup2026 #Mexico Dear Tourists #WelcomeToTheJungle #NarcGoverment	#WorldCup2026	1
689	2026-03-24 11:02:19+00	The World Cup waits for no one—especially not a slow manufacturer. If you’re tired of missed deadlines and faded prints, it’s time to go factory-direct. We handle everything from custom designs to orders of 500k+ pieces with full sublimation that lasts. #WorldCup2026	#WorldCup2026	1
690	2026-03-24 11:02:21+00	Football Unites the World War #worldcup2026	#WorldCup2026	1
691	2026-03-24 11:02:21+00	84 days to World Cup 2026! 48+ players earning KICK points 39,450 KICK distributed Play daily quiz & penalty shootout — earn points convertible to WC26 token! https:// t.me/wc26viral_bot #WorldCup2026 #WC26 #FIFA #Web3	#WorldCup2026	1
692	2026-03-24 11:02:21+00	http:// soccertease.beehiiv.com #WorldCup2026	#WorldCup2026	1
693	2026-03-24 11:02:21+00	"Football Unites the World War" #WorldCup2026	#WorldCup2026	1
694	2026-03-24 11:02:21+00	76/365 86 days to the World Cup #FIFAworldcup #worldcup2026 Psalms 89:40	#WorldCup2026	1
695	2026-03-24 11:02:23+00	Sambut EUFORIA PIALA DUNIA 2026 Bersama DEWABET. Daftar dan Menangkan Maxwin DISINI : https:// garasimobilku.website/worldcup2026/ #worldcup2026 #pialadunia2026 #dewabet #mexico #Canada #timnasindonesia #indonesia	#WorldCup2026	1
696	2026-03-24 11:02:23+00	#Vietnam se prepara para apoyar a México en el Mundial #WorldCup2026 En las tiendas deportivas ya se puede encontrar la camiseta de @miseleccionmx #DiplomaciaDeportiva #pontelaverde #vamosMéxico #VivaMéxico	#WorldCup2026	1
697	2026-03-24 11:02:25+00	Kiss the #FIFA #WorldCup2026 goodbye then	#WorldCup2026	1
698	2026-03-24 11:02:25+00	一次情報として以下のURLも貼っておきます。 これはすごい！ #WorldCup2026 YouTube公式 https:// blog.youtube/news-and-event s/fifa-world-cup-2026-youtube-partnership/ … FIFA公式リリース https:// inside.fifa.com/organisation/m edia-releases/fifa-youtube-agreement-fifa-world-cup-2026-preferred-platform …	#WorldCup2026	1
699	2026-03-24 11:02:25+00	YouTube partners with FIFA on exclusive World Cup elements https:// socialmediatoday.com/news/youtube-p artners-with-fifa-on-exclusive-world-cup-elements/815014/ … via @socialmedia2day これはビッグニュース。 W杯映像のメディアの独占構造が崩れ、個人クリエイターが公式の一部になる時代。 2026年は、スポーツメディアの歴史が書き換わる年になりそう。#WorldCup2026	#WorldCup2026	1
700	2026-03-24 11:02:25+00	#WorldCup2026 Group J teams & kits Predicted final standings: BRAZIL NETHERLANDS SWEDEN TUNISIA #subbuteo	#WorldCup2026	1
701	2026-03-24 11:02:28+00	¡Faltan 85 DÍAS para la gloria mundialista! La emoción crece desde Nueva York rumbo al #FIFA2026. Nos preparamos para vivir una fiesta que unirá culturas, pasiones y corazones en torno al fútbol. ¡México está listo para hacer vibrar al mundo entero! #85Días #WorldCup2026	#WorldCup2026	1
702	2026-03-24 11:02:28+00	Det har været meget voldsomt med Kasper Schmeichel #ForDanmark #VM2026 #WorldCup2026	#WorldCup2026	1
703	2026-03-24 11:02:28+00	Carlo Ancelotti langsung gas anak asuhnya dengan lawan-lawan berat jelang Piala Dunia 2026 Mulai dari Prancis, Kroasia, sampai Mesir Laga ini bisa ditonton LIVE di TVRI & TVRI Sport! #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
704	2026-03-24 11:02:28+00	The #Macedonia coach, Goce Sedloski, is set to hold only three training sessions ahead of the match vs. #Denmark in the #WorldCup2026 play-off semi-final. With the squad's meeting scheduled for Sunday (22nd of March), the national team will have only limited time...	#WorldCup2026	1
705	2026-03-24 11:02:30+00	Faltan 85 días: Brehme en el punto penal. ¡Pura sangre fría en 1990! ¿Qué estás esperando? ¿Quién ganará el Balón de Oro en 2026? Únete a n o sotros: http:// betstar77.com #WorldCup2026 #Football #AndreasBrehme #Germany #WorldCup #Football	#WorldCup2026	1
706	2026-03-24 11:02:30+00	World Cup 2026 is coming to USA! June 11 — July 19 11 US cities • 104 games Coldplay at halftime show! Team USA in Group D Which team are you picking? http:// popscopeusa.blogspot.com #WorldCup2026 #FIFA #TeamUSA	#WorldCup2026	1
707	2026-03-24 11:02:30+00	Today we take another step forward. At approximately 16:00 GMT (London), we’ll share one more milestone on the path to launching our "Alliance". Small steps. Big vision. Many Flags. One Nation. Stay tuned. #WCUP #BNB #WorldCup2026 #Crypto #Sports #Union	#WorldCup2026	1
708	2026-03-24 11:02:30+00	95 World Cup players in #Atlanta in 95 days https:// soccerwithdoug.substack.com/p/95-world-cup -players-in-atlanta-in-daa … #WorldCup2026	#WorldCup2026	1
709	2026-03-24 11:02:32+00	#WorldCup2026 Group I teams & kits Predicted final standings: FRANCE BULGARIA HONDURAS NORTH KOREA #subbuteo	#WorldCup2026	1
710	2026-03-24 11:02:32+00	Ibra sbarca in America: sarà la stella di Fox Sports per i Mondiali 2026! https:// milannews24.com/ibrahimovic-fo x-sports-commentatore-mondiali/ … #Ibrahimovic #FoxSports #WorldCup2026 #Zlatan	#WorldCup2026	1
711	2026-03-24 11:02:32+00	Morocco have more money than Senegal. They bought a last minute penalty and lost. Now they have bought the AFCON cup without kicking a ball. Time to ban Morocco from all football competitions. #WorldCup2026	#WorldCup2026	1
712	2026-03-24 11:02:32+00	GM, you can stress about World Cup 2026 tickets later with everyone else or you can lock in your right to buy now through @FIFACollect RTTs tradable, real utility, and you're ahead of millions of people your call link in comments #WorldCup2026 #FIFACollect #RTT	#WorldCup2026	1
713	2026-03-24 11:02:34+00	#Boycott #Fifa #WorldCup2026 #Iran #ZionismIsSatanism #IsraelTerroristState #TerroristUSA	#WorldCup2026	1
714	2026-03-24 11:02:34+00	Pio Esposito yakinkan Timnas Italia #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira https:// pialadunia.tvrinews.com/read/pd_ihmqdf smyk/pio-esposito-impresif-italia-kian-yakin-di-play-off-piala-dunia …	#WorldCup2026	1
715	2026-03-24 11:02:34+00	All countries with any belief in International Law, Human Rights, or even just the safety of their own citizens, should Boycott the USA...!!! #WorldCup #WorldCup2026 #BoycottUSA	#WorldCup2026	1
1113	2026-03-24 15:22:23+00	9. original suit (#raimiverse) #peterparker #spiderman	#Spiderman	0
717	2026-03-24 11:02:36+00	#WorldCup2026tickets TICKETS ON SALE NOW! United States vs Paraguay World Cup - Group D (Match 4) Jun 12 • Fri • 6:00PM • 2026 @ SoFi Stadium, Inglewood, California, USA Join Group: https:// chat.whatsapp.com/FwYDjwMyW2f9pL 5afIPWjy?mode=gi_t … #WorldCup2026 #WorldCup2026Tickets #USA #UnitedStates #Paraguay	#WorldCup2026	1
718	2026-03-24 11:02:36+00	Mistrzostwa Świata 2026 za 85 dni. #WorldCup2026 #Mundial2026 #Countdown	#WorldCup2026	1
719	2026-03-24 11:02:38+00	FIFA rejects Iran’s request to move 2026 World Cup matches from the US to Mexico, confirming fixtures will go ahead as scheduled despite security concerns. https:// thepublicpurview.com/fifa-rejects-i ran-world-cup-match-relocation/ … #FIFA #WorldCup2026 #Iran #Football #USA #Mexico #Canada #SportsNews	#WorldCup2026	1
720	2026-03-24 11:02:38+00	#WorldCup2026 tickets WTS WORLD CUP 2026 TICKETS. MATCH 7. MORROCO VS BRAZIL. $705 Join Whatsapp group: https:// chat.whatsapp.com/FwYDjwMyW2f9pL 5afIPWjy?mode=gi_t … DM IF YOU'RE INTERESTED #Worldcup2026 #T20WorldCup #t20wc2026final	#WorldCup2026	1
721	2026-03-24 11:02:38+00	"The 2026 World Cup will expand to 48 teams, will the group stage become 'garbage time'? For the sake of votes and broadcasting fees, is FIFA destroying the gold content of the World Cup? Which team do you think is here to make up for it?" #WorldCup2026 #FIFA	#WorldCup2026	1
722	2026-03-24 11:02:38+00	Tim Jerman diminta tak bawa Leroy Sane https:// pialadunia.tvrinews.com/read/pd_58y5sg hnaz/julian-nagelsmann-diminta-coret-leroy-sane-dari-skuad-piala-dunia-2026 … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
723	2026-03-24 11:02:42+00	Dua jempol untuk Liv Bolung yang ikut merancang apparel untuk Timnas Brasil. Desainnya keren-keren. Bagaimana menurut TVRISportsters? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
724	2026-03-24 11:02:42+00	NFF appealing FIFA's rejection on DR Congo players eligibility. Super Eagles 2026 WC dream still alive? Who's optimistic? Drop your predictions! #SuperEagles #FIFA #WorldCup2026	#WorldCup2026	1
725	2026-03-24 11:02:42+00	FIFA Confirms Iran’s World Cup Matches Will Not Be Moved from the US | TV One USA #WorldCup2026 #FIFAStatement #IranMatches #TVOneUSA	#WorldCup2026	1
726	2026-03-24 11:02:42+00	Just claimed my Base Player Card on @Picksdotapp ! Brazil | Football | LIT Stadium seats filling up fast before World Cup 2026 – grab yours and upgrade with referrals!Join here: https:// pre.getpicks.app/?ref=gp-dcjmvW ho%27s … coming to the pitch with me? #Picks #WorldCup2026	#WorldCup2026	1
727	2026-03-24 11:02:44+00	hese kids are about to go from “next big thing” to “household name” in one tournament. Who’s your favourite debutant for #WC2026? Or who did I miss? Drop your pick below #WorldCup2026 #Yamal #Wonderkids	#WorldCup2026	1
728	2026-03-24 11:02:44+00	Free rewards for football fans! 84 days to #WorldCup2026 WC26 Fantasy on Telegram: Free KICK points daily Football quiz + penalty game 500 KICK welcome bonus KICK points → WC26 token! @Web3Daily @AltCoinDaily https:// t.me/wc26viral_bot #WC2026 #Crypto	#WorldCup2026	1
729	2026-03-24 11:02:44+00	NOUVEAU MAILLOT ! Le nouveau maillot concept du Japon en version joueur est disponible sur le site ! : 29,99€ : 5-10 jours ! : -10% avec le code « 2k26 » ! https:// elite-fanstore.com/products/maill ot-japon-exterieur-version-joueur-coupe-du-monde-2026 … #SamuraiBlue #JFA #WorldCup2026 #Japan #WC2026	#WorldCup2026	1
730	2026-03-24 11:02:44+00	Carlo Ancelotti punya tradisi sukses bersama pemain Brasil https:// pialadunia.tvrinews.com/read/pd_ge5ot7 fvtv/carlo-ancelotti-punya-tradisi-sukses-bersama-pemain-brasil … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
731	2026-03-24 11:02:47+00	FIFA Signs Broadcast Deal With YouTube For World Cup 2026 Read More: https:// newsguru.pk/sports/fifa-wo rld-cup-2026-signs-youtube-broadcast-deal/ … #NewsGuru #FIFA #WorldCup2026 #YouTubeBroadcast #FootballNews	#WorldCup2026	1
732	2026-03-24 11:02:47+00	Brazil Excludes Neymar for World Cup Preparation In a surprising move, Brazil has left Neymar out of their squad as they refresh their lineup for the 2026 World Cup. The team will face Egypt before their crucial opener against Morocco. #Brazil #WorldCup2026 #JW7	#WorldCup2026	1
733	2026-03-24 11:02:47+00	Gala - Freed From Desire (#WorldCup2026 Remix)	#WorldCup2026	1
734	2026-03-24 11:02:49+00	Big update! FIFA x YouTube Watch the first 10 mins of FIFA World Cup 2026 matches FREE https:// allycaral.com/2026/03/18/fif a-partners-with-youtube-for-fifa-world-cup-2026-first-10-minutes-of-matches-to-stream-free/ … #WorldCup2026 #FIFA	#WorldCup2026	1
735	2026-03-24 11:02:49+00	Iran is in negotiations with FIFA regarding the relocation of the matches in the 2026 World Cup that are set to take place in the United States due to security reasons in the wake of escalating tensions in West Asia. #Iran #FIFA #WorldCup2026 #FootballNews #WestAsia	#WorldCup2026	1
736	2026-03-24 11:02:49+00	Bek @persib masuk dalam skuat Irak untuk play-off @FIFAWorldCup 2026 https:// pialadunia.tvrinews.com/read/pd_iqirvh ohyq/bek-persib-putros-masuk-skuat-irak-untuk-play-off-piala-dunia … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
737	2026-03-24 11:02:51+00	There’s no transport issue in BC Canada According to @Uber_Canada platform This is fake gray platform no use #exclusive dispatch Heavy rain So no demand whatsoever Welcome to BC Canada with @TransLink @Transport_gc @Dave_Eby #WorldCup2026	#WorldCup2026	1
738	2026-03-24 11:02:51+00	Calentando motores para junio El Mundial 2026 se acerca… #WorldCup2026 #FIFA2026 #AnimeArt #ぬきアニ #ぬきたし #かきたし #nukitashi_anime #Fanart #Futbol	#WorldCup2026	1
739	2026-03-24 11:02:51+00	#IranProtests #africanpride #WorldCup2026. I'm sure you won't even fight for your own country but you run to save to a foreign land cus you #nigerians like to seek validation to much for the wrong reasons. Nxi fxckin scam of Africa.	#WorldCup2026	1
740	2026-03-24 11:02:51+00	Meski mau jadi tuan rumah laga penyisihan Iran, Meksiko tetap bergantung pada logistik FIFA. Iran duel lawan Selandia Baru, 16 Juni, dan Belgia, 21 Juni, di Inglewood, lalu lawan Mesir di Seattle, 26 Juni. #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
741	2026-03-24 11:02:54+00	85 days until the 2026 World Cup kicks off! Get ready for 48 teams and 104 matches. It's going to be pure chaos. #WorldCup2026 #Soccer	#WorldCup2026	1
742	2026-03-24 11:02:54+00	Please,,, don’t come to #Mexico!! For the @FIFAWorldCup #WorldCup2026 you’ll find caos as soon as you land!! Airport is falling apart, no taxis at the terminal, no UBER!! THINK TWICE!!	#WorldCup2026	1
743	2026-03-24 11:02:54+00	NFF Appeals FIFA Decision on DR Congo World Cup Playoff Dispute The dispute centers on the eligibility of certain players used during a 2026 World Cup playoff match, with the NFF insisting it is not satisfied with the ruling. #NFF #FIFA #WorldCup2026 #99Pluznews	#WorldCup2026	1
833	2026-03-24 14:18:40+00	forget what they are wearing, this france team and depth is scary going in to a world cup #france #worldcup2026	#WorldCup2026	0
744	2026-03-24 11:02:54+00	FIFA has sanctioned Nigeria and DR Congo following World Cup play-off incidents. Nigeria was fined 1,000 Swiss francs after spectators threw objects during matches DR Congo received a 5,000 Swiss francs fine for the use of laser pointers by fans, violating Article 17.2.d.	#WorldCup2026	1
745	2026-03-24 11:02:56+00	FIFA has announced YouTube as the preferred platform for the 2026 World Cup. Media partners will be allowed to stream the first 10 minutes of every match, with select games available for full live streaming. #FIFA #worldcup2026 #sportsnews #youtubenews #99Pluznews	#WorldCup2026	1
746	2026-03-24 11:02:56+00	@TaynahEspinoza .Sacastic.You Can Be Defeated By Marocco in Frist Leg 2026 World Cup. Not On The Field.But Off The Field.Through Negotiations At the Table.Therefore Stay Alert Don't Underestimate.And Stay Focus.If You Need Hexa #WorldCup2026 #TNTSportsBr #CBF #CarloAnceloti	#WorldCup2026	1
747	2026-03-24 11:02:56+00	Sabrina Carpenter shows her support for Lionel Messi by rocking his 2026 World Cup-winning Argentina jersey! Check it out! [ http:// mid-day.com]( https:// mid-day.com/sports/footbal l/article/sabrina-carpenter-posts-a-picture-in-lionel-messis-2026-world-cup-winning-argentina-jersey-23621338 …) #SabrinaCarpenter #WorldCup2026 #bhivelabs	#WorldCup2026	1
748	2026-03-24 11:02:56+00	BREAKING FIFA World Cup venue change buzz amid – tensions #Trump warning raises security concerns for #Iran team Iran seeks to shift matches out of US FIFA yet to approve any venue change, schedule stays same #WorldCup2026 #USA #Geopolitics	#WorldCup2026	1
749	2026-03-24 11:02:58+00	Zlatan on FOX for WC 2026? This is going to be epic! What do you think – will he roast Messi or CR7 more? Predict the best moments! #WorldCup2026 #Zlatan	#WorldCup2026	1
750	2026-03-24 11:02:58+00	Cities preparing for the 2026 World Cup will face millions of international visitors. Language barriers. Traffic congestion. Overloaded services. Zentaph is building the systems cities will need. #AI #SmartCities #WorldCup2026	#WorldCup2026	1
751	2026-03-24 11:02:58+00	WADA POSTERGA DECISIÓN SOBRE TRUMP. La agencia antidopaje no vetará a funcionarios de EU... hasta después del Mundial 2026. Motivo: evitar conflicto antes de la Copa del Mundo. https:// especialistasdeldeporte.com/noticia/pospon en-decision-sobre-prohibicion-a-trump/ … #WorldCup2026 #WADA #Trump #LA2028	#WorldCup2026	1
752	2026-03-24 11:02:58+00	Presiden Mexico, Claudia Sheinbaum berkata negara itu bersedia menjadi tuan rumah bagi perlawanan pusingan pertama Iran di Piala Dunia 2026 jika diperlukan berikutan konflik di Asia Barat. https:// flashsukan.com.my/mexico-sedia-j adi-tuan-rumah-aksi-iran-untuk-piala-dunia/ … #Iran #Mexico #WorldCup2026 #FlashSukan	#WorldCup2026	1
753	2026-03-24 11:02:58+00	$100M is flowing into host city transit! If you're on a shuttle route, you’re in the money. Map these lines NOW and position your offers where fans land. Don't miss out! Is your shop on a transit route? #WorldCup2026 #HostCityHustle	#WorldCup2026	1
754	2026-03-24 11:03:00+00	Se PIERDEN EL MUNDIAL: Luis Ángel Malagón, Marcel Ruíz, Rodrigo Huecas, Luis Chávez y César Huerta. En recuperación (no estarán en Marzo): Edson Álvarez, Santiago Giménez, Gilberto Mora, César Montes y Mateo Chávez. #SelecciónMexicana #WorldCup2026 #VamosTri	#WorldCup2026	1
755	2026-03-24 11:03:00+00	YouTube Resmi Kerja Sama dengan FIFA untuk Piala Dunia 2026, Ada Siaran Gratis? https:// kaltim.tribunnews.com/superball/1141 217/youtube-resmi-kerja-sama-dengan-fifa-untuk-piala-dunia-2026-ada-siaran-gratis … lewat @tribunnews #youtube #fifa #worldcup2026 #pialadunia	#WorldCup2026	1
756	2026-03-24 11:03:00+00	El consejo a un niño que sueña con jugar un Mundial. #FernandoQuirarte @F_Quirarte #Mundial2026 #WorldCup2026 #FIFAWorldCup2026 #Mexico2026 #RumboAlMundial #CaminoAlMundial #copadelmundo Entrevista completa en el primer comentario:	#WorldCup2026	1
757	2026-03-24 11:03:02+00	Estamos cada vez más cerca. #WorldCup2026	#WorldCup2026	1
758	2026-03-24 11:03:02+00	@FIFAWorldCup @YouTube @beINSPORTS #worldcup2026	#WorldCup2026	1
759	2026-03-24 11:03:02+00	Gerakan kecil, dampaknya besar! Busquets cerdas membaca situasi… atau justru terlalu licik? #Dewacash #PialaDunia2026 #WorldCup2026 #FIFAWorldCup2026 #WC2026 #RoadTo2026 #GarudaMendunia	#WorldCup2026	1
760	2026-03-24 11:03:02+00	POLL: Who wins World Cup 2026? Brazil France Argentina Germany Reply with your pick! 84 days! Earn free KICK points on WC26 Fantasy: https:// t.me/WC26NFT_bot/app @brfootball #WorldCup2026	#WorldCup2026	1
761	2026-03-24 11:03:05+00	Y el Orizabeño se dice libanés....a lo mejor le gusta qué lo bombardeen ... #queretalove #worldcup2026	#WorldCup2026	1
762	2026-03-24 11:03:05+00	難しい状況ですね…。情勢も含めてイランのW杯出場自体がまだ不透明な中で、会場変更要請とFIFAの慎重な姿勢がどう影響するのか、4月の総会まで緊張感は続きそうです #WorldCup2026 #FIFA	#WorldCup2026	1
763	2026-03-24 11:03:05+00	The World Cup is coming to Mexico. But it's not just one city. Mexico City Guadalajara Monterrey Three completely different World Cup experiences. Discover them on GoNative. http:// gonativecity.com #WorldCup2026 #MexicoCity #VisitMexico	#WorldCup2026	1
764	2026-03-24 11:03:05+00	Reading 'upset and sad' from Neymar breaks my heart. He’s given everything to this shirt. 8 weeks to prove the doubters wrong. One last dance in North America is all we ask for. Stay strong, O Rei. #WorldCup2026	#WorldCup2026	1
765	2026-03-24 11:03:07+00	ایرانFIFA کے ساتھ World Cup 2026 میچز کو America سے باہر منتقل کرنے کے معاملے پر مذاکرات کر رہا ہے۔ #Iran #FIFA #WorldCup2026 #USA #FootballPolitics #MatchRelocation #GlobalFootball #SportsDiplomacy #BreakingNews #SportsNews	#WorldCup2026	1
766	2026-03-24 11:03:07+00	Timnas Iran mau ikut @FIFAWorldCup 2026 asal tampil di Meksiko https:// pialadunia.tvrinews.com/read/pd_fxq04r gyik/timnas-iran-buka-peluang-ikut-piala-dunia-2026-asal-main-di-meksiko … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
767	2026-03-24 11:03:07+00	RESMI: Neymar tidak masuk skuad Brasil untuk laga Maret Mungkin… kita tak akan melihat “pangeran” itu di Piala Dunia 2026 Bakat luar biasa, tapi cerita belum jadi legenda sepenuhnya #Neymar #Brasil #WorldCup2026 #SepakBola #FootballX	#WorldCup2026	1
768	2026-03-24 11:03:09+00	Neymar Jr should be called up #Brazil #WorldCup2026	#WorldCup2026	1
769	2026-03-24 11:03:09+00	Seperti apa kontroversi terkait batalnya Finalissima 2026? https:// pialadunia.tvrinews.com/read/pd_jl7jqz rh5r/kontroversi-di-balik-batalnya-finalissima-2026 … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	1
770	2026-03-24 11:03:09+00	韩K颇具看点的一场对决，本场思路（小球+防平） 联赛：韩K 18:30（北京时间） 队伍：金泉尚武光州FC 推荐：全场让球 光州+0.5 波胆：0-1 1-1 0-0 0-2 #韩K #WorldCup2026	#WorldCup2026	1
771	2026-03-24 11:03:09+00	Iran is in discussions with FIFA over the possibility of relocating its World Cup matches from the U.S. to Mexico, according to this statement by the country’s football president. “We’ll definitely not travel to the U.S.”, Taj says. #WorldCup2026 #TeamMelli	#WorldCup2026	1
772	2026-03-24 11:03:11+00	Iran say they are negotiating with FIFA to move their World Cup games to Mexico Full Iran team Current Schedule & squad: https:// fifaworldcupnews.com/2026-fifa-worl d-cup-iran-team/ … #WorldCup2026 #FIFAWorldCup #Iran #Soccer	#WorldCup2026	1
773	2026-03-24 11:03:11+00	Iran is in talks with FIFA to move its 2026 FIFA World Cup matches from the United States to Mexico due to security concerns linked to ongoing regional tensions. #IranFootball #WorldCup2026 #FIFA #FootballNews	#WorldCup2026	1
774	2026-03-24 11:03:11+00	Neymar left out of Brazil national football team squad for friendlies before the 2026 FIFA World Cup. #neymar #brazil #WorldCup2026 #bj88news #SportsNews	#WorldCup2026	1
775	2026-03-24 11:03:13+00	Millions waiting. Tickets vanish. Doland Drum: “Let them fall from the sky.” FIFA World Cup fairness = luck. #FIFAWorldCup #WorldCup2026 #Football #Soccer #worldcupfinal	#WorldCup2026	1
776	2026-03-24 11:03:13+00	Neymar Left Out of Brazil’s FIFA World Cup 2026 Warm-Up Squad #Neymar #BrazilFootball #WorldCup2026 #Selecao #FootballNews #InjuryUpdate #Soccer #BrazilSquad #FIFA #SportsNews	#WorldCup2026	1
777	2026-03-24 11:03:13+00	Millions arriving. Seats limited. Doland Drum: “Make them bounce in.” FIFA World Cup capacity = redefined. #FIFAWorldCup #WorldCup2026 #Football #Soccer #worldcupfinal	#WorldCup2026	1
778	2026-03-24 11:03:13+00	Possession lost. Game at risk. Doland Drum: “Swap the shoes.” FIFA World Cup confusion = control. #FIFAWorldCup #WorldCup2026 #Football #Soccer #worldcupfinal	#WorldCup2026	1
779	2026-03-24 11:08:03+00	Quais oito nações avançarão e manterão vivo o sonho da #WorldCup2026?	#WorldCup2026	1
780	2026-03-24 11:08:03+00	8 đội tuyển nào sẽ giành quyền đi tiếp và tiếp tục nuôi mộng #WorldCup2026?	#WorldCup2026	1
781	2026-03-24 11:08:03+00	แปดชาติใดบ้างที่จะผ่านเข้ารอบและยังคงสานฝันการเข้าร่วม #WorldCup2026 ต่อไป?	#WorldCup2026	1
782	2026-03-24 11:08:03+00	Siapa saja delapan tim yang akan bertahan dan menjaga asa di #WorldCup2026?	#WorldCup2026	1
783	2026-03-24 11:08:03+00	どの8か国が勝ち進み、#WorldCup2026 の夢をまだ追い続けられるでしょうか？	#WorldCup2026	1
784	2026-03-24 11:08:03+00	Which eight nations will advance and still keep their #WorldCup2026 dream alive?	#WorldCup2026	1
785	2026-03-24 11:08:05+00	In 1958, guided by a 17-year-old teenager known as Pelé, Brazil won its first World Cup title by defeating host nation Sweden 5–2 in the final. #flashback #worldcupfinal #worldcup2026 #SoccerWordCup #Brazil #JapaneseGP #UFCseattle #openingday #marchmadness	#WorldCup2026	1
786	2026-03-24 11:08:07+00	| مباريات المنتخبات العربية في مارس استعداداً لكأس العالم 2026 #المنتخبات_العربية#مباريات_مارس #توقف_دولي #FIFA_Day#استعدادات_كأس_العالم #كأس_العالم_2026 #WorldCup2026 #RoadToWorldCup #	#WorldCup2026	1
787	2026-03-24 11:08:07+00	Hugo Broos reveals that Brazil asked for R84 Million to play Bafana Bafana in Mzansi. With Argentina also requesting nearly R100 Million. https:// savarsitynewz.co.za/2026/03/24/saf a-rejects-r84-million-brazil-friendly-inside-the-high-stakes-choice-for-bafana-bafana/ … #BafanaBafana #WorldCup2026 #SouthAfrica #HugoBroos #SAFA #Brazil @orlandopirates @Masandawana @Hugo_Brosss	#WorldCup2026	1
788	2026-03-24 11:08:07+00	Welcome to #WorldCup2026	#WorldCup2026	1
789	2026-03-24 11:08:07+00	New footage shows ICE agents detaining a mother traveling with her young daughter at San Francisco International Airport. Witnesses repeatedly yelled “I don’t know who you are” as agents refused to show ID. What has America become?	#WorldCup2026	1
790	2026-03-24 11:08:10+00	¡Excelente selección de noticias! Orgullosos de ver nuestro análisis sobre el mercado de LatAm y el Mundial 2026 incluido en este recap. ¡Gran trabajo del equipo de @GIEspanol ! #BETER #LatAm #WorldCup2026	#WorldCup2026	1
791	2026-03-24 11:08:15+00	@PUMA just dropped its 2026 World Cup kits 11 nations. One global statement. https://onefootball.com/en/news/puma-unveil-their-world-cup-kits-heres-what-portugal-will-wear-42587720… #Puma #WorldCup2026 #Football #FIFAWorldCup	#WorldCup2026	1
792	2026-03-24 11:08:15+00	FIFA a fost reclamată la Comisia Europeană pentru prețurile biletelor la Cupa Mondială 2026 și pentru lipsa de transparență la vânzare. #FIFA #WorldCup2026 #ComisiaEuropeana #Fotbal #stiri #findnews https://findnews.ro/fifa-reclamata-la-comisia-europeana-din-cauza-biletelor-la-mondial-2000660…	#WorldCup2026	1
793	2026-03-24 11:08:15+00	Mexico Ready To Shine As 2026 World Cup Counts Down... FIND OUT MORE: https://envio.international/mexico-ready-to-shine-as-2026-world-cup-counts-down/… #WorldCup2026 #Mexico #logistics #Envio	#WorldCup2026	1
794	2026-03-24 11:08:15+00	For Sale: http://FRA.BET - http://ITA.BET http://ARG.BET - http://GER.BET Three letters. FIFA’s official country code. Positioned for the 2026 global football cycle. Rare inventory. Strategic asset. #WorldCup2026	#WorldCup2026	1
795	2026-03-24 11:10:16+00	As much as I would love for Ronaldo's Portugal to win this World Cup, it's really between Bafana Bafana and the French side. #WorldCup2026 #BafanaPride	#WorldCup2026	1
796	2026-03-24 11:17:29+00	أختفى المُحارب لا يعني الهروب بل تجهيز لضربه تُسكت الجميع #WorldCup2026	#WorldCup2026	1
797	2026-03-24 13:37:45+00	World Cup 2026 incoming! Argentina (defending champs) vs Brazil, the biggest clash in football! If they meet in the knockouts, it's PURE FIRE! or ? My take: Argentina wins it! What’s yours? Drop your prediction Tag a friend who’s hyped! #WorldCup2026 #FootballRivalry	#WorldCup2026	0
798	2026-03-24 13:37:45+00	95 players in 95 days https:// open.substack.com/pub/soccerwith doug/p/95-world-cup-players-in-atlanta-in-ca6?r=2yjpde&utm_medium=ios … #worldcup2026 #fifa	#WorldCup2026	0
799	2026-03-24 13:37:45+00	#UEFA has announced that referee for #WorldCup2026 play-off qualifier between #Turkey and #Romania will be #FrancoisLetexier.	#WorldCup2026	0
800	2026-03-24 13:37:45+00	Nidal Čelik on World Cup playoff semi-final against Wales: “It is big games like this that us Footballers live for!” #WorldCup2026 #WALBIH	#WorldCup2026	0
801	2026-03-24 13:37:45+00	BREAKING: Zinedine Zidane has reached an agreement to become head coach of the France national football team after the 2026 FIFA World Cup Fabrizio Romano A new era incoming… #Zidane #France #WorldCup2026 #FootballNews	#WorldCup2026	0
802	2026-03-24 13:37:45+00	WORLD CUP 2026: This is the Last Train with @ShevaughnRacha predicting who will be onboard. #WorldCup2026	#WorldCup2026	0
803	2026-03-24 13:37:48+00	CAF president we can't suffer in your presence, just allocate few Millions to SAFA. There's no accountability in African leadership #WorldCup2026	#WorldCup2026	0
834	2026-03-24 14:18:43+00	last day to join the @kreators_world campaign on @fifacollect and potentially lock in those 2026 world cup tickets! let’s gooo! #rtts #worldcup2026	#WorldCup2026	0
804	2026-03-24 13:37:48+00	Ready for World Cup action at the stunning Estadio Akron? Read our full Guadalajara venue guide before you plan your 2026 trip! https:// fifa-worldcup26.com/venues/mexico/ estadio-akron-guadalajara/ … #WorldCup2026 #Mexico2026 #Guadalajara	#WorldCup2026	0
805	2026-03-24 13:37:48+00	BREAKING Il a signé avec la France pour devenir le coach de l’équipe nationale après la Coupe du Monde 2026 ! Le football français entre dans une nouvelle ère… #Football #France #WorldCup2026 #ÉtatsUnisdAfrique	#WorldCup2026	0
806	2026-03-24 13:37:48+00	I built my ultimate squad by picking ONE player from each country. Can you replace even ONE player at any position with someone better from that same country? Drop your improved XI or tell me who you’re swapping and why! #WorldCup2026 #DreamTeam #Football #Mbappe #yamal	#WorldCup2026	0
807	2026-03-24 13:37:50+00	Tap dan screenshot. Hayo, TVRISportsters perlu berapa kali percobaan untuk bisa melengkapi foto Lionel Messi? Coba share di kolom komentar ya #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
808	2026-03-24 13:37:52+00	Heading to Monterrey for the 2026 World Cup? Explore Estadio BBVA—one of the most breathtaking venues of the tournament! Check out our complete stadium guide, transit tips, and match details here https:// fifa-worldcup26.com/venues/mexico/ estadio-bbva-monterrey/ … #WorldCup2026 #EstadioBBVA #Monterrey	#WorldCup2026	0
809	2026-03-24 13:37:54+00	Forget what they are wearing, This France team and depth is scary going in to a World Cup #France #Worldcup2026	#WorldCup2026	0
810	2026-03-24 13:37:54+00	Last day to join the @Kreators_World campaign on @FIFACollect and potentially lock in those 2026 World Cup tickets! Let’s gooo! #RTTs #WorldCup2026	#WorldCup2026	0
811	2026-03-24 13:37:54+00	Fans Drag FIFA to Court Over Skyrocketing 2026 World Cup Ticket Prices #FIFA #WorldCup2026 #TicketPrices	#WorldCup2026	0
812	2026-03-24 13:37:54+00	New drip alert! Senegal national football team & Puma have unveiled their home & away kits for the 2026 FIFA World Cup Home: Clean, classic look Away: Bold colors with a cultural touch What do you think of these designs? #Senegal #WorldCup2026 #FootballKits	#WorldCup2026	0
813	2026-03-24 13:56:25+00	#WorldCup #WorldCup2026 #FIFA L'Organisation des Supporters Européens (FSE) dépose un recours auprès de la Commission Européenne pour que la FIFA stoppe la tarification dynamique.	#WorldCup2026	0
814	2026-03-24 13:56:25+00	2026 ലെ ലോകകപ്പിൽ ഫ്രാൻസ് കോച്ച് ആകാൻ ഫ്രഞ്ച് ഫുട്ബോൾ ഇതിഹാസം സിനദിൻ സിദാൻ... #WorldCup2026 #Football #bigtv #bigtvlive #bigtvmalayalam	#WorldCup2026	0
815	2026-03-24 13:56:25+00	Gianluigi Donnarumma, Robert Lewandowski, Christian Eriksen, Arda Guler, hingga Viktor Gyokeres masih harus berjuang di play-off. Siapa lagi yang mimpinya ke Piala Dunia 2026 terancam, TVRISportsters? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
816	2026-03-24 14:06:23+00	Estadio BBVA in Monterrey regularly hits 100°F+ in June. It's one of 3 WC2026 venues in Mexico. Open air. No AC. If you're going, you need to know which sections have shade before you buy. http://seatsun.com → Monterrey shade map, free #WorldCup2026 #WC2026 #Monterrey	#WorldCup2026	0
817	2026-03-24 14:18:32+00	#worldcup #worldcup2026 #fifa l'organisation des supporters européens (fse) dépose un recours auprès de la commission européenne pour que la fifa stoppe la tarification dynamique.	#WorldCup2026	0
818	2026-03-24 14:18:32+00	2026 ലെ ലോകകപ്പിൽ ഫ്രാൻസ് കോച്ച് ആകാൻ ഫ്രഞ്ച് ഫുട്ബോൾ ഇതിഹാസം സിനദിൻ സിദാൻ... #worldcup2026 #football #bigtv #bigtvlive #bigtvmalayalam	#WorldCup2026	0
819	2026-03-24 14:18:32+00	gianluigi donnarumma, robert lewandowski, christian eriksen, arda guler, hingga viktor gyokeres masih harus berjuang di play-off. siapa lagi yang mimpinya ke piala dunia 2026 terancam, tvrisportsters? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
820	2026-03-24 14:18:32+00	world cup 2026 incoming! argentina (defending champs) vs brazil, the biggest clash in football! if they meet in the knockouts, it's pure fire! or ? my take: argentina wins it! what’s yours? drop your prediction tag a friend who’s hyped! #worldcup2026 #footballrivalry	#WorldCup2026	0
821	2026-03-24 14:18:34+00	#uefa has announced that referee for #worldcup2026 play-off qualifier between #turkey and #romania will be #francoisletexier.	#WorldCup2026	0
822	2026-03-24 14:18:34+00	nidal čelik on world cup playoff semi-final against wales: “it is big games like this that us footballers live for!” #worldcup2026 #walbih	#WorldCup2026	0
823	2026-03-24 14:18:34+00	breaking: zinedine zidane has reached an agreement to become head coach of the france national football team after the 2026 fifa world cup fabrizio romano a new era incoming… #zidane #france #worldcup2026 #footballnews	#WorldCup2026	0
824	2026-03-24 14:18:34+00	world cup 2026: this is the last train with @shevaughnracha predicting who will be onboard. #worldcup2026	#WorldCup2026	0
825	2026-03-24 14:18:36+00	caf president we can't suffer in your presence, just allocate few millions to safa. there's no accountability in african leadership #worldcup2026	#WorldCup2026	0
826	2026-03-24 14:18:36+00	ready for world cup action at the stunning estadio akron? read our full guadalajara venue guide before you plan your 2026 trip! https:// fifa-worldcup26.com/venues/mexico/ estadio-akron-guadalajara/ … #worldcup2026 #mexico2026 #guadalajara	#WorldCup2026	0
827	2026-03-24 14:18:36+00	breaking il a signé avec la france pour devenir le coach de l’équipe nationale après la coupe du monde 2026 ! le football français entre dans une nouvelle ère… #football #france #worldcup2026 #étatsunisdafrique	#WorldCup2026	0
828	2026-03-24 14:18:36+00	i built my ultimate squad by picking one player from each country. can you replace even one player at any position with someone better from that same country? drop your improved xi or tell me who you’re swapping and why! #worldcup2026 #dreamteam #football #mbappe #yamal	#WorldCup2026	0
829	2026-03-24 14:18:38+00	แปดชาติใดบ้างที่จะผ่านเข้ารอบและยังคงสานฝันการเข้าร่วม #worldcup2026 ต่อไป?	#WorldCup2026	0
830	2026-03-24 14:18:38+00	tap dan screenshot. hayo, tvrisportsters perlu berapa kali percobaan untuk bisa melengkapi foto lionel messi? coba share di kolom komentar ya #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
831	2026-03-24 14:18:40+00	which eight nations will advance and still keep their #worldcup2026 dream alive?	#WorldCup2026	0
832	2026-03-24 14:18:40+00	heading to monterrey for the 2026 world cup? explore estadio bbva—one of the most breathtaking venues of the tournament! check out our complete stadium guide, transit tips, and match details here https:// fifa-worldcup26.com/venues/mexico/ estadio-bbva-monterrey/ … #worldcup2026 #estadiobbva #monterrey	#WorldCup2026	0
835	2026-03-24 14:18:43+00	fans drag fifa to court over skyrocketing 2026 world cup ticket prices #fifa #worldcup2026 #ticketprices	#WorldCup2026	0
836	2026-03-24 14:18:43+00	new drip alert! senegal national football team & puma have unveiled their home & away kits for the 2026 fifa world cup home: clean, classic look away: bold colors with a cultural touch what do you think of these designs? #senegal #worldcup2026 #footballkits	#WorldCup2026	0
837	2026-03-24 14:18:43+00	أختفى المُحارب لا يعني الهروب بل تجهيز لضربه تُسكت الجميع #worldcup2026	#WorldCup2026	0
838	2026-03-24 14:18:45+00	8 đội tuyển nào sẽ giành quyền đi tiếp và tiếp tục nuôi mộng #worldcup2026?	#WorldCup2026	0
839	2026-03-24 14:18:45+00	as much as i would love for ronaldo's portugal to win this world cup, it's really between bafana bafana and the french side. #worldcup2026 #bafanapride	#WorldCup2026	0
840	2026-03-24 14:18:45+00	siapa saja delapan tim yang akan bertahan dan menjaga asa di #worldcup2026?	#WorldCup2026	0
841	2026-03-24 14:18:47+00	quais oito nações avançarão e manterão vivo o sonho da #worldcup2026?	#WorldCup2026	0
842	2026-03-24 14:18:49+00	どの8か国が勝ち進み、#worldcup2026 の夢をまだ追い続けられるでしょうか？	#WorldCup2026	0
843	2026-03-24 14:18:51+00	in 1958, guided by a 17-year-old teenager known as pelé, brazil won its first world cup title by defeating host nation sweden 5–2 in the final. #flashback #worldcupfinal #worldcup2026 #soccerwordcup #brazil #japanesegp #ufcseattle #openingday #marchmadness	#WorldCup2026	0
844	2026-03-24 14:18:53+00	| مباريات المنتخبات العربية في مارس استعداداً لكأس العالم 2026 #المنتخبات_العربية#مباريات_مارس #توقف_دولي #fifa_day#استعدادات_كأس_العالم #كأس_العالم_2026 #worldcup2026 #roadtoworldcup #	#WorldCup2026	0
845	2026-03-24 14:18:53+00	hugo broos reveals that brazil asked for r84 million to play bafana bafana in mzansi. with argentina also requesting nearly r100 million. https:// savarsitynewz.co.za/2026/03/24/saf a-rejects-r84-million-brazil-friendly-inside-the-high-stakes-choice-for-bafana-bafana/ … #bafanabafana #worldcup2026 #southafrica #hugobroos #safa #brazil @orlandopirates @masandawana @hugo_brosss	#WorldCup2026	0
846	2026-03-24 14:18:53+00	welcome to #worldcup2026	#WorldCup2026	0
847	2026-03-24 14:18:53+00	new footage shows ice agents detaining a mother traveling with her young daughter at san francisco international airport. witnesses repeatedly yelled “i don’t know who you are” as agents refused to show id. what has america become?	#WorldCup2026	0
848	2026-03-24 14:18:58+00	¡excelente selección de noticias! orgullosos de ver nuestro análisis sobre el mercado de latam y el mundial 2026 incluido en este recap. ¡gran trabajo del equipo de @giespanol ! #beter #latam #worldcup2026	#WorldCup2026	0
849	2026-03-24 14:18:58+00	steven gerrard heran trent alexander-arnold diabaikan thomas tuchel https:// pialadunia.tvrinews.com/read/pd_b7qmd8 q1rc/gerrard-gagal-paham-tuchel-gak-panggil-alexander-arnold … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
850	2026-03-24 14:18:58+00	przywieźcie puchar do polskiej ziemi! https:// youtu.be/xsixgjaqlle?si =tthsimjdjlt_bvl- … #polska #worldcup2026 #polalb #mundial #laczynaspilka @laczynaspilka #hymnnamundial @grosickikamil @lewy_official #pzpn @pzpn_pl	#WorldCup2026	0
851	2026-03-24 14:18:58+00	'but there has always been a footballer in troy. i am so happy now that it is shining and showing how good he is' #rtesport @irelandfootball #coybig #worldcup2026	#WorldCup2026	0
852	2026-03-24 14:18:58+00	80 hari menjelang @fifaworldcup 2026, seperti apa perkembangannya https:// pialadunia.tvrinews.com/read/pd_jaqh3e lyin/80-hari-menuju-piala-dunia-2026-kondisi-italia-hingga-sikap-fifa … #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
853	2026-03-24 14:19:00+00	scott mctominay with new scotland away kit. #worldcup2026	#WorldCup2026	0
854	2026-03-24 14:19:00+00	with the expanded format, the dream is closer than ever for these countries.which team do you want to see make their first world cup appearance in 2026 the most? drop your answer below! #worldcup2026 #neverplayed #firsttimers #fifaworldcup	#WorldCup2026	0
855	2026-03-24 14:19:00+00	sambil ngabubu..... eh udah lewat, mohon maaf lahir batin tvrisportsters tvrisportsters bisa tebak skuat juara piala dunia dari negara mana dan tahun berapa ini? #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
856	2026-03-24 14:19:02+00	harambee stars head coach benni mccarthy on 8-0 loss in last friendly match against senegal as focus now shifts to fifa series frendlies against estonia and grenada/rwanda. #harambeestars #betshack #worldcup2026 #sportsnews	#WorldCup2026	0
857	2026-03-24 14:19:02+00	from the streets of lisbon to the stadiums in north america, a whole nation breathed as one today. portugal isn’t just a team; it’s a family. today, the seleção das quinas showed the world that heart beats talent every single time. . #seleção #portugalwin #worldcup2026 #forçaport	#WorldCup2026	0
858	2026-03-24 14:19:02+00	@puma just dropped its 2026 world cup kits 11 nations. one global statement. https:// onefootball.com/en/news/puma-u nveil-their-world-cup-kits-heres-what-portugal-will-wear-42587720 … #puma #worldcup2026 #football #fifaworldcup	#WorldCup2026	0
859	2026-03-24 14:19:04+00	fifa a fost reclamată la comisia europeană pentru prețurile biletelor la cupa mondială 2026 și pentru lipsa de transparență la vânzare. #fifa #worldcup2026 #comisiaeuropeana #fotbal #stiri #findnews https:// findnews.ro/fifa-reclamata -la-comisia-europeana-din-cauza-biletelor-la-mondial-2000660 …	#WorldCup2026	0
860	2026-03-24 14:19:04+00	mexico ready to shine as 2026 world cup counts down... find out more: https:// envio.international/mexico-ready-t o-shine-as-2026-world-cup-counts-down/ … #worldcup2026 #mexico #logistics #envio	#WorldCup2026	0
861	2026-03-24 14:19:04+00	for sale: http:// fra.bet - http:// ita.bet http:// arg.bet - http:// ger.bet three letters. fifa’s official country code. positioned for the 2026 global football cycle. rare inventory. strategic asset. #worldcup2026	#WorldCup2026	0
862	2026-03-24 14:19:04+00	who will score the most goals at the 2026 fifa world cup?	#WorldCup2026	0
863	2026-03-24 14:19:06+00	i just decided that uruguay is my pick 2 win world cup @talksport cos they got valverde. the best plyr in the world #worldcup2026 plus they got cape verde and saudi arabia in their group & they will breeze to qualification to next stage frm their group along with spain	#WorldCup2026	0
864	2026-03-24 14:19:06+00	new era new kits france unveil their 2026 world cup kits inspired by strong ties with the usa style meets legacy on the world stage #france #worldcup2026 #nikefootball #newkit #bj88	#WorldCup2026	0
865	2026-03-24 14:19:06+00	abro hilo sobre por qué el repechaje en méxico contra surinam será el fin del "milagro" de la verde. #worldcup2026 #bolivia #suriname #análisisdeélite #repechaje #mundial	#WorldCup2026	0
867	2026-03-24 14:19:08+00	tak bisa dipungkiri kondisi mental bisa sangat berpengaruh pada performa. pelatih italia, gennaro gattuso, dibantu kapten tim harus bisa membantu para pemain untuk mengelola kepercayaan diri dan ketenangan. #tvriworldcup #worldcup2026 #tvrisports #pialadunia2026 #bolagembira	#WorldCup2026	0
868	2026-03-24 14:19:08+00	fiston mayele has joined the dr congo camp in mexico ahead of the 2026 world cup playoffs. the striker links up with the squad as preparations intensify for the crucial fixtures. #worldcup2026 #africanfootball #drcongo	#WorldCup2026	0
869	2026-03-24 14:19:08+00	goal tercepat? #worldcup2026 #pialadunia2026 #sepakboladunia #highlightswc2026 #pialaduniaupdate #bola88 #chundai #golspektakuler	#WorldCup2026	0
870	2026-03-24 14:19:10+00	#letsgo #worldcup2026 #soccer #messi #messi #usa #argentina #tuesdaymotivation #mls	#WorldCup2026	0
871	2026-03-24 14:19:10+00	can you imagine training like a madman for 25 years and being called lazy just because you don't post anything on social media? x.com/magicalpep/sta…	#WorldCup2026	0
872	2026-03-24 14:19:10+00	we calibrated 30 years of world cup data against prediction markets. here's what we found: - croatia: +536% undervalued - morocco: +137% undervalued - brazil: -78% overpriced markets aren't as smart as you think @zerve_ai #zervehack #worldcup2026	#WorldCup2026	0
873	2026-03-24 14:19:10+00	el mundial 2026 todavía no empezó… pero ya se está jugando. hinchas estadios emoción real todo en un solo lugar. vivilo antes que nadie https:// multiideasweb.com/mundial2026/si mulador-mundial-2026.php … #mundial2026 #worldcup2026 #fútbol #simulador #argentina #soccer	#WorldCup2026	0
874	2026-03-24 14:19:10+00	#worldcup2026	#WorldCup2026	0
875	2026-03-24 14:19:10+00	¡por fin! tras años de crímenes contra la humanidad y presión de la opinión pública, la fifa se decidió a sancionar a los israelíes… aunque no celebren todavía, que aún no les hemos contado en qué consisten esas ‘sanciones’	#WorldCup2026	0
876	2026-03-24 14:19:13+00	get the your team customized soccer jersey of world cup soccer. “three nations. one dream. customize your world cup pride with melash sports.” #melashsports #worldcup2026 #usa #mexico #canada #soccerunity #customjersey #northamericafootball #gameon #footballpride	#WorldCup2026	0
877	2026-03-24 14:19:13+00	listos para el jueves, ya me siento jamaiquino #worldcup2026	#WorldCup2026	0
878	2026-03-24 14:19:13+00	@unhumanrights @bchrc @bchrc @hrw where are these ? #worldcup2026 @moreperfectus @uber and @lyft are still exploiting harassing abusing humanities the gig trap	#WorldCup2026	0
879	2026-03-24 14:19:13+00	fifa world cup 2026 playoffs: final battle for global glory begins @fifa @uefa @conmebol @afc @caf #worldcup2026 #fifaworldcup #footballplayoffs #soccernews #worldcupqualifiers #footballfans #trendingsports	#WorldCup2026	0
880	2026-03-24 14:19:15+00	quick wc2026 seat check before you buy: 1. go to http:// seatsun.com 2. pick your stadium 3. enter game date + kickoff time 4. see exactly which sections are shaded takes 60 seconds. potentially saves you 90 minutes of misery. free, no signup. #wc2026 #worldcup2026	#WorldCup2026	0
881	2026-03-24 14:19:15+00	wc2026 is 79 days away. if you have tickets for an afternoon game in miami, monterrey, or kansas city and haven't checked your section's sun exposure — do it now. http:// seatsun.com → all 16 venues, section-level shade by kickoff time #worldcup2026 #wc2026	#WorldCup2026	0
882	2026-03-24 14:19:15+00	italy could miss another world cup. let that sink in. #wcq #worldcup2026 #azzurri	#WorldCup2026	0
883	2026-03-24 14:19:15+00	fifa world cup 2026 playoffs: final qualification matches explained https:// theelitereview.com/fifa-world-cup -2026-playoffs/ … @fifacom @uefacom @conmebol @afc @caf_online #worldcup2026 #fifaworldcup #footballplayoffs #soccernews #worldcupqualifiers #footballfans #trendingsports	#WorldCup2026	0
884	2026-03-24 14:19:18+00	the stage is set. the colors are louder. @nike unveils all 2026 world cup™ kits. https:// sports.yahoo.com/articles/nike- kits-2026-world-cup-105900472.html … #worldcup2026 #nikefootball #nike #fifaworldcup	#WorldCup2026	0
885	2026-03-24 14:19:18+00	reggae boyz on the brink. jamaica’s world cup dream faces a fearless new caledonia in a huge inter-confederation playoff. leon bailey could be the difference, but the pressure is all on jamaica. full story https:// worldinsport.com/reggae-boyz-on -the-brink/ … #reggaeboyz #jamaica #worldcup2026	#WorldCup2026	0
886	2026-03-24 14:19:18+00	is the 2026 world cup america’s game-changer? get ready for a cultural revolution in soccer! don’t miss out! #worldcup2026 #soccerinusa https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	0
887	2026-03-24 14:19:18+00	get ready for a soccer revolution! the 2026 world cup will redefine america's game. don't miss out! #worldcup2026 #soccerinusa https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	0
888	2026-03-24 14:19:20+00	is the 2026 world cup america's grand awakening for soccer? even tom brady thinks so! don't miss out! #worldcup2026 #soccerinusa https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	0
889	2026-03-24 14:19:20+00	"get ready, america! the 2026 world cup will elevate soccer to new heights, uniting cultures like never before. #worldcup2026 #culturalunity" https:// spanglishsoccer.substack.com/p/is-the-2026- world-cup-americas-game …	#WorldCup2026	0
890	2026-03-24 14:19:20+00	el mundial de brasil 2014 fue una oda al fútbol, estadios míticos, el fin de un ciclo para españa, resultados históricos y la 4ta estrella para alemania . a meses de la #worldcup2026, recordamos la última gran cita en sudamérica. [18 xi's y otros referentes/promesas]	#WorldCup2026	0
891	2026-03-24 14:19:20+00	only ghana and nigeria that’s even hyping the world cup on twitter, the rest just silent. unfortunately my dear 9ja no qualify, if not this hype for too mad. #worldcup2026	#WorldCup2026	0
892	2026-03-24 14:19:20+00	te invitamos al 4º ciclo de conferencias sobre diplomacia deportiva en eurasia. analizaremos la participación de países de la gran eurasia rumbo a la copa mundial 2026 y su impacto político, económico y social. ¡no te lo pierdas! #worldcup2026 #copamundial #mundial2026 #futbol	#WorldCup2026	0
893	2026-03-24 14:19:22+00	it’s time to #boycottfifa and cancel #worldcup2026 #claudiashenibaum . fifa is a part of trump‘s “peace“ coalition. stop being subservient to your oppressor.	#WorldCup2026	0
894	2026-03-24 14:19:22+00	the us government collected over $1 billion in immigration fees then refused to process the applications. no denials. no refunds. just silence. this is the largest fee fraud in the history of the american immigration system. here's what's happening.	#WorldCup2026	0
895	2026-03-24 14:19:22+00	estadio bbva in monterrey averages 100°f+ in june. it's one of 10 open-air wc2026 venues. know which sections are shaded before you buy → http:// seatsun.com #worldcup2026 #monterrey #wc2026	#WorldCup2026	0
957	2026-03-24 14:40:54+00	you think #tourism in america is already bad? it's about to get a lot worse. #worldcup2026 #ice #terrorizingvisitors #sfo #maga	#WorldCup2026	0
896	2026-03-24 14:19:22+00	takéto niečo vie len stanislav lobotka. ale treba pripomenúť, že to bol dlhý večer a toto bolo počas jeho už xtého rozhovoru. preto ho chápem, ale o to vtipnejšie to celé bolo. stano je super #represr #futbalistaroka #worldcup2026 #sscnapoli	#WorldCup2026	0
897	2026-03-24 14:19:22+00	première sélection : samir el mourabet entre émotion et énorme défi https:// csport.ma/premiers-mots- samir-el-mourabet-maroc/ … #maroc #football #worldcup2026	#WorldCup2026	0
898	2026-03-24 14:19:25+00	on 31st march 6 of these teams will qualify for #worldcup2026 1 : wales, bosnia, italy, n.ireland 2 : ukraine, sweden, poland, albania 3 : slovakia, kosovo, turkey, romania 4 : czech, ireland, denmark, macedonia 5 : jamaica, new caledonia, dr congo 6 : bolivia, suriname, iraq	#WorldCup2026	0
899	2026-03-24 14:19:25+00	bugün 23 mart. wilson firması daha 3 gün sonraki romanya ile playoff maçı oynanmadan piyasaya sürdüğü dünya kupası toplarında türk bayrağına da yer vermiş. turu geçeceğimize garatinti gözüyle bakıyorlar demek ki (sam's club, atalanta, abd) #dünyakupası #worldcup2026 #worldcup	#WorldCup2026	0
900	2026-03-24 14:19:25+00	no se olviden de comprar la bandera de uruguay #worldcup2026	#WorldCup2026	0
901	2026-03-24 14:19:25+00	zidane sets his sights on france – oui, it’s official! #zidane #frenchfootball #worldcup2026	#WorldCup2026	0
902	2026-03-24 14:19:25+00	austria vs ghana loading… international friendly this friday at 17:00! black stars gearing up for #worldcup2026 who’s winning this one? #blackstars #ghanafootball	#WorldCup2026	0
903	2026-03-24 14:19:27+00	houston's asia town and chinatown delivers an authentic experience when it comes to food, people, and culture. if your coming to houston for world cup 2026, take a trip west of downtown and check this part of the city out! #houstontx #houston2026 #worldcup2026 #soccermatters	#WorldCup2026	0
904	2026-03-24 14:19:27+00	world cup playoffs: the final battle for europe’s last spots! #worldcup2026 #wcq #uefa #playoffs #roadto2026	#WorldCup2026	0
905	2026-03-24 14:19:27+00	italy. 4 time world cup winners. they are 90 minutes away from missing the world cup on home soil. italy vs northern ireland. march 26. single leg. no second chances. the most dangerous night in italian football history. #worldcup2026 #azzurri	#WorldCup2026	0
906	2026-03-24 14:19:27+00	it’s the summer we’re all waiting for and in 80 days time we’re finally getting the greatest football competition in the world. the #worldcup2026 is on the way and millions of eyes will be glued on the mexico/south africa game. for the love of the game @fifaworldcup	#WorldCup2026	0
907	2026-03-24 14:19:29+00	mexico city's government has created an #ai to help tourists navigate easily the city during #worldcup2026	#WorldCup2026	0
908	2026-03-24 14:19:29+00	asia x h-town houston’s asia town and chinatown delivers an authentic experience when it comes to food, people, culture. if you’re coming to houston for world cup 2026, take a trip out west and check out this part of the city. #houstontx #houston2026 #worldcup2026	#WorldCup2026	0
909	2026-03-24 14:19:29+00	llegan cartas legendarias a panini adrenalyn xl world cup 2026, aquí los detalles: https:// youtu.be/9xllxeksmwm https:// efootballnews.com.mx/2026/03/llegan -cartas-legendarias-panini.html … #adrenalyn #adrenalyn2026 #worldcup2026 #panini #videojuegos #efootballnewsmx	#WorldCup2026	0
910	2026-03-24 14:19:31+00	italy. wales. republic of ireland. poland. ukraine. all of them could miss the world cup in 3 days time. single-leg knockouts. no second chances. one bad night and you’re watching from your sofa. march 26 is going to be absolutely brutal. #worldcup2026	#WorldCup2026	0
911	2026-03-24 14:19:31+00	all smiles and hugs in the france national team #france #worldcup2026	#WorldCup2026	0
912	2026-03-24 14:19:31+00	¿hasta cuándo las playas de #acapulco estarán "conce$ionada$" por lacrosos en complicidad con autoridades de todos los niveles? ¡ @semarnat_mx @profepa_mx @zofematacapulco @fonaturmx @promotoraplayas son una farsa! los estamos esperando @fifaworldcup #worldcup2026 @visitmex .	#WorldCup2026	0
913	2026-03-24 14:19:34+00	estadio bbva in monterrey regularly hits 100°f+ in june. it's one of 3 wc2026 venues in mexico. open air. no ac. if you're going, you need to know which sections have shade before you buy. http:// seatsun.com → monterrey shade map, free #worldcup2026 #wc2026 #monterrey	#WorldCup2026	0
914	2026-03-24 14:19:34+00	fifa released the first official song for the 2026 world cup on monday, ahead of the tournament which will be hosted by the united states, canada and mexico. the track, titled “lighter,” features jelly roll and carin leon and is produced by cirkut. #worldcup2026 #fifa #lighter	#WorldCup2026	0
915	2026-03-24 14:19:34+00	have you heard the song made for france national team 2026 ? “dembele cherki “ e loud …….. #france #worldcup2026	#WorldCup2026	0
916	2026-03-24 14:19:34+00	before the midterms there's something that will test for real that "involvement" above all things: #worldcup2026	#WorldCup2026	0
917	2026-03-24 14:19:34+00	#worldcup2026 #futbol #soccerwordcup #aliencardshq #toppschrome #football	#WorldCup2026	0
918	2026-03-24 14:19:36+00	i̇ngiliz yıldızlar dünya kupası 2026’da i̇ngiliz tarzı bir kır evi otelinde kalıyorlar #england #worldcup2026 orkun i̇cardi göztepe neymar montella cherki	#WorldCup2026	0
919	2026-03-24 14:19:36+00	estadio bbva in monterrey is hosting wc2026 matches in june. average temperature: 100°f+ it has a partial canopy. upper sections = shade. lower bowl = full sun. check your section before you buy: http:// seatsun.com/stadiums/bbva #worldcup2026 #monterrey #wc2026	#WorldCup2026	0
920	2026-03-24 14:19:36+00	80 days start of the world cup 2026 #worldcup2026	#WorldCup2026	0
921	2026-03-24 14:19:36+00	90 days start of the world cup 2026 #worldcup2026 x.com/10msb/status/2…	#WorldCup2026	0
922	2026-03-24 14:19:38+00	england calls up ben white, passes over trent alexander-arnold #worldcup #worldcup2026	#WorldCup2026	0
923	2026-03-24 14:19:38+00	dünya kupası; 11 haziran/19 temmuz 2026 usa,kanada,meksika i̇zlerim diye çok heveslenmeyin türkiye saatiyle maç başlama saatleri. 22.00 23.00 01.00 02.00 04.00 07.00 #worldcup2026	#WorldCup2026	0
924	2026-03-24 14:19:38+00	atencion, alex, desafortunadamente.. murio. #espn #futbolpicante #worldcup2026 #canal12 #snapdragonstadium #unitedstatesfootballclub #ligamx	#WorldCup2026	0
925	2026-03-24 14:19:38+00	can i plead with all my friends in #thehobby if anyone gets these and wishes to get rid of/flip/gift/trade any scotland players they find (particularly scott mctominay), i am here @cardpurchaser @get_big_cards #worldcup2026 #scotland #panini	#WorldCup2026	0
926	2026-03-24 14:19:38+00	first look: @paniniamerica prizm @fifaworldcup 2026™ the world’s biggest stage meets the hobby’s biggest brand as prizm world cup returns bigger than ever featuring all 48 qualified nations in one global chase! new parallels incoming: aguila /70, maple leaf /86, old	#WorldCup2026	0
995	2026-03-24 15:21:10+00	just got stung by a scorpion in my living room. men, that hurts a lot! what's the best first aid for it? #scorpion	#Spiderman	0
927	2026-03-24 14:19:40+00	morocco, i’m here what if morocco /puma dropped that kind of shoot? كون دار هذا النوع ديال الفوتوشوت غادي يكون تسويق مختلف #morocco #worldcup2026 #jersey #photoshoot #المغرب	#WorldCup2026	0
928	2026-03-24 14:19:40+00	el #mundial2026 se va transmitir por youtube #fifaworldcup2026 #worldcup2026 #youtube #copadelmundo	#WorldCup2026	0
929	2026-03-24 14:19:40+00	yeni türkiye formalarımız gayet güzel #worldcup2026	#WorldCup2026	0
930	2026-03-24 14:19:40+00	here's what's making headlines in the world of sports: read more: http:// channelonnewsonline.com powered by channel one research desk #channelonesports #blackstars #worldcup2026 #ghanafootball #icct20 #cricket #sportsnews #newswrap	#WorldCup2026	0
931	2026-03-24 14:19:43+00	italia 90.... i was only 8 and the first match i remember is the romania game.... " a nation holds its breath " #worldcup2026	#WorldCup2026	0
932	2026-03-24 14:19:43+00	italy face a wc playoff semifinal march 26 - if they qualify, uefa playoff b winner meets tunisia at monterrey stadium (bbva), june 14. june temps 32-36°c - book a hotel with a pool. http:// monterreystadium.com #wc2026europe #worldcup2026 #monterrey	#WorldCup2026	0
933	2026-03-24 14:19:45+00	group j decider: jordan vs algeria at san francisco stadium (levi's), june 22 at 8pm pt. algeria's squad is largely european-based - strong technical side. bay area evenings drop to 15-18°c; bring a layer. http:// sanfranciscobayareastadium.com #wc2026europe #worldcup2026 #bayarea	#WorldCup2026	0
934	2026-03-24 14:19:45+00	mpanse anvan #worldcup2026 lan ! leta ak @fhfhaiti - fédération haïtienne de football lan dwe òganize yon vwayaj ak jwè seleksyon pou vini okap ! òganize yo vizite citadelle laferrière ak jwè yo ! anpil nan jwè yo bezwen enèji @ayibo_sport sa ! #haiti #worldcup2026	#WorldCup2026	0
935	2026-03-24 14:19:45+00	@rifiband https:// youtu.be/ovgks5lm73w?si =x16c97xhbioqjxk3 … #england #anthem #worldcup2026 #mentalhealth #standtogether	#WorldCup2026	0
936	2026-03-24 14:19:45+00	a 48-team world cup across 3 countries means fans will need more than just tickets. @karnfromgoldon joined sdh am to talk about fan path and its effort to bring travel planning, housing, & fan communities into one place ahead of #worldcup2026.	#WorldCup2026	0
937	2026-03-24 14:19:47+00	@fifamedia #worldcup2026 dear turist, as a person that deeply love jalisco, please, don't come. we have security and infraestructure major issues and the cherry on the pay is this water supply that @gobiernojalisco has been incompetent to supply clean it enough for human use.	#WorldCup2026	0
938	2026-03-24 14:19:47+00	tengo un anuncio importante que compartirles. aunque desde hace muchos años el @siapagdl vive una crisis institucional y de presupuesto, asumo mi responsabilidad histórica en el rescate del organismo operador del agua, dedicando todos los recursos posibles para su recuperación y	#WorldCup2026	0
939	2026-03-24 14:19:47+00	o sea, no esta bien en ninguna colonia!! pero pues ahí viene el #worldcup2026 y la ciudad se ve increíble y su seguridad de 1er mundo... spoiler, is noooot! @fifaworldcup	#WorldCup2026	0
940	2026-03-24 14:19:47+00	#worldcup2026 anulad el viaje! cancel your travel plans!	#WorldCup2026	0
941	2026-03-24 14:19:49+00	and that's how the champions celebrated tonight. india india #worldcup2026 #t20worldcup2026final	#WorldCup2026	0
942	2026-03-24 14:19:49+00	@paulpogba il vous faut garder espoir, faire preuve de patience et vous battre pour atteindre la coupe du monde et la ligue des nations de l'uefa. nous sommes avec vous et nous vous attendons. #worldcup2026	#WorldCup2026	0
943	2026-03-24 14:19:49+00	las nuevas equipaciones de croacia para la copa del mundo de 2026. a la primera le favorece la franja blanca de en medio, mientras que a la segunda, en mi modesta opinión, no le favorece tanto. ¿vosotros qué opináis, camaradas? #hns #vatreni #worldcup2026	#WorldCup2026	0
944	2026-03-24 14:19:49+00	adidas.. the best saudint #worldcup2026	#WorldCup2026	0
945	2026-03-24 14:19:51+00	over the last few days, 18 national teams have already unveiled their uniforms for the 2026 world cup, and the rivalry for the best kit is already on ! what's your #1 so far? https:// flashscore.com/news/soccer-wo rld-cup-which-teams-have-already-released-their-kits-for-the-2026-world-cup/faklhrrb/ … #worldcup2026	#WorldCup2026	0
946	2026-03-24 14:19:51+00	¡última hora! zinedine zidane ha dicho sí a convertirse en el nuevo seleccionador de francia! didier deschamps afirma que quiere retirarse después del mundial de 2026. #marketdeportivo #worldcup2026	#WorldCup2026	0
947	2026-03-24 14:19:51+00	¡faltan 100 días para el inicio de la copa mundial 2026! los 5 favoritos a ganarla según las casas de apuesta españa 5.50/1 inglaterra 6.50/1 francia 9/1 argentina 9/1 brasil 9/1 #marketdeportivo #worldcup2026	#WorldCup2026	0
948	2026-03-24 14:19:51+00	the world cup is coming and so is the demand discover airbnb’s latest incentive announcement for local residents! read more at the link below https:// bergenrealestate.com/world-cup-2026 -airbnb-offers-750-usd-to-new-bergen-county-hosts/ … #bergencounty #worldcup2026 #njrealestate #airbnbopportunity #metlifestadium	#WorldCup2026	0
949	2026-03-24 14:19:53+00	discours franc de notre légendaire « waddle » concernant les playoffs « on se bat juste pour une chose, la kanaky ! » « c’est sur un match, le petit peut toujours gagner comme en coupe de france. » #worldcup2026 #kanaky #nouvellecalédonie	#WorldCup2026	0
950	2026-03-24 14:19:56+00	#breaking ice agents now on the ground at airports! while democrats keep tsa workers unpaid and lines stretch for hours, @potus and tom homan just deployed ice officers to keep airports moving. this is what real leadership looks like: stepping in to help american workers	#WorldCup2026	0
951	2026-03-24 14:19:56+00	who’s the player- world cup edition answer to last q ernst happel . . . . daily quiz, every evening.. thanks for your interactions #footballnerd #worldcup #worldcup2026	#WorldCup2026	0
952	2026-03-24 14:19:56+00	get ahead of the game! #worldcup2026 travel #carhire #flights #ukairportparking https:// bit.ly/3vzwxuk supporting @ssafa & @blesma #travel #canada #mexico #usa #football #soccer #holidays #forces #expat #forcescarhire #mhhsbd	#WorldCup2026	0
953	2026-03-24 14:19:58+00	umpan dengan 200 iq! bukan cuma skill, tapi visi permainan yang bikin lawan benar-benar terkecoh. #dewacash #pialadunia2026 #worldcup2026 #fifaworldcup2026 #wc2026 #roadto2026 #garudamendunia	#WorldCup2026	0
954	2026-03-24 14:19:58+00	this should be fun during #worldcup2026 @fifaworldcup	#WorldCup2026	0
955	2026-03-24 14:19:58+00	if you are from another country i urge you not to come to america. it's not safe for you here. psycho trump and his private army of ice soldiers have taken over airports. they can decide to arrest you without cause and keep you in a cage for months. america is not safe!	#WorldCup2026	0
956	2026-03-24 14:19:58+00	| مباريات المنتخبات العربية في مارس استعداداً لكأس العالم 2026 | arab national teams' matches in march in preparation for the 2026 world cup #worldcup2026	#WorldCup2026	0
958	2026-03-24 14:40:54+00	"international window vibes: with injuries piling up (saliba, gabriel out), which club gets hit hardest right now? a) arsenal b) chelsea c) man city d) other (reply!) drop your take! #football #worldcup2026"	#WorldCup2026	0
959	2026-03-24 14:40:56+00	usmnt upcoming schedule - friendly vs uruguay to close out 2025; world cup next summer - nbc sports read more → https:// newzly.ai/article/127128 -usmnt-upcoming-schedule-friendly … #usmnt #worldcup2026 #uruguayfriendly	#WorldCup2026	0
960	2026-03-24 14:40:56+00	congress, republicans and democrats together, presented a deal to trump to end the airport nightmares. trump rejected it. he's demanding the save act be passed as a condition. he's also sending ice to airports, though it's unclear what exactly they'd be doing. america. 2026.	#WorldCup2026	0
961	2026-03-24 14:40:58+00	قائمة منتخب أوروغواي المُستدعاة للتوقف الدولي لمواجهة إنجلترا والجزائر. #news #كأس_العالم_2026 #worldcup2026	#WorldCup2026	0
962	2026-03-24 14:40:58+00	cancel #worldcup2026	#WorldCup2026	0
963	2026-03-24 14:40:58+00	slovenskí futbalisti pred tréningom s víťazmi me 1976, ktorí im zaželali veľa šťastia v baráži o ms 2026 #represr #worldcup2026	#WorldCup2026	0
964	2026-03-24 14:40:58+00	france have had a lot of bangers through the years. this one is no different . #france #worldcup2026	#WorldCup2026	0
965	2026-03-24 14:40:58+00	youtube makes #worldcup2026 deal with #fifa that lets broadcasters show parts of games live. #fyi #football #media #voetbal	#WorldCup2026	0
966	2026-03-24 14:51:51+00	@grok score prediction please #predictionmarkets #worldcup2026 #türkiyeromania	#WorldCup2026	0
967	2026-03-24 14:51:59+00	the arrival of the french national team players at camp is just a regular fashion show. the quality of fits and players, this is insane	#WorldCup2026	0
968	2026-03-24 14:52:49+00	#acapulco | turistas denuncian cobros ilegales en playa papagayo un video viral de la semana muestra el momento en que prestadores de servicios intentaron cobrarle a una pareja de visitantes 200 pesos por estacionarse en la vía pública y 400 pesos adicionales por usar su	#WorldCup2026	0
969	2026-03-24 14:52:56+00	todo se prestava para que alex aguinaga fuera la gran promesa futbolística... se intereso en los bares a finales de sus treinta...	#WorldCup2026	0
970	2026-03-24 14:53:04+00	por esto estamos pagando?? @siapagdl no es posible que el agua esté saliendo así en jardínes del country @trafico_zmg	#WorldCup2026	0
971	2026-03-24 14:53:04+00	ice is not at airports to help tsa and reduce lines. they are there (without identification) trying to arrest people, exactly as i predicted. ice must be abolished. x.com/surajit_ghosh2…	#WorldCup2026	0
972	2026-03-24 14:53:06+00	so, ice is working the airports as tsa now, you say? after terrorizing innocent people in the streets? and they aren't wearing masks at their new assignment? how interesting! i feel like this moment should be documented in photos of these so called "patriots." lots of them.	#WorldCup2026	0
973	2026-03-24 14:53:19+00	ice detain mother at airport—traveling with young daughter. first reported kidnapping at airport since trump ordered ice agents to report—refuse to show id. "i don't know who you are!" witness yells. "you could be someone kidnapping her!" agent continue to refuse to show id	#WorldCup2026	0
974	2026-03-24 15:20:57+00	250324 윤호 인스타 your friendly neighborhood#yunhois3gram #spiderman	#Spiderman	0
975	2026-03-24 15:20:57+00	your friendly neighborhood #yunhois3gram #spiderman	#Spiderman	0
976	2026-03-24 15:20:57+00	which spider man is better? tobey magui̇re andrew garfiled tom holland #spiderman	#Spiderman	0
977	2026-03-24 15:20:57+00	“un gran poder conlleva una gran responsabilidad.” — tío ben la base de todo héroe. #spiderman #marvel #fgbonlinestore	#Spiderman	0
978	2026-03-24 15:20:57+00	mary jane watson — dazzling in a bold spider-inspired outfit, she radiates confidence, charm, and the iconic style that makes her unforgettable #maryjane #spiderman #aiart	#Spiderman	0
979	2026-03-24 15:21:00+00	zamanında diğer sm oyunlarını da alabilseydim keşke... #spiderman	#Spiderman	0
980	2026-03-24 15:21:00+00	her biri ayrı güzel be!	#Spiderman	0
981	2026-03-24 15:21:00+00	uh oh, looks like spidey is in trouble! #peterparker #spiderman #sexy	#Spiderman	0
982	2026-03-24 15:21:00+00	with the new crossover coming tomorrow, i just wanted to remind people of this panel #superman #spiderman #dccomics #marvel	#Spiderman	0
983	2026-03-24 15:21:03+00	من سيفوز في مواجهة بين سبايدرمان لتوم هولاند وكينغ بين لفينسنت دونوفريو؟ لن نعرف الإجابة ما لم تتمكن marvel وsony من حل خلافات الحقوق بينهما. للمزيد: https:// bit.ly/41n4mpz #spiderman #kingpin #marvel	#Spiderman	0
984	2026-03-24 15:21:03+00	can venom break spider-man? dive into the emotional chaos! #spiderman #venom	#Spiderman	0
985	2026-03-24 15:21:03+00	yo, cada que recuerdo que salió el tráiler de spider-man brand new day #spiderman #marvel #trailer #thecinemagic #spidermanbrandnewday	#Spiderman	0
986	2026-03-24 15:21:05+00	am i the only one?: am i the only one who remembers the first time i saw eman esfandi? this t-shirt makes me smile thinking about those early days before spider-man took off! such a fun throwback. https:// shirtkaya.com/product/t-shir t/1952583-i-knew-eman-esfandi-before-spider-man-brand-new-day … #spiderman #emanesfandi #throwback #tshirtlove	#Spiderman	0
987	2026-03-24 15:21:05+00	mcu #spideytorch #humantorch #spiderman	#Spiderman	0
988	2026-03-24 15:21:05+00	en attendant, allez voir projet dernière chance ! #spiderman	#Spiderman	0
989	2026-03-24 15:21:05+00	this is for you, spider-man freaks and tom holland fans… ps, as a matter of fact yes, i do have a clips channel. thank you for asking. https:// youtu.be/oh44w7jfq3w?si =f9jhmi8jyqtxjuvb … #spiderman #tomholland #spidermanunnuevodía	#Spiderman	0
990	2026-03-24 15:21:08+00	la tercera película de tom holland como #spiderman dejo en taquilla algo más de 1900 millones de dólares a quienes somos nostálgicos nos emociono bastante volver a ver a tobey y andrew con el traje de #spiderman y haciendo equipo con tom	#Spiderman	0
991	2026-03-24 15:21:08+00	that og spider-man reference was too clean #spiderman #marvel #comics #fyp #viral	#Spiderman	0
992	2026-03-24 15:21:08+00	i just got a random idea. what if the spot encounters caine? #spiderman #digitalcircus #spiderverse	#Spiderman	0
993	2026-03-24 15:21:10+00	la siguiente película de #spiderman hasta ahora es la más emocionante de todas por todo el misterio que generó que si un multiverso!! que si 3 tom holland! que tal vez volvían los spiderman anteriores pero ellos decían que no #spidermannowayhome año: 2021	#Spiderman	0
994	2026-03-24 15:21:10+00	peter parker got bitten by a spider and he became #spiderman. i got stung by a scorpion , what would i become? i need a superhero name, please! #scorpionpower #mcu #tuesdayvar	#Spiderman	0
996	2026-03-24 15:21:10+00	all three recent mafex are still available for pre-order: aquaman-joker & b&g spider-man at hobby link japan & nin nin game. hlj https:// go.flyguytoys.com/hljmafex nng https:// go.flyguytoys.com/nngmafex #mafex #ad #spiderman	#Spiderman	0
997	2026-03-24 15:21:13+00	black cat having the venom symbiote sounds like a cool mini series comic that should happen! #blackcat #venom #spiderman #marvel #comics #marvelcomics	#Spiderman	0
998	2026-03-24 15:21:13+00	#spiderman #thor	#Spiderman	0
999	2026-03-24 15:21:13+00	you gotta move on at that point #trending #fypシ゚viral #spiderman #fyp #viral	#Spiderman	0
1000	2026-03-24 15:21:13+00	doth protest too much @therealsupes you literally defending how you like spider-man trying to do a bunch of rumors about how you talk about it. double taking loyal to nothing clout chasing trend hopping reactor. trying to double down on your defense. #spiderman quit yappin	#Spiderman	0
1001	2026-03-24 15:21:15+00	really proud how this one turned out @marvelstudios red goblin transformation #comics #greengoblin #spiderman #marvel #animation #marvelfanart	#Spiderman	0
1002	2026-03-24 15:21:15+00	new youtube action figure review: marvel legends spider-man mj zendaya http:// youtube.com/louisbernal #spiderman #marvel #marvellegends #zendaya #actionfigures	#Spiderman	0
1003	2026-03-24 15:21:15+00	swim x spider-man. #bts_swi̇m #spiderman	#Spiderman	0
1004	2026-03-24 15:21:15+00	nice little grab!! #spidermanvspredator #spiderman #predator #marvel #dc #marveldc #spidermancomics #predatorcomics #cgc	#Spiderman	0
1005	2026-03-24 15:21:18+00	i don't blame anyone for liking hobgoblin because we lost a lot when we lost green goblin. but the truth is he's dead. and gone. and copy-cat characters are lame. #spiderman	#Spiderman	0
1006	2026-03-24 15:21:18+00	c'est pour ça que les jeux spider man sont juste incroyable non ouvert au débat #spiderman #jeux #marvel	#Spiderman	0
1007	2026-03-24 15:21:18+00	continuing our fun webhead ilocos adventures as we visit patapat bridge, blue lagoon, saud beach, bangui windmills, kapurpurawan, cape bojeador lighthouse, camp bojeador and pasuquin arc! #spiderman #spidey #peterparker #marvel #avengers #superhero #cosplay #thetravelingspidey	#Spiderman	0
1008	2026-03-24 15:21:18+00	touchdown, ilocos! enjoying fun adventures in ilocos norte as we visit malacanang of the north, paoay church, laoag sand dunes, bacarra church & bell tower and laoag cathedral! #spiderman #spidey #peterparker #marvel #avengers #superhero #cosplay #thetravelingspidey	#Spiderman	0
1009	2026-03-24 15:21:20+00	พวงกุญแจ spider man/สไปเดอร์แมน disneyland hongkong มีไฟ เปิดปิดไฟได้ 500 ส่งฟรี (ซื้อมาเองกับมือค่ะ แต่ไม่อยากเก็บแล้ว) สนใจ/สอบถาม ทักdm #ส่งต่อของสะสม #disneyland #spiderman #พวงกุญแจตุ๊กตา #พวงกุญแจ #ตลาดนัดอนิเมะ #ตลาดนัดดิสนีย์	#Spiderman	0
1010	2026-03-24 15:21:20+00	ส่งต่อ/ปล่อย/ขาย พร้อมส่ง พวงกุญแจ spider man/สไปเดอร์แมน disneyland hongkong มีไฟ เปิดปิดไฟได้ 500 ส่งฟรี (ซื้อมาเองกับมือค่ะ แต่ไม่อยากเก็บแล้ว) สนใจ/สอบถาม ทักdm #ส่งต่อของสะสม #disneyland #spiderman #พวงกุญแจตุ๊กตา #พวงกุญแจ #ตลาดนัดอนิเมะ #ตลาดนัดดิสนีย์	#Spiderman	0
1011	2026-03-24 15:21:20+00	back with #spidermanbrandnewday poster designed by me thoughts? #spiderman #marvel #spidermanbnd	#Spiderman	0
1012	2026-03-24 15:21:20+00	#gawdshots #virtualphotography #spiderman	#Spiderman	0
1013	2026-03-24 15:21:23+00	un nuevo día comienza. disfruta ya del tráiler oficial de #spidermanbrandnewday 31 de julio, exclusivamente en los cines #spiderman #marvel #cinesimperial #sabadell	#Spiderman	0
1014	2026-03-24 15:21:23+00	spider-man brand new day trailer breakdown in hindi. youtube link - https:// youtu.be/eedg64vuthi?si =kf0hqe1a8fesbeos … #spiderman #spidermanbrandnewday #sonypictures #marvel #tomholland	#Spiderman	0
1015	2026-03-24 15:21:23+00	only 2000s people know this? am i right? #gwenstacy #spiderman #tobeymegiure #gwen #2002 #marvel	#Spiderman	0
1016	2026-03-24 15:21:25+00	best one yet #spiderman #marvel #brandnewday	#Spiderman	0
1017	2026-03-24 15:21:25+00	likeeeeeekrjdjdk x.com/myyouwithjk/st…	#Spiderman	0
1018	2026-03-24 15:21:25+00	spider-man nerf gun : nerf sniper #spiderman #nerfsniper #comedyvideo https:// youtube.com/shorts/5a5zlq8 cjcs?si=bbxu9o1wqtlmwy3o … qua @youtube	#Spiderman	0
1019	2026-03-24 15:21:25+00	wtf wtf wtf wtf wtf wtf.... please be it andrew .... please be it andrew ..... i am gonna flip it this trio will come again... #spiderman	#Spiderman	0
1020	2026-03-24 15:21:25+00	#spiderman	#Spiderman	0
1021	2026-03-24 15:21:28+00	24 மணி நேரத்தில் அதிகம் பார்க்கப்பட்ட spider-man படத்தின் டிரெய்லர்கள்! #spiderman #spidermanmovies #marvel #marvelstudios #mcu #movietrailers #marvelfans #superheromovies #spidermanfans	#Spiderman	0
1022	2026-03-24 15:21:28+00	how were things in 2025 for you guys? #spiderman	#Spiderman	0
1023	2026-03-24 15:21:28+00	spiderman — trailer x motion graphics . #spiderman #motiondesign	#Spiderman	0
1024	2026-03-24 15:21:30+00	waiting for #spidermanbeyondthespiderverse , , 452 days to go , , #spiderman #sony #haileesteinfeld #shameikmoore #milesmorales #gwenstacy #spiderverse	#Spiderman	0
1025	2026-03-24 15:21:30+00	algo raro pasa con spider-man: brand new day… el tráiler cambia según el país en algunos desaparecen los lanzaredes https:// cmcs.es/smbndd #spiderman #brandnewday #marvel #spiderman4 #ucm #marvelstudios	#Spiderman	0
1026	2026-03-24 15:21:30+00	i was handed a stack of comics from one of my participants at my stop motion course today. absolute bonkers story and artwork from bernie and michelle wrightson, really helps the larger format! #spiderman #berniewrightson #theamazingspiderman #marvelcomics	#Spiderman	0
1027	2026-03-24 15:21:30+00	ojo solo comentaré sobre las películas individuales de #spiderman claro también tuvo una destacada participación en capitán américa guerra civil del año 2016 ,en #infinitywar (2018) y #endgame(2019)	#Spiderman	0
1028	2026-03-24 15:21:33+00	peter parker scene from the trailer when he was in a spider cocoon..... will he get a transformation into man-spider? #spiderman #brandnewday #daredevil #echo #jessicajones	#Spiderman	0
1029	2026-03-24 15:21:33+00	the amazing spider-man #spiderman #theamazingspiderman #andrewgarfield	#Spiderman	0
1030	2026-03-24 15:21:33+00	la película #spidermanfarfromhome es la primera película de #spiderman en pasar la barrera de los mil millones en taquilla.	#Spiderman	0
1109	2026-03-24 15:22:21+00	13. inverted upgraded suit (#mcu) #peterparker #spiderman #spidermannowayhome	#Spiderman	0
1031	2026-03-24 15:21:33+00	la segunda película de tom holland como #spiderman se llamo #spidermanfarfromhome o spiderman lejos de casa. data del año 2019 fue post #endgame también actuaron : samuel l. jackson, zendaya y jake gyllenhaal tuvo un presupuesto de 160 millones taquilla: 1.132 millones	#Spiderman	0
1032	2026-03-24 15:21:35+00	just another edit from my tiktok(21_marvel) #spiderman #spidermanbrandnewday #marvel #imaginedragons	#Spiderman	0
1033	2026-03-24 15:21:35+00	what if spider-man brand new day happened in the 2000s pre-mcu featuring tobey maguire spider-man, eric bana and thomas jane #spidermanbrandnewday #marvel #spiderman	#Spiderman	0
1034	2026-03-24 15:21:35+00	peter thats gross #vtuber #spiderman	#Spiderman	0
1035	2026-03-24 15:21:35+00	first look at zendaya in ‘spider-man: brand new day.’ #zendaya #spiderman	#Spiderman	0
1036	2026-03-24 15:21:37+00	and this is how your favourite cinema is made #spiderman #titanic #movienews	#Spiderman	0
1037	2026-03-24 15:21:37+00	#thedevilwearsprada was never just a fashion film for me, it understood that fashion is not frivolous.. it is language, hierarchy, editing, instinct and a thousand invisible decisions before something reaches the rest of us.. you see it in #andy learning to see, in #emily	#Spiderman	0
1038	2026-03-24 15:21:37+00	spider-man (2002) spider-man: brand new day (2026) #spiderman #spidermanbrandnewday	#Spiderman	0
1039	2026-03-24 15:21:37+00	grab the iconic soundtrack on vinyl for just $21.99! perfect for fans of the film and vinyl collectors! https:// amazon.com/dp/b07nrf9nzy? tag=emmadeals-20&linkcode=ogi&th=1&psc=1 … price: $22 (21% off) #amazon #spiderman #vinyl #soundtrack #ad	#Spiderman	0
1040	2026-03-24 15:21:40+00	spider-man: brand new day படத்தில் savage hulk மீண்டும் வருவார் என்று தகவல் வெளியாகியுள்ளது #spidermanbrandnewday #spiderman #hulk #savagehulk #greyhulk #marvel #mcu #marvelupdates	#Spiderman	0
1041	2026-03-24 15:21:40+00	we are officially caught up on editing so i can resume editing other footage nothing that needs to be done asap and also recording and streaming again soon again here soon anyways here's part 9 of #spiderman via @youtube #streamer #contentcreator	#Spiderman	0
1042	2026-03-24 15:21:40+00	seguí dibujando. agregué sombras. detalles. firmé el sketch. no por ego. por costumbre. por esa necesidad absurda de dejar evidencia de que estuviste aquí. #spidermanunnuevodía #spiderman #sketch #fanart	#Spiderman	0
1043	2026-03-24 15:21:42+00	rumor: joe keery is being linked to spider-man: brand new day fans are already pushing him as harry osborn / green goblin… not confirmed yet. rumor would like to see him in spiderman guys? #spiderman	#Spiderman	0
1044	2026-03-24 15:21:42+00	yeah that's pete for you #spiderman	#Spiderman	0
1045	2026-03-24 15:21:42+00	top 5 biggest villains in spiderman. what do you think? #spiderman	#Spiderman	0
1046	2026-03-24 15:21:44+00	#spiderman #smremastered #virtualphotography	#Spiderman	0
1047	2026-03-24 15:21:44+00	meet ben reilly, the ultimate clone hero! swing into action with this exclusive spider-man - scarlet spider pop! vinyl. shop now at https:// titanpopculture.com.au/products/spide r-man-scarlett-spider-ben-reilly-us-exclusive-pop-vinyl-rs … #spiderman #scarletspider #benreilly	#Spiderman	0
1048	2026-03-24 15:21:44+00	spider-man saving new york… but slowly losing himself in spider-man: brand new day, peter is doing good in new york but starts feeling a weird mutation in his body he turns to bruce banner for help… but things spiral when hulk gets involved #spiderman #viralreels #marvel	#Spiderman	0
1049	2026-03-24 15:21:46+00	all villains in spider-man: brand new day oh boy #spiderman	#Spiderman	0
1050	2026-03-24 15:21:46+00	hoy he visto la última película de #spiderman (tom holland) es un películon pero estoy completamente destrozada,me gustó ver los momentos más románticos de #petermj pero ese final no compensa,todo el sufrimiento de peter y acabar solo…peter parker mereces tu final feliz	#Spiderman	0
1051	2026-03-24 15:21:46+00	hoy me hice una noche de pelis para ver de nuevo las películas de #spiderman de tom holland aprovechando q ha salido el trailer del próximo estreno ( #spidermanbrandnewday ) me encantó revivir los momentos bonitos de #petermj y los momentos felices y fuertes de peter…	#Spiderman	0
1052	2026-03-24 15:21:46+00	marvel rivals: spiderman vs scarlet witch and white fox #marvelrivals #spidermanunnuevodía #spiderman #whitefox #avengersdoomsday	#Spiderman	0
1053	2026-03-24 15:21:49+00	unreleased clip from spider-man: no way home. #spiderman	#Spiderman	0
1054	2026-03-24 15:21:49+00	bollyman is much more powerful than #spiderman, #superman, & everyone else! #bollywood used to make chapri class films for the front benchers & mass masaala now they are fcuked as even the front benchers & chapris love quality movies like #dhurandha, #kantara, #chhava etc.!	#Spiderman	0
1055	2026-03-24 15:21:51+00	important reminder that #deadpool calling #spiderman 'baby boy' is canon. #spideypool ftw	#Spiderman	0
1056	2026-03-24 15:21:51+00	haiiii im looking for #spiderman mutuals!!!! - mina, 18 - she/her - i love andrew garfield - also going to talk about books and other shows probably #moots #moothunt if this flops its ai and i didn't make this	#Spiderman	0
1057	2026-03-24 15:21:51+00	it’s a brand new day #spiderman	#Spiderman	0
1058	2026-03-24 15:21:51+00	the amazing spider-man omnibus vol. 1 by stan lee, steve ditko, jack kirby - in 1962, stan lee and steve ditko created one of the most enduring icons in american popular media: the amazing spider-man! https:// amzn.to/3bwrxs5 #spiderman #stanlee	#Spiderman	0
1059	2026-03-24 15:21:53+00	my autism is beyond your understanding. #spiderman #spidermanart #deltarune #deltaruneart	#Spiderman	0
1060	2026-03-24 15:21:53+00	#neiljosten #spiderman #wip	#Spiderman	0
1061	2026-03-24 15:21:53+00	i did one more #nightwing #spiderman #spidywing	#Spiderman	0
1062	2026-03-24 15:21:53+00	cuando tu novio es medio wachin #spiderman #nightwing #spidywing x.com/neuron2k/statu…	#Spiderman	0
1063	2026-03-24 15:21:55+00	iron man merite il nouvelle génération comme pour spiderman !!!! #ironman #spiderman #marvel #marvelnews	#Spiderman	0
1064	2026-03-24 15:21:55+00	「誰の中にもヒーローがいる。」 マーベル・スタジオ『スパイダーマン：ブランド・ニュー・デイ』 2026年7月31日公開まであと129日。 ファンアート： @nordicgraphics 、 @bosslogic 、 @sahinduzgunart 、 @ursrockrider #スパイダーマン #spiderman #ブランドニュー・デイ #映画	#Spiderman	0
1065	2026-03-24 15:21:55+00	“hay un héroe en todos nosotros.” marvel studios’ spider-man: brand new day se estrena en cines dentro de 129 días, el 31 de julio de 2026. fan art por: nordicgraphics, bosslogic, sahinduzgunart, ursrockrider #spiderman #spidermanbrandnewday #estreno #cine	#Spiderman	0
1110	2026-03-24 15:22:21+00	12. stealth suit (#mcu) #peterparker #spiderman #spidermanfarfromhome	#Spiderman	0
1111	2026-03-24 15:22:23+00	10. upgraded suit (#mcu) #peterparker #spiderman #spidermanfarfromhome #spidermannowayhome	#Spiderman	0
1066	2026-03-24 15:21:57+00	“hay un héroe en cada uno de nosotros.” marvel studios’ spider-man: brand new day llega a los cines en 129 días, el 31 de julio de 2026. fan art por: @nordicgraphics , @bosslogic , @sahinduzgunart , @ursrockrider #spidermancountdown #spidermanbrandnewday #spiderman #marvelstudios	#Spiderman	0
1067	2026-03-24 15:21:57+00	miles morales: across the spider-verse edit | "bones" #spiderverse #milesmorales #spiderman #acrossthespiderverse #marveledit #gwenstacy #spiderman2099 #amv #imaginedragons #sonyanimation #multiverse #spidersociety	#Spiderman	0
1068	2026-03-24 15:21:57+00	con ustedes su frase de película. #spiderman 3 (2007)	#Spiderman	0
1069	2026-03-24 15:21:57+00	130 days left for spider man brand new day. #spidermanbrandnewday #spiderman #marvel #comics #mcu	#Spiderman	0
1070	2026-03-24 15:21:59+00	happy tuesday #spiderman	#Spiderman	0
1071	2026-03-24 15:21:59+00	destin daniel cretton the legend your becoming. #wonderman #spiderman #shangchi	#Spiderman	0
1072	2026-03-24 15:21:59+00	‘wonder man’ has been renewed for season 2 at disney+	#Spiderman	0
1073	2026-03-24 15:21:59+00	would you want this darker spider-man? brand new day concept poster looks crazy (via @ilyasmosbah ) #spiderman #brandnewday #marvel #marvelstudios #spidermanmovie #tomholland #mcu #movieposter #conceptart #cinema #trending	#Spiderman	0
1074	2026-03-24 15:22:01+00	mentorship secrets! can peter handle the big city? what do you think? #spiderman #milesmorales	#Spiderman	0
1075	2026-03-24 15:22:01+00	#mafex no.308 spider-man black & gold suit 予約受付中 https:// 1999.co.jp/11358558 『spider-man: no way home』より「#spiderman black & gold suit」が登場！ 頭部パーツ3種/マジックゲートやマジックガントレット用のエフェクトパーツ/各種ウェブパーツ/可動式フィギュアスタンド付属！	#Spiderman	0
1076	2026-03-24 15:22:01+00	#spidermanfanart #spiderman	#Spiderman	0
1077	2026-03-24 15:22:01+00	i think people with fandom ocs should assert their dominance by treating their oc like a fully canon character. use the actual media # when posting art of them & if people ask "who tf is that" become extremely cryptic or go "duh it's [name]" like they're supposed to know	#Spiderman	0
1078	2026-03-24 15:22:04+00	#spidermanhomecoming tiene como protagonistas a tom holland, robert downey jr, michael keaton y zendaya es la primera película de #spiderman en el denominado ucm	#Spiderman	0
1079	2026-03-24 15:22:04+00	toca conversar de la primera película de tom holland como #spiderman #spidermanhomecoming se realizó en el año 2017 luego de su aparición importante en civil wars su presupuesto fue de 180 millones su recaudación final fue de 880 millones	#Spiderman	0
1080	2026-03-24 15:22:06+00	homem aranha one final day #spiderman	#Spiderman	0
1081	2026-03-24 15:22:06+00	brand new day filminde peter'ın yaşayacağı min olaylar hahahah #spiderman #çizgiroman	#Spiderman	0
1082	2026-03-24 15:22:06+00	spiderwomen black, requested by a follower on tiktok: https:// tiktok.com/@maki_iyushima ?_r=1&_t=zs-94wfnjkss6m … #spidermanunnuevodía #spiderman #black #blacklist	#Spiderman	0
1083	2026-03-24 15:22:06+00	that freefall scene will be #spidermanbrandnewday #joethegeeksmarvelmondays #spiderman #marvel #mcu #tomholland #peterparker #yourfriendlyneighborhoodspiderman #spidey #absolutepeak #absolutepeakmeme #absolutecinema #joethgeek	#Spiderman	0
1084	2026-03-24 15:22:08+00	#spiderman #hombrearaña #spidermanfanart	#Spiderman	0
1085	2026-03-24 15:22:08+00	pre-orders open! mafex no.308 mafex spider-man black & gold suit (medicom toy) order from https:// amiami.com/eng/search/lis t/?s_st_list_preorder_available=1&s_st_list_backorder_available=1&s_st_list_newitem_available=1&s_keywords=spider-man%e3%80%80medicom%20toy&utm_source=twitter_en&utm_medium=social&utm_campaign=twitter … #spidermannowayhome #spiderman #peterparker	#Spiderman	0
1086	2026-03-24 15:22:08+00	https:// youtube.com/live/axku75ffe bc?si=vuzhbbm0odkxuz4w … #spiderman #marvel #mcu	#Spiderman	0
1087	2026-03-24 15:22:08+00	"parker hates it when i get the drop on him." "i hate it when he gets the drop on me." here we have spider-man chasing venom throughout the city. based off a scene from neversoft's spider-man. #spiderman #venom	#Spiderman	0
1088	2026-03-24 15:22:11+00	suit up! peni parker and sp//dr have officially joined the roster of marvel tokon: fighting souls! #marveltokon #peniparker #spiderman #marvelgames #fightingsouls	#Spiderman	0
1089	2026-03-24 15:22:11+00	waiting for a brand new day a little fanmade poster #spidermanbrandnewday #spidermanunnuevodía #spiderman	#Spiderman	0
1090	2026-03-24 15:22:11+00	lars as #mysterio from #spiderman in #tekken8 #tekken8edit follow me for more	#Spiderman	0
1091	2026-03-24 15:22:13+00	23. 1977 suit #peterparker #spiderman #theamazingspiderman	#Spiderman	0
1092	2026-03-24 15:22:13+00	22. 1978 suit #takuyayamashiro #spiderman	#Spiderman	0
1093	2026-03-24 15:22:13+00	he saved the villain, saved mj and ned's future, but he couldn't save himself and aunt may. #spiderman is a curse, a curse that prevents peter from finding happiness.	#Spiderman	0
1094	2026-03-24 15:22:13+00	#spiderman #funko	#Spiderman	0
1095	2026-03-24 15:22:15+00	#mafex anuncia más figuras del universo fílmico, #spiderman black & gold suit de la película no way home y #aquaman stealth suit de la película lost kingdom	#Spiderman	0
1096	2026-03-24 15:22:15+00	#spiderman #marvelstudios #spidermanbrandnewday #mcu	#Spiderman	0
1097	2026-03-24 15:22:15+00	redid the atmosphere and lighting #blender #spiderman	#Spiderman	0
1098	2026-03-24 15:22:15+00	final swing recreation #blender #spiderman	#Spiderman	0
1099	2026-03-24 15:22:17+00	super rant вихідні: обговорюємо новий трейлер "spider-man: brand new day", скандал з "lanterns" та свіжі анонси від джеймса ганна! #superrant #spiderman #lanterns #jamesgunn	#Spiderman	0
1100	2026-03-24 15:22:17+00	did anyone else notice something “off” about the brazilian spider-man: brand new day trailer…? #spiderman #marvel #tomholland #meme #funny	#Spiderman	0
1101	2026-03-24 15:22:17+00	#virtualphotography #photomode #spiderman	#Spiderman	0
1102	2026-03-24 15:22:17+00	i like messing with game's photo mode sometimes	#Spiderman	0
1103	2026-03-24 15:22:17+00	graças ao avanço da ia, esse vazamento de spider-man: no way home seria totalmente "falso" hoje em dia. #spiderman	#Spiderman	0
1104	2026-03-24 15:22:19+00	quick sketch based on that mcfarlane draw #spidermanbrandnewday #spiderman #fanart	#Spiderman	0
1105	2026-03-24 15:22:19+00	17. vigilante suit (#webbverse) #peterparker #spiderman #theamazingspiderman	#Spiderman	0
1106	2026-03-24 15:22:19+00	16. human spider suit (#raimiverse) #peterparker #spiderman	#Spiderman	0
1107	2026-03-24 15:22:19+00	15. homemade suit (#mcu) #peterparker #spiderman #spidermanhomecoming #spiderfarfromhome	#Spiderman	0
1108	2026-03-24 15:22:21+00	14. integrated suit (#mcu) #peterparker #spiderman #spidermannowayhome	#Spiderman	0
1114	2026-03-24 15:22:23+00	7. stark suit (#mcu) #peterparker #spiderman #captainamericacivilwar #spidermanhomecoming #avengersinfinitywar #spidermanfarfromehome	#Spiderman	0
1115	2026-03-24 15:22:25+00	6. amazing suit (#webbverse) #peterparker #spiderman #theamazingspiderman	#Spiderman	0
1116	2026-03-24 15:22:25+00	5. webbed suit (#raimiverse) #peterparker #spiderman #spiderman2 #spiderman3 #spidermannowayhome	#Spiderman	0
1117	2026-03-24 15:22:25+00	do you remember those leaked behind-the-scenes photos of spider-man that went viral in 2025? can't believe the trailer is out so soon! #spiderman #newtrailers #2026movie	#Spiderman	0
1118	2026-03-24 15:22:28+00	4. webbed black suit (#raimiverse) #peterparker #spiderman #spiderman3	#Spiderman	0
1119	2026-03-24 15:22:28+00	3. amazing 2 suit (#webbverse) #peterparker #spiderman #theamazingspiderman2 #spidermannowayhome	#Spiderman	0
1120	2026-03-24 15:22:28+00	2. new red and blue suit (#mcu) #peterparker #spiderman #spidermannowayhome	#Spiderman	0
1121	2026-03-24 16:10:21+00	actors that audition for iconic roles (and didn’t get it) #titanic #jumanji #spiderman #twilight #indianajones #starwars	#Spiderman	0
1122	2026-03-24 16:10:21+00	you might remember this spiderman poster (during the period of 2002-2006) this #spiderman poster was printed in every child's notebook.	#Spiderman	0
1123	2026-03-24 16:10:21+00	https:// youtu.be/lh-yy9f27wo even #spiderman would be jealous… #tifa #ff7 @youtube @ayakamods	#Spiderman	0
1124	2026-03-24 16:10:21+00	first landed this speed vault twist in 2013 — 13 years later, still got it if #spiderman can do it… why can’t we?	#Spiderman	0
1125	2026-03-24 16:10:21+00	o novo trailer de marvel tōkon: fighting souls introduz peni parker! o game será lançado em 6 de agosto para ps5 e pc. nos apoie no catarse: http:// catarse.me/falaanimal compre produtos da marvel através do nosso link: https:// amzn.to/4rtvgkh #marvel #spiderman #peniparker #game	#Spiderman	0
1126	2026-03-24 16:10:21+00	a little violent tirade/adventure for #thepunisher before off to confront/help #spiderman in july!	#Spiderman	0
1127	2026-03-24 16:10:21+00	frank castle returns in a marvel television special presentation: the punisher: one last kill may 12, only on @disneyplus.	#Spiderman	0
1128	2026-03-24 16:10:21+00	#spiderman #haruncan ay ay ay kafayı yemelik … patlamış mısırım hazır 31 temmuzu bekliyorum	#Spiderman	0
1129	2026-03-24 16:10:23+00	in trying to save everyone, peter parker is slowly consumed by the weight of being spider-man. as he works to uncover a horror rising from beneath the city, he’s forced to confront what his promise is really costing him. currently in production #b3d #spiderman #blender	#Spiderman	0
1130	2026-03-24 16:10:23+00	260324 #윤호 인스타그램 your friendly neighborhood #yunhois3gram #spiderman https:// instagram.com/p/dwrskysfehs/	#Spiderman	0
1131	2026-03-24 16:10:23+00	the cutest spiderman #yunhois3gram #spiderman #yunho #윤호 #ateez #에이티즈	#Spiderman	0
1132	2026-03-24 16:10:26+00	hoje o amigo da vizinha chega no canal: https:// youtube.com/shorts/of_myxx qhwi?feature=share … #spiderman	#Spiderman	0
1133	2026-03-24 16:10:26+00	need some help, please. i need spider-man accounts to follow that are primarily comics focused, not movie. general marvel comics accounts are good, too. any suggestions would be appreciated. thank you. #spiderman #marvel #comicbook #follow	#Spiderman	0
1134	2026-03-24 16:10:26+00	tbh i think he should have both. since his organic webbing is based on his emotional state he should have the web shooters as a backup. it should be a thing he does naturally. #spiderman #marvel #spidermanbrandnewday #marvelstudios #marvelcomics #marvelcinematicuniverse	#Spiderman	0
1135	2026-03-24 16:10:26+00	the real reason spider-men shoot webs differently - have you ever noticed that not every spider-man shoots webs the same way? - some use gadgets, while others have powers that come naturally from within. - this difference has been a long-standing debate among fans. - tobey	#Spiderman	0
1136	2026-03-24 16:10:29+00	mj가 되어야지………… #윤호 #spiderman	#Spiderman	0
1137	2026-03-24 16:10:29+00	mafex marvel spider-man black & gold suit (spider-man: no way home) - three interchangeable heads - plus effect parts for the magic gate - the magic gauntlet - various web parts - articulated figure stand #marvelcomics #marvel #spiderman #mafex	#Spiderman	0
1138	2026-03-24 16:10:29+00	#spidermanbrandnewday #spiderman trailer reaction #marvel	#Spiderman	0
1139	2026-03-24 16:10:29+00	[] 260324 yunho instagram post your friendly neighborhood #spiderman #yunho #윤호 #yunhois3gram #ateez #에이티즈	#Spiderman	0
1140	2026-03-24 16:10:32+00	260324 #윤호 인스타그램 your friendly neighborhood #yunhois3gram #spiderman	#Spiderman	0
1141	2026-03-24 16:14:46+00	random sketch . .#art #marvel #spiderman #comics #drawing	#Spiderman	0
1142	2026-03-24 16:14:46+00	yunho-ya… i did it first #yunho #spiderman	#Spiderman	0
1143	2026-03-24 16:14:46+00	new post spider-man: across the spider-verse print by @visualsofazmat1 x @bottlenecknyc - on sale today! #spiderman #spiderverse #azmatmunshi #bottleneckgallery	#Spiderman	0
\.


--
-- Data for Name: tweets_processed; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."tweets_processed" ("id", "original_id", "clean_text", "lang", "sentiment_label") FROM stdin;
1	1	heran diabaikan pialadunia.tvrinews.com/read/pd_b7qmd8 gerrard gagal paham panggil alexander tvriworldcup worldcup2026 tvrisport	en	negative
2	3	footballer happy shin show good rtesport coybig worldcup2026	en	positive
3	5	mctominay new kit	en	neutral
4	7	expand format dream close country team want appearance drop answer worldcup2026	en	neutral
5	9	loss friendly match focus shift frendlie sportsnew	en	neutral
6	10	street stadium nation breathe today team family today show world heart beat talent single time worldcup2026	en	positive
7	11	drop kit nation global statement world cup kit here portugal wear-42587720 worldcup2026 football	en	neutral
8	13	ready shine count find envio.international/mexico-ready-t o shine as-2026 world cup count worldcup2026 logistic envio	en	neutral
9	14	sale ita.bet letter official country code position global football cycle rare inventory strategic asset	en	neutral
10	16	decide pick win get good plyr get group breeze qualification stage group	en	positive
11	17	new unveil kit inspire strong tie meet legacy world stage worldcup2026	en	positive
12	21	join camp playoff striker link squad preparation intensify crucial fixture worldcup2026	en	neutral
13	23	letsgo soccer messi tuesdaymotivation	en	neutral
14	24	imagine training madman year call lazy post social medium	en	negative
15	25	calibrate year datum prediction market find +536 undervalue undervalue -78 overpriced market smart think worldcup2026	en	neutral
16	30	team customize nation customize worldcup2026 northamericafootball gameon	en	neutral
17	32	exploit harass abuse humanity	en	negative
18	33	playoff begin worldcupqualifier footballfan	en	neutral
19	34	seat check buy pick stadium enter game date kickoff time section shade take second save minute misery free signup	en	negative
20	35	day ticket afternoon game check section sun exposure venue section level shade kickoff time	en	neutral
21	36	miss let sink azzurri	en	negative
22	37	playoff explain worldcup2026 worldcupqualifier footballfan	en	neutral
23	39	stage set color loud unveil kit worldcup2026 nikefootball nike fifaworldcup	en	neutral
24	40	brink dream face fearless huge inter confederation playoff difference pressure story	en	neutral
25	41	game changer ready cultural revolution soccer miss spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	neutral
26	42	ready soccer revolution redefine game miss spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	neutral
27	43	grand awakening soccer think miss spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	neutral
28	44	ready elevate soccer new height unite culture worldcup2026 spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	neutral
29	46	hype rest silent dear 9ja qualify hype mad	en	neutral
30	48	time boycottfifa cancel peace coalition stop subservient oppressor	en	negative
31	49	government collect immigration fee refuse process application denial refund silence large fee fraud history american immigration system happen	en	negative
32	50	average ° open air venue know section shade buy worldcup2026	en	neutral
33	52	sélection samir émotion énorme défi csport.ma/premiers-mots- samir el mourabet football	fr	positive
34	53	31st team qualify	en	neutral
35	56	zidane sight official zidane	en	neutral
36	57	loading international friendly black gear win	en	positive
37	58	deliver authentic experience come food people culture come trip west downtown check city worldcup2026	en	neutral
38	60	time winner minute miss home soil single leg second chance dangerous night italian football history azzurri	en	negative
39	61	summer wait day time get great football competition world way million eye glue game love game	en	positive
40	62	government create help tourist navigate city worldcup2026	en	neutral
41	63	deliver authentic experience come food people culture come trip check city	en	neutral
42	64	los youtu.be/9xllxeksmwm legendarias adrenalyn panini videojuego efootballnewsmx	en	neutral
43	65	miss day time single leg knockout second chance bad night watch sofa go brutal	en	negative
44	68	hit ° venue open air go need know section shade buy shade map free	en	neutral
45	69	release official song tournament host track title light feature produce worldcup2026 light	en	neutral
46	70	hear song team cherki loud	en	neutral
47	71	midterm test real involvement thing	en	neutral
48	74	host match average temperature ° partial canopy upper section shade low bowl = sun check section buy	en	neutral
49	75	day start world	en	positive
50	76	day start world	en	positive
51	77	call pass worldcup2026	en	neutral
52	79	futbolpicante snapdragonstadium unitedstatesfootballclub ligamx	en	neutral
53	80	plead friend get wish rid flip gift trade player find worldcup2026 panini	en	neutral
54	81	look ™ world big stage meet hobby big brand return big feature qualified nation global chase new parallel incoming	en	neutral
55	82	drop kind shoot كون هذا ديال الفوتوشوت غادي يكون مختلف المغرب	en	neutral
56	83	por youtube fifaworldcup2026 youtube copadelmundo	en	neutral
57	85	make headline world sport read power channelonesport worldcup2026 icct20 cricket newswrap	en	neutral
58	86	italia match remember game nation hold breath	en	neutral
59	87	face playoff semifinal qualify winner meet temp c book hotel pool worldcup2026	en	neutral
60	88	decider pm squad european base strong technical evening drop bring layer worldcup2026	en	neutral
61	89	mpanse anvan lan ak fédération football òganize yon vwayaj ak seleksyon vini òganize vizit citadelle laferrièr ak jwè enèji	fr	negative
62	90	england anthem standtogether	en	neutral
63	91	team country mean fan need ticket join talk effort bring travel planning housing community place worldcup2026	en	neutral
64	92	dear turist person love come security infraestructure major issue pay water supply incompetent supply clean human use	en	negative
65	96	champion celebrate tonight worldcup2026 t20worldcup2026final	en	positive
66	97	falloir garder espoir faire preuve patience battre atteindre coupe uefa attendre	fr	positive
67	100	day national team unveil uniform rivalry good kit flashscore.com/news/soccer-wo rld cup team release kit the-2026 world cup	en	neutral
68	103	come demand late incentive announcement local resident read link offers-750 usd new bergen county worldcup2026	en	neutral
69	104	discours franc légendaire playoff chose match petit gagner coupe nouvellecalédonie	fr	positive
70	105	break ice agent worker unpaid line stretch hour deploy ice officer airport move real leadership look step help american worker	en	neutral
71	106	player- q daily quiz evening thank interaction footballnerd	en	neutral
72	107	travel ukairportparking bit.ly/3vzwxuk support travel football soccer holiday force expat forcescarhire mhhsbd	en	neutral
73	110	country urge come safe private army ice soldier take airport decide arrest cause cage month safe	en	negative
74	111	| مباريات arab national team match preparation	en	neutral
75	112	think tourism bad lot bad ice	en	negative
76	113	international window vibe injury pile club hit reply drop football	en	neutral
77	114	usmnt upcoming schedule friendly close summer upcoming schedule friendly usmnt worldcup2026	en	neutral
78	115	present deal end airport nightmare reject demand pass condition send ice airport unclear	en	negative
79	119	lot banger year different	en	neutral
80	120	youtube make deal let broadcaster part game live fyi football media	en	neutral
81	121	final open training session tomorrow departure sign dozen kid come meet idol great vibe	en	positive
82	122	football agent cover handful league cover team injury record form fixture vulnerability flag predict build bet agent fantasy tool trader analyst worldcup2026 aiagent	en	neutral
83	123	football world buzz international squad name friendly line stake high time football	en	neutral
84	124	terancam tvriworldcup worldcup2026 tvrisport posisi phil foden terancam oleh	en	negative
85	125	final afsel-2010 gol iniesta markahi kejayaan eropa tvriworldcup worldcup2026 tvrisport	en	neutral
86	129	open get spotlight get stage tricky people think worldcup2026	en	negative
87	132	special guest revealed！keung boyband mirror celebrate celebrate edition product launch keungto football	en	neutral
88	134	albirroja​ pumafootball​ pumakits​ footballshirt​ kitcollector​ homekit​	en	neutral
89	135	kit land classic blue kit get copper twist inspire mint kit bring fresh vibe available location	en	neutral
90	136	legendary push generation eclipse historic tally goal likely catch worldcup2026 sportybetghana	en	neutral
91	138	mean spotlight tourism rep work lure people region tourism	en	neutral
92	139	football player endorse ban international sport competition	en	negative
93	140	football legend endorse demand suspend international football end grave violation international law apartheid rule crime genocide	en	negative
94	141	wait custom jersey team soft skin friendly fade pattern corner pro look factory worldcup2026	en	neutral
95	142	open air bowl roof summer sun buy ticket check section shade commit free venue section level shade kickoff time worldcup2026	en	neutral
96	143	denmark crisis magic give edge threaten counter grind nervy win reach playoff final denmark	en	neutral
97	144	venue able stay open live match approve moray world cup worldcup2026 hospitality license nightlife thehighlandtime	en	neutral
98	146	list league cover query 10x league coverage competitor daily refresh bet agent fantasy agent trading agent edge start app.virtuals.io/acp/agents/ld1	en	neutral
99	147	wrong league cover query 10x league coverage competitor daily refresh bet agent fantasy agent trading agent edge start app.virtuals.io/acp/agents/ld1 worldcup2026 football	en	negative
100	148	get promotional world cup bag ional worldcup2026	en	neutral
101	149	drop kit clean line bold look hit different	en	positive
102	150	buy ticket stressful guess bake sun minute show sun shade section free signup venue	en	neutral
103	151	begin week action	en	neutral
104	153	speak stand chance fly worldcup2026	en	neutral
105	154	o inversión ppconcarr#hechoconlaspata	en	neutral
106	155	dream italys world cup dream	en	positive
107	157	ready stand chance fly big prize real opportunity	en	neutral
108	160	think ticket start collectible queue rtt right buy ticket decide cut resale chaos access fair add layer thought agree fifacollect	en	neutral
109	163	launch conversational engine redefine dlvr.it/trf7gm sportsbook worldcup2026 bet	en	neutral
110	165	drop squad forward ambition final tournament materialize right follow world soccer soccerplayer.co worldcup2026	en	neutral
111	166	heat high humidity open air stadium canopy coverage upper tier low bowl expose know buy seatsun.com/stadiums/bbva worldcup2026	en	neutral
112	168	nouveau maillot équipe coupe monde dévoilé couleur inédit inspirée football	fr	positive
113	170	compte faire jouer vert coupe falloir faire annuler maillot vomir impossible	fr	negative
114	171	youtu.be/gf5nu9yek7k 80 dance pop version celebrate listen compare original scottishfootball worldcup2026 bringthetrophyhame	en	neutral
115	172	maillot maillot corée coupe disponible site euro jour code coree exterieur version joueur coupe monde-2026	fr	neutral
116	173	day countdown continue watch moment live wlive+ countdown fifaworldcup2026 wclub	en	neutral
117	174	code celebrate build special tribute celebration historic win worldcup2026 html css cricket	en	neutral
118	178	buy wc2026 ticket check sun exposure book hotel check review noon kickoff put section direct sun minute map section venue	en	neutral
119	182	light feel soulless passion fire calor toss bin pray save real banger time	en	neutral
120	184	worldcup fifa music	en	neutral
121	185	big star shine world stage rise talent global icon dominate watch follow worldcup2026	en	positive
122	186	geopolitic crash football reshape g tournament read breakdown ld cup-2026 controversy security fear need know right now/ think play relocate withdraw worldcup2026 football	en	negative
255	369	spot fundraising launch event gtv	en	neutral
123	187	huge drama brew demand group game security fear strike safety concern comment boycott iranian chief cup-2026 controversy security fear need know right now/	en	negative
124	188	real time market impact demand supply m thing work self employ agency employ self employ uber driver	en	neutral
125	190	underrated heat trap temperature hit f+ upper deck canopy cover low bowl check section buy	en	neutral
126	191	worldcup2034 worldcup2038 football soccer	en	neutral
127	192	stick daily insight cultivate love wisdom intentional living base exercise cultivate love wisdom amazon.com/cultivating-lo ebook dp fifaworldcup roadtoworldcup	en	neutral
128	193	worldcup2034 worldcup2038 football soccer	en	neutral
129	194	fish worldcup2034 worldcup2038 football soccer backtothefuture lulz	en	neutral
130	195	worldcup2034 worldcup2038 football soccer backtothefuture lulz	en	neutral
131	196	02601_living_hell take leg worldcup2034 worldcup2038 football soccer backtothefuture lulz	en	neutral
132	197	worldcup2034 worldcup2038 football soccer backtothefuture lulz	en	neutral
133	198	day player earn point kick distribute daily quiz earn point convertible token worldcup2026 wc26 web3	en	neutral
134	199	boycott bio worldcup fifaworldcup fifa trump netanyahu epsteinfile potus flotus pedofile jetten	en	negative
135	200	ice agent airline terminal foreigntourist come	en	neutral
136	201	surprised include starting bad season coyg	en	negative
137	202	well time stage mass casualty false flag attack	en	negative
138	203	breaking injury expect worldcup2026	en	negative
139	204	keep clean sheet yesterday save season league look reaction incredible goalkeeper need worldcup2026 play off vcf	en	positive
140	205	mission begin today national team gather appoint coach hold training session bear speak fluent youtu.be/tffgvl_35tu?si =	en	neutral
141	206	usmnt​ nikefootball​ nikekits​ footballshirt​ kitcollector​ awaykit​	en	neutral
142	207	con story pm | web storiesfromthecitie	en	neutral
143	208	home kit clean red base bold nordic cross subtle pattern pure heritage vibe dominate fifaworldcup	en	positive
144	209	rking tailgating metlife fifa world cup metlifestadium usasoccer newjersey	en	neutral
145	210	exploitation despatch low pay private chauffeur worldcup2026	en	neutral
146	211	love concert poster à worldcup2026 countdown publicist use poster competition request use poster day come hometown	en	neutral
147	213	spot worldcup2026 newspoint247live	en	neutral
148	215	roof go match sit summer sun pick right section map seat stay shaded worldcup2026	en	neutral
149	216	drive ad brand want reach theenterprise.new worldcup2026 sportsmarketing	en	neutral
150	218	co host advantage real summer group think produce big upset tell worldcup2026	en	negative
151	219	language winner route ver stadefrance afcon2025	en	neutral
152	222	go wild wait	en	negative
153	224	world shopping think go	en	neutral
154	226	day remain focus shift tactic identity r200 worldcup2026	en	neutral
155	228	ready disappoint goal go miss boycott match hold	en	negative
156	229	discuss preparation commend visa process improvement discuss preparation towards-2026 world cup ablakwa commend visa process improvements?utm_source = dlvr.it&utm_medium = twitter	en	neutral
157	231	ticket big party football history make get shock qualification prediction drop worldcup2026	en	neutral
158	232	launch fundraising campaign detail s-30m world cup fundraise worldcup2026 joy997fm	en	neutral
159	235	fan disappoint budget matter say fund travel worldcup2026 mahamadecision	en	negative
160	236	sleep moment perfect mix young star experience year thought worldcup2026 cristiano	en	neutral
161	238	jelly roll outta ppl	en	negative
162	239	𝗢𝗙𝗙𝗜𝗖𝗜𝗔𝗟 song lighter	en	neutral
163	240	call injure leave diabolical keeper deserve finish	en	negative
164	241	inspire cultivate love wisdom amazon.com/cultivating-lo ve ebook dp fifaworldcup worldcupfootball roadtoworldcup worldcupfinal worldcupqualifier worldcupgoal worldcupmatch	en	neutral
165	242	head window"—it engine room 3d player avatar real time tactical bot game change way redefine soccer soccer	en	neutral
166	245	good luck worldcup2026	en	positive
167	246	mind year old mbokazi make insane pass world watch	en	negative
168	247	predict match get prediction try app link comment worldcup2026 matchday	en	neutral
169	248	run simulation predictor beat penalty final simulator care reputation run	en	neutral
170	249	date get group stage game tricky worldcup2026	en	negative
171	250	confuse format simple explanation stage round final good team fight champion ready worldcup2026	en	neutral
172	251	come expect guest want join festivity rent gear need list extra equipment fan start earn worldcup2026	en	neutral
173	252	plan attend buy ticket official platform follow ticket sale announcement avoid unofficial seller rush stay informed ticket update worldcup2026 worldcupticket	en	neutral
174	254	find net goal rule handball build encourage sign striker worldcup2026 play semi final play	en	neutral
175	255	nff appeal rule eligibility dispute give hop story reject verdict file fresh	en	neutral
176	256	support kit win	en	positive
177	258	national embarrassment tailgate point international event	en	negative
178	259	parking tailgating match good thing host pre match hospitality experience match	en	positive
179	260	day arrive legend injury scare massive financial shake drop road take wild turn detail fifaworldcupnews.com/breaking-news- fifa on-21 march-2026/ football break	en	negative
180	263	countdown day win predict play earn kick point daily football quiz shootout game kick welcome bonus kick wc26 token worldcup2026	en	neutral
181	264	worldcup2026 ice football soccer	en	neutral
182	265	demand resignation today host world	en	negative
183	266	fact blow mind drop football	en	neutral
184	267	play knockout game + fan imagine atmosphere	en	neutral
185	268	generational talent final stage soak	en	neutral
186	269	host time host year making	en	neutral
187	270	match sleep schedule ready	en	neutral
188	271	corner fact need know worldcup2026	en	neutral
189	273	get huge boost midfielder recall squad flyingeze.com/pascal-gross-d eniz undav brighton midfielder world cup football worldcup2026	en	neutral
190	276	dream play grow watch kid fall love game hope year old wonderkid express	en	neutral
191	278	highlight reel mark word breakout star drop	en	neutral
192	279	care deserve england threelion	en	neutral
193	280	calling youtu.be/8mr7mkyhn9a?si worldcupfinal worldcupchampion	en	neutral
194	283	terrain jeu lance maillot mode streetwear activation stratégique connecter marque culture urbain décryptage sportsmarketing.fr/maillots-puma- 2026-new	fr	neutral
195	284	new design shirt upcoming match worldcup2026 play off complete new equipment unveil accord reprezentacija adida oprema na plej natprevarite sp/	en	neutral
196	286	want play want budge game day unresolved nation miss qualify blink worldcup2026 sixyardscoop global	en	neutral
197	288	american crave instant gratification goal minute constant action soccer poetry buildup chess match player dictate game coach world sport click	en	neutral
198	289	guess go trophy worldcup2026	en	neutral
199	290	eat good cup	en	neutral
200	292	youtube.com/shorts/pbtt48k pxqy pemain naturalisasi	en	neutral
201	295	journey worldcup2026 cricketteam	en	neutral
202	296	playoff great chance qualify group tough level interesting week	en	positive
203	298	draw set group tough pitfall tough game cross qualify playoff	en	neutral
204	301	good adida kit vote reply ranking adida	en	positive
205	302	usmnt​ nikefootball​ nikekits​ footballshirt​ kitcollector​ matchdayvibes​ homekit​ soccerbible​ score90​	en	neutral
206	303	excited opening party final team go way drop answer worldcup2026 3monthstogo	en	neutral
207	304	day player earn point kick distribute daily quiz earn point convertible token worldcup2026 wc26 web3	en	neutral
208	305	delay security funding leave planning pressure warning terror threat unrest tight leader react protect global event worldcup2026 security miss follow	en	negative
209	308	lead worldcup2026 land	en	neutral
210	309	disqualify team hand trophy promise year	en	negative
211	310	welcome football jersey support home delivery welcome place order enjoy preferential discount activity check homepage contact me.#shirt worldcup2026 worldcup vinijr méxico fyp	en	neutral
212	311	niggas buy replica like	en	neutral
213	312	kit drop clean bold ready big stage wear home landslaget	en	neutral
214	317	day worldcup2026 tamringtone download caberfeidhmusic.bandcamp.com/track/the-tart armys scottish ringtone	en	neutral
215	318	horizon international collection design teaser youfan worry get scot cover wearethemod troubadourvintage	en	neutral
216	319	draw firm line boycott match play tournament read o boycott continue fifa world cup-2026 worldcup2026	en	negative
217	320	lose knock group stage know luck cunt win	en	negative
218	321	sale ita.bet letter official country code position global football cycle rare inventory strategic asset	en	neutral
219	324	woman get 100k people man useless perform man football tournament bonker worldcup2026	en	negative
220	325	live performance opening ceremony	en	neutral
221	326	state funding fan worldcup2026	en	neutral
222	327	unveil kit american energy level clutch mascot clutch token bear moment entry ticket load nest	en	neutral
223	329	state funding fan l state funding for-2026 world cup fan president mahama?utm_source = dlvr.it&utm_medium = twitter worldcup2026	en	neutral
224	330	etsy.com/shop/substitut etees?ref = dashboard header	en	neutral
225	332	reject request play match deny request play match make clear plan change official schedule	en	neutral
226	333	companion match explore host city stay ready kickoff build journey	en	neutral
227	334	lead expect downtown plan transport	en	neutral
228	336	03.12.26 pm look host ticket sale roof official fan	en	neutral
229	337	drop official jersey kit tell story culture football history stage fifaworldcup2026 worldcup2026 adidas worldcupjersey	en	neutral
230	338	absolute destroy defense win drop pick test football knowledge free quiz game football	en	neutral
231	342	theme custom guy mcflys_customdesign mcflys_customkick cristianoronaldo	en	neutral
232	343	superstar star official reveal adida home jersey classic red design technology trend yamal	en	neutral
233	345	fly believe real	en	neutral
234	346	takes streak end window unbeaten	en	neutral
235	347	refuse iranian game country kill leader send player death	en	negative
236	348	believe try partner find successful negotiation fc26	en	neutral
237	349	major og omit man squad bar injury go start rb close shocker	en	negative
238	350	england football fun brand project order celebrate release new kit	en	neutral
239	351	sport englandsquad football	en	neutral
240	352	request share moment stage fundraiser footballmeetsmusic	en	neutral
241	354	summer wait day time get great football competition world way million eye glue game love game	en	positive
242	355	trump m security bill hold month money approve receive match day truthoverspin	en	neutral
243	356	takes point window register draw show ability hang well competition possible	en	neutral
244	357	set rock summer mood listen rock version scottishfootball worldcup2026 bringthetrophyhame	en	neutral
245	358	new kit come account take hit worldcup2026	en	neutral
246	359	loading back switch side pressure hit wish country qualify spoil	en	neutral
247	360	شیڈول انفینٹینو football	en	neutral
248	362	state fund supporter read fund world cup supporter president mahama	en	neutral
249	363	include membership fee access high odd ticket access overpay worldcup2026 ticket include tax slip look	en	neutral
250	364	fifa2026​ canada​ nikefootball​ nikekits​ footballshirt​ kitcollector​ matchdayvibes​ alphonsodavies​ homekit​	en	neutral
251	365	wale fundraise gbcnew	en	neutral
252	366	date circle opponent miss make tempting worldcup2026	en	negative
253	367	eat match match late night come worldcup2026	en	neutral
254	368	official outfit comfy couch fit watch shine worldcup2026 soccer wc2026 banter	en	neutral
256	370	kit clean gold puma year prove wrong stage exit prediction age screenshot	en	neutral
257	371	soccer help travel plan doug p soccer doug meet jason can?r=2yjpde&utm_campaign = post&utm_medium = web	en	neutral
258	372	big night football fan reppe cause spark generation rise	en	positive
259	373	government target m fundraising drive campaign 3news.com/sports/footbal l government targets-30m fundraising drive black stars-2026 world cup = dlvr.it&utm_medium = twitter	en	neutral
260	375	drop new kit retro collar unveil retro inspire kit for-2026 world worldcup2026	en	neutral
261	377	kit face fan penalty look incredible drip outscore team	en	positive
262	380	blanc rouge classique angleterre besoin révolution maillot terrain	fr	neutral
263	381	discuss concern concern pod listen 50.mp3 sick	en	negative
264	382	pathetic join boycott	en	negative
265	383	refuse action club base israeli settlement fail enforce rule flout international law clear opportunity stand right international law decision	en	negative
266	384	hear revive career mot worldcup2026	en	neutral
267	385	drop kit beautiful kit jersey well tournament result	en	positive
268	386	get ready welcome world scenic help ensure look good global stage link worldcup2026	en	positive
269	387	world swedia adida semua aja worldcup2026	en	neutral
270	392	arrive fundraising launch fundraise	en	neutral
271	400	african football write script afcon2025	en	neutral
272	401	red devil income squad gear clash prep pull string ready fly goal unstoppable	en	neutral
273	402	player winbgame stand chance go amabhincanation ingoma	en	neutral
274	403	include squad post injury lead friendly prep get ready destroy	en	neutral
275	404	adida release stunning national team kit summer adida football soccer	en	positive
276	405	unveil shirt upcoming match worldcup2026 play off perfect colour beautiful design	en	positive
277	406	national football team kit worldcup2026 football soccer fifaworldcup	en	neutral
278	407	drop shock omission prioritise form fitness mental strength friendly worldcup2026	en	neutral
279	408	want ongoing game worldcup2026	en	neutral
280	409	team dominate scoring chart know national team goal tournament	en	neutral
281	410	𝙊𝙉𝙀 𝙒𝙀𝙀𝙆 𝙏𝙊 𝙂𝙊 worldcup2026 replica ball arrive goal score game tournament subbuteo	en	neutral
282	412	shock drop worldcup2026 qualifier fifaworldcup	en	neutral
283	413	nouveau maillot sénégal coupe monde dévoiler	fr	neutral
284	414	game brand centre stage collection design play final whistle brand world big conversation explore range shorturl.at/1b9oz	en	neutral
285	415	stick inspire cultivate love wisdom amazon.com/cultivating-lo ve ebook dp fifaworldcup worldcupfootball roadtoworldcup worldcupfinal worldcupqualifier worldcupgoal worldcupmatch	en	neutral
286	418	proud continue collaboration national team analysis mean track player league style tactical consistent view road	en	positive
287	420	away kit release	en	neutral
288	421	puma drop new national team kit miss design good shirt see win kit game worldcup2026	en	neutral
289	423	horizon sport bet strategy centre help industry gear upcoming tournament read f.mtr.cool/raqvwmzecj igame	en	neutral
290	424	get m secure security	en	neutral
291	425	get federal funding support safety security boston25news.com/news/local/bo federal funding support safety security fifa world trueanthem&utm_medium = trueanthem&utm_source = twitter	en	neutral
292	426	striker expel national team perceive disloyalty government rule confirm worldcup2026 report cnn.it/4bch97y	en	negative
293	429	𝗢𝗙𝗙𝗜𝗖𝗜𝗔𝗟 away kit	en	neutral
294	431	strike landmark deal stream insideworldsoccer.com/2026/03/fifa-y fifawc	en	neutral
295	432	help ticket denmarkvireland 31st boy vip	en	neutral
296	433	celebrate different culture story identity football kit art pitch country shin unique way clean collection see football	en	neutral
297	434	good decide conversation worldcup2026	en	positive
298	435	thread new national team kit drop	en	neutral
299	436	nation trophy clarity afcon2025	en	neutral
300	437	fly fuck watch second paedophile support charade	en	negative
301	438	squad play game announce	en	neutral
302	440	cook kit wc26 kit good drop today vote worldcup2026	en	positive
303	441	detail head facebook.com/photo/?fbid=12 noscotlandnoparty billygilmour tartanarmy	en	neutral
304	442	collection pick debate clean global stage fan wait fave kit drop worldcup2026	en	neutral
305	444	time sooo excite worldcup2026	en	positive
306	445	nation build dynasty run retirement home	en	neutral
307	448	stop french national team equipedefrance worldcup2026	en	neutral
308	449	coupe anp prolonger date inscription attribution code accréditation mars dernier délai manquer passer date demande accepter anps	fr	neutral
309	450	minute save french striker final secure title worldcup worldcupfinal worldcupchampion soccer futbol championsleague	en	neutral
310	452	team win world strong team go eish warmonger want spoil beautiful game	en	negative
311	453	important point note squad classify midfielder line direct competition decision classification thought	en	neutral
312	455	give proper chance coach hesitant threelion	en	negative
313	456	lightning speed skill art goal rewrite history unstoppable viral fyp sportsfan trend	en	neutral
314	457	ticket specific seat assign match fan section check follow link fwc26-refunds-mgmt.tickets.fifa.com/account/ticket worldcup2026 fifaworldcup	en	neutral
315	458	geopolitical conflict brutal crime commit derange individual massacre civilian	en	negative
316	459	support meet present receive goodwill visit journey	en	positive
317	460	kit look worldcup2026	en	neutral
318	461	mois cdm adida lancer premier maillot sélection partenaire football kitreveal	fr	neutral
319	464	kit clean elite win kit battle	en	positive
320	465	day opening match manager detail late team news benefit defender hope squad summer bbc.co.uk/sounds/play/p0 n7jq7q	en	neutral
626	902	zidane set sight official zidane frenchfootball	en	positive
321	466	wristband product cost high demand easy customize wristband fan favorite global event add lineup hqfulfillment.com/cms/index/new dropshippe	en	neutral
322	467	close think well time upgrade setup lay evening match day hosting bespoke audio visual composition bring moment life garden	en	neutral
323	469	black sky blue magic kit pure fire vibe trefoil classic look unstoppable worldcup2026 albiceleste	en	positive
324	471	decision play tension change schedule twist say boycott game want match move cision iran-2026 world worldcup2026 fifaworldcup soccer	en	negative
325	473	win trip big match world enter	en	neutral
326	475	tvriworldcup worldcup2026 tvrisport wafat como mampu pasok pemain	en	negative
327	476	real conversation starter worldcup2026	en	neutral
328	477	fifa.sale price ticket	en	neutral
329	479	ready era new design passion game tell story wear drop favorite team football	en	neutral
330	480	contender kit year worldcup2026	en	neutral
331	482	release triumph worldcup2026	en	neutral
332	484	good change strip worldcup2026	en	positive
333	487	news update kit drop leave right usmnt home unveiled adidas kit hit today tomorrow host look sharp get good wait	en	neutral
334	488	unveil new away kit qualify roll time grab clean kit	en	neutral
335	489	fifa.sale price ticket	en	neutral
336	490	release news week go throw time sportscard panini worldcup2026	en	neutral
337	491	maillot maillot concept version joueur disponible site euro jour code ot y-3-version joueur coupe monde-2026 samuraiblue	fr	neutral
338	492	group argentina+strong side think easy ride knockout drop pick worldcup2026	en	neutral
339	493	reveal away kit	en	neutral
340	494	fifa.sale price ticket	en	neutral
341	495	military barrack threaten ban african team stand pull tournament include win pitch brekko	en	negative
342	496	release kit little schalke touch go blue think worldcup2026	en	neutral
343	498	fifa solve geopolitical conflict rule change worldcup2026 schedule iranwar‌	en	neutral
344	499	tropi piala dunia worldcup julesrimet soccer football napoleonoceanus	en	neutral
345	500	confirm proceed schedule team participate concern involvement geopolitical tension read l president gianni infantino break silence iran world cup match shift worldcup2026	en	neutral
346	504	good experience happen stadium happen city go prove	en	positive
347	505	| drop | switzerland football	en	neutral
348	507	glad see light let world brilliance	en	positive
349	508	𝗡𝗢𝗧 𝗔 𝗪𝗜𝗡𝗚𝗘𝗥 coach say quality good winger help national team role	en	neutral
350	509	live clean look elite comfort build game day limited stock miss usmnt	en	neutral
351	511	predict drive surge ad spend ad impact diminish shift medium landscape worldcup2026	en	neutral
352	512	want host rotation partner strong favorite fifaworldcupnews.com/2028-copa-amer soccer	en	neutral
353	513	leak official day time new normal host driver exploit deduct huge pay addition low pay trip	en	neutral
354	514	different expose youtu.be/q5kwvcz26ca?si	en	neutral
355	516	project economic impact detail feature girl worldcup2026	en	neutral
356	519	country support feel energy soccer feel short youtu.be/f7guj0pkcji?si =	en	neutral
357	522	come make move medium training = world class coverage count day	en	neutral
358	523	summer wait day time get great football competition world way million eye glue game love game	en	positive
359	525	football build heat navigate security tension playoff drama major global ticket demand team massive stake tournament shape big	en	neutral
360	526	sport dilemma number10battle	en	neutral
361	527	city tourism chatbot worldcup2026	en	neutral
362	530	ambassadeur expliquer soutien éléphant limite football	fr	negative
363	532	𝗡𝗢 𝗥𝗔𝗬𝗡𝗘𝗥𝗦 reveal final squad prep leave worldcup2026 afcon2025 football detail	en	neutral
364	533	hotel shine global stage access training tool elevate guest experience attract repeat visitor hotelexcellence#ahlei	en	positive
365	534	win pick day earn free kick point worldcup2026	en	neutral
366	535	accord generate advertising revenue fragmented ecosystem key connect match marketing strategy	en	neutral
367	537	new reject call ban action give context interpretation relevant provision final legal status remain unresolved complex matter public international law	en	neutral
368	538	expect national team participate medium report worldcup2026	en	neutral
369	539	stick inspire cultivate love wisdom amazon.com/cultivating-lo ve ebook dp fifaworldcup worldcupfootball roadtoworldcup worldcupfinal worldcupqualifier worldcupgoal worldcupmatch	en	neutral
370	541	| youtu.be/ryggoa6cyl4?si = fcnlxp5as7su0 mf use sound energy start worldcup2026 viral	en	neutral
371	543	major shift upcoming tournament explore option group stage match north american host city seek relocate-2026 world cup group match north american host worldcup2026 nextclicknews	en	neutral
372	544	let watch live enter draw imagine watch game love feeeli feeeli pay little	en	neutral
373	545	breaking fan ghanaian influence join training trendingtopic virałpost	en	neutral
374	546	preppe stage ​the roster lock massive double header face grit flair perfect blueprint ready world journey continue	en	positive
375	548	trend new memoir insight family life honest personal story football	en	neutral
376	553	team kit predict final standing subbuteo	en	neutral
377	554	turn stadium personal showroom embroidered fan shirt look good social medium feed stand worldcup2026	en	neutral
378	555	join ⁦ ⁩ ⁦ ⁩ coverage	en	neutral
379	557	venir communiquer liste joueur convoquer prochain amicau équipe vue coupe monde	fr	neutral
380	558	target journalist crew job host worldcup2026	en	neutral
381	559	stinker hooked change life man	en	negative
382	560	get tournament feel	en	neutral
383	566	compete seek match security concern official ask relocate group game schedule follow update worldcup2026	en	neutral
384	567	continue preparation play match official negotiate shift game host country ongoing tension worldcup2026	en	neutral
385	568	listen manager detail late team news benefit defender hope squad summer hint new arrival n7jq7q	en	neutral
386	569	run worldcup2026 cricketguru	en	neutral
387	570	फीफा गहराया मैच epen playing fifa world cup-2026 talk shift match fifaworldcup2026 worldcup2026	en	neutral
388	572	free reward football fan day kick point daily quiz penalty game kick welcome bonus kick point wc26 token	en	neutral
389	574	पर फुल्टन के साथ तैयार worldcup2026 championshipgoal	en	neutral
390	575	® 2026worldcup fifaworldcup gamedaysod	en	neutral
391	576	team kit predict final standing angola subbuteo	en	neutral
392	577	await decision petition verdict shape qualification hope redefine campaign grow anticipation fan stakeholder follow update worldcup2026	en	neutral
393	578	send spy team get interesting worldcup2026	en	neutral
394	579	soccer fan horrible people claim control perceive economic benefit worth	en	negative
395	580	release security funding host city country spend estimate	en	neutral
396	583	make cut break lock bubble player road start subscribe sportsmedia.new young star think lock final roster worldcup2026 soccer	en	neutral
397	584	reject request match proceed schedule security concern boycott hint worldcup2026	en	negative
398	585	break withdraw plan boycott match security concern negotiate game source	en	negative
399	586	youtube form historic partnership stream fan access minute live match preview exclusive historic digital archival content free mobile smart device worldcup2026 youtube soccer	en	neutral
400	588	sport make football	en	neutral
401	589	win trip big match world	en	positive
402	591	miss big name squad fill experience add speed energy technical skill contender summer face tough test play samuraiblue month	en	neutral
403	594	annonce partenariat fifa x coupe diffusion intégral match accès angle créateur contenu	fr	neutral
404	595	partnership announce match stream select game angle access creator worldcup2026	en	neutral
405	598	partner preferred platform expand digital coverage creator lead content wide access global fan ifa partner youtube for-2026 world cup-11226930?utm_source = twittercompanypage&utm_medium sportsmarketing youtube	en	neutral
406	599	pull fave play worldcup2026;#worldcup	en	neutral
407	600	national football team push shift match safety concern rise tension read eek world cup match worldcup2026 football	en	negative
408	602	pull fave play worldcup2026;#worldcup	en	neutral
409	605	predict think champion worldcup2026	en	neutral
410	607	withdraw boycott threat refuse play	en	negative
411	608	view current situation perfect unpopular dark horse candidate ukrainian team	en	neutral
412	609	maillot maillot coupe monde disponible site euro jour code ot domicile coupe monde-2026 samuraiblue	fr	neutral
413	612	iriran continue preparation uncertainty remain federation confirm team play match ongoing political security concern worldcup2026 football كأس_العالم كرة_القدم sport continue world cup preparation play say soccer chief	en	neutral
414	614	ready start 16th worldcup2026	en	neutral
415	618	leave grow sad upset retire hint worldcup2026 ancelotti	en	negative
416	619	award money host city low month kickoff big sporting event history get final prep boost securityfunding	en	neutral
417	620	plan stadium plan city real experience happen stadium	en	neutral
418	621	month money cross rich poor think worldcup2026	en	neutral
419	622	football chief confirm withdraw negotiation ongoing group stage match political conflict worldcup2026	en	neutral
420	623	plan ticket battle minute queue right ticket access limit tradable marketplace hold roll dice reply	en	neutral
421	626	step boycott draw hard line confirm participation demand venue change rise tension worldcup2026 football	en	negative
422	627	uncertainty negotiate negotiate match security concern worldcup2026	en	neutral
423	628	usmnt descend high usmnt head coach name man roster friendly worldcup2026 pochettino	en	neutral
424	629	caf décider attribuer worldcup2026 début competition décider fifa	fr	neutral
425	630	game name ready live match preview worldcup2026 youtubesoccer	en	neutral
426	631	need rest summer	en	negative
427	634	love new home kit resemble iconic kit wish kit light navy boy good usmnt	en	positive
428	635	midfielder reveal player tell partake photoshoot kit design follow disappointment kit	en	neutral
429	638	excite captainamerica art	en	positive
430	639	worldcup2034 worldcup2038 football soccer	en	neutral
431	640	nation match countdown get real tournament takeover fifaworldcup worldcup2026	en	neutral
432	641	rate fuel fly machine mean transport people worldcup2026 lot want boycott help unethical fucknugget give big fuck	en	negative
433	642	summer wait day time get great football competition world way million eye glue game love game	en	positive
434	644	rival mystery get weird game schedule	en	negative
435	645	elemente countryja hip hopa worldcup2026	en	neutral
436	646	global football shake war put doubt official possible participate safety concern strike worldcup2026 football break	en	negative
437	647	dream doubt exclude final friendly seismic shift worldcup2026	en	neutral
438	648	hop fade omit final friendly seismic shift	en	neutral
439	649	come ticket miss big sport event year	en	neutral
440	650	offer open move game safety fear negotiate tournament twist war	en	neutral
441	651	dream jeopardy omit final friendly seismic shift worldcup2026	en	neutral
442	652	version celebrate listen compare original scottishfootball worldcup2026 bringthetrophyhame	en	neutral
443	653	difference public medium deserve information constitutional right heavy rain driver passenger have difficulty match host	en	negative
444	654	kit unite team badge bold stripe minimalist star viral design historic home tournament worldcup2026	en	neutral
445	656	open pm play confirm final worldcup2026	en	neutral
446	657	react snub warm up cite fitness concern forward remain determined earn recall final squad announce worldcup2026 football ancelotti	en	neutral
447	658	decision money win trump realise win courtroom	en	neutral
448	659	say expect play schedule report iranian want match move security concern withdraw change group game set	en	neutral
449	660	kick pm local schedule night avoid peak heat min central worldcup2026	en	neutral
450	661	strain claim life year olds hospitalized thing occur boycottafcon worldcup2026 politicslive gyokere trafalgar	en	negative
451	662	live luxury waterfront monthly stay event	en	neutral
452	663	preparation intensify embassy release informational video help moroccan supporter plan trip worldcup2026	en	neutral
453	666	want clash request ticket price cross showdown ticket detail rtugal ticket worldcup2026	en	neutral
454	667	match venue country powerful man big earth big deal	en	positive
455	668	turn proposal host game reaffirm match proceed schedule rise tension decision worldcup2026 ogmnewsfc.com/fifa-rejects-m exico proposal reaffirm iran partici	en	neutral
456	670	end era magic heartbreake hear talk finish line journey hop find fitness dance worldcup2026	en	neutral
457	671	match relocation usa mexico/ thecownews	en	neutral
458	672	refuse bow demand change fixture accommodate geopolitical pressure miss kickoff problem click live icon jump stake favorite fixture live play	en	neutral
459	673	فیفا کرنے انکار پیشرفت sunrisersleed cricket saudshakeel	en	neutral
460	675	inspire cultivate love wisdom amazon.com/cultivating-lo ebook dp fifaworldcup worldcupfootball roadtoworldcup worldcupfinal worldcupqualifier worldcupgoal worldcupmatch	en	neutral
461	676	lead digital ticket market south american fan supporter week trader lock seat track action official marketplace drop see fifacollect	en	neutral
462	677	south american team dominate right ticket trade week collect.fifa.com/blog/ecuador-r ight ticket la tri run fifa collect?utm_source = social&utm_medium = instagram&utm_campaign = rtt&referrer	en	neutral
463	678	win pick day earn free kick point worldcup2026	en	neutral
464	679	declare participate match locate	en	neutral
465	680	reject request play match country host bomb solution reject request disgraceful institution	en	negative
466	681	day win start series analyse team player history prediction stay tune check comment section watch worldcup2026	en	neutral
467	682	kit unite national team design bold home soil pride worldcup2026	en	neutral
468	683	people turn zócalo large -city zocalo large soccer class guinness world worldcup2026 soccer	en	neutral
469	684	new blog promotional global attention turn big sporting event world brand unique opportunity connect audience read blog	en	neutral
470	689	wait slow manufacturer tired miss deadline fade print time factory direct handle custom design order piece sublimation last	en	negative
471	691	day player earn point kick distribute daily quiz earn point convertible token worldcup2026 wc26 web3	en	neutral
472	698	これはすごい world cup-2026 youtube edia release fifa youtube agreement fifa world cup-2026 prefer platform	en	positive
473	699	youtube partner exclusive element artner fifa exclusive world cup これはビッグニュース w杯映像のメディアの独占構造が崩れ、個人クリエイターが公式の一部になる時代	en	negative
474	700	team kit predict final standing sweden subbuteo	en	neutral
475	704	coach set hold training session match worldcup2026 play semi final squad meeting schedule 22nd national team limited time	en	neutral
476	706	come city game halftime team pick teamusa	en	neutral
477	707	today step share milestone path launch small step big vision nation stay tune worldcup2026	en	positive
478	708	player day -player daa	en	neutral
479	709	team kit predict final standing subbuteo	en	neutral
480	711	money buy minute penalty lose buy cup kick ball time ban football competition	en	neutral
481	712	stress ticket lock right buy tradable real utility million people link comment	en	neutral
482	713	boycott worldcup2026 zionismissatanism israelterroriststate terroristusa	en	negative
483	714	yakinkan tvriworldcup worldcup2026 tvrisport pio esposito impresif italia kian yakin di play	en	neutral
484	715	country belief safety citizen boycott boycottusa	en	neutral
485	716	day road knockout stage easy undefeated team face elimination ready drama surprise worldcup2026 football	en	neutral
486	717	worldcup2026ticket tickets worldcup2026 worldcup2026ticket	en	neutral
487	719	reject request match confirm fixture schedule security concern thepublicpurview.com/fifa-rejects-i run world cup match worldcup2026	en	neutral
488	720	ticket ticket group interested t20worldcup t20wc2026final	en	neutral
489	721	expand team group stage garbage time sake vote broadcasting fee destroy gold content team think worldcup2026	en	negative
490	724	nff appeal rejection player eligibility wc dream alive optimistic drop prediction worldcup2026	en	neutral
491	725	confirm move | tv worldcup2026 tvoneusa	en	neutral
492	726	claim | | seat fill grab upgrade referrals!join come pitch	en	neutral
493	727	hese kid big thing household tournament favourite debutant miss drop pick worldcup2026 wonderkid	en	positive
494	728	free reward football fan day kick point daily quiz penalty game kick welcome bonus kick point wc26 token	en	neutral
495	729	maillot maillot concept version joueur disponible site euro jour code ot exterieur version joueur coupe monde-2026 samuraiblue	fr	neutral
496	731	sign read rld cup-2026 sign youtube broadcast worldcup2026	en	neutral
497	732	exclude surprising leave squad refresh lineup team face crucial opener worldcup2026	en	neutral
498	734	big update min match free allycaral.com/2026/03/18/fif partner youtube world cup-2026 minute match stream	en	neutral
499	735	negotiation relocation match set place security reason wake escalate tension	en	neutral
500	737	transport issue accord platform fake gray platform use exclusive dispatch heavy rain demand welcome worldcup2026	en	negative
501	739	africanpride sure fight country run save foreign land cus like seek validation wrong reason fxckin scam	en	negative
502	741	day kick ready team match go pure chaos soccer	en	negative
503	742	come worldcup2026 find caos land airport fall taxis terminal uber think	en	negative
504	743	decision dispute center eligibility certain player playoff match insist satisfied ruling 99pluznew	en	neutral
505	744	sanction follow play incident fin swiss franc spectator throw object match receive swiss franc fine use laser pointer fan violate article	en	negative
506	745	announce preferred platform medium partner allow stream minute match select game available live streaming sportsnew youtubenew 99pluznew	en	neutral
507	746	defeat negotiation table underestimate need	en	negative
508	747	show support rock win jersey check mid-day.com/sports/footbal l article sabrina carpenter post picture lionel messis-2026 world cup win argentina jersey-23621338 bhivelab	en	neutral
509	748	break venue change buzz tension trump warning raise security concern team seek shift match approve venue change schedule stay	en	neutral
510	749	zlatan go epic think roast predict good moment worldcup2026	en	positive
511	750	city prepare face million international visitor language barrier traffic congestion overloaded service build system city need	en	negative
512	753	flow host city transit shuttle route money line position offer fan land miss shop transit route hostcityhustle	en	neutral
513	760	win pick day earn free kick point t.me/wc26nft_bot/app worldcup2026	en	neutral
514	763	come city different experience discover worldcup2026	en	neutral
515	764	read upset sad break heart give shirt week prove doubter wrong dance ask stay strong	en	negative
516	765	ایرانfifa کے ساتھ میچز کرنے کے معاملے	en	neutral
517	771	discussion possibility relocate match accord statement country football president travel say	en	neutral
518	772	negotiate game team fifaworldcupnews.com/2026-fifa-worl worldcup2026 fifaworldcup soccer	en	neutral
519	773	talk match security concern link ongoing regional tension worldcup2026	en	negative
520	774	leave national football team squad friendly worldcup2026 bj88new sportsnews	en	neutral
521	775	million wait ticket vanish let fall sky fairness luck fifaworldcup worldcup2026 football soccer worldcupfinal	en	neutral
522	776	leave worldcup2026 soccer sportsnews	en	neutral
523	777	million arrive seat limit bounce capacity redefine worldcup2026 football soccer worldcupfinal	en	neutral
524	778	possession lose game risk swap shoe confusion = control fifaworldcup worldcup2026 football soccer worldcupfinal	en	negative
525	784	nation advance worldcup2026 dream alive	en	positive
526	785	guide year old teenager know win title defeat host nation 5–2 final flashback worldcupfinal ufcseattle openingday marchmadness	en	neutral
527	787	reveal ask play request reject r84 brazil friendly high stake choice worldcup2026	en	neutral
528	789	new footage show ice agent detain mother travel young daughter witness yell know agent refuse	en	negative
529	791	drop kit nation global statement worldcup2026 football	en	neutral
530	793	ready shine count find worldcup2026 logistic envio	en	neutral
531	794	sale letter official country code position global football cycle rare inventory strategic asset	en	neutral
532	795	love win french bafanapride	en	neutral
533	\N	incoming defend champ big clash football meet knockout pure win drop prediction friend hype worldcup2026	en	positive
534	\N	player day doug p/95 world cup player ca6?r=2yjpde&utm_medium =	en	neutral
535	\N	announce referee play qualifi	en	neutral
536	\N	playoff semi final big game footballer live walbih	en	positive
537	\N	breaking reach agreement head coach national football team new era incoming zidane	en	neutral
538	\N	president suffer presence allocate safa accountability african leadership	en	negative
539	\N	ready action stunning read venue guide plan trip worldcup2026	en	neutral
540	\N	breaking signer devenir coach équipe national coupe football français nouveau ère football étatsunisdafrique	fr	positive
541	\N	build ultimate squad pick player country replace player position well country drop improved xi tell swap worldcup2026 football yamal	en	negative
542	\N	head breathtaking venue tournament check complete stadium guide transit tip match detail bbva worldcup2026 estadiobbva	en	positive
543	\N	forget wear team depth scary go	en	negative
544	\N	day join campaign lock ticket let gooo worldcup2026	en	positive
545	\N	fan drag skyrocket price	en	neutral
546	\N	new drip alert national football team unveil home kit clean classic look bold color cultural touch think design	en	positive
547	813	organisation supporter européen fse dépose recours commission européen stopper tarification dynamique	fr	negative
548	\N	incoming defend champ big clash football meet knockout pure win drop prediction friend hype worldcup2026	en	positive
549	\N	player day doug p/95 world cup player ca6?r=2yjpde&utm_medium =	en	neutral
550	\N	announce referee play qualifi	en	neutral
551	\N	playoff semi final big game footballer live walbih	en	positive
552	\N	breaking reach agreement head coach national football team new era incoming zidane	en	neutral
553	\N	president suffer presence allocate safa accountability african leadership	en	negative
554	\N	ready action stunning read venue guide plan trip worldcup2026	en	neutral
555	\N	breaking signer devenir coach équipe national coupe football français nouveau ère football étatsunisdafrique	fr	positive
556	\N	build ultimate squad pick player country replace player position well country drop improved xi tell swap worldcup2026 football yamal	en	negative
557	\N	head breathtaking venue tournament check complete stadium guide transit tip match detail bbva worldcup2026 estadiobbva	en	positive
558	\N	forget wear team depth scary go	en	negative
559	\N	day join campaign lock ticket let gooo worldcup2026	en	positive
560	\N	fan drag skyrocket price	en	neutral
561	\N	new drip alert national football team unveil home kit clean classic look bold color cultural touch think design	en	positive
562	813	organisation supporter européen fse dépose recours commission européen stopper tarification dynamique	fr	negative
563	820	defend champ big clash football meet knockout pure fire win drop prediction tag friend hype footballrivalry	en	positive
564	820	player day doug p/95 world cup player ca6?r=2yjpde&utm_medium =	en	neutral
565	824	announce referee play qualifi turkey romania francoisletexi	en	neutral
566	824	nidal playoff semi final wale big game footballer live walbih	en	positive
567	824	breaking reach agreement head coach national football team romano new era incoming zidane footballnew	en	neutral
568	828	ready world cup action stunning estadio read venue guide plan trip	en	neutral
569	828	breaking signer france devenir coach équipe national coupe monde football français nouveau ère football étatsunisdafriqu	fr	positive
570	828	build ultimate squad pick player country replace player position well country drop improved xi tell swap worldcup2026 football	en	negative
571	833	nation advance dream alive	en	neutral
572	833	head monterrey world explore estadio breathtaking venue tournament check complete stadium guide transit tip match detail bbva worldcup2026 estadiobbva monterrey	en	positive
573	833	forget wear team depth scary go world cup	en	negative
574	837	forget wear team depth scary go world cup	en	negative
575	837	day join campaign lock world cup ticket let gooo rtt	en	positive
576	837	fan drag fifa court skyrocket world cup ticket price ticketprice	en	negative
577	837	new alert football team unveil home kit clean classic look bold color cultural touch think design footballkit	en	positive
578	840	love win world french bafanapride	en	negative
579	842	nation advance dream alive	en	neutral
580	842	nation advance dream alive	en	neutral
581	842	nation advance dream alive	en	neutral
582	842	nation advance dream alive	en	neutral
583	843	nation advance dream alive	en	neutral
584	843	nation advance dream alive	en	neutral
585	843	nation advance dream alive	en	neutral
586	843	guide year old teenager know win world cup title defeat host nation sweden 5–2 final flashback worldcupfinal soccerwordcup japanesegp ufcseattle openingday marchmadness	en	neutral
587	847	guide year old teenager know win world cup title defeat host nation sweden 5–2 final flashback worldcupfinal soccerwordcup japanesegp ufcseattle openingday marchmadness	en	neutral
588	847	reveal ask r84 play request reject r84 brazil friendly high stake choice bafanabafana	en	neutral
589	847	new footage show ice agent detain mother travel young daughter witness yell know agent refuse d.	en	negative
590	847	guide year old teenager know win world cup title defeat host nation sweden 5–2 final flashback worldcupfinal soccerwordcup japanesegp ufcseattle openingday marchmadness	en	neutral
591	847	reveal ask r84 play request reject r84 brazil friendly high stake choice bafanabafana	en	neutral
592	847	new footage show ice agent detain mother travel young daughter witness yell know agent refuse d.	en	negative
593	852	trent alexander gerrard gagal paham panggil alexander tvriworldcup worldcup2026 tvrisport	en	neutral
594	852	footballer troy happy shin show good rtesport coybig worldcup2026	en	positive
595	855	mctominay new scotland	en	neutral
596	855	expand format dream close countries.which team want world cup appearance drop answer neverplaye firsttimer	en	positive
597	858	star head coach loss friendly match senegal focus shift series frendlie rwanda harambeestar sportsnew	en	negative
598	858	street lisbon stadium nation breathe today team family today seleção quina show world heart beat talent single time	en	positive
599	858	drop world kit nation global statement world cup kit here portugal wear-42587720 puma football fifaworldcup	en	neutral
600	862	ready shine world cup count find envio.international/mexico-ready-t o shine as-2026 world cup count envio	en	neutral
601	862	sale letter official country code position global football cycle rare inventory strategic asset	en	neutral
602	866	new era new kit unveil world cup kit inspire strong tie style meet legacy world stage newkit bj88	en	positive
603	869	mayele join world cup playoff striker link squad preparation intensify crucial fixture africanfootball drcongo	en	neutral
604	875	letsgo soccer tuesdaymotivation	en	neutral
605	875	imagine training madman year call lazy post social medium	en	negative
606	875	calibrate year world cup datum prediction market find croatia +536 undervalue undervalue overpriced market smart think zervehack	en	negative
607	879	team customize soccer soccer nation dream customize world cup pride melash sport melashsport customjersey northamericafootball gameon	en	neutral
608	879	exploit harass abuse humanity gig trap	en	negative
609	879	playoff final battle global glory begin fifaworldcup footballplayoff soccernew worldcupqualifier footballfan trendingsport	en	neutral
610	883	quick seat check buy pick stadium enter game date kickoff time section shade take second save minute misery free signup	en	negative
611	883	day ticket afternoon game city check section sun exposure venue section level shade kickoff time	en	neutral
612	883	miss world let sink azzurri	en	negative
613	883	playoff final qualification match explain fifaworldcup footballplayoff soccernew worldcupqualifier footballfan trendingsport	en	neutral
614	887	stage set color loud unveil world kit worldcup2026 nike fifaworldcup	en	neutral
615	887	boyz brink dream face fearless new caledonia huge inter confederation playoff difference pressure story reggaeboyz	en	neutral
616	887	game changer ready cultural revolution soccer miss spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	neutral
617	887	ready soccer revolution world redefine game miss spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	positive
618	892	grand awakening soccer think miss spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	neutral
619	892	ready world cup elevate soccer new height unite culture culturalunity spanglishsoccer.substack.com/p/is-the-2026- world cup america game	en	positive
620	892	hype world cup twitter rest silent dear 9ja qualify hype mad	en	negative
621	897	time boycottfifa cancel peace coalition stop subservient oppressor	en	negative
622	897	government collect immigration fee refuse process application denial refund silence large fee fraud history american immigration system happen	en	negative
623	897	° open air venue know section shade buy	en	neutral
624	897	sélection samir mourabet émotion énorme défi csport.ma/premiers-mots- samir el mourabet maroc football	fr	positive
625	902	31st team qualify wale ukraine sweden denmark bolivia suriname	en	neutral
627	902	international friendly black star gear win blackstar	en	neutral
628	906	town chinatown deliver authentic experience come food people culture come trip west downtown check city houstontx soccermatter	en	positive
629	906	playoff final battle spot playoff	en	neutral
630	906	time world cup winner minute miss world cup home soil single leg second chance dangerous night italian football history azzurri	en	negative
631	906	summer wait day time get great football competition world way million eye glue game love game	en	positive
632	909	llegan carta legendaria adrenalyn detalle legendarias adrenalyn panini videojuego efootballnewsmx	en	positive
633	909	summer wait day time get great football competition world way million eye glue game love game	en	positive
634	909	government create ai help tourist navigate city worldcup2026	en	positive
635	909	town town chinatown deliver authentic experience come food people culture come trip west check city houstontx	en	positive
636	909	llegan carta legendaria adrenalyn detalle legendarias adrenalyn panini videojuego efootballnewsmx	en	positive
637	909	llegan carta legendaria adrenalyn detalle legendarias adrenalyn panini videojuego efootballnewsmx	en	positive
638	909	llegan carta legendaria adrenalyn detalle legendarias adrenalyn panini videojuego efootballnewsmx	en	positive
639	912	llegan carta legendaria adrenalyn detalle legendarias adrenalyn panini videojuego efootballnewsmx	en	positive
640	912	miss world cup day time single leg knockout second chance bad night watch sofa go brutal	en	negative
641	912	smile hug national team	en	positive
642	917	hit ° venue open go need know section shade buy shade map free	en	neutral
643	917	release official song world tournament host track title light feature jelly roll carin leon produce cirkut fifa light	en	neutral
644	917	hear song national team cherki loud	en	neutral
645	917	midterm test real involvement thing worldcup2026	en	neutral
646	917	futbol soccerwordcup toppschrome football	en	neutral
647	921	host match average temperature ° partial canopy upper section shade low bowl = sun check section buy	en	neutral
648	921	day start world	en	neutral
649	921	day start world	en	neutral
650	926	call pass trent alexander worldcup	en	neutral
651	926	plead friend thehobby get wish rid flip gift trade scotland player find scott mctominay panini	en	negative
652	926	look prizm ™ world big stage meet hobby big brand world cup return big feature qualified nation global chase new parallel incoming maple leaf old	en	neutral
653	930	drop kind shoot كون هذا ديال الفوتوشوت غادي يكون مختلف المغرب	en	neutral
654	930	transmitir por youtube fifaworldcup2026 youtube copadelmundo	en	neutral
655	930	make headline world sport read power channel research desk channelonesport blackstar cricket sportsnew newswrap	en	neutral
656	930	make headline world sport read power channel research desk channelonesport blackstar cricket sportsnew newswrap	en	neutral
657	932	make headline world sport read power channel research desk channelonesport blackstar cricket sportsnew newswrap	en	neutral
658	932	make headline world sport read power channel research desk channelonesport blackstar cricket sportsnew newswrap	en	neutral
659	932	match remember game nation hold breath	en	neutral
660	932	face playoff semifinal qualify winner meet temp book hotel pool wc2026europe	en	neutral
661	936	pm squad european base strong technical evening drop c bring layer wc2026europe bayarea	en	neutral
662	936	youtu.be/ovgks5lm73w?si england anthem standtogether	en	neutral
663	936	team world cup country mean fan need ticket join talk fan path effort bring travel planning housing community place	en	neutral
664	940	dear turist person love come security infraestructure major issue cherry pay water supply incompetent supply clean human use	en	negative
665	944	champion celebrate tonight t20worldcup2026final	en	positive
666	944	falloir garder espoir faire preuve patience battre atteindre coupe monde ligue nation uefa être attendre	fr	positive
667	944	adida good saudint worldcup2026	en	positive
668	948	adida good saudint worldcup2026	en	positive
669	948	day national team unveil uniform world rivalry good kit flashscore.com/news/soccer-wo rld cup team release kit the-2026 world cup worldcup2026	en	neutral
670	948	world come demand discover airbnb late incentive announcement local resident read link offers-750 usd new bergen county bergencounty njrealestate airbnbopportunity metlifestadium	en	neutral
671	948	street lisbon stadium nation breathe today team family today seleção quina show world heart beat talent single time	en	positive
672	949	world come demand discover airbnb late incentive announcement local resident read link offers-750 usd new bergen county bergencounty njrealestate airbnbopportunity metlifestadium	en	neutral
673	949	street lisbon stadium nation breathe today team family today seleção quina show world heart beat talent single time	en	positive
674	949	discours franc légendaire playoff chose match petit gagner coupe nouvellecalédonie	fr	positive
675	952	break ice agent ground airport tsa worker unpaid line stretch hour homan deploy ice officer airport move real leadership look step help american worker	en	negative
676	952	player- edition answer ernst happel daily quiz evening thank interaction footballnerd	en	positive
677	952	game travel carhire flight ukairportparking bit.ly/3vzwxuk support travel football soccer holiday force expat forcescarhire mhhsbd	en	neutral
678	957	think tourism bad lot bad ice terrorizingvisitor	en	negative
679	958	international window vibe injury pile club hit arsenal chelsea man city reply drop football	en	neutral
680	959	usmnt upcoming schedule friendly uruguay close world cup summer sport read upcoming schedule friendly usmnt worldcup2026	en	neutral
681	960	present deal trump end airport nightmare trump reject demand act pass condition send ice airport unclear	en	negative
682	964	lot banger year different	en	positive
683	965	youtube make deal fifa let broadcaster part game live fyi football media	en	neutral
684	967	arrival french national team player camp regular fashion quality fit player insane	en	positive
685	971	ice airport help tsa reduce line identification try arrest people predict ice abolish	en	negative
686	972	ice work airport tsa terrorize innocent people street wear mask new assignment interesting feel moment document photo call patriot lot	en	negative
687	973	mother airport travel young daughter report kidnapping airport trump order ice agent report refuse know witness yell kidnap agent continue refuse d	en	negative
688	974	윤호 인스타 friendly neighborhood#yunhois3gram spiderman	en	positive
689	975	friendly neighborhood spiderman	en	positive
690	976	spider man well garfile spiderman	en	neutral
691	978	dazzle bold spider inspire outfit radiate confidence charm iconic style make unforgettable maryjane spiderman	en	positive
692	982	new crossover come tomorrow want remind people panel superman spiderman dccomics marvel	en	neutral
693	984	break spider man dive emotional chaos spiderman venom	en	negative
694	986	remember time see eman esfandi t shirt make smile think early day spider man take fun throwback know eman esfandi spider man brand new day spiderman emanesfandi throwback	en	positive
695	987	mcu spideytorch humantorch spiderman	en	neutral
696	988	attendre aller voir projet dernier chance spiderman	fr	neutral
697	989	spider man freak tom fan matter fact clip channel thank ask youtu.be/oh44w7jfq3w?si = f9jhmi8jyqtxjuvb spiderman spidermanunnuevodía	en	neutral
698	991	spider man reference clean spiderman marvel comic_strip fyp viral	en	positive
699	992	get random idea spot encounter caine spiderman spiderverse	en	neutral
700	994	bite spider spiderman sting scorpion need superhero scorpionpower mcu tuesdayvar	en	negative
701	995	sting scorpion living room man hurt lot good aid scorpion	en	negative
702	996	recent mafex available pre order aquaman spider man game nng ad spiderman	en	neutral
703	997	black cat have venom sound cool mini series comic happen blackcat venom spiderman marvel comic_strip	en	positive
704	999	get point trend fypシ゚viral spiderman fyp viral	en	neutral
705	1000	protest defend like spider man try bunch rumor talk double take loyal clout chase trend hopping reactor try double defense spiderman quit yappin	en	negative
706	1001	proud turn red transformation comic_strip spiderman marvel animation marvelfanart	en	positive
707	1002	new youtube action figure review marvel legend spider man youtube.com/louisbernal spiderman marvel marvellegend zendaya actionfigure	en	neutral
708	1005	blame like hobgoblin lose lot lose green truth dead go copy cat character lame spiderman	en	negative
709	1006	jeu spider incroyable débat spiderman jeu marvel	fr	negative
710	1007	continue fun adventure visit blue lagoon saud beach bangui windmill cape bojeador lighthouse camp bojeador pasuquin spiderman spidey peterparker marvel avenger superhero cosplay	en	positive
711	1008	enjoy fun adventure norte visit north sand dune bacarra tower cathedral spiderman spidey peterparker marvel avenger superhero cosplay	en	positive
712	1011	spidermanbrandnewday poster design thought spiderman marvel spidermanbnd	en	neutral
713	1012	gawdshot virtualphotography spiderman	en	neutral
714	1014	spider man brand new day trailer breakdown kf0hqe1a8fesbeo spiderman spidermanbrandnewday sonypicture marvel	en	neutral
715	1015	people know right gwenstacy spiderman tobeymegiure gwen marvel	en	negative
716	1018	spider man nerf gun nerf sniper spiderman nerfsniper comedyvideo youtube.com/shorts/5a5zlq8 cjcs?si = qua	en	neutral
717	1019	go flip trio come spiderman	en	negative
718	1022	thing guy spiderman	en	neutral
719	1023	spiderman trailer motion graphic spiderman motiondesign	en	neutral
720	1024	wait spidermanbeyondthespiderverse day spiderman haileesteinfeld shameikmoore milesmorale gwenstacy spiderverse	en	neutral
721	1026	hand stack comic_strip participant stop motion course today absolute bonker story artwork help large format spiderman berniewrightson	en	positive
722	1028	scene trailer spider cocoon transformation man spider spiderman brandnewday daredevil echo jessicajone	en	neutral
723	1029	amazing spider man spiderman	en	positive
724	1032	edit spiderman spidermanbrandnewday marvel imaginedragon	en	neutral
725	1033	spider man brand new day happen 2000 pre mcu feature maguire spider spidermanbrandnewday marvel spiderman	en	neutral
726	1034	s gross vtuber spiderman	en	negative
727	1035	look spider man brand new day spiderman	en	neutral
728	1036	favourite cinema spiderman titanic movienew	en	neutral
729	1037	fashion film understand fashion frivolous language hierarchy editing instinct invisible decision reach rest learn	en	neutral
730	1039	grab iconic soundtrack vinyl perfect fan film vinyl collector tag = ogi&th=1&psc=1 price amazon spiderman vinyl soundtrack ad	en	positive
731	1041	catch edit resume edit footage need asap record stream spiderman streamer contentcreator	en	neutral
732	1043	rumor link spider man brand new day fan push confirm rumor like spiderman guy spiderman	en	neutral
733	1045	big villain spiderman think spiderman	en	neutral
734	1046	spiderman smremastere virtualphotography	en	neutral
735	1047	meet ultimate clone hero swing action exclusive spider man scarlet spider pop vinyl shop r man scarlett reilly exclusive pop vinyl spiderman scarletspider	en	positive
736	1048	spider man save lose spider man brand new day good start feel weird mutation body turn bruce banner help thing spiral hulk involve spiderman viralreel marvel	en	negative
737	1049	villain spider man brand new day boy spiderman	en	positive
738	1052	marvel rival spiderman scarlet witch white fox marvelrival spiderman whitefox avengersdoomsday	en	neutral
739	1053	unreleased clip spider man way spiderman	en	neutral
740	1054	bollyman powerful spiderman superman bollywood chapri class film bencher fcuke bencher quality movie dhurandha chhava	en	positive
741	1055	important reminder deadpool call spiderman baby boy canon	en	positive
742	1056	look spiderman mutual love go talk book show moot flop ai	en	neutral
743	1057	brand new day spiderman	en	positive
744	1058	amazing spider man vol create enduring icon american popular medium amazing spider man amzn.to/3bwrxs5 spiderman	en	positive
745	1063	iron merite nouveau génération spiderman spiderman marvel marvelnew	fr	positive
746	1067	mile morale spider verse edit | bone spiderverse milesmorale spiderman acrossthespiderverse marveledit gwenstacy amv imaginedragon sonyanimation multiverse spidersociety	en	neutral
747	1069	day leave spider brand new day spidermanbrandnewday spiderman marvel comic_strip mcu	en	neutral
748	1072	wonder man renew season	en	neutral
749	1073	want dark spider man new day concept poster look crazy spiderman brandnewday marvel marvelstudio spidermanmovie mcu movieposter conceptart cinema trend	en	neutral
750	1074	mentorship secret handle big city think spiderman milesmorale	en	neutral
751	1077	think people fandom ocs assert dominance treat oc canon character use actual medium post art people ask cryptic suppose know	en	negative
752	1082	spiderwoman black request follower tiktok = m spiderman black blacklist	en	neutral
753	1083	freefall scene spidermanbrandnewday joethegeeksmarvelmonday spiderman marvel mcu tomholland peterparker yourfriendlyneighborhoodspiderman spidey absolutepeak absolutepeakmeme absolutecinema joethgeek	en	positive
754	1085	pre orders open man black gold suit order amiami.com/eng/search/li t/?s_st_list_preorder_available=1&s_st_list_backorder_available=1&s_st_list_newitem_available=1&s_keyword = spider man%e3%80%80medicom%20toy&utm_source = twitter_en&utm_medium = social&utm_campaign = twitter spidermannowayhome spiderman peterparker	en	neutral
755	1086	youtube.com/live/axku75ffe bc?si = vuzhbbm0odkxuz4w spiderman marvel mcu	en	neutral
756	1087	hat drop hate get drop spider man chase venom city base scene spider man spiderman venom	en	negative
757	1088	suit peni parker join roster marvel fight soul peniparker spiderman marvelgame fightingsoul	en	positive
758	1089	wait brand new day little fanmade poster spidermanbrandnewday spiderman	en	neutral
759	1091	suit peterparker spiderman theamazingspiderman	en	neutral
760	1093	save villain save mj future save aunt spiderman curse curse prevent find happiness	en	negative
761	1097	redo atmosphere light blender spiderman	en	negative
762	1098	final swing recreation blender spiderman	en	neutral
763	1100	notice brazilian spider brand new day trailer spiderman marvel tomholland meme funny	en	negative
764	1101	virtualphotography photomode spiderman	en	neutral
765	1102	like mess game photo mode	en	neutral
766	1104	quick sketch base mcfarlane draw spidermanbrandnewday spiderman fanart	en	neutral
767	1108	integrate suit mcu peterparker spiderman spidermannowayhome	en	neutral
768	1109	invert upgrade suit mcu peterparker spiderman spidermannowayhome	en	neutral
769	1110	suit mcu peterparker spiderman spidermanfarfromhome	en	neutral
770	1111	upgrade suit mcu peterparker spiderman spidermanfarfromhome spidermannowayhome	en	neutral
771	1112	duration film spider man brand new day hour minute spiderman	en	neutral
772	1114	stark suit mcu peterparker spiderman captainamericacivilwar spidermanhomecome avengersinfinitywar spidermanfarfromehome	en	negative
773	1117	remember leak scene photo spider man go viral believe trailer spiderman newtrailer 2026movie	en	positive
774	1119	amazing suit webbverse peterparker spiderman theamazingspiderman2 spidermannowayhome	en	positive
775	1120	new red blue suit mcu peterparker spiderman spidermannowayhome	en	neutral
776	1121	actor audition iconic role titanic spiderman twilight indianajone starwar	en	negative
777	1122	remember spiderman poster period spiderman poster print child notebook	en	neutral
778	1123	spiderman jealous tifa ff7	en	negative
779	1124	land speed vault twist year get spiderman	en	positive
780	1126	little violent tirade adventure thepunisher confront help spiderman	en	neutral
781	1127	return marvel television special presentation punisher kill	en	neutral
782	1129	try save consume weight spider man work uncover horror rise city force confront promise cost production b3d spiderman blender	en	negative
783	1130	윤호 인스타그램 friendly neighborhood spiderman instagram.com/p/dwrskysfehs/	en	neutral
784	1131	cute spiderman spiderman yunho 윤호 ateez 에이티즈	en	positive
785	1132	vizinha chega canal youtube.com/shorts/of_myxx qhwi?feature = share spiderman	en	neutral
786	1133	need help need spider man account follow comic_strip focus movie general marvel comic_strip account good suggestion appreciate thank spiderman marvel comicbook follow	en	neutral
787	1134	tbh think organic webbing base emotional state web shooter backup thing spiderman marvel spidermanbrandnewday marvelstudio marvelcinematicuniverse	en	neutral
788	1135	real reason spider man shoot webs notice spider man shoot webs way use gadget power come difference stand debate fan tobey	en	neutral
789	1137	spider man black gold suit spider man way interchangeable head effect part magic gate magic gauntlet web part articulate figure stand marvelcomic marvel spiderman mafex	en	neutral
790	1138	spidermanbrandnewday spiderman trailer reaction marvel	en	neutral
791	1139	yunho post friendly neighborhood spiderman yunho 윤호 ateez 에이티즈	en	neutral
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: -
--

COPY "public"."utilisateur" ("id_utilisateur", "nom", "prenom", "email", "mot_de_passe", "date_naissance", "poids_corps", "sexe", "role", "id_coach") FROM stdin;
2	Connor	Sarah	sarah.connor@bartrack.com	password_hash_123	1985-06-20	65.00	F	coach	\N
3	Rossi	Gio	gio@bartrack.com	password_hash_123	1998-04-12	82.00	M	athlete	1
4	Dupont	Michel	michel.dupont@gmail.com	password_hash_123	1995-11-03	78.50	M	athlete	1
5	Smith	Alice	alice.smith@yahoo.com	password_hash_123	2001-02-28	58.20	F	athlete	1
6	Mbappe	Kylian	kiki@football.fr	password_hash_123	1998-12-20	75.00	M	athlete	1
7	Ripley	Ellen	ellen.ripley@space.com	password_hash_123	1990-08-08	62.50	F	athlete	2
8	Stark	Tony	tony@stark.com	password_hash_123	1982-05-29	72.00	M	athlete	2
9	Romanoff	Natasha	bw@avengers.com	password_hash_123	1994-11-22	59.00	F	athlete	2
10	Banner	Bruce	hulk@smash.com	password_hash_123	1988-12-18	95.00	M	athlete	2
11	choco	pepito	pepito_choco@example.com	$2b$12$C2YzBEOdoLn5HmmnufLBeOH8qGhpi9w3sO2fCEdsl1z/17DlKBrqa	2025-12-17	56.00	M	athlete	\N
12	chocoss	pepitosss	pepitosss_choco@example.com	$2b$12$L7f.96kwt5BMIgQ4BRPgJuuWgB4kDaMFz9yZjlcWI/iT3ftv60uPm	2025-12-17	56.00	M	athlete	\N
13	remi	leboss	leboss@example.com	$pbkdf2-sha256$29000$UUppDeH8f2/tnZPyXivlPA$wht6CCFRwr0gpretUq/ks7dauQfiQ2J4Qkk2R1Mv1XI	2025-12-17	80.00	M	athlete	\N
14	duppi	thomas	thomas.duppi@gmail.com	$pbkdf2-sha256$29000$ZiyltNZ6T6n1nrPWmpOSUg$fQ5OIeesncmSwiKO/PerZFf8dSgAvZebGLfZaCrLh1A	2005-04-02	70.00	M	athlete	\N
15	test	test	test@test.com	$pbkdf2-sha256$29000$e89Z6x0DYIwxJkQopTTGWA$U2HKydtSgKkQ5.Sf569lmvrI5VNLe1IGE5oR0t4nHEo	2000-01-01	70.00	F	athlete	\N
1	Carter	Coach	coach.carter@bartrack.com	password_hash_123	1980-01-15	40.00	M	coach	\N
16	PHAN	David	david.phan@gmail.com	$pbkdf2-sha256$29000$0Ppf612LMUaI0bo3phRCCA$Olw8X9d.JVjBKnMYVKD4o/yiCiyCaRqwr64qbULRGtg	2000-12-20	70.00	M	athlete	\N
17	escobar	pablo	pabloemilio@example.com	$pbkdf2-sha256$29000$Wcu5N6Z0jtEaI8S4d65VSg$WIwvQmoimnSayyZL46qw9Cmhj19bDUeiZVKYTa3k2XQ	2025-12-17	120.00	F	athlete	\N
18	test1	test	test1@test.com	$pbkdf2-sha256$29000$QohR6l1rDcEYg5DSGmMMAQ$FnSK7YNUlKUthR5NLY0qZiCejG5kdEhgdRolpiphgzY	2000-02-02	60.00	M	athlete	\N
20	Famille	Test	test.test@gmail.com	$pbkdf2-sha256$29000$ZowRYmxtTemdc47x3huDUA$4yNBzEiSFYSbK1x1nkmBR/FdlABp03RCv/1ews2WoEQ	2000-11-23	60.00	M	athlete	\N
19	Test	Thomas1	thomasduppi@gmail.com	$pbkdf2-sha256$29000$CIGwNuZ8LyVEyHkvxRhDSA$iXUvp3Te3/yfKUgXpnb9mcBdpd1N7kWrSvmk0gvMXEE	2005-02-05	69.00	M	athlete	\N
24	leboss	camarche	michmich31@example.com	$pbkdf2-sha256$29000$DYGwVmoNQYiRUipFKCWEUA$gyf37Wd2no9ry5Su.0ENF1WGJZNFDK2uIOuyP1hW/v4	2001-03-04	90.00	M	admin	\N
27	testapi	test	testapi.test@gmail.com	$pbkdf2-sha256$29000$ntMa43wPQSglJKTU2jtnTA$.aLxv9FjWVeJEAUfC72wQtNnucUpQ.75P0OEWTRw68o	2000-12-20	70.00	M	athlete	\N
28	admin	admin	admin@admin.com	$pbkdf2-sha256$29000$xpizVsrZe..dE0LImZMSQg$B9OP4/4kA58BUED5eoFj9Cv5PZzsU.WamH11r7eGGMU	2026-03-25	90.00	M	admin	\N
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY "realtime"."schema_migrations" ("version", "inserted_at") FROM stdin;
20211116024918	2025-11-26 07:47:25
20211116045059	2025-11-26 07:47:27
20211116050929	2025-11-26 07:47:29
20211116051442	2025-11-26 07:47:31
20211116212300	2025-11-26 07:47:33
20211116213355	2025-11-26 07:47:34
20211116213934	2025-11-26 07:47:36
20211116214523	2025-11-26 07:47:38
20211122062447	2025-11-26 07:47:40
20211124070109	2025-11-26 07:47:42
20211202204204	2025-11-26 07:47:44
20211202204605	2025-11-26 07:47:45
20211210212804	2025-11-26 07:47:51
20211228014915	2025-11-26 07:47:52
20220107221237	2025-11-26 07:47:54
20220228202821	2025-11-26 07:47:56
20220312004840	2025-11-26 07:47:57
20220603231003	2025-11-26 07:48:00
20220603232444	2025-11-26 07:48:02
20220615214548	2025-11-26 07:48:04
20220712093339	2025-11-26 07:48:06
20220908172859	2025-11-26 07:48:07
20220916233421	2025-11-26 07:48:09
20230119133233	2025-11-26 07:48:11
20230128025114	2025-11-26 07:48:13
20230128025212	2025-11-26 07:48:15
20230227211149	2025-11-26 07:48:16
20230228184745	2025-11-26 07:48:18
20230308225145	2025-11-26 07:48:20
20230328144023	2025-11-26 07:48:21
20231018144023	2025-11-26 07:48:23
20231204144023	2025-11-26 07:48:26
20231204144024	2025-11-26 07:48:28
20231204144025	2025-11-26 07:48:29
20240108234812	2025-11-26 07:48:31
20240109165339	2025-11-26 07:48:33
20240227174441	2025-11-26 07:48:36
20240311171622	2025-11-26 07:48:38
20240321100241	2025-11-26 07:48:42
20240401105812	2025-11-26 07:48:47
20240418121054	2025-11-26 07:48:49
20240523004032	2025-11-26 07:48:55
20240618124746	2025-11-26 07:48:57
20240801235015	2025-11-26 07:48:59
20240805133720	2025-11-26 07:49:00
20240827160934	2025-11-26 07:49:02
20240919163303	2025-11-26 07:49:04
20240919163305	2025-11-26 07:49:06
20241019105805	2025-11-26 07:49:08
20241030150047	2025-11-26 07:49:14
20241108114728	2025-11-26 07:49:17
20241121104152	2025-11-26 07:49:18
20241130184212	2025-11-26 07:49:20
20241220035512	2025-11-26 07:49:22
20241220123912	2025-11-26 07:49:24
20241224161212	2025-11-26 07:49:25
20250107150512	2025-11-26 07:49:27
20250110162412	2025-11-26 07:49:29
20250123174212	2025-11-26 07:49:30
20250128220012	2025-11-26 07:49:32
20250506224012	2025-11-26 07:49:33
20250523164012	2025-11-26 07:49:35
20250714121412	2025-11-26 07:49:37
20250905041441	2025-11-26 07:49:38
20251103001201	2025-11-26 07:49:40
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY "realtime"."subscription" ("id", "subscription_id", "entity", "filters", "claims", "created_at") FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."buckets_analytics" ("name", "type", "format", "created_at", "updated_at", "id", "deleted_at") FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."buckets_vectors" ("id", "type", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."migrations" ("id", "name", "hash", "executed_at") FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-11-26 07:47:22.683795
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-11-26 07:47:22.688169
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-11-26 07:47:22.717116
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-11-26 07:47:22.762022
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-11-26 07:47:22.765614
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-11-26 07:47:22.773616
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-11-26 07:47:22.776871
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-11-26 07:47:22.789461
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-11-26 07:47:22.795923
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-11-26 07:47:22.799245
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-11-26 07:47:22.802517
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-11-26 07:47:22.822035
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-11-26 07:47:22.825354
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-11-26 07:47:22.828517
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-11-26 07:47:22.832509
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-11-26 07:47:22.837681
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-11-26 07:47:22.84163
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-11-26 07:47:22.846973
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-11-26 07:47:22.862345
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-11-26 07:47:22.87329
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-11-26 07:47:22.87721
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-11-26 07:47:22.880537
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-11-26 07:47:23.288143
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2025-11-26 07:47:23.324076
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2025-11-26 07:47:23.327494
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2025-11-26 07:47:23.336712
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2025-11-26 07:47:23.340751
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-01-21 12:48:20.213565
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2025-11-26 07:47:22.693954
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2025-11-26 07:47:22.770059
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2025-11-26 07:47:22.780036
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2025-11-26 07:47:22.785684
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2025-11-26 07:47:22.884654
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2025-11-26 07:47:22.897817
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2025-11-26 07:47:23.245136
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2025-11-26 07:47:23.250423
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2025-11-26 07:47:23.255344
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2025-11-26 07:47:23.261232
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2025-11-26 07:47:23.267378
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2025-11-26 07:47:23.273792
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2025-11-26 07:47:23.275246
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2025-11-26 07:47:23.27972
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2025-11-26 07:47:23.282704
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2025-11-26 07:47:23.292064
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2025-11-26 07:47:23.299516
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2025-11-26 07:47:23.303455
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2025-11-26 07:47:23.311276
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2025-11-26 07:47:23.315594
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2025-11-26 07:47:23.320592
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2025-11-26 07:47:23.343746
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-03-04 08:04:01.314156
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-03-04 08:04:01.37524
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-03-04 08:04:01.37673
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-03-04 08:04:01.398286
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-03-04 08:04:01.400312
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-03-04 08:04:01.401396
56	fix-optimized-search-function	cb58526ebc23048049fd5bf2fd148d18b04a2073	2026-03-04 08:04:01.407418
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY "storage"."vector_indexes" ("id", "name", "bucket_id", "data_type", "dimension", "distance_metric", "metadata_configuration", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY "vault"."secrets" ("id", "name", "description", "secret", "key_id", "nonce", "created_at", "updated_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, false);


--
-- Name: exercice_id_exercice_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."exercice_id_exercice_seq"', 5, true);


--
-- Name: ref_rpe_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."ref_rpe_table_id_seq"', 96, true);


--
-- Name: repetition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."repetition_id_seq"', 484, true);


--
-- Name: seance_exo_id_seance_exo_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."seance_exo_id_seance_exo_seq"', 33, true);


--
-- Name: seance_id_seance_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."seance_id_seance_seq"', 18, true);


--
-- Name: serie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."serie_id_seq"', 99, true);


--
-- Name: tweets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."tweets_id_seq"', 1, false);


--
-- Name: tweets_processed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."tweets_processed_id_seq"', 1, false);


--
-- Name: utilisateur_id_utilisateur_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('"public"."utilisateur_id_utilisateur_seq"', 28, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('"realtime"."subscription_id_seq"', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "amr_id_pk" PRIMARY KEY ("id");


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."audit_log_entries"
    ADD CONSTRAINT "audit_log_entries_pkey" PRIMARY KEY ("id");


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."custom_oauth_providers"
    ADD CONSTRAINT "custom_oauth_providers_identifier_key" UNIQUE ("identifier");


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."custom_oauth_providers"
    ADD CONSTRAINT "custom_oauth_providers_pkey" PRIMARY KEY ("id");


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."flow_state"
    ADD CONSTRAINT "flow_state_pkey" PRIMARY KEY ("id");


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_pkey" PRIMARY KEY ("id");


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_provider_id_provider_unique" UNIQUE ("provider_id", "provider");


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."instances"
    ADD CONSTRAINT "instances_pkey" PRIMARY KEY ("id");


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_authentication_method_pkey" UNIQUE ("session_id", "authentication_method");


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_pkey" PRIMARY KEY ("id");


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_last_challenged_at_key" UNIQUE ("last_challenged_at");


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_authorization_code_key" UNIQUE ("authorization_code");


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_authorization_id_key" UNIQUE ("authorization_id");


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_client_states"
    ADD CONSTRAINT "oauth_client_states_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_clients"
    ADD CONSTRAINT "oauth_clients_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_pkey" PRIMARY KEY ("id");


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_user_client_unique" UNIQUE ("user_id", "client_id");


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id");


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_token_unique" UNIQUE ("token");


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_entity_id_key" UNIQUE ("entity_id");


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_pkey" PRIMARY KEY ("id");


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_pkey" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_pkey" PRIMARY KEY ("id");


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."sso_providers"
    ADD CONSTRAINT "sso_providers_pkey" PRIMARY KEY ("id");


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_phone_key" UNIQUE ("phone");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."webauthn_challenges"
    ADD CONSTRAINT "webauthn_challenges_pkey" PRIMARY KEY ("id");


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."webauthn_credentials"
    ADD CONSTRAINT "webauthn_credentials_pkey" PRIMARY KEY ("id");


--
-- Name: exercice exercice_nom_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."exercice"
    ADD CONSTRAINT "exercice_nom_key" UNIQUE ("nom");


--
-- Name: exercice exercice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."exercice"
    ADD CONSTRAINT "exercice_pkey" PRIMARY KEY ("id_exercice");


--
-- Name: hot_metrics hot_metrics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."hot_metrics"
    ADD CONSTRAINT "hot_metrics_pkey" PRIMARY KEY ("sentiment_label");


--
-- Name: profil_vbt profil_vbt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."profil_vbt"
    ADD CONSTRAINT "profil_vbt_pkey" PRIMARY KEY ("id_utilisateur", "id_exercice");


--
-- Name: ref_rpe_table ref_rpe_table_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."ref_rpe_table"
    ADD CONSTRAINT "ref_rpe_table_pkey" PRIMARY KEY ("id");


--
-- Name: repetition repetition_id_serie_numero_rep_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."repetition"
    ADD CONSTRAINT "repetition_id_serie_numero_rep_key" UNIQUE ("id_serie", "numero_rep");


--
-- Name: repetition repetition_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."repetition"
    ADD CONSTRAINT "repetition_pkey" PRIMARY KEY ("id");


--
-- Name: seance_exo seance_exo_id_seance_id_exercice_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance_exo"
    ADD CONSTRAINT "seance_exo_id_seance_id_exercice_key" UNIQUE ("id_seance", "id_exercice");


--
-- Name: seance_exo seance_exo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance_exo"
    ADD CONSTRAINT "seance_exo_pkey" PRIMARY KEY ("id_seance_exo");


--
-- Name: seance seance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance"
    ADD CONSTRAINT "seance_pkey" PRIMARY KEY ("id_seance");


--
-- Name: serie serie_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."serie"
    ADD CONSTRAINT "serie_pkey" PRIMARY KEY ("id");


--
-- Name: tweets tweets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tweets"
    ADD CONSTRAINT "tweets_pkey" PRIMARY KEY ("id");


--
-- Name: tweets_processed tweets_processed_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tweets_processed"
    ADD CONSTRAINT "tweets_processed_pkey" PRIMARY KEY ("id");


--
-- Name: tweets tweets_raw_content_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."tweets"
    ADD CONSTRAINT "tweets_raw_content_key" UNIQUE ("raw_content");


--
-- Name: ref_rpe_table unique_reps_rpe; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."ref_rpe_table"
    ADD CONSTRAINT "unique_reps_rpe" UNIQUE ("reps", "rpe");


--
-- Name: utilisateur utilisateur_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."utilisateur"
    ADD CONSTRAINT "utilisateur_email_key" UNIQUE ("email");


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."utilisateur"
    ADD CONSTRAINT "utilisateur_pkey" PRIMARY KEY ("id_utilisateur");


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY "realtime"."messages"
    ADD CONSTRAINT "messages_pkey" PRIMARY KEY ("id", "inserted_at");


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY "realtime"."subscription"
    ADD CONSTRAINT "pk_subscription" PRIMARY KEY ("id");


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY "realtime"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."buckets_analytics"
    ADD CONSTRAINT "buckets_analytics_pkey" PRIMARY KEY ("id");


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."buckets"
    ADD CONSTRAINT "buckets_pkey" PRIMARY KEY ("id");


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."buckets_vectors"
    ADD CONSTRAINT "buckets_vectors_pkey" PRIMARY KEY ("id");


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."migrations"
    ADD CONSTRAINT "migrations_name_key" UNIQUE ("name");


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."migrations"
    ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."objects"
    ADD CONSTRAINT "objects_pkey" PRIMARY KEY ("id");


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_pkey" PRIMARY KEY ("id");


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads"
    ADD CONSTRAINT "s3_multipart_uploads_pkey" PRIMARY KEY ("id");


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."vector_indexes"
    ADD CONSTRAINT "vector_indexes_pkey" PRIMARY KEY ("id");


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "audit_logs_instance_id_idx" ON "auth"."audit_log_entries" USING "btree" ("instance_id");


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "confirmation_token_idx" ON "auth"."users" USING "btree" ("confirmation_token") WHERE (("confirmation_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "custom_oauth_providers_created_at_idx" ON "auth"."custom_oauth_providers" USING "btree" ("created_at");


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "custom_oauth_providers_enabled_idx" ON "auth"."custom_oauth_providers" USING "btree" ("enabled");


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "custom_oauth_providers_identifier_idx" ON "auth"."custom_oauth_providers" USING "btree" ("identifier");


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "custom_oauth_providers_provider_type_idx" ON "auth"."custom_oauth_providers" USING "btree" ("provider_type");


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "email_change_token_current_idx" ON "auth"."users" USING "btree" ("email_change_token_current") WHERE (("email_change_token_current")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "email_change_token_new_idx" ON "auth"."users" USING "btree" ("email_change_token_new") WHERE (("email_change_token_new")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "factor_id_created_at_idx" ON "auth"."mfa_factors" USING "btree" ("user_id", "created_at");


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "flow_state_created_at_idx" ON "auth"."flow_state" USING "btree" ("created_at" DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "identities_email_idx" ON "auth"."identities" USING "btree" ("email" "text_pattern_ops");


--
-- Name: INDEX "identities_email_idx"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX "auth"."identities_email_idx" IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "identities_user_id_idx" ON "auth"."identities" USING "btree" ("user_id");


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "idx_auth_code" ON "auth"."flow_state" USING "btree" ("auth_code");


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "idx_oauth_client_states_created_at" ON "auth"."oauth_client_states" USING "btree" ("created_at");


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "idx_user_id_auth_method" ON "auth"."flow_state" USING "btree" ("user_id", "authentication_method");


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "mfa_challenge_created_at_idx" ON "auth"."mfa_challenges" USING "btree" ("created_at" DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "mfa_factors_user_friendly_name_unique" ON "auth"."mfa_factors" USING "btree" ("friendly_name", "user_id") WHERE (TRIM(BOTH FROM "friendly_name") <> ''::"text");


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "mfa_factors_user_id_idx" ON "auth"."mfa_factors" USING "btree" ("user_id");


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "oauth_auth_pending_exp_idx" ON "auth"."oauth_authorizations" USING "btree" ("expires_at") WHERE ("status" = 'pending'::"auth"."oauth_authorization_status");


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "oauth_clients_deleted_at_idx" ON "auth"."oauth_clients" USING "btree" ("deleted_at");


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "oauth_consents_active_client_idx" ON "auth"."oauth_consents" USING "btree" ("client_id") WHERE ("revoked_at" IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "oauth_consents_active_user_client_idx" ON "auth"."oauth_consents" USING "btree" ("user_id", "client_id") WHERE ("revoked_at" IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "oauth_consents_user_order_idx" ON "auth"."oauth_consents" USING "btree" ("user_id", "granted_at" DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "one_time_tokens_relates_to_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("relates_to");


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "one_time_tokens_token_hash_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("token_hash");


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "one_time_tokens_user_id_token_type_key" ON "auth"."one_time_tokens" USING "btree" ("user_id", "token_type");


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "reauthentication_token_idx" ON "auth"."users" USING "btree" ("reauthentication_token") WHERE (("reauthentication_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "recovery_token_idx" ON "auth"."users" USING "btree" ("recovery_token") WHERE (("recovery_token")::"text" !~ '^[0-9 ]*$'::"text");


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "refresh_tokens_instance_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id");


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "refresh_tokens_instance_id_user_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id", "user_id");


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "refresh_tokens_parent_idx" ON "auth"."refresh_tokens" USING "btree" ("parent");


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "refresh_tokens_session_id_revoked_idx" ON "auth"."refresh_tokens" USING "btree" ("session_id", "revoked");


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "refresh_tokens_updated_at_idx" ON "auth"."refresh_tokens" USING "btree" ("updated_at" DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "saml_providers_sso_provider_id_idx" ON "auth"."saml_providers" USING "btree" ("sso_provider_id");


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "saml_relay_states_created_at_idx" ON "auth"."saml_relay_states" USING "btree" ("created_at" DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "saml_relay_states_for_email_idx" ON "auth"."saml_relay_states" USING "btree" ("for_email");


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "saml_relay_states_sso_provider_id_idx" ON "auth"."saml_relay_states" USING "btree" ("sso_provider_id");


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "sessions_not_after_idx" ON "auth"."sessions" USING "btree" ("not_after" DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "sessions_oauth_client_id_idx" ON "auth"."sessions" USING "btree" ("oauth_client_id");


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "sessions_user_id_idx" ON "auth"."sessions" USING "btree" ("user_id");


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "sso_domains_domain_idx" ON "auth"."sso_domains" USING "btree" ("lower"("domain"));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "sso_domains_sso_provider_id_idx" ON "auth"."sso_domains" USING "btree" ("sso_provider_id");


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "sso_providers_resource_id_idx" ON "auth"."sso_providers" USING "btree" ("lower"("resource_id"));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "sso_providers_resource_id_pattern_idx" ON "auth"."sso_providers" USING "btree" ("resource_id" "text_pattern_ops");


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "unique_phone_factor_per_user" ON "auth"."mfa_factors" USING "btree" ("user_id", "phone");


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "user_id_created_at_idx" ON "auth"."sessions" USING "btree" ("user_id", "created_at");


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "users_email_partial_key" ON "auth"."users" USING "btree" ("email") WHERE ("is_sso_user" = false);


--
-- Name: INDEX "users_email_partial_key"; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX "auth"."users_email_partial_key" IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "users_instance_id_email_idx" ON "auth"."users" USING "btree" ("instance_id", "lower"(("email")::"text"));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "users_instance_id_idx" ON "auth"."users" USING "btree" ("instance_id");


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "users_is_anonymous_idx" ON "auth"."users" USING "btree" ("is_anonymous");


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "webauthn_challenges_expires_at_idx" ON "auth"."webauthn_challenges" USING "btree" ("expires_at");


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "webauthn_challenges_user_id_idx" ON "auth"."webauthn_challenges" USING "btree" ("user_id");


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX "webauthn_credentials_credential_id_key" ON "auth"."webauthn_credentials" USING "btree" ("credential_id");


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX "webauthn_credentials_user_id_idx" ON "auth"."webauthn_credentials" USING "btree" ("user_id");


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX "ix_realtime_subscription_entity" ON "realtime"."subscription" USING "btree" ("entity");


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX "messages_inserted_at_topic_index" ON ONLY "realtime"."messages" USING "btree" ("inserted_at" DESC, "topic") WHERE (("extension" = 'broadcast'::"text") AND ("private" IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX "subscription_subscription_id_entity_filters_key" ON "realtime"."subscription" USING "btree" ("subscription_id", "entity", "filters");


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX "bname" ON "storage"."buckets" USING "btree" ("name");


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX "bucketid_objname" ON "storage"."objects" USING "btree" ("bucket_id", "name");


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX "buckets_analytics_unique_name_idx" ON "storage"."buckets_analytics" USING "btree" ("name") WHERE ("deleted_at" IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX "idx_multipart_uploads_list" ON "storage"."s3_multipart_uploads" USING "btree" ("bucket_id", "key", "created_at");


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX "idx_objects_bucket_id_name" ON "storage"."objects" USING "btree" ("bucket_id", "name" COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX "idx_objects_bucket_id_name_lower" ON "storage"."objects" USING "btree" ("bucket_id", "lower"("name") COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX "name_prefix_search" ON "storage"."objects" USING "btree" ("name" "text_pattern_ops");


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX "vector_indexes_name_bucket_id_idx" ON "storage"."vector_indexes" USING "btree" ("name", "bucket_id");


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER "tr_check_filters" BEFORE INSERT OR UPDATE ON "realtime"."subscription" FOR EACH ROW EXECUTE FUNCTION "realtime"."subscription_check_filters"();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER "enforce_bucket_name_length_trigger" BEFORE INSERT OR UPDATE OF "name" ON "storage"."buckets" FOR EACH ROW EXECUTE FUNCTION "storage"."enforce_bucket_name_length"();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER "protect_buckets_delete" BEFORE DELETE ON "storage"."buckets" FOR EACH STATEMENT EXECUTE FUNCTION "storage"."protect_delete"();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER "protect_objects_delete" BEFORE DELETE ON "storage"."objects" FOR EACH STATEMENT EXECUTE FUNCTION "storage"."protect_delete"();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER "update_objects_updated_at" BEFORE UPDATE ON "storage"."objects" FOR EACH ROW EXECUTE FUNCTION "storage"."update_updated_at_column"();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_auth_factor_id_fkey" FOREIGN KEY ("factor_id") REFERENCES "auth"."mfa_factors"("id") ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "auth"."oauth_clients"("id") ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_authorizations"
    ADD CONSTRAINT "oauth_authorizations_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "auth"."oauth_clients"("id") ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."oauth_consents"
    ADD CONSTRAINT "oauth_consents_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_flow_state_id_fkey" FOREIGN KEY ("flow_state_id") REFERENCES "auth"."flow_state"("id") ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_oauth_client_id_fkey" FOREIGN KEY ("oauth_client_id") REFERENCES "auth"."oauth_clients"("id") ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."webauthn_challenges"
    ADD CONSTRAINT "webauthn_challenges_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY "auth"."webauthn_credentials"
    ADD CONSTRAINT "webauthn_credentials_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;


--
-- Name: utilisateur fk_coach; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."utilisateur"
    ADD CONSTRAINT "fk_coach" FOREIGN KEY ("id_coach") REFERENCES "public"."utilisateur"("id_utilisateur") ON DELETE SET NULL;


--
-- Name: repetition fk_repetition_serie; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."repetition"
    ADD CONSTRAINT "fk_repetition_serie" FOREIGN KEY ("id_serie") REFERENCES "public"."serie"("id") ON DELETE CASCADE;


--
-- Name: seance_exo fk_seance_exo_exercice; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance_exo"
    ADD CONSTRAINT "fk_seance_exo_exercice" FOREIGN KEY ("id_exercice") REFERENCES "public"."exercice"("id_exercice") ON DELETE CASCADE;


--
-- Name: seance_exo fk_seance_exo_seance; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance_exo"
    ADD CONSTRAINT "fk_seance_exo_seance" FOREIGN KEY ("id_seance") REFERENCES "public"."seance"("id_seance") ON DELETE CASCADE;


--
-- Name: seance fk_seance_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."seance"
    ADD CONSTRAINT "fk_seance_utilisateur" FOREIGN KEY ("id_utilisateur") REFERENCES "public"."utilisateur"("id_utilisateur") ON DELETE CASCADE;


--
-- Name: serie fk_serie_seance_exo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."serie"
    ADD CONSTRAINT "fk_serie_seance_exo" FOREIGN KEY ("id_seance_exo") REFERENCES "public"."seance_exo"("id_seance_exo") ON DELETE CASCADE;


--
-- Name: profil_vbt fk_vbt_exercice; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."profil_vbt"
    ADD CONSTRAINT "fk_vbt_exercice" FOREIGN KEY ("id_exercice") REFERENCES "public"."exercice"("id_exercice") ON DELETE CASCADE;


--
-- Name: profil_vbt fk_vbt_utilisateur; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."profil_vbt"
    ADD CONSTRAINT "fk_vbt_utilisateur" FOREIGN KEY ("id_utilisateur") REFERENCES "public"."utilisateur"("id_utilisateur") ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."objects"
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads"
    ADD CONSTRAINT "s3_multipart_uploads_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_upload_id_fkey" FOREIGN KEY ("upload_id") REFERENCES "storage"."s3_multipart_uploads"("id") ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY "storage"."vector_indexes"
    ADD CONSTRAINT "vector_indexes_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets_vectors"("id");


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."audit_log_entries" ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."flow_state" ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."identities" ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."instances" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."mfa_amr_claims" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."mfa_challenges" ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."mfa_factors" ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."one_time_tokens" ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."refresh_tokens" ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."saml_providers" ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."saml_relay_states" ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."schema_migrations" ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."sessions" ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."sso_domains" ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."sso_providers" ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE "auth"."users" ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE "realtime"."messages" ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."buckets" ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."buckets_analytics" ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."buckets_vectors" ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."migrations" ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."objects" ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."s3_multipart_uploads" ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."s3_multipart_uploads_parts" ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE "storage"."vector_indexes" ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION "supabase_realtime" WITH (publish = 'insert, update, delete, truncate');


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER "issue_graphql_placeholder" ON "sql_drop"
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION "extensions"."set_graphql_placeholder"();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER "issue_pg_cron_access" ON "ddl_command_end"
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION "extensions"."grant_pg_cron_access"();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER "issue_pg_graphql_access" ON "ddl_command_end"
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION "extensions"."grant_pg_graphql_access"();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER "issue_pg_net_access" ON "ddl_command_end"
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION "extensions"."grant_pg_net_access"();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER "pgrst_ddl_watch" ON "ddl_command_end"
   EXECUTE FUNCTION "extensions"."pgrst_ddl_watch"();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER "pgrst_drop_watch" ON "sql_drop"
   EXECUTE FUNCTION "extensions"."pgrst_drop_watch"();


--
-- PostgreSQL database dump complete
--

\unrestrict cZ9c6hvpxeKF6CTFZgNSHOucM4fJqWWcBQhAitl4Cg5jDbcJgFe9p1eaNhrAhsG

