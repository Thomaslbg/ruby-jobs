# rspec app_spec.rb

require 'rspec'

require_relative './app.rb'

RSpec.describe "Prices calculator", type: :model do
  let(:data)            { JSON.parse(File.read('data.json')) }
  let(:expected_output) { JSON.parse(File.read('test_expected_output.json')) }
  let(:calculator)      { Calculator.new(data) }
  let(:practitioner1)   { Practitioner.new(1, true) }
  let(:practitioner2)   { Practitioner.new(2, false) }
  let(:communication1)  { Communication.new(true, 1, "2019-03-01 10:00:00", practitioner1) }
  let(:communication2)  { Communication.new(false, 4, "2019-03-05 15:00:00", practitioner2) }


  describe Calculator do
    describe '#generate_output' do
      it 'Output corresponds to expected output' do
        expect(JSON.parse(File.read('output.json'))).to eql(expected_output)
      end
    end
    describe '#practitioners' do
      it 'Calculator returns 4 instances of Practionner' do
          expect(calculator.practitioners.count).to eql(4)
      end
    end
    describe '#communications' do
      it 'Calculator returns 14 instances of Communication' do
        expect(calculator.practitioners.count).to eql(4)
      end
    end
  end

  describe Practitioner do
    describe '#express?' do
      it 'returns true if delivery is express' do
          expect(practitioner1.express?).to eql(true)
      end
      it 'returns false if delivery is not express' do
          expect(practitioner2.express?).to eql(false)
      end
    end
  end



  describe Communication do
    describe '#color?' do
      it 'returns true if color mode' do
        expect(communication1.color?).to eql(true)
      end
      it 'returns false if not color mode' do
        expect(communication2.color?).to eql(false)
      end
    end

    describe '#additional_pages' do
      it 'returns 0 on a 1 page communication' do
        expect(communication1.additional_pages).to eql(0)
      end
      it 'returns 3 on a 4 pages communication' do
        expect(communication2.additional_pages).to eql(3)
      end
    end

    describe '#express?' do
      it 'returns true if express mode' do
        expect(communication1.express?).to eql(true)
      end
      it 'returns false if not express mode' do
        expect(communication2.express?).to eql(false)
      end
    end

    describe '#date_format' do
      it 'returns date at the write format (YYYY-MM-DD)' do
        expect(communication1.date_format).to match(/^\d{4}-\d{2}-\d{2}$/)
      end
    end

    describe '#total' do
      it 'returns 0.28 for {"id"=>1, "practitioner_id"=>1, "pages_number"=>1, "color"=>true, "sent_at"=>"2019-03-01 10:00:00"}' do
        expect(communication1.total).to eql(0.88)
      end
      it 'returns 0.91 for {"id"=>12, "practitioner_id"=>2, "pages_number"=>4, "color"=>false, "sent_at"=>"2019-03-05 15:00:00"}' do
        expect(communication2.total).to eql(0.31)
      end
    end
  end
end
