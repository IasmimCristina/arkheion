# frozen_string_literal: true

module UserScoped
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    validates :user, presence: true


    scope :unscoped_by_user, -> { unscope(where: :user_id) }

    before_validation :set_current_user, on: :create
  end

  private

  def set_current_user
    self.user ||= Current.user if Current.user.present?
  end

  class_methods do
    def create_for_current_user(attributes = {})
      create(attributes.merge(user: Current.user))
    end
  end
end
