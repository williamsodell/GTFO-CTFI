class SessionsController < ApplicationController
  def create
    session[:username] = auth_hash['info']['nickname']
    redirect_to new_countdown_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end