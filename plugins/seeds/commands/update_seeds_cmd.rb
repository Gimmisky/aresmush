module AresMUSH
  module Seeds
    class UpdateSeedsCmd
      include CommandHandler
      
      # Command format: seeds/update <name>=<seed id>/<seed desc>

      attr_accessor :target_name, :seed_id, :description

      def parse_args
        if (cmd.args =~ /\//)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.target_name = titlecase_arg(args.arg1)
          self.seed_id = args.arg2
          self.description = args.arg3
        end
      end

      def required_args
        [self.target_name, self.seed_id, self.description]
      end

      def check_can_set
         return nil if enactor.is_admin?
         return "You cannot update seeds."
      end    

      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          #  Call find_attribute in helper.rb to find if there is such a seed on char.
          attr = Seeds.find_seed(model, self.seed_id)
                   
          # If so, then update the seed. 
          if (attr)
            attr.update(desc: self.description)
            client.emit_success "Seed #{attr.id}, #{attr.name}, was updated."
            Login.emit_if_logged_in(model, "%xg%% Seed ##{attr.id} (#{attr.name}) was updated.%xn")
            Login.notify(model, :seeds, "Seed ##{attr.id} (#{attr.name}) was updated. Check your seeds.", attr.id)
          else
            client.emit_failure "Seed ##{self.seed_id} not found."
          end
         
        end
      end

    end
  end
end