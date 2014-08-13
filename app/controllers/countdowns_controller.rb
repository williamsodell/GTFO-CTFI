class CountdownsController < ApplicationController
  before_filter :user_required, only: [:new, :create]

  def index
    @countdowns = Countdown.where('start_date < ?', DateTime.now).where('end_date > ?', DateTime.now).where(site: @site).order('end_date DESC').take(10)
  end

  def show
    @countdown = Countdown.where(name: params[:id], site: @site).first

    if @countdown.nil?
      redirect_to root_url, alert: "Countdown #{params[:id]} does not exist."
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
