module AresMUSH
  module Seeds
    class SendSeedsCmd
      include CommandHandler
      
      # Command format: seeds/send <name>=<seed name>/<seed desc>

      attr_accessor :target_name, :seed_name, :description

      def parse_args
        if (cmd.args =~ /\//)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.target_name = titlecase_arg(args.arg1)
          self.seed_name = args.arg2
          self.description = args.arg3
        end
      end

      def required_args
        [self.target_name, self.seed_name, self.description]
      end

      def check_can_set
         return nil if enactor.is_admin?
         return "You cannot send seeds."
      end    

      def handle
        # Get current date
        date = Time.now.strftime("%Y-%m-%d")

        divider = "+==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+"

        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          v = Seed.create(name: self.seed_name, date: date, desc: self.description, character: model)
          client.emit_success "Seed ##{v.id} (#{self.seed_name}) sent to #{model.name}."
          Login.emit_if_logged_in(model, "%xg%% You received a seed: #{self.seed_name}.%xn%R#{divider}%R#{self.description}%R#{divider}")
          Login.notify(model, :seeds, "New seed ##{v.id}: #{self.seed_name}.", v.id)
        end
      end

    end
  end
end