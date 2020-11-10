# frozen_string_literal: true
require "spec_helper"

RSpec.describe Purkamyern do
  it 'has a version number' do
    expect(Purkamyern::VERSION).not_to be nil
  end
end


describe "Pokedex" do
  describe "#initialize" do
    it "inits new pokedex with a name" do
      new_pokedex = Purkamyern::Pokedex.new("Char")

      pokedex_owner = new_pokedex.instance_variable_get(:@owner)

      expect(pokedex_owner).to eq("Char")
    end
  end
  describe "#factory_reset" do
    it "clears pokedex" do
      new_pokedex = Purkamyern::Pokedex.new("Char")

      new_pokedex.factory_reset

      expect(Purkamyern::Pokedex.all).to !include(new_pokedex)
    end
  end
end

describe "Pokemon" do

end

describe "Api" do

end

describe "Cli" do

end