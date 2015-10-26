class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      login(user)
    else
      flash.now[:errors] = ["Username or Password Invalid"]
      render :new
    end

  end

  def destroy
    logout
  end
end
