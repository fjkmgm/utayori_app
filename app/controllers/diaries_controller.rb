class DiariesController < ApplicationController
  before_action :require_login
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    @diaries = current_user.diaries.order(written_on: :desc)
  end

  def show; end

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

  def edit; end

  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: "日記を更新しました"
    else
      flash.now[:alert] = "日記の更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary.destroy!
    redirect_to diaries_path, notice: "日記を削除しました", status: :see_other
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :body, :written_on)
  end

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end
end
