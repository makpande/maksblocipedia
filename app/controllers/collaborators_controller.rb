class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.build(collaborator_params)

    if @collaborator.save
      flash[:notice] = "#{@collaborator.user.name} was added as a collaborator to this Wiki."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error removing this collaborator from this Wiki."
      render :show
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "\"#{@collaborator.user_id}\" was removed as a collaborator from this Wiki."
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
