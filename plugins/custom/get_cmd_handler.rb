def self.get_cmd_handler(client, cmd, enactor)
  case cmd.root
  when "motivations"
    case cmd.switch
    when "set"
      return SetMotivationsCmd
    end
  end
  return nil
end