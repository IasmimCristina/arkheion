# frozen_string_literal: true

class Annotation < ApplicationRecord
  belongs_to :character_sheet

  # ====
  validates :category, presence: true
  validates :content, presence: true

  # =====
  enum category: {
    historico: "historico",
    aliados: "aliados",
    inimigos: "inimigos",
    tesouros: "tesouros",
    objetivos: "objetivos",
    observacoes: "observacoes",
    roleplay: "roleplay"
  }, _prefix: true

  # =====
  scope :by_category, ->(cat) { where(category: cat) }
end
