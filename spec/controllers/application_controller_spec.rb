require 'spec_helper'

describe ApplicationController do
  describe '#authenticate' do
    context "when the user's not signed in" do
      before do
        allow(controller).to receive(:deny_access)
        allow(controller).to receive(:signed_in?) { false }
      end

      it 'denies access to the application' do
        expect(controller).to receive(:deny_access)
        controller.authenticate
      end
    end
  end
end
