class Input < ActiveRecord::Base

  include InputFilters

  belongs_to :user
  has_one :departament, through: :user
  has_one :organization, through: :user

  after_create :notify_leaderboard

  def value=(new_value)
    self[:value] = new_value.gsub(' ', '').gsub(',', '.').to_f
  end

  private

  def notify_leaderboard
    WebsocketRails["organization-#{user.organization_id}"].trigger(:input_created, {name: user.name, value: value})
  end

end
