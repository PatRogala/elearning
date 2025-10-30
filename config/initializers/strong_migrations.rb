# Mark existing migrations as safe
StrongMigrations.start_after = 20_251_015_072_033

# Set timeouts for migrations
# If you use PgBouncer in transaction mode, delete these lines and set timeouts on the database user
StrongMigrations.lock_timeout = 10.seconds
StrongMigrations.statement_timeout = 1.hour

# Analyze tables after indexes are added
# Outdated statistics can sometimes hurt performance
StrongMigrations.auto_analyze = true

# Set the version of the production database
# so the right checks are run in development
StrongMigrations.target_version = 17

# Remove invalid indexes when rerunning migrations
StrongMigrations.remove_invalid_indexes = true
