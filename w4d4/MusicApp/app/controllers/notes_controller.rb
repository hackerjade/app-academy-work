class NotesController < ApplicationController
  before_action :ensure_is_author only: [:destroy]

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      flash[:success] = ["Note successfully saved"]
      redirect_to track_url(params["track_id"])
    else
      flash[:errors] = @note.errors.full_messages
      redirect_to track_url(params["track_id"])
    end
  end

  def index
    @notes = Note.all
    render :index
  end

  def new
    @note = Note.new
    render :new
  end

  def destroy
    Note.delete(params["id"])
    redirect_to track_url(params["track_id"])
  end

  private
  def note_params
    params.require(:note).permit(:text)
  end

  def ensure_is_author
    if current_user.id == self.id
      render status: 403 text: "tisk tisk"
  end
end
