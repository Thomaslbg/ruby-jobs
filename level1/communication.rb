class Communication
    attr_reader :practitioner
    def initialize(color, pages, sent_at, practitioner)
      @color = color
      @pages = pages
      @sent_at = sent_at
      @practitioner = practitioner
    end

    def total
      total = PRICES_INDEX[:base]
      total += PRICES_INDEX[:color] if self.color?
      total += self.additional_pages * PRICES_INDEX[:additional_pages]
      total += PRICES_INDEX[:express] if self.practitioner.express?
      return total.round(2)
    end


    def color?
      @color
    end

    def additional_pages
      @pages - 1
    end

    def express?
      self.practitioner.express?
    end

    def date_format
      @sent_at.split(" ")[0]
    end
end
