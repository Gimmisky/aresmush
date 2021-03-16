module AresMUSH
  module Seeds
    class AddCategoryCmd
      include CommandHandler
      
      # Command format: seeds/addcat <name>=<seed category>

      attr_accessor :target_name, :seed_category

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)
        self.target_name = titlecase_arg(args.arg1)
        self.seed_category = args.arg2
      end

      def required_args
        [self.target_name, self.seed_category]
      end

      def check_can_set
         return nil if enactor.is_admin?
         return "You cannot use this command."
      end    

      def handle
        ClassTargetFinder.with_a_character(self.target_name, client, enactor) do |model|
          if (model.seed_cat == nil)
            categories = ["#{self.seed_category}"]
          else
            categories = model.seed_cat
            categories.push("#{self.seed_category}")
          end
          model.update(seed_cat: categories)
          client.emit_success "Seed category #{self.seed_category} added on #{self.target_name}."
          client.emit_success "#{self.target_name}'s categories are now #{model.seed_cat}."
        end
      end

    end
  end
end