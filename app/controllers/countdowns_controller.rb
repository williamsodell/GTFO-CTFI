class CountdownsController < ApplicationController
  before_filter :user_required, only: [:new, :create]

  def index
    
  end

  def show
    @countdown = Countdown.where(name: params[:id], site: @site).first

    if @countdown.nil?
      redirect_to root_url
    else
      respond_to do |format|
        format.html
        format.json do
          render json: @countdown
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
    @countdown.site = @site
    @countdown.save!
    redirect_to countdown_path(@countdown.name)
  end
end
