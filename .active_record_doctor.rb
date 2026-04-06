ActiveRecordDoctor.configure do
  global :ignore_tables, [
    # Ignore internal Rails or gems related tables.
    "ar_internal_metadata",
    "schema_migrations",
    "active_storage_blobs",
    "active_storage_attachments",
    "action_text_rich_texts",
    "active_storage_variant_records",
    # SolidQueue lives in a separate queue database, not the main DB.
    "solid_queue_blocked_executions",
    "solid_queue_claimed_executions",
    "solid_queue_failed_executions",
    "solid_queue_jobs",
    "solid_queue_pauses",
    "solid_queue_processes",
    "solid_queue_ready_executions",
    "solid_queue_recurring_executions",
    "solid_queue_recurring_tasks",
    "solid_queue_scheduled_executions",
    "solid_queue_semaphores",
    # SolidCache lives in a separate cache database.
    "solid_cache_entries"
  ]

  global :ignore_models, [
    # Ignore internal Rails or gems related models.
    "ActiveStorage::Blob",
    "ActiveStorage::Attachment",
    "ActiveStorage::VariantRecord",
    "ActiveStorage::Preview",
    "ActionText::EncryptedRichText",
    "ActionText::RichText",
    "ActionMailbox::InboundEmail",
    "SolidCache::Entry",
    "SolidQueue::BlockedExecution",
    "SolidQueue::ClaimedExecution",
    "SolidQueue::FailedExecution",
    "SolidQueue::Job",
    "SolidQueue::Pause",
    "SolidQueue::Process",
    "SolidQueue::ReadyExecution",
    "SolidQueue::RecurringExecution",
    "SolidQueue::RecurringTask",
    "SolidQueue::ScheduledExecution",
    "SolidQueue::Semaphore"
  ]
end
