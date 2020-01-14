module AresMUSH
  module Tinker
    class TinkerCmd
      include CommandHandler
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !enactor.has_permission?("tinker")
        return nil
      end
      
    def handle
        char = Character.all.select { |c| c.name == cmd.args }.first
            if (char)
                client.emit "You found #{char.name}"
            else
                client.emit "Nothing found."
    end
end

    end
  end
end
