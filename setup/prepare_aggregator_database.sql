CREATE TABLE IF NOT EXISTS migration_info (version INTEGER NOT NULL);
DELETE FROM migration_info;
INSERT INTO migration_info(version) VALUES (0);
DROP SCHEMA IF EXISTS dvo CASCADE;
CREATE SCHEMA dvo;
CREATE TABLE dvo.migration_info (version INTEGER NOT NULL);
INSERT INTO dvo.migration_info(version) VALUES (0);