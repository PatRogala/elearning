module Ui
  # Component for rendering a navigation link
  class NavLinkComponent < ApplicationViewComponent
    option :label, Types::String
    option :href, Types::String

    delegate :current_page?, to: :helpers

    def call
      link_to href, class: classes do
        content_tag(:span, label) +
          (if current_page?(href)
             content_tag(:span, "",
                         class: "absolute bottom-0 left-0 w-full h-[2px] bg-[#E0115F]")
           end).to_s
      end
    end

    private

    def classes
      current_page?(href) ? active_classes : inactive_classes
    end

    def active_classes
      "relative font-medium py-2 transition-colors text-[#E0115F] text-base"
    end

    def inactive_classes
      "text-[#E5E2E1]/60 hover:text-[#E5E2E1] text-base font-medium transition-colors py-2"
    end
  end
end
