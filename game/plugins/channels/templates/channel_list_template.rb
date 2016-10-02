module AresMUSH
  module Channels
    class ChannelListTemplate < ErbTemplateRenderer
      include TemplateFormatters
      
      attr_accessor :channels
      
      def initialize(channels, enactor)
        @channels = channels
        @enactor = enactor
        super File.dirname(__FILE__) + "/channel_list.erb"        
      end
      
      def channel_name(channel)
        channel.display_name(false)
      end
      
      def channel_roles(channel)
        channel.roles.join(" ")
      end
      
      def channel_announce(channel)
        channel.announce ? " +   " : " -   "
      end
      
      def channel_on_indicator(channel)
        is_on_channel?(channel) ? "(+)" : "(-)"
      end
      
      def is_on_channel?(channel)
        Channels.is_on_channel?(@enactor, channel) 
      end
      
      def channel_aliases(channel)
        Channels.get_channel_option(@enactor, channel, 'alias')
      end      
    end
  end
end