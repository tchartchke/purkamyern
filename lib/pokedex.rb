# frozen_string_literal: true

class Pokedex
  attr_accessor :pokemon, :owner

  @@all = Set.new

  def initialize(owner)
    @owner = owner
    @pokemon = Set.new
    @@all.add(self)
  end

  def scan(identifier)
    poke = Pokedex.discovered?(identifier)
    poke ||= discover_new_pokemon(identifier)
    pokemon.add?(poke) unless seen?(poke.name)
  end

  def discover_new_pokemon(identifier)
    Api.new.get_pokemon(identifier)
  end

  def get_pokemon_id_or_name(identifier)
    poke = seen?(identifier)
    poke ? poke.send(Pokedex.flip(identifier)) : nil
  end

  def get_type(identifier)
    poke = seen?(identifier)
    poke ? poke.types : nil
  end

  def seen?(identifier)
    return nil if pokemon.empty?

    pokemon.find { |p| p.send(Pokedex.name_or_id(identifier)) == identifier }
  end

  def seen
    pokemon.size
  end

  def self.discovered?(identifier)
    return nil if Pokemon.all.empty?

    Pokemon.all.find { |p| p.send(name_or_id(identifier)) == identifier }
  end

  def self.name_or_id(identifier)
    identifier.to_i.positive? ? 'id' : 'name'
  end

  def self.flip(identifier)
    identifier.to_i.positive? ? 'name' : 'id'
  end

  def self.all
    @@all
  end
end
