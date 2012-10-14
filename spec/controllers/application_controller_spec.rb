require 'spec_helper'

describe ApplicationController do
  describe '#authenticate' do
    context "when the user's not signed in" do
      before do
        controller.stub(deny_access: nil, signed_in?: false)
      end

      it 'denies access to the application' do
        controller.should_receive(:deny_access)
        controller.authenticate
      end
    end
  end
end
