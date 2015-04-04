class Organization < ActiveRecord::Base

  has_many :departaments
  has_many :users
  has_many :inputs, through: :users

  def days_left
    TimeDifference.between(trial_end_at, Time.now).in_days.round
  end

  def trial_end_at
    created_at + 30.days
  end

  def to_json(options)
    super(options.merge({methods: [:days_left]}))
  end

  def self.availability(subdomain)
    organizations = where(subdomain: subdomain)
    if organizations.empty?
      {available: true}
    else
      {available: false, recommendation: "#{subdomain}#{organizations.count+1}"}
    end
  end
end
