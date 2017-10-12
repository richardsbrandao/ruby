module Graphs
    module Investiment
        def heritage
            saved_moneys = SavedMoney.select(:amount_cents, :date).all.order(:date)
            saved_moneys.each_with_object(Hash.new(0)) do |saved_money, reduced| 
                reduced[period(saved_money.date)] = reduced[last_period(saved_money.date)] if reduced[period(saved_money.date)] == 0
                reduced[period(saved_money.date)] += saved_money.amount_cents / 100
            end.map do |period, accumulated| 
                { period: period, accumulated: accumulated } 
            end
        end

        def objectives
            goal_names = Goal.all.map(&:name)
            saved_money_groupped_by_period = SavedMoney.cached_all_with_percentages.group_by { |saved_money| period(saved_money.date) }

            deposit_unit_by_period = {}
            saved_money_groupped_by_period.each  do |period, saved_moneys|
               saved_moneys.each do |saved_money|
                  deposit_unit_by_period[period] = [] if deposit_unit_by_period[period].nil?
                  deposit_unit_by_period[period] = deposit_unit_by_period[period] + convert_saved_money_to_unit(saved_money)
               end
            end

            deposit_unit_by_period_and_goal = {}
            deposit_unit_by_period.each do |period, deposit_unit|
               deposit_unit_by_period_and_goal[period] = deposit_unit.group_by { |unit| unit[:goal_name] }
            end

            result = deposit_unit_by_period_and_goal.map do |period,deposit_unit_by_goal| 
               [period, deposit_unit_by_goal.map do |goal_name,goal_deposits| 
                     [
                        goal_name, 
                        goal_deposits.reduce(0) { |total,deposit| total+deposit[:value] }
                     ]
                     end.to_h
               ]  
            end.to_h

            result = result.map do |period, goal_balance|  
               [period, goal_names.map { |goal| 
                  [goal, result.fetch(last_period_from_string(period), {}).fetch(goal, 0)+goal_balance.fetch(goal, 0)] }.to_h ]
            end.to_h

            goal_names_for_graph = goal_names.map { |goal_name| [['key', goal_name.underscore.gsub(' ', '_')], ['label', goal_name]].to_h }

            result = result.map do |period,goal_balance| 
              
                [
                  ['period', period]
                ].to_h.merge(
                  goal_balance.map { |goal_name, value| [goal_name.underscore.gsub(' ', '_'), value] }.to_h
                )
              
            end

            final = {objectives: result, goals: goal_names_for_graph}
            final
        end



        private

        def convert_saved_money_to_unit(saved_money)
           saved_money.saved_money_percentages.map do |saved_money_percentage|
              {value: saved_money.amount_cents/100, goal_name: saved_money_percentage.goal.name}
           end
        end

        def period(date)
            "#{date.year}-#{date.month}"
        end

        def last_period(date)
            one_month_ago = date - 1.month
            "#{one_month_ago.year}-#{one_month_ago.month}"
        end

        def last_period_from_string(period)
           year, month = period.split('-')
           last_period(Time.local(year, month, 1))
        end

    end
end