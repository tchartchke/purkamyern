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
    @@all.add(self) unless @@all.find { |entry| entry.name == name }
  end

  def self.all
    @@all
  end

  def self.discovered
    @@all.size
  end

  def self.clear
    @@all.clear
  end
end
