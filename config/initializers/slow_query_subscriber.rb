# Catch slow queries in development and test
class SlowQuerySubscriber < ActiveSupport::Subscriber
  SECONDS_THRESHOLD = 0.5

  ActiveSupport::Notifications.subscribe("sql.active_record") do |name, start, finish, _, data|
    duration = finish - start
    Rails.logger.debug { "[#{name}] #{duration} #{data[:sql]}" } if duration > SECONDS_THRESHOLD
  end
end
