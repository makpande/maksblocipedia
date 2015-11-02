class CollaboratorController < ApplicationController


  def create
    @wiki = Wiki.current_wiki.id
    @user = User.find(params[:id])
    collaborators = @wiki.collaborators.build(user_id: @user)

    if @collaborators.save
      flash[:notice] = "#{@collaborators.user.name} was added as a collaborator to thie Wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing this collaborator from this Wiki."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborators = Collaborator.find(params[:id])

    if @collaborators.destroy
      flash[:notice] = "\"#{@collaborators.user_id}\" was removed as a collaborator from thie Wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing this collaborator from this Wiki."
      render :show
    end
  end

  private
  def collaborator_params
    params.require(:collaborator).permit(:wiki_id, :user_id)
  end
end
