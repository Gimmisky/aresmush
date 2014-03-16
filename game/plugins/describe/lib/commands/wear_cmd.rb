module AresMUSH
  module Describe
    class WearCmd
      include AresMUSH::Plugin
      
      attr_accessor :names
      
      # Validators
      must_be_logged_in
      no_switches
      
      def want_command?(client, cmd)
        cmd.root_is?("wear")
      end
      
      def crack!
        if cmd.args.nil?
          self.names = nil 
          return
        end
        
        self.names = cmd.args.split(',').map { |n| n.normalize }
      end
      
      def validate_outfits_exist
        return t('dispatcher.invalid_syntax', :command => 'wear') if self.names.nil? || self.names.empty?
        self.names.each do |n|
          return t('describe.outfit_does_not_exist', :name => n) if client.char.outfit(n).nil?
        end
        return nil
      end
      
      def handle
        desc = ""
        self.names.each do |n|
          desc << client.char.outfit(n)
        end
        Describe.set_desc(client.char, desc)
        client.emit_success t('describe.outfits_worn')
      end
    end
  end
end
