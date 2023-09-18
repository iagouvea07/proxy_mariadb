-- MASTER COMMANDS

SHOW MASTER STATUS;

CREATE USER 'replicator'@'%' IDENTIFIED BY '12345';

GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';


CREATE USER 'monitor'@'%' IDENTIFIED BY 'monitor';

GRANT USAGE, REPLICATION CLIENT ON *.* TO 'monitor'@'%';

FLUSH PRIVILEGES;


-- MIRROR COMMANDS

CHANGE MASTER TO
    MASTER_HOST='172.18.0.3',
    MASTER_USER='replicator',
    MASTER_PASSWORD='12345',
    MASTER_LOG_FILE='mysql-bin.000002',
    MASTER_LOG_POS=328;

START SLAVE;

--MASTER COMMANDS

