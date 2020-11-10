# frozen_string_literal: true
require 'net/http'
require 'rest-client'
require 'json'

class Purkamyern::Scanner
  attr_reader :url

  def initialize
    @url = 'https://pokeapi.co/api/v2/'
  end

  def get_pokemon(id)
    url_lookup = "#{url}pokemon/#{id}/"
    if valid_endpoint?(url_lookup)
      poke_info = RestClient.get(url_lookup)
      base_info = JSON.parse(poke_info)
      Purkamyern::Pokemon.new(base_info)
    end
  end

  def valid_endpoint?(url_lookup)
    url = URI.parse(url_lookup)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true if url.scheme == 'https'
    res = req.request_head(url.path)
    res.code[0] != '4'
  end
end