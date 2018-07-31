require 'rails_helper'

RSpec.describe Authenticable do
  controller(ApplicationController) do
    include Authenticable
  end
  #cria o app_controller resebendo o subject, poderia usar direto o subject, que e uma instancia da propria classe
  let(:app_controller) { subject }

  describe '#current_user' do
		let(:user) { create(:user) }

		before do
			req = double(:headers => { 'Authorization' => user.auth_token})
			allow(app_controller).to receive(:request).and_return(req)
		end

		it 'returns the user from the authorization header' do
			expect(app_controller.current_user).to eq(user)
		end
  end

  # def current_user
	# 	User.find_by(auth_token: request.headers['Authorization'])
  # end
end
