# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  private    :boolean          default(FALSE)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wiki < ActiveRecord::Base
  belongs_to :user
<<<<<<< HEAD
  has_many :collaborators, dependent: :destroy
=======
  has_many :collaborators
>>>>>>> collaborator
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }
  default_scope { order('created_at DESC') }

<<<<<<< HEAD
  def collaborators
    Collaborator.where(wiki_id: wiki_id)
  end

  def users
    collaborators.users
=======
  def public?
    !private
>>>>>>> collaborator
  end
end
