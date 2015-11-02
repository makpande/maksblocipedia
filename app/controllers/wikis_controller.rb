class WikisController < ApplicationController

  def index
    # @wikis = Wiki.visible_to(current_user).all
    @wikis = policy_scope(Wiki)
<<<<<<< HEAD
    @public = Wiki.where("private = ?", false)

  end

  def new
    @wikis = Wiki.new
    @collaborators = Collaborator.new
    authorize @wikis
=======
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
>>>>>>> collaborator
  end

  def create
    @wiki = current_user.wikis.build(wiki_params)
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the post.  Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def edit
<<<<<<< HEAD
    @wikis = Wiki.find(params[:id])

    @collaborators = Collaborator.new
    # @collaborators = @wiki.collaborators
    # @collaborators = @wiki.collaborators.build(user_id: @user)
    @users = User.all.to_a.reject!{|x| @collaborators.user.include?(x) || @wiki.user == x}
    authorize @wikis
=======
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
    @collaborator = Collaborator.new
    @users = User.all.to_a.reject!{|x| @collaborators.users.include?(x) || @wiki.user == x}
    authorize @wiki
>>>>>>> collaborator
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the Wiki.  Please try again."
      render :edit
    end
  end

  def destroy
<<<<<<< HEAD
    @wikis = Wiki.find(params[:id])
    # @wikis.authorize
=======
    @wiki = Wiki.find(params[:id])
    @wiki.authorize
>>>>>>> collaborator

    if @wiki.destroy
      flash[:notice] = "The \"#{@wiki.title}\" Wiki was deleted successfully."
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
