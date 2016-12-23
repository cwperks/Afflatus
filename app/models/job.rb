class Job
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :company
  attr_accessor :categories
  attr_accessor :levels
  attr_accessor :location
end
