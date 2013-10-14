class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
    
  def new
      @user = User.new
  end
    
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        redirect_to @user, notice: 'User was successfully created.'
      else
        p "error"
        render "new"
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
end
