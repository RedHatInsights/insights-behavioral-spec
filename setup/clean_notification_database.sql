drop table if exists migration_info;
delete from reported;
delete from new_reports cascade;
