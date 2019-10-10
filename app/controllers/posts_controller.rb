class PostsController < ApplicationController

    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @posts = Post.all
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.create(post_params)
        if @post.save
            redirect_to @post, notice: "#{@post.title} was successfully saved."
        else
            render "new"
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to @post, notice: "#{@post.title} was successfully updated."
        else
            render "edit"
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, notice: "#{@post.title} was successfully deleted."
    end

    private

        def set_post
            @post = Post.find(params[:id])
        end

        def post_params
            params.require(:post).permit(:title, :body, :author_id)
        end

end