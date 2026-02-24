# We need proxy if we want to use local minio server for active storage
Rails.application.config.active_storage.resolve_model_to_route = :rails_storage_proxy
