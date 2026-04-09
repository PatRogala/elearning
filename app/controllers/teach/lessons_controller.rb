module Teach
  # Controller for managing lessons in instructor dashboard
  class LessonsController < ApplicationController
    before_action :authenticate_user!

    def new
      course = find_course
      lesson = course.lessons.build
      @form = Teach::LessonForm.new(lesson)
      authorize([:instructor, lesson])
    end

    def edit
      course = find_course
      lesson = course.lessons.friendly.find(params[:id])
      @form = Teach::LessonForm.new(lesson)
      authorize([:instructor, lesson])
    end

    def create
      course = find_course
      lesson = course.lessons.build(position: next_position(course))
      @form = Teach::LessonForm.new(lesson)
      authorize([:instructor, lesson])

      if @form.validate(lesson_params)
        @form.save
        redirect_to edit_teach_course_path(course), notice: t("flash.lesson.created")
      else
        flash[:alert] = @form.errors.full_messages.join(", ")
        redirect_to new_teach_course_lesson_path(course)
      end
    end

    def update
      course = find_course
      lesson = course.lessons.friendly.find(params[:id])
      @form = Teach::LessonForm.new(lesson)
      authorize([:instructor, lesson])

      if @form.validate(lesson_params)
        @form.save
        redirect_to edit_teach_course_path(course), notice: t("flash.lesson.updated")
      else
        flash[:alert] = @form.errors.full_messages.join(", ")
        redirect_to edit_teach_course_lesson_path(course, lesson)
      end
    end

    def destroy
      course = find_course
      lesson = course.lessons.friendly.find(params[:id])
      authorize([:instructor, lesson])

      lesson.destroy
      redirect_to edit_teach_course_path(course), notice: t("flash.lesson.destroyed")
    end

    private

    def find_course
      policy_scope([:instructor, Course]).friendly.find(params[:course_id])
    end

    def lesson_params
      params.expect(lesson: %i[title content])
    end

    def next_position(course)
      course.lessons.maximum(:position).to_i + 1
    end
  end
end
