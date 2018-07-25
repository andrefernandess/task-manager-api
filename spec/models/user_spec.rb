require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) } #let cria a instancia do objeto apenas no momento q for usado.
  #it { expect(user).to respond_to(:email) }

  #validacao usando o shoulda-matchers
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('joao@email').for(:email) }



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
