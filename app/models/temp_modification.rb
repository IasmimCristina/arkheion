# frozen_string_literal: true

class TempModification < ApplicationRecord
  belongs_to :character_sheet

  validates :data, presence: true


  def delta_hp
    data['delta_hp'].to_i
  end

  def to_h
    data.deep_symbolize_keys
  end
end
