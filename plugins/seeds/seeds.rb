$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Seeds

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("seeds", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "seeds"
        case cmd.switch
        when "send"
          return SendSeedsCmd
        when "rm"
          return RmSeedsCmd
        when "view"
          return ViewSeedsCmd
        when "update"
          return UpdateSeedsCmd
        when "addcat"
          return AddCategoryCmd
        when "rmcat"
          return RmCategoryCmd
        when "sendcat"
          return SendSeedsToCatCmd
        else
          return SeedsCmd
        end
      end
      nil
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      # Web request is handled in the Profile plugin, since Seeds appear on char profiles.
      nil
    end

  end
end