module AresMUSH
  module Custom
    class MotivationsCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.motivations, "#{model.name}'s Motivations"
          client.emit template.render
        end
      end
    end
  end
end