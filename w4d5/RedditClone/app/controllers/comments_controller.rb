class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = comment_params[:post_id]
    #fail
    @comment.save
    redirect_to post_url(@comment.post)
  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
