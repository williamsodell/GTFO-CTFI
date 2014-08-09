class CountdownsController < ApplicationController
  before_filter :user_required, only: [:new, :create]

  def index
    
  end

  def show
    @countdown = Countdown.where(name: params[:id]).first
    respond_to do |format|
      if @countdown
        format.html
        format.json do
          render json: @countdown
        end
      else
        format.html { render 'claim' }
        format.json do
          render json: {username: params[:id], date: nil}, :status => 404
        end
      end
    end
  end

  def new
    @countdown = Countdown.new(twitter_id: session[:username])
  end
  
  def create
    countdown_params = params.require(:countdown).permit(:name, :image, :title, :hashtag, :start_date, :end_date, :start_description, :end_description)
    @countdown = Countdown.new(countdown_params)
    @countdown.twitter_id = session[:username]
    @countdown.save!
    redirect_to countdown_path(@countdown.name)
  end
end
