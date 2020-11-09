# frozen_string_literal: true

class Purkamyern::Api
  attr_reader :url

  def initialize
    @url = 'https://pokeapi.co/api/v2/'
  end

  def get_pokemon(id)
    poke_info = RestClient.get("#{url}pokemon/#{id}/")
    base_info = JSON.parse(poke_info)
    Purkamyern::Pokemon.new(base_info)
  end

  # TODO: add in evolution details

end
