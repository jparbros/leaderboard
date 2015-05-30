module InputFilters

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def search(params)
      inputs = self.includes(:user, :departament)
      inputs = inputs.by_user(params[:user_id]) if params[:user_id]
      inputs = inputs.by_today if params[:period] == 'today'
      inputs = inputs.by_week if params[:period] == 'week'
      inputs = inputs.by_month if params[:period] == 'month'
      inputs = inputs.by_quarter if params[:period] == 'quarter'
      inputs = inputs.by_year if params[:period] == 'year'
      inputs = inputs.by_departament(params[:departament_id]) if params[:departament_id]
      inputs = inputs.group_by_user if params[:group_by_user]
      inputs = inputs.paginate(page: params[:page], per_page: 20) if params[:page]
      inputs = inputs.get_ordered(params) if params[:order]
      inputs
    end

    def by_today
      where(date: Date.today)
    end

    def by_week
      where('date >= ? and date <= ?', Date.today.at_beginning_of_week, Date.today.at_end_of_week)
    end

    def by_month
      where('date >= ? and date <= ?', Date.today.beginning_of_month, Date.today.end_of_month)
    end

    def by_quarter
      where('date >= ? and date <= ?', Date.today.beginning_of_quarter, Date.today.end_of_quarter)
    end

    def by_year
      where('date >= ? and date <= ?', Date.today.beginning_of_year, Date.today.end_of_year)
    end

    def by_user user_id
      where(user_id: user_id)
    end

    def by_departament(departament_id)
      joins(:departament).where(departaments: {id: departament_id})
    end

    def group_by_user
      all.group_by {|input| input.user_id}.values.map do |values|
        user = values.first.user
        {realized: values.map(&:value).inject(0, &:+).round(2), username: user.name, picture: user.avatar.url(:medium), target: user.target}
      end
    end

    def get_leader
      all.max
    end

    def get_ordered(params)
      inputs = order_by_name(params[:order_direction]) if params[:order] == 'name'
      inputs = order_by_date(params[:order_direction]) if params[:order] == 'date'
      inputs = order_by_value(params[:order_direction]) if params[:order] == 'value'
      inputs = order_by_team(params[:order_direction]) if params[:order] == 'team'
      inputs
    end

    def order_by_name(direction = 'DESC')
      puts direction
      order("users.name #{direction}")
    end

    def order_by_date(direction = 'DESC')
      order("inputs.date #{direction}")
    end

    def order_by_value(direction = 'DESC')
      order("inputs.value #{direction}")
    end

    def order_by_team(direction = 'DESC')
      order("departaments.name #{direction}")
    end

  end
end