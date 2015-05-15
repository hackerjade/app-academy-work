class SubsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_author, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def index
    @subs = Sub.all
    render :index
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_author
    @sub = Sub.find(params[:id])
    #fail
    if @sub.moderator_id != current_user.id
      redirect_to subs_url
    end
  end

  def ensure_logged_in
    if !logged_in?
      redirect_to new_session_url
    end
  end
end
