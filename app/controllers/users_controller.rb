class UsersController < ApplicationController
  before_action :require_login, only: %i[show edit update]
  before_action :set_user, only: %i[show edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      flash.now[:alert] = "ユーザー登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました"
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    # 自分以外のユーザーの編集ページにアクセスしようとした場合はマイページへリダイレクト
    redirect_to user_path(current_user) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end