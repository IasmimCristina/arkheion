class CharacterSheetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @character_sheets = character_sheets_scope.order(:created_at)
  end

  def show
    @character_sheet = character_sheets_scope.find(params[:id])
  end

  private
  # Better loading - encapsulation
  def character_sheets_scope
    current_user.character_sheets.with_full_data
  end
end
