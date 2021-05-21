module AresMUSH
  module Seeds
    class SeedsCmd
      include CommandHandler
      
      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end
      
      def check_can_view
         return nil if self.name == enactor_name
         return nil if enactor.is_admin?
         return "You're not allowed to view other peoples' seeds."
      end    
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          seeds = model.seeds.to_a.sort_by { |v| v.date }.reverse
          paginator = Paginator.paginate(seeds, cmd.page, 5)

          if (paginator.out_of_bounds?)
            client.emit_failure paginator.out_of_bounds_msg
          else
            template = SeedsTemplate.new(model, paginator)
            client.emit template.render
          end
        end

#        if (cmd.args)
#          nil
#        else
#          Login.mark_notices_read(enactor, :seeds, nil)
#        end

      end
    end
  end
end