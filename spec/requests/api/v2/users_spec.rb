require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:headers) do
    {
      'Accept' => 'application/vnd.taskmanager.v2',
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => user.auth_token
    }
  end

  before { host! 'api.taskmanager.test' }

  describe 'GET /users/:id' do
    before do
      get "/users/#{user_id}", params: {}, headers: headers
    end

    context 'When the user exists' do
      it 'returns the user' do

        expect(json_body[:id]).to eq(user_id)
      end

      it 'returns status code is 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'When user does not exist' do
      let(:user_id) { 1000 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # describe "POST /users" do
  #    before do
  #      post '/users', params: { user: user_params }.to_json, headers: headers
  #    end
  #
  #    context 'when the request params are valid' do
  #      let(:user_params) { attributes_for(:user) }
  #
  #      it 'returns status code 201' do
  #        expect(response).to have_http_status(201)
  #      end
  #
  #      it 'returns the json data for the created user' do
  #
  #        expect(json_body[:email]).to eq(user_params[:email])
  #      end
  #    end
  #
  #    context 'when the request params are invalid' do
  #      let(:user_params) { attributes_for(:user, email: 'invalid.email@') }
  #
  #      it 'returns status code 422' do
  #        expect(response).to have_http_status(422)
  #      end
  #
  #      it 'returns the json data for the errors' do
  #        user_response = JSON.parse(response.body)
  #        expect(user_response).to have_key(:errors)
  #      end
  #    end
  #  end

  # describe 'PUT /users/:id' do
  #    before do
  #      put "/users/#{user_id}", params: { user: user_params }.to_json, headers: headers
  #    end
  #
  #    context 'when request params are valid' do
  #      let(:user_params) {{ email: 'new_email@taskmanager.com' }}
  #
  #      it 'returns 200 code' do
  #        expect(response).to have_http_status(200)
  #      end
  #
  #      it 'returnd json data for update user' do
  #
  #        expect(json_body[:email]).to eq(user_params[:email])
  #      end
  #    end
  #
  #    context 'when request params are invalid' do
  #      let(:user_params) {{ email: 'invalid@' }}
  #
  #      it 'returns status 422' do
  #        expect(response).to have_http_status(422)
  #      end
  #
  #      it 'returnd json data for errors' do
  #
  #        expect(json_body[:email]).to have_key(:errors)
  #      end
  #    end
  # end

  describe 'DELETE /users/:id' do
    before do
      delete "/users/#{user_id}", params: {}, headers: headers
    end

    it 'returns code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes database' do
      expect( User.find_by(id: user.id) ).to be_nil
    end
  end
end
