module AresMUSH
  module Seeds

    def self.find_seed(model, seed_id)
      # name_downcase = seed_name.downcase
      # Using the 'seeds' collection from seeds_model.rb
      model.seeds.select { |a| a.id == seed_id }.first
    end
  end

end