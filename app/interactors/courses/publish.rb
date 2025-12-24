module Courses
  # Set course status to published if it is valid
  class Publish < ApplicationInteractor
    delegate :course, to: :context

    def call
      context.fail!(message: I18n.t("courses.validation.image.blank")) unless course.image.attached?
      context.fail!(message: I18n.t("courses.validation.description.blank")) if course.description.blank?

      course.update!(published: true)
    end
  end
end
