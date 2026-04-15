module Ui
  # Flash message in right top corner
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
      when :error then "triangle-alert"
      when :success then "check-circle-2"
      else "info"
      end
    end

    def container_classes
      "w-full max-w-sm pointer-events-auto transition-all duration-300 ease-out opacity-0 translate-y-2"
    end

    def icon_classes
      case scheme
      when :error   then "text-[#c48b8b]"
      when :success then "text-[#8ab095]"
      else               "text-[#8a7b7e]"
      end
    end
  end
end
