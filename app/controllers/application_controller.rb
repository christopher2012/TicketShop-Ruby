class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  include EventsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Zaloguj się, aby uzyskać dostęp!"
      redirect_to login_url
    end
  end
end
