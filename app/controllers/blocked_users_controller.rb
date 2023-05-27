class BlockedUsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.blocked?
      #binding.pry
      @user.update(blocked: false)
      redirect_to blocked_users_path, notice: 'Usuário desbloqueado com sucesso.'
    else
      @user.update(blocked: true)
      redirect_to blocked_users_path, notice: 'Usuário bloqueado com sucesso.'
    end
    #binding.pry
  end

  private 
  
  def user_params
    params.require(:user).permit(:blocked)
  end
end