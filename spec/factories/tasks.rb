FactoryGirl.define do
    factory :task do
        title { Faker::Lorem.sentence }
        description { Faker::Lorem.paragraph }
        deadline { Faker::Date.forward }
        done false
        user#no factory , desta forma a partir do relacionamento ele carrega um model user para relacionar
    end
  end