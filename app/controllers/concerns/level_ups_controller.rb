# frozen_string_literal: true

class LevelUpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_character_sheet

  def create
    result = ApplyLevelUpInteractor.call(character_sheet: @character_sheet, data: level_up_params.to_h)

    if result.success?
      flash[:notice] = "Level up aplicado com sucesso."
    else
      Rails.logger.warn("[ApplyLevelUpInteractor] #{result.failure.inspect}")
      flash[:alert] = "Não foi possível aplicar level up: #{result.failure}"
    end

    redirect_to character_sheet_path(@character_sheet)
  end

  private

  def set_character_sheet
    @character_sheet = current_user.character_sheets.find(params[:character_sheet_id])
  end

  def level_up_params
    params.require(:level_up).permit(:class, :delta_hp)
  end
end
