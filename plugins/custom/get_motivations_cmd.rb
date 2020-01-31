module AresMUSH
  module Custom
    class SetMotivationsCmd
      include CommandHandler
      
      attr_accessor :motivations

      def parse_args
       self.motivations = trim_arg(cmd.args)
      end

      def handle
        enactor.update(motivations: self.motivations)
        client.emit_success "Motivations set!"
      end
    end
  end
end