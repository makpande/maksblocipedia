class CollaboratorController < ApplicationController

  def create
    @wiki=Wiki.current_wiki.id
    @user=User.find(params[:id])
    collaborator = @wiki.colaborators.build(user_id: @user)
  end
end
