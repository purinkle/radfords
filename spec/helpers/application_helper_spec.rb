require 'spec_helper'

describe ApplicationHelper do
  describe '#flash_message_class' do
    subject { helper.flash_message_class(type) }

    let(:type) { 'foo' }

    it 'returns "info"' do
      expect(subject).to eql('info')
    end

    context 'when the flash is an alert' do
      let(:type) { :alert }

      it 'returns "error"' do
        expect(subject).to eql('error')
      end
    end

    context 'when the flash is a notice' do
      let(:type) { :notice }

      it 'returns "success"' do
        expect(subject).to eql('success')
      end
    end
  end

  describe '#title' do
    subject { helper.title }

    context "when there's no current title and no title content" do
      before do
        helper.stub(:content_for).with(:title) { nil }
        instance_variable_set(:@title, nil)
      end

      it 'returns "Radfords of Somerford"' do
        expect(subject).to eql('Radfords of Somerford')
      end
    end
  end
end
