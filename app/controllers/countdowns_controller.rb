class CountdownsController < ApplicationController
  before_filter :user_required, only: [:new, :create, :edit, :update, :destory]

  def index
    @countdowns = Countdown.where('start_date < ?', DateTime.now).where('end_date > ?', DateTime.now).where(site: @site).order('end_date DESC').take(10)
  end

  def show
    @countdown = find params[:id]
    return if @countdown.nil?

    respond_to do |format|
      format.html
      format.json do
        render json: @countdown
      end
    end
  end

  def new
    @countdown = Countdown.new(twitter_id: session[:username])
  end
  
  def create
    @countdown = Countdown.new(countdown_params)
    @countdown.twitter_id = session[:username]
    @countdown.site = @site

    if @countdown.save
      redirect_to countdown_path(@countdown.name)
    else
      render 'new'
    end
  end

  def edit
    @countdown = find params[:id]
    return if @countdown.nil?
    redirect_to countdown_path(@countdown.name), alert: "This is not your countdown!" if @countdown.twitter_id != session[:username]
  end

  def update
    @countdown = Countdown.where(id: params[:id], site: @site).first
    return redirect_to root_url, alert: "Countdown does not exist." if @countdown.nil?
    redirect_to countdown_path(@countdown.name), alert: "This is not your countdown!" if @countdown.twitter_id != session[:username]

    if @countdown.update(countdown_params)
      redirect_to countdown_path(@countdown.name)
    else
      render 'edit'
    end
  end

  def destory
    @countdown = find params[:id]
    return if @countdown.nil?
    redirect_to countdown_path(@countdown.name), alert: "This is not your countdown!" if @countdown.twitter_id != session[:username]
    redirect_to countdown_path(@countdown.name), notice: "Currently do not support deleting."
  end

  private
    def countdown_params
      params.require(:countdown).permit(:name, :image, :title, :hashtag, :start_date, :end_date, :start_description, :end_description)
    end

    def find(name)
      countdown = Countdown.where(name: name.downcase, site: @site).first
      redirect_to root_url, alert: "Countdown #{name} does not exist." if countdown.nil?
      return countdown
    end
end
