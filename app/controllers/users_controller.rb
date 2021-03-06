class UsersController < ApplicationController

  before_filter :signed_in_user,  :only => [:index, :edit, :update, :destroy, :show]
  before_filter :correct_user,    :only => [:edit]

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Nuevo usuario"
  end

  def create

    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      flash[:success] = "Bienvenido a SocialBike"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Error"
      @title = "Nuevo usuario"
      render 'new'

    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])

      flash[:success] = "Datos actualizados"
      redirect_to @user
    else
      flash[:alert] ="Error"
      @title = "Edit user"
      render 'edit'
    end

  end

  def index

    @user = User.search_user(params[:search],params[:page])
    #@users = User.paginate(:page => params[:page])
    @title = "Usuarios"
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

  def signed_in_user
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    flash[:danger] = "Acceso restringido"
    redirect_to signin_path
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(@current_user)) unless current_user?(@user)
  end
end
