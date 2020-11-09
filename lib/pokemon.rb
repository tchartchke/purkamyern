class Pokemon
  attr_accessor :name, :types, :id

  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key.downcase}=", value) if self.class.method_defined?(key.downcase)
      if key == 'types'
        @types = []
        value.each do |t|
          @types << t['type']['name']
        end
      end
    end
  end
  
end
