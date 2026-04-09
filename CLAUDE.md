# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Szkoleo** is an MVP e-learning platform built with Ruby on Rails 8.1. It targets tech education (especially Ruby/Rails) with multi-format content: video, text, quizzes, and programming tasks. The differentiator from competitors like Udemy is rich interactive tools.

## Development Environment

All development runs inside Docker containers managed by `dip`:

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

**First-time setup note**: After `dip provision`, create a MinIO bucket named `default-bucket` at `http://localhost:9001` (credentials: minio/miniodevelopment) for Active Storage to work.

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
- All instructor-facing mutations go through Reform form objects (not raw model params)
- `Teach::CourseForm` handles validation and persistence separately from the model

**Interactors** — `app/interactors/`
- Business logic steps: `result = Courses::Publish.call(course: @course)`
- Include `Interactor` module, use `context` for passing data

**Policies (Pundit)** — `app/policies/`
- Every controller action is authorized: `authorize @course`
- Scopes via `policy_scope(Course)`
- Separate policies: `CoursePolicy` (public), `InstructorCoursePolicy` (teach namespace)

**View Components** — `app/components/`
- UI primitives: `UI::ButtonComponent`, `UI::FlashMessageComponent`, `UI::NavLinkComponent`
- Preview in development: `/lookbook`

### Controller Namespaces

- **Public**: `CoursesController`, `DashboardController`, `PagesController` (HighVoltage static pages)
- **Teach namespace** (`/teach/`): `Teach::CoursesController`, `Teach::LessonsController` — instructor dashboard, uses Reform forms + interactors
- **Admin** (`/avo/`): Avo-based admin panel, requires admin role

### Routing

Routes are locale-scoped: `/:locale/...`. Default locale is Polish (`:pl`). Root path goes to `dashboard#index`. Auth via Devise with a custom registrations controller.

### Models

- `User` — Devise auth, roles via `UserRole` join table (admin/teacher/developer)
- `Course` — belongs to instructor (User), has many lessons, uses MoneyRails for pricing, ActionText for rich description
- `Lesson` — belongs to course, ordered position, rich content via ActionText

### Tech Stack Notes

- **Asset pipeline**: Propshaft (not Sprockets)
- **JS**: Bun bundler, Hotwire (Turbo + Stimulus), no heavy frontend framework
- **CSS**: Tailwind CSS 4.x
- **Rich text**: ActionText + Trix, with `@37signals/Lexxy` editor
- **Feature flags**: Flipper gem
- **Background jobs**: Solid Queue (Rails 8 built-in)

## Design System

**"The Editorial IDE"** — dark mode (Obsidian background), Ruby Red (`#E0115F`) accents.

- Fonts: Space Grotesk (headlines), Inter (body/labels)
- **No 1px borders** — use surface layer transitions instead
- Buttons, inputs, cards use surface-container layering

## Testing Setup

- Framework: RSpec with FactoryBot, Capybara, Shoulda Matchers
- Acceptance tests: Cucumber
- Database strategy: DatabaseCleaner with transactions
- N+1 detection: Prosopite (opt-in per spec)
- Coverage: SimpleCov
- Admin/teacher roles are auto-created in test suite setup (`spec/rails_helper.rb`)
