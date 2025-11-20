module Ui
  # Component for rendering a flash message
  class FlashMessageComponent < ApplicationViewComponent
    option :type, Types::String | Types::Symbol
    option :message, Types::String

    def render?
      message.present?
    end

    private

    def scheme
      case type.to_s
      when "alert", "error" then :error
      when "notice", "success" then :success
      else :info
      end
    end

    def icon_name
      case scheme
      when :error then "alert-circle"
      when :success then "check-circle-2"
      else "info"
      end
    end

    def container_classes
      base = "w-80 max-w-sm bg-white border border-neutral-900 border-l-4 flex items-start gap-4 px-4 py-4 transition-all duration-300 ease-out opacity-0 translate-y-2 shadow-none"

      color_class = case scheme
                    when :error   then "border-l-red-600"
                    when :success then "border-l-emerald-600"
                    else               "border-l-neutral-900"
                    end

      "#{base} #{color_class}"
    end

    def icon_classes
      case scheme
      when :error   then "text-red-600"
      when :success then "text-emerald-600"
      else               "text-neutral-900"
      end
    end
  end
end
