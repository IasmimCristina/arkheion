# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ==
  has_many :character_sheets, dependent: :destroy

  # ==
  def display_name
    email.split("@").first.humanize
  end
end
