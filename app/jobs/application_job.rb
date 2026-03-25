# We use SolidQueue for background job processing
# We do not use ActiveJob::Base because we won't change backend
class ApplicationJob < ActiveJob::Base
end
