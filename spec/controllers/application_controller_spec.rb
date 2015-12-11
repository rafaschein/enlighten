require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '.layout_by_resource' do
    before { allow(controller).to receive(:devise_controller?) { devise_controller } }

    context 'when devise controller' do
      let(:devise_controller) { true }

      it 'receives login' do
        expect(controller.send(:layout_by_resource)).to eq('login')
      end
    end

    context 'when not devise controller' do
      let(:devise_controller) { false }

      it 'receives application' do
        expect(controller.send(:layout_by_resource)).to eq('application')
      end
    end
  end

  describe '.pundit_not_authorized' do
    context 'redirect to public 403' do
      it 'receives redirect' do
        expect(controller).to receive(:redirect_to).with('/403')
        controller.send(:pundit_not_authorized)
      end
    end
  end
end
