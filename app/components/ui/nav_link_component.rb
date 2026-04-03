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
      "#{base_classes} text-[#5a2e35] border-[#e9d5d8]"
    end

    def inactive_classes
      "#{base_classes} text-[#8a7b7e] border-transparent hover:text-[#5a2e35] hover:border-[#f5e6e8]"
    end

    def base_classes
      "uppercase tracking-widest text-[13px] font-medium pb-1 border-b-2 transition-colors"
    end
  end
end
