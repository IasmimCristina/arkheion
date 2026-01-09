# frozen_string_literal: true

module CharacterSheets
  class UpdateService
    def self.call(sheet:, params:)
      new(sheet, params).call
    end

    def initialize(sheet, params)
      @sheet = sheet
      @params = params.dup
    end

    def call
      ActiveRecord::Base.transaction do
        @sheet.update!(
          name: @params.delete(:name),
          player_name: @params.delete(:player_name),
          info: @params.delete(:info) || @sheet.info
        )

        if (attrs = @params.delete(:character_attributes))
          if @sheet.character_attributes
            @sheet.character_attributes.update!(attrs)
          else
            @sheet.create_character_attributes!(attrs)
          end
        end

        if (combat = @params.delete(:character_combat))
          if @sheet.character_combat
            @sheet.character_combat.update!(combat)
          else
            @sheet.create_character_combat!(combat)
          end
        end

        @sheet
      end
    end
  end
end
