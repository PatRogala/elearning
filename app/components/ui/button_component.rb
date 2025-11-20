module Ui
  # Component for rendering a button
  class ButtonComponent < ApplicationViewComponent
    option :label,  Types::String
    option :href,   Types::String
    option :method, Types::Symbol, default: -> { :get }
    option :mobile, Types::Bool,   default: -> { false }
    option :scheme, Types::Symbol.enum(:primary, :danger), default: -> { :primary }

    def call
      if method == :delete
        button_to label, href, method: method, class: classes
      else
        link_to label, href, class: classes
      end
    end

    private

    def classes
      base = "inline-block font-bold uppercase tracking-[0.15em] border transition-all duration-300 text-center"

      color_classes = case scheme
                      when :danger
                        "border-red-600 text-red-600 hover:bg-red-600 hover:text-white"
                      else
                        "border-neutral-900 text-neutral-900 hover:bg-neutral-900 hover:text-white"
                      end

      size_classes = mobile ? "block w-full text-sm py-3 mt-2" : "text-xs px-6 py-2.5"

      "#{base} #{color_classes} #{size_classes}"
    end
  end
end
