module AresMUSH
  module Randomset
    
    def self.is_valid_arena_level?(level)
      return false if !level
      names = Global.read_config('randomset', 'arenas').map { |a| a['level'].to_s }
      names.include?(level)
    end
    
    def self.is_valid_enemy_level?(level)
      return false if !level
      names = Global.read_config('randomset', 'enemies').map { |a| a['level'].downcase }
      names.include?(level.downcase)
    end

    def self.is_valid_condition_level?(level)
      return false if !level
      names = Global.read_config('randomset', 'conditions').map { |a| a['level'].downcase }
      names.include?(level.downcase)
    end

  end
end