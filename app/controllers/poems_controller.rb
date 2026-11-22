class PoemsController < ApplicationController
  skip_before_action :require_login, only: %i[index], raise: false

  def index
    @query = params[:q]
    @poems = Poem.search(@query).includes(:keywords).order(:number)
  end
end
