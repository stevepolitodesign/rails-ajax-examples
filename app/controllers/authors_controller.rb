class AuthorsController < ApplicationController

    before_action :set_author, only: [:show, :edit, :update, :destroy]

    def index
        @authors = Author.all
    end

    def show
    end

    def new
        @author = Author.new
    end

    def create
        @author = Author.create(author_params)        
        respond_to do |format|
            if @author.save
                format.html { redirect_to @author, notice: "#{@author.formatted_name} was successfully saved." }
                # NOTE AUTHOR STEP 1: This will run the code in `app/views/comments/create.js.erb`.
                format.js
            else
                format.html { render 'new' }
                # NOTE AUTHOR STEP 1: This will run the code in `app/views/comments/create.js.erb`.
                format.js
            end
        end
    end

    def edit
    end

    def update
        if @author.update(author_params)
            redirect_to author_path(@author), notice: "#{@author.formatted_name} was successfully updated."
        else
            render 'edit'
        end
    end

    def destroy
        @author.destroy
        redirect_to authors_path, notice: "#{@author.formatted_name} was successfully deleted."
    end

    private 

        def set_author
            @author = Author.find(params[:id])
        end

        def author_params
            params.require(:author).permit(:first_name, :last_name)
        end
end