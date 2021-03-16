module AresMUSH
  module Seeds
    class RmSeedsCmd
      include CommandHandler
      
      # Command format: seeds/rm <name>=<seed id>

      attr_accessor :target_name, :seed_id

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)
        self.target_name = titlecase_arg(args.arg1)
        self.seed_id = args.arg2
      end

      def required_args
        [self.target_name, self.seed_id]
      end

      def check_can_set
         return nil if enactor.is_admin?
         return "%xr%% You cannot remove seeds.%xn"
      end    

      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          #  Call find_attribute in helper.rb to find if there is such a seed on char.
          attr = Seeds.find_seed(model, self.seed_id)
          
          if (attr)
            attr.delete
            client.emit_success "#{self.target_name}'s Seed #{self.seed_id} removed."
            # Login.emit_if_logged_in(model, "%xg%% Seed: #{self.seed_id} was removed.%xn")
            # Login.notify(model, :seeds, "Removed seed: #{self.seed_id}. Check your seeds.", nil)
          else 
            client.emit_failure "#{self.target_name}'s Seed #{self.seed_id} not found."
          end
        end
      end

    end
  end
end