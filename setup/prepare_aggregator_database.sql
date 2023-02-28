create table migration_info (
    version integer not null
);

insert into migration_info(version) values (0);
