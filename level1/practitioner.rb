class Practitioner
  attr_reader :id
  
    def initialize(id, express)
      @express = express
      @id = id
    end

    def express?
      @express
    end
end
