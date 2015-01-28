class Organization < ActiveRecord::Base

  def days_left
    TimeDifference.between(trial_end_at, Time.now).in_days.round
  end

  def trial_end_at
    created_at + 30.days
  end

  def to_json(options)
    super(options.merge({methods: [:days_left]}))
  end
end
