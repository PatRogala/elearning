# CLAUDE.md

File guides Claude Code (claude.ai/code) for this repo.

## Project Overview

**Szkoleo** — MVP e-learning platform, Ruby on Rails 8.1. Target: tech education (Ruby/Rails). Content: video, text, quizzes, programming tasks. Differentiator from Udemy: rich interactive tools.

## Development Environment

All dev runs in Docker via `dip`:

```bash
dip provision          # First-time setup: build images, install gems/packages, prepare DB
dip rails s            # Start server at localhost:3000
dip rails c            # Rails console
dip rails db:migrate   # Run migrations
dip bundle install     # Install gems
dip bun install        # Install JS packages
dip psql               # PostgreSQL console
dip down               # Shutdown all containers
```

**First-time setup note**: After `dip provision`, create MinIO bucket named `default-bucket` at `http://localhost:9001` (credentials: minio/miniodevelopment) for Active Storage to work.

Services: PostgreSQL 17, MinIO (S3-compatible storage), Mailcatcher (dev email at localhost:1080).

## Commands

### Testing
```bash
dip rails test                              # Full test suite (RSpec + Cucumber)
bundle exec rspec spec/models/course_spec.rb         # Run specific file
bundle exec rspec spec/models/course_spec.rb:10      # Run specific line
bundle exec rspec --only-failures                    # Rerun failed tests
```

### Linting & Quality
```bash
bin/rubocop                   # Ruby style (auto-fix with -a flag)
bin/brakeman                  # Security static analysis
bin/bundler-audit             # Gem vulnerability check
bundle exec database_consistency   # DB/model constraint consistency
```

### Full CI Pipeline
```bash
dip rails ci    # Runs: rubocop, bundler-audit, bun audit, brakeman, database_consistency, active_record_doctor, rspec, cucumber, db:seed:replant
```

### Asset Building
```bash
bun bun.config.js             # Build JS → app/assets/builds/application.js
npm run build:css             # Build Tailwind CSS → app/assets/builds/application.css
```

## Architecture

### Key Patterns

**Forms (Reform gem)** — `app/forms/teach/`
- Instructor mutations go through Reform form objects (not raw model params)
- `Teach::CourseForm` handles validation + persistence separate from model

**Interactors** — `app/interactors/`
- Business logic steps: `result = Courses::Publish.call(course: @course)`
- Include `Interactor` module, pass data via `context`

**Policies (Pundit)** — `app/policies/`
- Every controller action authorized: `authorize @course`
- Scopes: `policy_scope(Course)`
- Separate policies: `CoursePolicy` (public), `InstructorCoursePolicy` (teach namespace)

**View Components** — `app/components/`
- UI primitives: `UI::ButtonComponent`, `UI::FlashMessageComponent`, `UI::NavLinkComponent`
- Dev preview: `/lookbook`

### Controller Namespaces

- **Public**: `CoursesController`, `DashboardController`, `PagesController` (HighVoltage static pages)
- **Teach namespace** (`/teach/`): `Teach::CoursesController`, `Teach::LessonsController` — instructor dashboard, Reform + interactors
- **Admin** (`/avo/`): Avo admin panel, requires admin role

### Routing

Routes locale-scoped: `/:locale/...`. Default locale Polish (`:pl`). Root → `dashboard#index`. Auth via Devise + custom registrations controller.

### Models

- `User` — Devise auth, roles via `UserRole` join table (admin/teacher/developer)
- `Course` — belongs to instructor (User), has many lessons, MoneyRails pricing, ActionText rich description
- `Lesson` — belongs to course, ordered position, ActionText rich content

### Tech Stack Notes

- **Asset pipeline**: Propshaft (not Sprockets)
- **JS**: Bun bundler, Hotwire (Turbo + Stimulus), no heavy frontend framework
- **CSS**: Tailwind CSS 4.x
- **Rich text**: ActionText + Trix, `@37signals/Lexxy` editor
- **Feature flags**: Flipper gem
- **Background jobs**: Solid Queue (Rails 8 built-in)

## Design System

For design see @DESIGN.md

## Testing Setup

- Framework: RSpec + FactoryBot, Capybara, Shoulda Matchers
- Acceptance: Cucumber
- DB strategy: DatabaseCleaner with transactions
- N+1 detection: Prosopite (opt-in per spec)
- Coverage: SimpleCov
- Admin/teacher roles auto-created in test setup (`spec/rails_helper.rb`)