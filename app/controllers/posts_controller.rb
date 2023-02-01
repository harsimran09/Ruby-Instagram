class PostsController < ApplicationController
    def destroy
        @post = current_user.posts.find(params[:id])
        @post.destroy
        redirect_to user_path(current_user)
    end
    def show
        @post = Post.find(params[:id])
        @comment = @post.comments.build
    end
    def create
        Post.create(post_params)
        redirect_to root_path
      end
      private
      def post_params
        params.require(:post).permit(:caption, :image, :user_id)
      end
end
