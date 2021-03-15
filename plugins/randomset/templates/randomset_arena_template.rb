module AresMUSH
  class ArenaTemplate < ErbTemplateRenderer
          
    attr_accessor :text, :title, :subfooter, :subtitle
    
    def initialize(text, title = nil, subfooter = nil, subtitle = nil)

      @text = text
      @title = title
      @subtitle = subtitle
      @subfooter = subfooter
      
      super File.dirname(__FILE__) + "/randomset_arena.erb"
    end
  end
end