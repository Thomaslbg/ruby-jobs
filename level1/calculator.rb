class Calculator
    attr_reader :practitioners
    attr_reader :communications

    def initialize(file)
      @practitioners = []
      # créer toutes les instances de Practitioner
      file['practitioners'].each do |p|
        @practitioners << Practitioner.new(p['id'], p['express_delivery'])
      end

      @communications = []
      # créer toutes les instances de Communication
      file['communications'].each do |c|
        practitioner = @practitioners.find{ |p| p.id == c['practitioner_id'] }
        @communications << Communication.new(c['color'], c['pages_number'], c['sent_at'], practitioner)
      end
    end


    def generate_output
      totals = []
      @communications.each do |c|
        item = { 'sent_on' => c.date_format, 'total' => c.total}
        totals << item
      end
      output = { 'totals' => totals }
      File.write('output.json', JSON.pretty_generate(output))
    end
end
