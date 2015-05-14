class TracksController < ApplicationController
  before_action :log_in_filter

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:success] = ["Track successfully saved"]
      redirect_to track_url(@track.id)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @track = Track.new
    render :new
  end

  def edit
    @track = Track.new
    render :edit
  end

  def show
  end

  def update
    @track = Track.find_by(params["id"])
    if @track.update(track_params)
      flash[:success] = ["Track updated successfully"]
      redirect_to track_url(@track.id)
    else
      flash[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  private
  def track_params
    params.require(:track).permit(:name,
      :album_id,
      :track_type,
      :lyrics
    )
  end
end
