module AresMUSH
  module Seeds
    class ViewSeedsCmd
      include CommandHandler
      
      # Admin command format: seeds/view <char name>=<seed id>
      # Self command format: seeds/view <seed id>

      attr_accessor :target_name, :seed_id

      def parse_args
        # If argument contains an '=' sign, do the admin version
        if (cmd.args =~ /=/)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.target_name = titlecase_arg(args.arg1)
          self.seed_id = args.arg2
        else
          self.target_name = enactor_name
          self.seed_id = trim_arg(cmd.args)
        end
      end

      def required_args
        [self.target_name, self.seed_id]
      end
      
      def check_can_view
         return nil if self.target_name == enactor_name
         return nil if enactor.is_admin?
         return "You're not allowed to view other peoples' seeds."
      end    

      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          #  Call find_attribute in helper.rb to find if there is such a seed on char.
          attr = Seeds.find_seed(model, self.seed_id)
          
          if (attr)
            template = BorderedDisplayTemplate.new attr.desc, "#{attr.date} - #{attr.name}"
            client.emit template.render
            if (self.target_name == enactor_name)
              Login.mark_notices_read(enactor, :seeds, attr.id)
            end
          else
            client.emit_failure "Seed num #{self.seed_id} was not found."
          end
        end
      end

    end
  end
end