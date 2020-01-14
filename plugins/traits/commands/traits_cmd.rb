module AresMUSH
  module Traits
    class TraitsCmd
      include CommandHandler
                
      attr_accessor :name
            
      def parse_args
        self.name = cmd.args || enactor_name
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          traits = (model.traits || {}).sort.map { |k, v| "#{k} - #{v}"}
          template = BorderedListTemplate.new traits, t('traits.traits_title', :name => model.name)
          client.emit template.render     
        end
      end
    end
  end
end
