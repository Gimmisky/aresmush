module AresMUSH
  module Demographics
    class ApparentAgeCensusTemplate < ErbTemplateRenderer      
      attr_accessor :paginator

      def initialize(paginator)
        @paginator = paginator
        super File.dirname(__FILE__) + "/apparent_age_census_template.erb"
      end      
    end
  end
end
