class Admin::DashboardController < ApplicationController
  before_filter :authenticate

  def show
    @users = User.all
  end

  protected

  def authenticate
    if user = authenticate_with_http_basic { |u, p| validate_password(u, p) }
      @current_user = user
    else
      request_http_basic_authentication
    end
  end

  def validate_password(u, p)
    puts " -- #{u} #{p}=#{AppConfig['admin_password']}?"
    u == 'admin' && p == AppConfig['admin_password']
  end
end
