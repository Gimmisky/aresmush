module AresMUSH
  module Custom
    class SetGiftCmd
      include CommandHandler
      
      attr_accessor :gift

      def parse_args
       self.gift = trim_arg(cmd.args)
      end

      def handle
        enactor.update(gift: self.gift)
        client.emit_success "Your Gift is set!"
      end
    end
  end
end