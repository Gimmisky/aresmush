$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Custom
    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("custom", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "gift"
        case cmd.switch
        when "set"
          return SetGiftCmd
        else
          return GiftCmd
        end
      end
      return nil
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "psyche"
        case cmd.switch
        when "set"
          return SetPsycheCmd
        else
          return PsycheCmd
        end
      end
      return nil
    end
   
  end
end
