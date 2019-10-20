class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]
    before_action :set_post, only: [:create, :edit, :update]

    def create
        @comment = @post.comments.create(comment_params)
        # TODO handle errors
        respond_to do |format|
            if  @comment.save
                format.html { redirect_to @post, notice: 'Comment was successfully created.' }
                format.js
            else
                format.html { render action: "new" }
                format.js
            end
        end
    end

    def edit
    end

    def update
        if @comment.update(comment_params)
            redirect_to @comment.post, notice: "Comment updated."
        else
            render 'edit'
        end
    end

    def destroy
        @comment.destroy
        redirect_to @comment.post, notice: "Comment successfully deleted."
    end

    private

        def set_post
            @post = Post.find(params[:post_id])
        end

        def set_comment
            @comment = Comment.find(params[:id])
        end

        def comment_params
            params.require(:comment).permit(:body)
        end
end