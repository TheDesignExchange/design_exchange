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

class User < ActiveRecord::Base
  validates :login, :name, :password, :password_confirmation,
            :crypted_password, :password_salt, :persistence_token, presence: true
  validates :login, :name, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}
  validates :login, uniqueness: { message: "A user already exists with this login."}, on: :create
  validates :password, confirmation: true,
            length: { minimum: 8, maximum: 255, 
            too_short: "Password must have at least %{count} characters.",
            too_long:  "Pasword cannot have over %{count} characters." }

  attr_accessible :login, :name, :password, :password_confirmation
  acts_as_authentic
end
