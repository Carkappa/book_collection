class ApplicationController < ActionController::Base
  # Every page requires a signed-in admin; visitors are sent to the login page.
  before_action :authenticate_admin!

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
