class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user).all
    authorize @wikis
  end

  def new
    @wikis = Wiki.new
    authorize @wikis
  end

  def create
    @wikis = current_user.wikis.build(wiki_params)
    authorize @wikis
    if @wikis.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wikis
    else
      flash[:error] = "There was an error saving the post.  Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaborators = Collaborator.all
  end

  def edit
    @wikis = Wiki.find(params[:id])
    authorize @wikis
  end

  def update
    @wikis = Wiki.find(params[:id])
    authorize @wikis

    if @wikis.update_attributes(wiki_params)
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

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
