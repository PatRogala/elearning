return if Rails.env.test?

# App defaults for every environment
Role.find_or_create_by!(name: "Admin", id: Role::ADMIN_ID)
Role.find_or_create_by!(name: "Teacher", id: Role::TEACHER_ID)
Role.find_or_create_by!(name: "Developer", id: Role::DEVELOPER_ID)
