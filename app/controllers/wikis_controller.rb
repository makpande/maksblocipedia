class WikisController < ApplicationController

  def index
    @wikis = Wiki.all
  end

  def new
    @wikis = Wiki.new
  end

  def create
    @wikis = Wiki.new(params.require(:wiki).permit(:title, :body))
    if @wikis.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wikis
    else
      flash[:error] = "There was an error saving the post.  Please try again."
      render :new
    end
  end

  def show
    @wikis = Wiki.find(params[:id])
  end

  def edit
    @wikis = Wiki.find(params[:id])
  end

  def update
    @wikis = Wiki.find(params[:id])

    if @wikis.update_attributes(params.require(:wiki).permit(:title, :body))
      flash[:notice] = "Wiki was updated."
      redirect_to @wikis
    else
      flash[:error] = "There was an error saving the Wiki.  Please try again."
      render :edit
    end
  end

  def destroy
    @wikis = Wiki.find(params[:id])

    if @wikis.destroy
      flash[:notice] = "The \"#{@wikis.title}\" Wiki was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

end
