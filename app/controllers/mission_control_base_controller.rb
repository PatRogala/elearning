# We dont want to use pundit in Mission Control
class MissionControlBaseController < ApplicationController
  skip_after_action :verify_authorized
end
