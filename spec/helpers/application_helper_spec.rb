require 'spec_helper'

describe ApplicationHelper do
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
