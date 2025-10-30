# We use Sidekiq for background job processing
# We do not use ActiveJob::Base because we won't change backend
class ApplicationJob
  include Sidekiq::Job
end
