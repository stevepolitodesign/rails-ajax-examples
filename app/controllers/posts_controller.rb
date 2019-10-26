class PostsController < ApplicationController

    before_action :set_post, only: [:show, :edit, :update, :destroy]
    # NOTE AUTHOR This is needed for the new author form to work in `app/views/posts/new.html.erb` and `app/views/posts/edit.html.erb`.
    before_action :new_author, only: [:new, :edit]

    def index
        @posts = Post.all
    end

    def show
        # NOTE COMMENT STEP 2: This is needed in order for `app/views/comments/_form.html.erb` to use `@comment`.
        # NOTE COMMENT STEP 2: Using `@comment = @post.comments.build` did not work. This was becuase `<%= render "comments/form" %>` was being rendered before `<%= render @post.comments %>` in `app/views/posts/show.html.erb`.
        @comment = Comment.new(post: @post)
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

        def new_author
            @author = Author.new
        end

end