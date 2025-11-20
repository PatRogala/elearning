module Ui
  # Component for rendering a navigation link
  class NavLinkComponent < ApplicationViewComponent
    option :label, Types::String
    option :href, Types::String
    option :mobile, Types::Bool, default: -> { false }

    def call
      link_to label, href, class: classes
    end

    private

    def classes
      base = "font-bold text-neutral-900 uppercase tracking-[0.15em] transition-all duration-300"

      if @mobile
        "#{base} block py-4 text-sm border-b border-neutral-100 hover:bg-neutral-50"
      else
        "#{base} text-xs hover:text-neutral-500 decoration-neutral-900 underline-offset-4 hover:underline"
      end
    end
  end
end
