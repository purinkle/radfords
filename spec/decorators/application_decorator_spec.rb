# -- coding: utf-8 --

require 'spec_helper'

describe ApplicationDecorator do
  let(:decorator) { klass.new(double) }
  let(:klass) { ApplicationDecorator }

  describe '#display_as_pounds' do
    subject { decorator.display_as_pounds(value) }

    let(:currency) { double(:currency) }
    let(:h) { double(:h) }
    let(:value) { double(:value) }

    before do
      h.stub(:number_to_currency).with(value, unit: '£') { currency }
      decorator.stub(h: h)
    end

    it 'returns the value as a currency' do
      expect(subject).to eql(currency)
    end
  end
end
