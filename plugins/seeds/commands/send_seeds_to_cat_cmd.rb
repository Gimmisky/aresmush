module AresMUSH
  module Seeds
    class SendSeedsToCatCmd
      include CommandHandler
      
      # Command format: seeds/sendcat <category>=<seed name>/<seed desc>

      attr_accessor :target_category, :seed_name, :description

      def parse_args
        if (cmd.args =~ /\//)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
          self.target_category = args.arg1
          self.seed_name = args.arg2
          self.description = args.arg3
        end
      end

      def required_args
        [self.target_category, self.seed_name, self.description]
      end

      def check_can_set
         return nil if enactor.is_admin?
         return "You cannot send seeds."
      end    

      def handle
        # Get current date
        date = Time.now.strftime("%Y-%m-%d")

        divider = "+==~~~~~====~~~~====~~~~====~~~~=====~~~~=====~~~~====~~~~====~~~~====~~~~~==+"

	x = 0

        chars = Character.all.select { |c| c.seed_cat&.include? "#{self.target_category}" }
        chars.each do |char|
          if (!char.is_npc? && !char.is_admin? && char.is_approved?)
            v = Seed.create(name: self.seed_name, date: date, desc: self.description, character: char)
            client.emit_success "Seed ##{v.id} (#{self.seed_name}) sent to #{char.name}."
            Login.emit_if_logged_in(char, "%xg%% You received a seed: #{self.seed_name}.%xn%R#{divider}%R#{self.description}%R#{divider}")
            Login.notify(char, :seeds, "New seed ##{v.id}: #{self.seed_name}.", v.id)
	    x += 1
          else
            next
          end
        end

	if (x == 0 )
	  client.emit_failure "No targets found. No seeds sent. Check the category is an exact match, including case sensitivity. (ex 'Psychism' vs 'psychism')."
	else
	  client.emit_success "Seed #{self.seed_name} sent to Category #{self.target_category} (done)."
	end


        #chars = Character.all.select { |c| c.seed_cat =~ /^#{self.target_category}$/i && !c.is_npc? && !c.is_admin? && c.is_approved? }
        #chars.each do |char|
        #  v = Seed.create(name: self.seed_name, date: date, desc: self.description, character: char)
        #  client.emit_success "Seed ##{v.id} (#{self.seed_name}) sent to #{char.name}."
        #  Login.emit_if_logged_in(char, "%xg%% You received a seed: #{self.seed_name}!%xn%R#{divider}%R#{self.description}%R#{divider}")
        #  Login.notify(char, :seeds, "New seed: #{self.seed_name}! Check your seeds.", v.id)
        #end

      end

    end
  end
end