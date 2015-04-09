class Input < ActiveRecord::Base

  belongs_to :user
  has_one :departament, through: :user
  has_one :organization, through: :user

  def self.by_today
    where(date: Date.today)
  end

  def self.by_week
    where('date >= ? and date <= ?', Date.today.at_beginning_of_week, Date.today.at_end_of_week)
  end

  def self.by_month
    where('date >= ? and date <= ?', Date.today.beginning_of_month, Date.today.end_of_month)
  end

  def self.by_quarter
    where('date >= ? and date <= ?', Date.today.beginning_of_quarter, Date.today.end_of_quarter)
  end

  def self.by_year
    where('date >= ? and date <= ?', Date.today.beginning_of_year, Date.today.end_of_year)
  end

  def self.by_user user_id
    where(user_id: user_id)
  end

  def self.by_departament(departament_id)
    joins(:departament).where(departaments: {id: departament_id})
  end

  def self.group_by_user
    all.group_by {|input| input.user_id}.values.map do |values|
      user = values.first.user
      {realized: values.map(&:value).inject(0, &:+).round(2), username: user.name, picture: user.avatar.url(:medium), target: user.target}
    end
  end

  def self.get_leader
    all.max
  end

end
