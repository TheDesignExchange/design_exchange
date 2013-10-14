# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  login             :string(255)      not null
#  crypted_password  :string(255)      not null
#  password_salt     :string(255)      not null
#  persistence_token :string(255)      not null
#  name              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
