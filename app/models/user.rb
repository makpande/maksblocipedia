# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         has_many :wikis
         has_many :collaborators
   before_create :set_default_role

   def admin?
     role == 'admin'
   end

   def premium?
     role == 'premium'
   end

   def basic?
     role == 'standard'
   end

   def upgrade_acct
     self.update_attributes(role: 'premium')
     self.wikis.where(private: false).update_all(private: true)
   end

   def downgrade_acct
     self.update_attributes(role: 'standard')
     self.wikis.where(private: true).update_all(private: false)
   end

   def collaborations
    Collaborator.where(user_id: id)
  end

  def wikis
    collaborators.wikis
  end
  
   private
   def set_default_role
     self.role||= 'standard'
   end
end
