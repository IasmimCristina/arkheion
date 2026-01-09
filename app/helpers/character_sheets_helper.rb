module CharacterSheetsHelper
  def class_options_for_select(selected = nil)
    choices = ClassData::CLASS_INFORMATION.keys.map { |k| [k.humanize, k] }
    options_for_select(choices, selected)
  end
end
