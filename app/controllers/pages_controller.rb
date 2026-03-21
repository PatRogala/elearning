# Custom controller for static pages
class PagesController < ApplicationController
  include HighVoltage::StaticPage

  def show
    authorize(:page)
    super
  end

  def layout_for_page
    "application"
  end
end
