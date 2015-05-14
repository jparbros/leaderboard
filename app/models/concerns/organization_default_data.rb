module OrganizationDefaultData
  extend ActiveSupport::Concern

  def create_default_data
    create_teams
    create_users
  end

  def create_teams
    @team_1 = self.departaments.create(name: 'Team 1', period: ['weekly', 'quartly'])
    @team_2 = self.departaments.create(name: 'Team 2', period: ['monthly', 'yearly'])
  end

  def create_users
    create_user({ email: "player1@#{self.subdomain}.com", departament_id: @team_1.id,
      alias: 'Player 1', name: 'Player 1', target: { weekly: 10000, quartly: 120000 }})

    create_user({ email: "player2@#{self.subdomain}.com", departament_id: @team_1.id,
      alias: 'Player 2', name: 'Player 2', target: { weekly: 15000, quartly: 180000 }})

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
end