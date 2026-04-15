module Ui
  # Component for rendering a navigation link
  class NavLinkComponent < ApplicationViewComponent
    option :label, Types::String
    option :href, Types::String

    delegate :current_page?, to: :helpers

    def call
      link_to href, class: classes do
        content_tag(:span, label)
      end
    end

    private

    def classes
      current_page?(href) ? active_classes : inactive_classes
    end

    def active_classes
      "#{base_classes} text-[#191c1f] border-[#191c1f]"
    end

    def inactive_classes
      "#{base_classes} text-[#505a63] border-transparent hover:text-[#191c1f] hover:border-[#c9c9cd]"
    end

    def base_classes
      "text-sm font-medium tracking-wide pb-1 border-b-2 transition-colors"
    end
  end
end
