# frozen_string_literal: true

class Api
  attr_reader :url

  def initialize
    @url = 'https://pokeapi.co/api/v2/'
  end

  def get_pokemon(id)
    response = RestClient.get("#{url}pokemon/#{id}/")
    poke_info = JSON.parse(response)
    Pokemon.new(poke_info)
  end
end
