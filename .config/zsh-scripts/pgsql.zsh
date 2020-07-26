pghelp () {
  cat << EOF
\list                                                                                       - # List db
\c [db]                                                                                     - # Connect to DB
\du                                                                                         - # List user accounts
\dt                                                                                         - # List tables
\select count(datid) from pg_stat_activity;                                                 - # Get all active connections
createuser -W <user>                                                                        - # Create user with password
createdb -O <owner> <user>                                                                  - # Create DB
GRANT ALL on DATABASE <db> to <user>;                                                       - # Grant to a DB user
ALTER ROLE <user> ENCRYPTED PASSWORD '<md5 password hashed here>';                          - # Add password
md5 hashing:
$ python2.7
>>> import hashlib
>>> username = "username"
>>> password = "password1234"
>>> "md5" + hashlib.md5(password + username).hexdigest()
'hash'
export PGCLIENTENCODING=UTF8; psql -p 26257 -h localhost                                    - # Cockroach connection string
EOF
}
