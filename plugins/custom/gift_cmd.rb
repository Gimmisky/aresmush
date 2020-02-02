module AresMUSH
  module Custom
    class GiftCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.gift, "#{model.name}'s Gift"
          client.emit template.render
        end
      end
    end
  end
end