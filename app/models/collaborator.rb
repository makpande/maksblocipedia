class Collaborator < ActiveRecord::Base

  has_many :user
  belongs_to :wiki

  def self.users
    user_id = User.where(id: pluck(:user_id))
  end

  def self.wikis
    wiki_id = Wiki.where(id: pluck(:wiki_id))
  end

<<<<<<< HEAD
  # def user
  #   User.find(user_id)
  # end
  #
  # def wiki
  #   Wiki.find(wiki_id)
  # end

=======
  def user
    User.find(user_id)
  end

  def wiki
    Wiki.find(wiki_id)
  end
>>>>>>> collaborator
end
