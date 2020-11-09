# frozen_string_literal: true

class Api
  attr_reader :url

  def initialize
    @url = 'https://pokeapi.co/api/v2/'
  end

  def get_pokemon(id)
    poke_info = RestClient.get("#{url}pokemon/#{id}/")
    habitat = RestClient.get("#{url}pokemon-habitat/#{id}/")
    base_info = JSON.parse(poke_info)
    habitat_info = JSON.parse(habitat)
    Pokemon.new(base_info, habitat_info)
  end
end
