module OrganizationDefaultData
  extend ActiveSupport::Concern

  def create_default_data
    create_teams
    create_users
    create_dummy_data
    create_new_subscription
  end

  def create_teams
    @team_1 = self.departaments.create(name: 'Team 1', period: ['weekly', 'quarterly'])
    @team_2 = self.departaments.create(name: 'Team 2', period: ['monthly', 'yearly'])
  end

  def create_users
    create_user({ email: "player1@#{self.subdomain}.com", departament_id: @team_1.id,
      alias: 'Player 1', name: 'Player 1', target: { weekly: 10000, quarterly: 120000 }})

    create_user({ email: "player2@#{self.subdomain}.com", departament_id: @team_1.id,
      alias: 'Player 2', name: 'Player 2', target: { weekly: 15000, quarterly: 180000 }})

    create_user({ email: "player3@#{self.subdomain}.com", departament_id: @team_2.id,
      alias: 'Player 3', name: 'Player 3', target: { monthly: 100000, yearly: 1200000 }})

    create_user({ email: "player4@#{self.subdomain}.com", departament_id: @team_2.id,
      alias: 'Player 4', name: 'Player 4', target: { monthly: 70000, yearly: 840000 }})
  end

  def create_user(user_params)
    user = self.users.new(user_params)
    user.set_password
    user.provider = "email"
    user.role = "user"
    user.active = true
    User.skip_callback("create", :after, :send_on_create_confirmation_instructions)
    user.save!
  end

  def create_dummy_data
    users.each do |user|
      create_input(user)
    end
  end

  def create_input(user)
     value = rand(1000.0..2000.0).round(2)
     user.inputs.create(
       value: value,
       date: Time.now,
       description: "Input of #{user.email} by #{value} at #{date.to_s(:short)}"
     )
  end

  def create_new_subscription
    subscription = self.build_subscription
    date = Date.today + Organization::DEMO_PERIOD
    subscription.active_until = date
    subscription.save
  end
end