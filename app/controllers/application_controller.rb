class ApplicationController < ActionController::Base
  def route_not_found
    render nothing: true, status: :not_found
  end
end
