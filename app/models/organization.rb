class Organization < ActiveRecord::Base

  has_many :departaments
  has_many :users
  has_many :inputs, through: :users
  has_one :subscription

  def days_left
    TimeDifference.between(trial_end_at, Time.now).in_days.round
  end

  def trial_end_at
    created_at + 30.days
  end

  def to_json(options)
    super(options.merge({methods: [:days_left]}))
  end

  def self.availability(subdomain_to_check)
    #
    organizations = where("subdomain like ?", "#{subdomain_to_check}")

    if organizations.empty?
      {available: true}
    else
      subdomain_to_check = subdomain_to_check.gsub(/\d*$/, '')
      organization_count = where("subdomain like ?", "#{subdomain_to_check}%").count + 1
      {available: false, recommendation: "#{subdomain_to_check}#{organization_count}"}
    end
  end

  def owner
    users.find_by(owner: true)
  end

  def guest_user
    users.find_by(provider: 'username')
  end
end
