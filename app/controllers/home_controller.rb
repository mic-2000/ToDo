class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index]

  def index
    if current_user
      redirect_to projects_path(format: :html)
    elsif current_user.nil?
      redirect_to new_user_session_path
    end
  end
end
