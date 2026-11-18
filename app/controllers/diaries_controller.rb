class DiariesController < ApplicationController
  before_action :require_login

  def index
    @diaries = current_user.diaries.order(written_on: :desc)
  end

  def show
    @diary = current_user.diaries.find(params[:id])
  end

  def new
    @diary = current_user.diaries.build(written_on: Date.today)
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to @diary, notice: "日記を投稿しました"
    else
      flash.now[:alert] = "日記の投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body, :written_on)
  end
end
