class AlbumsController < ApplicationController
  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = ["Album successfully saved"]
      redirect_to album_url(@album.id)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @album = Album.new
    render :new
  end

  def edit
    @album = Album.new
    render :edit
  end

  def show
  end

  def update
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = ["Album updated successfully"]
      redirect_to album_url(@album.id)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def destroy
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
