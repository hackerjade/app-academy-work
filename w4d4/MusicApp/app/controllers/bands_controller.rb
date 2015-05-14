class BandsController < ApplicationController
  before_action :log_in_filter

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = ["Band successfully saved"]
      redirect_to band_path(@band.id)
    else
      flash[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def edit
    @band = Band.new
    render :edit
  end

  def show
    render :show
  end

  def update
    @band = Band.new(band_params)
    if @band.save
      flash[:success] = ["Band successfully saved"]
      redirect_to band_path(@band.id)
    else
      flash[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
