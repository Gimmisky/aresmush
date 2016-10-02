module AresMUSH
  module Channels
    class ChannelCreateCmd
      include CommandHandler
      include CommandRequiresLogin
      include CommandRequiresArgs
           
      attr_accessor :name

      def crack!
        self.name = titleize_input(cmd.args)
      end
      
      def required_args
        {
          args: [ self.name ],
          help: 'channels'
        }
      end
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !Channels.can_manage_channels?(enactor)
        return nil
      end
      
      def check_channel_exists
        return t('channels.channel_already_exists', :name => self.name) if Channel.found?(self.name.upcase)
        return nil
      end
      
      def handle
        channel = Channel.create(name: self.name)
        client.emit_success t('channels.channel_created', :alias => channel.default_alias.join(",") )
      end
    end
  end
end
