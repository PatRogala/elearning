module Layout
  # A little spacer with a marquee animation
  class MarqueeSpacerComponent < ApplicationViewComponent
    private

    def items
      t(".items")
    end
  end
end
