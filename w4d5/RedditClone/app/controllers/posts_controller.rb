class PostsController < ApplicationController
  before_action :ensure_author, only: [:edit,:update]

  def new
    @post = Post.includes(:comments).new
    render :new
  end

  def create
    @post = Post.new(post_params)
    params[:post][:sub_ids].each do |sub_id|
      PostSub.create(sub_id: sub_id.to_i, post: @post)
    #  @post.sub_id = sub_id
    end

    if @post.save
      redirect_to sub_url(@post.subs.first)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if @post.update
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id)
  end

  def ensure_author
    @post = Post.find(params[:id])
    if @post.author_id != current_user.id
      redirect_to sub_url(@post.sub)
    end
  end
end
