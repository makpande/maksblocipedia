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

  default_scope { order('created_at DESC') }
end
