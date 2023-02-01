class CommentsController < ApplicationController
    def comment_params
        params.require(:comment).permit(:post_id, :txt)
    end
    def create
        # @comment = Comment.new(comment_params)
        @post = Post.find(params[:post_id])
        # @comment = @post.comments.build(params[:comment].permit(:txt))
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.save!
   
        # respond_to do |format|
        #   if @comment.save
            # format.html { redirect_to @comment.post, notice: "Comment was successfully created." }
        #   else
        #     format.html { render :new, status: :unprocessable_entity }
        #   end
        # end
        redirect_to @post
    end
end
