require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } #let cria a instancia do objeto apenas no momento q for usado.
  #it { expect(user).to respond_to(:email) }

  #validacao usando o shoulda-matchers
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('joao@email').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email and created_at' do
      user.save!
      #este metodo permite alterar o funcionamento do devise que, para nesta chamada o token retornado seja oque foi definido, neste caso: abc123xyzTOKEN
      allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at} - Token: abc123xyzTOKEN")
    end
  end



  #subject { build(:user) } #está criando um objeto user pelo factorygirl, pela configuracao feita , nao precisa colocar a classe FactoryGirl::build(:user)
  #before { @user = FactoryGirl.build(:user) }

  # it { expect(@user).to respond_to(:email) }
  # it { expect(@user).to respond_to(:name) }
  # it { expect(@user).to respond_to(:password) }
  # it { expect(@user).to respond_to(:password_confirmation) }
  # it { expect(@user).to be_valid }

  # it { expect(@user).to respond_to(:email) } @teste com o objeto instanciado do factorygirl
  #it { expect(subject).to respond_to(:email) } #teste instanciando o subject
  #it { is_expected.to respond_to(:email) } #teste utilizando o subject de forma anonima, forma recomendada
  #it { is_expected.to respond_to(:name) }
  #it { expect(subject).to be_valid }
end
