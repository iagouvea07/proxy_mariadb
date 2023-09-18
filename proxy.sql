INSERT INTO mysql_servers(hostgroup_id,hostname,port) VALUES (1,'172.18.0.2',3306);
INSERT INTO mysql_servers(hostgroup_id,hostname,port) VALUES (1,'172.18.0.3',3306);

SELECT * FROM mysql_servers;

UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_username';
UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_password';

UPDATE global_variables SET variable_value='2000' WHERE variable_name IN ('mysql-monitor_connect_interval','mysql-monitor_ping_interval','mysql-monitor_read_only_interval');
SELECT * FROM global_variables WHERE variable_name LIKE 'mysql-monitor_%';

LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;

SHOW TABLES FROM monitor;

LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;

SELECT * FROM monitor.mysql_server_connect_log ORDER BY time_start_us DESC LIMIT 3;
SELECT * FROM monitor.mysql_server_ping_log ORDER BY time_start_us DESC LIMIT 3;

SELECT * FROM mysql_servers;

INSERT INTO mysql_replication_hostgroups (writer_hostgroup,reader_hostgroup,comment) VALUES (1,2,'cluster');

LOAD MYSQL SERVERS TO RUNTIME;

SELECT * FROM monitor.mysql_server_read_only_log ORDER BY time_start_us DESC LIMIT 3;

SAVE MYSQL SERVERS TO DISK;
SAVE MYSQL VARIABLES TO DISK;

INSERT INTO mysql_query_rules (username, destination_hostgroup, active, match_digest, apply) VALUES
    ('monitor', 2, 1, '^SELECT.* FOR UPDATE', 1),
    ('monitor', 1, 1, '^SELECT ', 1);

LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;