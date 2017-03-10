create table VC_STATUS
(
 FILEPATH varchar(256) not null,
 REPOSITORY_DT datetime null,
 FILEMOD_DT datetime null,
 LASTIMPORT_REV char(32) null, 
 primary key  (FILEPATH)
);

