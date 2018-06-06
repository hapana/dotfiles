pghelp () {
  cat << EOF
\list                                        - # List db
\c [db]                                      - # Connect to DB
\du                                          - # List user accounts
\dt                                          - # List tables
\CREATE DATABASE dbname                      - # Create DB
\CREATE USER user                            - # Create User
\GRANT ALL ON DATABASE db TO USER            - # Grant everything for user to DB
select count(datid) from pg_stat_activity;   - # Get all active connections
EOF
}
