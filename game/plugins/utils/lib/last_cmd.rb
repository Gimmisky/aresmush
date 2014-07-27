module AresMUSH
  module Utils
    class AutospaceCmd
      include Plugin
      include PluginWithoutSwitches
      include PluginRequiresLogin
      
      attr_accessor :name
      
      def want_command?(client, cmd)
        cmd.root_is?("last")
      end
      
      def crack!
        self.name = trim_input(cmd.args)
      end

      def handle
        ClassTargetFinder.with_a_character(self.name, client) do |target|
          other_client = Global.client_monitor.find_client(target)
          if (!other_client.nil?)
            client.emit_ooc t('last.currently_online', :name => target.name)
          else
            last = OOCTime.local_time_str(client, target.last_on)
            client.emit_ooc t('last.last_online', :name => target.name, :time => last)
          end
        end
      end
    end
  end
end
