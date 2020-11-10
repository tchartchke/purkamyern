# frozen_string_literal: true
require 'pathname'

class Purkamyern::Api
  attr_reader :url

  def initialize
    @url = 'https://pokeapi.co/api/v2/'
  end

  def get_pokemon(id)

    # if !File.file?("/Users/char/Flatiron/projects/purkamyern/test data/pokemon/#{id}")
    #   return nil
    # end

    poke_info = File.read("/Users/char/Flatiron/projects/purkamyern/test data/pokemon/#{id}")
    base_info = JSON.parse(poke_info)
    Purkamyern::Pokemon.new(base_info)
    # poke_info = RestClient.get("#{url}pokemon/#{id}/")
    # base_info = JSON.parse(poke_info)
    # Purkamyern::Pokemon.new(base_info)
  end

  # TODO: add in evolution details

end
