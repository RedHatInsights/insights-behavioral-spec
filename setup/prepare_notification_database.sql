create table if not exists migration_info (version integer not null);
insert into migration_info(version) values (0);