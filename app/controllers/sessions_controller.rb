class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)

    if user && User.authenticate(params[:session][:email], params[:session][:password])
      flash[:success] ="Bienvenido"
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
