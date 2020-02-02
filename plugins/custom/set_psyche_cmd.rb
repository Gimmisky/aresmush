module AresMUSH
  module Custom
    class SetPsycheCmd
      include CommandHandler
      
      attr_accessor :psyche

      def parse_args
       self.psyche = trim_arg(cmd.args)
      end

      def handle
        enactor.update(psyche: self.psyche)
        client.emit_success "Your Psyche is set!"
      end
    end
  end
end