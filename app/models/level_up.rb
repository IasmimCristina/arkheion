# frozen_string_literal: true

class LevelUp < ApplicationRecord
  belongs_to :character_sheet

  validates :data, presence: true


  def character_class
    return unless data.is_a?(Hash) && data.present?

    data.with_indifferent_access["class"]
  end

  def to_h
    data.deep_symbolize_keys
  end
end
