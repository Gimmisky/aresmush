$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Traits
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("traits", "shortcuts")
    end
 
    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "trait"
        case cmd.switch
        when "set"
          return SetTraitCmd
        when "remove"
          return RemoveTraitCmd
        else
          return TraitsCmd
        end
      end
      
      nil
    end
  end
end
