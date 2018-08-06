class Api::V2::TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :deadline, :done, 
             :user_id, :created_at, :updated_at,
             :short_description, :is_late

  belongs_to :user
  
  def short_description
    object.description[0..40]
  end

  #este metodo pega o objeto que a classe se refere, neste caso a task, assim pode se usar a notacao object para acessar seus atributos.
  #acessa o atributo deadline do objeto que vai serializar, e verifica se a data é maior que a data atual, retornando true ou false
  def is_late
    Time.current > object.deadline if object.deadline.present?
  end
end
