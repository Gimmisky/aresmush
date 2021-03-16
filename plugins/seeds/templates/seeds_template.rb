module AresMUSH
  module Seeds
    class SeedsTemplate < ErbTemplateRenderer
      
      attr_accessor :char, :paginator
      
      def initialize(char, paginator)
        @char = char
        @paginator = paginator
        super File.dirname(__FILE__) + "/seeds.erb"
      end
 
    end
  end
end