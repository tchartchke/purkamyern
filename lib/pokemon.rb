# frozen_string_literal: true

class Pokemon
  attr_accessor :name, :types, :id

  @@all = Set.new

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
    @types = []
    attributes['types'].each do |t|
      @types << t['type']['name']
    end
    @@all.add(self) if !@@all.find { |entry| entry.name == name}
    self
  end

  def self.all
    @@all
  end
end
