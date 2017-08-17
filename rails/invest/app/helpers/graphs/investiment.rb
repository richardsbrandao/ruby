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
            SavedMoney.cached_all_with_percentages.map do |saved_money| 
                [saved_money.date, saved_money.amount_cents, saved_money.saved_money_percentages] 
            end
        end

        private

        def period(date)
            "#{date.year}-#{date.month}"
        end

        def last_period(date)
            one_month_ago = date - 1.month
            "#{one_month_ago.year}-#{one_month_ago.month}"
        end
    end
end