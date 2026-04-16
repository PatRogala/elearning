module Enrollments
  # Enrolls a user in a free course
  class Create < ApplicationInteractor
    delegate :user, :course, to: :context

    def call
      context.fail!(message: I18n.t("enrollments.validation.not_free")) unless course.price.zero?
      if Enrollment.exists?(user: user, course: course)
        context.fail!(message: I18n.t("enrollments.validation.already_enrolled"))
      end

      context.enrollment = Enrollment.create!(user: user, course: course)
    end
  end
end
