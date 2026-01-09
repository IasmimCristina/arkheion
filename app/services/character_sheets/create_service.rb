# frozen_string_literal: true

module CharacterSheets
  class CreateService
    def self.call(user:, params:)
      new(user, params).call
    end

    def initialize(user, params)
      @user = user
      @params = params.dup
    end

    def call
      ActiveRecord::Base.transaction do
        sheet = @user.character_sheets.create!(
          name: @params.delete(:name),
          player_name: @params.delete(:player_name),
          info: @params.delete(:info) || {}
        )

        if (attrs = @params.delete(:character_attributes))
          sheet.create_character_attributes!(attrs)
        end

        if (combat = @params.delete(:character_combat))
          sheet.create_character_combat!(combat)
        end


        sheet
      end
    end
  end
end
