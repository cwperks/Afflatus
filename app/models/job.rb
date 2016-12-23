class Job
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :company
  attr_accessor :category
  attr_accessor :level
  attr_accessor :location
end
