module AresMUSH

  class Character < Ohm::Model
    collection :seeds, "AresMUSH::Seed"
    attribute :seed_cat, :type => DataType::Array, :default => []
  end

  class Seed < Ohm::Model
    include ObjectModel

    attribute :name
    attribute :date
    attribute :desc
    reference :character, "AresMUSH::Character"
    index :name
  end

end