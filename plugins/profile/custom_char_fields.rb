module AresMUSH
  module Profile
    class CustomCharFields
      
      # Note: Viewer may be nil if someone's looking at the character page without being logged in
      def self.get_fields_for_viewing(char, viewer)
        return { gift: Website.format_markdown_for_html(char.gift), psyche: Website.format_markdown_for_html(char.psyche) }
      end

      def self.get_fields_for_editing(char, viewer)
        return { gift: Website.format_input_for_html(char.gift), psyche: Website.format_input_for_html(char.psyche) }
      end

      def self.save_fields_from_profile_edit(char, char_data)
        char.update(gift: char_data[:custom][:gift], psyche: char_data[:custom][:psyche])
      end
      
      # Return a hash of custom fields formatted for editing in chargen
      # Example: return { goals: Website.format_input_for_html(char.goals) }
      def self.get_fields_for_chargen(char)
        return {}
      end
      
      # Save fields and return an array of any error messages.
      # Note Custom fields will be in chargen_data[:custom]
      # Example: char.update(goals: chargen_data[:custom][:goals])
      def self.save_fields_from_chargen(char, chargen_data)
        return []
      end
      
    end
  end
end