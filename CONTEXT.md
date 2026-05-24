# Szkoleo

MVP e-learning platform for tech education. Instructors publish courses; Learners enroll and track progress through lessons.

## Language

### People

**User**:
The single identity in the system. Role determines capability — a User is a Learner, Instructor, Admin, or Developer depending on assigned roles.
_Avoid_: Account, member, profile

**Learner**:
A User who enrolls in and progresses through Courses.
_Avoid_: Student, participant, attendee

**Instructor**:
A User who creates and manages Courses. Identified by the `instructor` role.
_Avoid_: Teacher, author, creator

**Admin**:
A User with access to the platform administration panel (Avo). Manages platform content and users.
_Avoid_: Superuser, moderator

**Developer**:
A User with access to technical operations panels (Sidekiq, PgHero). Distinct from Admin — ops-focused, not content-focused.
_Avoid_: Superadmin, sysadmin

### Content

**Course**:
The primary content unit. Created by an Instructor, composed of ordered Lessons. Exists in one of two states: Draft or Published.
_Avoid_: Class, programme, module

**Lesson**:
An ordered unit of content within a Course. Content is always mixed: text-based with optional video. Future content types (quizzes, programming tasks) will be added within the same Lesson structure.
_Avoid_: Chapter, unit, section, lecture

**Draft**:
A Course not yet visible to Learners. The initial state of every Course.
_Avoid_: Unpublished, hidden, private

**Published**:
A Course visible to and enrollable by Learners.
_Avoid_: Active, live, released

**Instructor Panel**:
The area of the application where Instructors create and manage their Courses and Lessons. Accessed via the `/teach/` URL namespace.
_Avoid_: Teach dashboard, instructor dashboard, teacher panel

### Learning

**Enrollment**:
A Learner's registration in a Course. Currently limited to free Courses; paid Enrollment via Purchase is planned.
_Avoid_: Registration, subscription

**Purchase**:
A Learner's payment transaction to gain Enrollment in a paid Course. Not yet implemented.
_Avoid_: Payment, order, transaction, buy

**LessonCompletion**:
A record that a Learner has completed a specific Lesson. The source of truth for Progress.
_Avoid_: Lesson progress, lesson done, check-off

**Progress**:
The ratio of a Learner's LessonCompletions to the total Lessons in a Course (X of Y lessons done). Course-level completion tracking is planned but not yet implemented.
_Avoid_: Course completion, percentage done

## Example dialogue

> **Dev**: "Should we show course completion on the dashboard?"
> **Domain expert**: "We don't have Course Completion yet — just Progress. Show X of Y lessons."

> **Dev**: "Can any user enroll?"
> **Domain expert**: "Only Learners, and only in Published Courses. Enrollment is free-only right now — paid is coming."

> **Dev**: "Who can edit a course?"
> **Domain expert**: "Only the Instructor who created it, plus Admins."

## Flagged ambiguities

**`teacher` vs `instructor`**: The codebase currently uses the role name `teacher` and the association name `instructor_id`. Canonical term is **Instructor**. The `teacher` role string is pending rename to `instructor`.
