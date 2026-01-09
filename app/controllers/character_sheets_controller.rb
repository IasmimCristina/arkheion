class CharacterSheetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @character_sheets = current_user.character_sheets.order(:created_at)
  end

  def show
    @character_sheet = current_user.character_sheets.find(params[:id])
  end
end
