module Misc
  # Renders animated flash messages in the top-right corner
  class FlashMessagesComponent < ApplicationViewComponent
    option :flash, Types::Hash | Types::Instance(ActionDispatch::Flash::FlashHash)

    private

    def flash_entries
      entries_source = flash.respond_to?(:to_h) ? flash.to_h : flash
      entries_source.each_with_object([]) do |(type, message), entries|
        next if message.blank?

        Array(message).each do |msg|
          entries << { type: normalize_type(type), message: msg }
        end
      end
    end

    def normalize_type(type)
      case type.to_s
      when "notice", "success" then :success
      when "alert", "error" then :error
      when "warning" then :warning
      else :info
      end
    end

    def type_styles(type)
      case type
      when :success
        "bg-green-50 border-green-200 text-green-800"
      when :error
        "bg-red-50 border-red-200 text-red-800"
      when :warning
        "bg-yellow-50 border-yellow-200 text-yellow-900"
      else
        "bg-blue-50 border-blue-200 text-blue-800"
      end
    end

    def type_icon(type)
      case type
      when :success then "check-circle"
      when :error then "circle-alert"
      when :warning then "alert-triangle"
      else "info"
      end
    end
  end
end
