module AresMUSH
  module FS3Combat
    class CombatStartCmd
      include CommandHandler
      include CommandRequiresLogin
      
      attr_accessor :type
      
      def crack!
        self.type = cmd.args ? titleize_input(cmd.args) : "Real"
      end
      
      def check_mock
        types = ['Mock', 'Real']
        return nil if !self.type
        return t('fs3combat.invalid_combat_type', :types => types.join(" ")) if !types.include?(self.type)
        return nil
      end
      
      def check_not_already_in_combat
        return t('fs3combat.you_are_already_in_combat') if enactor.is_in_combat?
        return nil
      end
      
      def handle
        is_real = self.type == "Real"
        combat = CombatInstance.create(:organizer => enactor, 
          :is_real => is_real,
          :num => CombatInstance.next_num)
        combat.join(enactor.name, "Observer", enactor)
        combat.save
        
        message = is_real ? "fs3combat.start_real_combat" : "fs3combat.start_mock_combat"
        
        client.emit_ooc t(message, :num => combat.num)
      end
    end
  end
end