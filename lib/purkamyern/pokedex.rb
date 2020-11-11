# frozen_string_literal: true

class Purkamyern::Pokedex
  attr_accessor :pokemon, :owner, :scanner

  def initialize(owner)
    @owner = owner
    @pokemon = SortedSet.new
    @scanner = Purkamyern::Scanner.new
  end

  def scan(identifier)
    poke = Purkamyern::Pokedex.discovered?(identifier)
    poke ||= discover_new_pokemon(identifier)
    return if poke.nil?

    pokemon.add?(poke)
    poke
  end

  def discover_new_pokemon(identifier)
    scanner.get_pokemon(identifier)
  end

  def get_type(identifier)
    poke = seen?(identifier)
    poke ? poke.types : nil
  end

  def find_pokemons_of_type(type)
    pokemon.find_all { |p| p.types.include?(type)} 
  end

  def seen?(identifier)
    return if pokemon.empty?

    pokemon.find { |p| p.send(Purkamyern::Pokedex.name_or_id(identifier)).to_s == identifier.to_s }
  end

  def seen
    @pokemon.size
  end

  def self.discovered?(identifier)
    return if Purkamyern::Pokemon.all.empty?

    Purkamyern::Pokemon.all.find { |p| p.send(name_or_id(identifier)).to_s == identifier.to_s }
  end

  def self.name_or_id(identifier)
    identifier.to_i.positive? ? 'id' : 'name'
  end

end