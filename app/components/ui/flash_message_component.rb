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
      when :error then "triangle-alert"
      when :success then "check-circle-2"
      else "terminal"
      end
    end

    def container_classes
      base = "w-96 max-w-sm bg-[#1C1B1B] flex items-center gap-3 pr-3 py-3 relative overflow-hidden rounded-sm"
      base += " transition-all duration-300 ease-out opacity-0 translate-y-2"

      shadow_class = case scheme
                     when :error   then "shadow-[0_0_40px_-10px_rgba(228,135,135,0.15)]"
                     when :success then "shadow-[0_0_40px_-10px_rgba(224,17,95,0.15)]"
                     else               "shadow-[0_0_40px_-10px_rgba(91,63,68,0.2)]"
                     end

      "#{base} #{shadow_class}"
    end

    def left_indicator_classes
      base = "absolute left-0 top-0 bottom-0 w-[3px]"

      color_class = case scheme
                    when :error   then "bg-[#E48787]" # Koralowy czerwony
                    when :success then "bg-[#E0115F]" # Rubinowy akcent z Design Systemu
                    else               "bg-[#5B3F44]" # Outline-variant (Muted Mauve)
                    end

      "#{base} #{color_class}"
    end

    def icon_classes
      case scheme
      when :error   then "text-[#E48787]"
      when :success then "text-[#E0115F]"
      else               "text-[#5B3F44]"
      end
    end

    def title_classes
      base = "text-sm font-medium leading-snug"

      color_class = case scheme
                    when :error then "text-[#E48787]"
                    else "text-[#E5E2E1]"
                    end

      "#{base} #{color_class}"
    end
  end
end
