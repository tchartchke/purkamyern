# frozen_string_literal: true

class Purkamyern::Pokedex
  attr_accessor :pokemon, :owner, :api

  @@all = Set.new

  def initialize(owner)
    @owner = owner
    @pokemon = SortedSet.new
    @api = Purkamyern::Api.new
    @@all.add(self)
  end

  def factory_reset
    @@all.delete(self)
  end

  def scan(identifier)
    poke = Purkamyern::Pokedex.discovered?(identifier)
    ## TODO: verify that identifier is valid, aka path is valid
    poke ||= discover_new_pokemon(identifier)
    pokemon.add?(poke) unless seen?(poke.name)
    poke
  end

  def discover_new_pokemon(identifier)
    api.get_pokemon(identifier)
  end

  def get_pokemon_id_or_name(identifier)
    poke = seen?(identifier)
    poke ? poke.send(Purkamyern::Pokedex.flip(identifier)) : nil
  end

  def get_type(identifier)
    poke = seen?(identifier)
    poke ? poke.types : nil
  end

  def of_type(type)
    pokemon.find_all { |p| p.types.include?(type)}
    
  end

  def seen?(identifier)
    return nil if pokemon.empty?

    pokemon.find { |p| p.send(Purkamyern::Pokedex.name_or_id(identifier)).to_s == identifier.to_s }
  end

  def seen
    @pokemon.size
  end

  def self.discovered?(identifier)
    return nil if Purkamyern::Pokemon.all.empty?

    Purkamyern::Pokemon.all.find { |p| p.send(name_or_id(identifier)).to_s == identifier.to_s }
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
