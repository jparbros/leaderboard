class Input < ActiveRecord::Base

  include InputFilters

  belongs_to :user
  has_one :departament, through: :user
  has_one :organization, through: :user

end
