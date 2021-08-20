class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/prototypes/#{comment.prototype.id}"
  end

  #def create
    #@comments = Comment.create(comment_params)
    #if @comments.save
      #redirect_to prototype_path
    #else
      #@comments = @comments.includes(:user)
      #render :index
    #end
  #end

private
def comment_params
  params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
end
end