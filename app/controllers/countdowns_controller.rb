class CountdownsController < ApplicationController
  before_filter :user_required, only: [:new, :create]

  def index
    
  end

  def show
    @countdown = Countdown.where(twitter_id: params[:id]).recent.first
    respond_to do |format|
      if @countdown
        format.html
        format.json do
          render json: {username: @countdown.twitter_id, date: @countdown.date}
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
    @countdown = Countdown.new(date: Date.current)
    @countdown.twitter_id = session[:username]
  end
  
  def create
    countdown = params.require(:countdown).permit(:date)
    @countdown = Countdown.new(countdown_params)
    @countdown.twitter_id = session[:username]
    @countdown.save!
    redirect_to countdown_path(@countdown.twitter_id)
  end
end
