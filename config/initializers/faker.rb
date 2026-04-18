# New experimental feature in Faker 3.8.0 to improve performance.
return unless Rails.env.local?

Faker::Config.lazy_loading = true
