module AresMUSH    
  module Randomset
    class ArenaCmd
      include CommandHandler

      # Syntax: arena/random <level>=<badguy level>/<condition level>

      attr_accessor :arena_level, :enemy_level, :condition_level

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2_slash_arg3)
        self.arena_level = titlecase_arg(args.arg1)
        self.enemy_level = titlecase_arg(args.arg2)
        self.condition_level = downcase_arg(args.arg3)
      end

      def required_args
        [self.arena_level, self.enemy_level, self.condition_level]
      end

      def check_valid_args
        return t('randomset.arena_error', :level => self.arena_level) if !Randomset.is_valid_arena_level?(self.arena_level)
        return t('randomset.enemy_error', :level => self.enemy_level) if !Randomset.is_valid_enemy_level?(self.enemy_level)
        return t('randomset.condition_error', :level => self.condition_level) if !Randomset.is_valid_condition_level?(self.condition_level)
        return nil
      end
  
      def handle
        # Build lists of arenas, enemies, and conditions from the config yml files.
        # Select only the subset of entries which match the appropriate parameters.
        # Select a single random item from the subset.

        arenas = Global.read_config("randomset", "arenas")
        arena_list = arenas.sort_by { |arena| arena['level']}.select{ |arena| arena['level'].to_s == self.arena_level }
        random_arena = arena_list.sample

        enemies = Global.read_config("randomset", "enemies")
        enemy_list = enemies.sort_by { |enemies| enemies['level']}.select{ |enemies| enemies['level'].to_s == self.enemy_level }
        random_enemy = enemy_list.sample

        conditions = Global.read_config("randomset", "conditions")
        condition_list = conditions.sort_by { |conditions| conditions['level']}.select{ |conditions| conditions['level'].to_s == self.condition_level }
        random_condition = condition_list.sample

        # Construct a hash containing the final result.
        random_final = { "arena" => {"name" => random_arena['name'], "description" => random_arena['description']}, "enemy" => {"name" => random_enemy['name'], "description" => random_enemy['description']}, "condition" => {"name" => random_condition['name'], "description" => random_condition['description']} }

        # Send to template.
	template = ArenaTemplate.new random_final, t('randomset.readout_title')
        client.emit template.render

      end

    end
  end
end