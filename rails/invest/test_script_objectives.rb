require 'date'

saved_moneys = [
   {
      "id":5,
      "date":"2017-04-10T03:00:00.050Z",
      "investiment_id":2,
      "created_at":"2017-06-10T03:00:00.136Z",
      "updated_at":"2017-06-10T03:00:00.136Z",
      "amount_cents":50000,
      "amount_currency":"BRL",
      "saved_money_percentages":[
         {
            "id":5,
            "value":100,
            "saved_money_id":5,
            "goal":{"name": "Goal 1", "id": 1},
            "created_at":"2017-06-10T03:00:00.136Z",
            "updated_at":"2017-06-10T03:00:00.136Z"
         }
      ]
   },
   {
      "id":2,
      "date":"2017-05-10T03:00:00.048Z",
      "investiment_id":2,
      "created_at":"2017-06-10T03:00:00.118Z",
      "updated_at":"2017-06-10T03:00:00.118Z",
      "amount_cents":200000,
      "amount_currency":"BRL",
      "saved_money_percentages":[
         {
            "id":2,
            "value":100,
            "saved_money_id":2,
            "goal":{"name": "Goal 1", "id": 1},
            "created_at":"2017-06-10T03:00:00.119Z",
            "updated_at":"2017-06-10T03:00:00.119Z"
         }
      ]
   },
   {
      "id":3,
      "date":"2017-05-10T03:00:00.049Z",
      "investiment_id":2,
      "created_at":"2017-06-10T03:00:00.126Z",
      "updated_at":"2017-06-10T03:00:00.126Z",
      "amount_cents":300000,
      "amount_currency":"BRL",
      "saved_money_percentages":[
         {
            "id":3,
            "value":100,
            "saved_money_id":3,
            "goal":{"name": "Goal 2", "id": 2},
            "created_at":"2017-06-10T03:00:00.127Z",
            "updated_at":"2017-06-10T03:00:00.127Z"
         }
      ]
   },
   {
      "id":4,
      "date":"2017-05-10T03:00:00.050Z",
      "investiment_id":2,
      "created_at":"2017-06-10T03:00:00.131Z",
      "updated_at":"2017-06-10T03:00:00.131Z",
      "amount_cents":100000,
      "amount_currency":"BRL",
      "saved_money_percentages":[
         {
            "id":4,
            "value":100,
            "saved_money_id":4,
            "goal":{"name": "Goal 2", "id": 2},
            "created_at":"2017-06-10T03:00:00.132Z",
            "updated_at":"2017-06-10T03:00:00.132Z"
         }
      ]
   },
   {
      "id":1,
      "date":"2017-06-10T03:00:00.000Z",
      "investiment_id":1,
      "created_at":"2017-06-10T03:00:00.108Z",
      "updated_at":"2017-06-10T03:00:00.108Z",
      "amount_cents":100000,
      "amount_currency":"BRL",
      "saved_money_percentages":[
         {
            "id":1,
            "value":100,
            "saved_money_id":1,
            "goal":{"name": "Goal 1", "id": 1},
            "created_at":"2017-06-10T03:00:00.111Z",
            "updated_at":"2017-06-10T03:00:00.111Z"
         }
      ]
   }
]

def period(date)
    "#{date.year}-#{date.month}"
end

def last_period_from_string(period)
   year, month = period.split('-')
   last_period(Time.local(year, month, 1))
end

def last_period(date)
   one_month_ago = date - 1.month
   "#{one_month_ago.year}-#{one_month_ago.month}"
end

def convert_saved_money_to_unit(saved_money)
   saved_money[:saved_money_percentages].map do |saved_money_percentage|
      {value: saved_money[:amount_cents]/100, goal_name: saved_money_percentage[:goal][:name]}
   end
end


saved_moneys_group_by_period = saved_moneys.group_by {|v| period(v[:date].to_time) }
# {"2017-4":[
#    {"id":5,"date":"2017-04-10T03:00:00.050Z","investiment_id":2,"created_at":"2017-06-10T03:00:00.136Z","updated_at":"2017-06-10T03:00:00.136Z","amount_cents":50000,"amount_currency":"BRL","saved_money_percentages":[{"id":5,"value":100,"saved_money_id":5,"goal":{"name": "Goal 1", "id": 1},"created_at":"2017-06-10T03:00:00.136Z","updated_at":"2017-06-10T03:00:00.136Z"}]}
#  ],

#  "2017-5":[
#    {"id":2,"date":"2017-05-10T03:00:00.048Z","investiment_id":2,"created_at":"2017-06-10T03:00:00.118Z","updated_at":"2017-06-10T03:00:00.118Z","amount_cents":200000,"amount_currency":"BRL","saved_money_percentages":[{"id":2,"value":100,"saved_money_id":2,"goal":{"name": "Goal 1", "id": 1},"created_at":"2017-06-10T03:00:00.119Z","updated_at":"2017-06-10T03:00:00.119Z"}]},
#    {"id":3,"date":"2017-05-10T03:00:00.049Z","investiment_id":2,"created_at":"2017-06-10T03:00:00.126Z","updated_at":"2017-06-10T03:00:00.126Z","amount_cents":300000,"amount_currency":"BRL","saved_money_percentages":[{"id":3,"value":100,"saved_money_id":3,"goal":{"name": "Goal 2", "id": 2},"created_at":"2017-06-10T03:00:00.127Z","updated_at":"2017-06-10T03:00:00.127Z"}]},
#    {"id":4,"date":"2017-05-10T03:00:00.050Z","investiment_id":2,"created_at":"2017-06-10T03:00:00.131Z","updated_at":"2017-06-10T03:00:00.131Z","amount_cents":100000,"amount_currency":"BRL","saved_money_percentages":[{"id":4,"value":100,"saved_money_id":4,"goal":{"name": "Goal 2", "id": 2},"created_at":"2017-06-10T03:00:00.132Z","updated_at":"2017-06-10T03:00:00.132Z"}]}
#   ],

#  "2017-6":[
#    {"id":1,"date":"2017-06-10T03:00:00.000Z","investiment_id":1,"created_at":"2017-06-10T03:00:00.108Z","updated_at":"2017-06-10T03:00:00.108Z","amount_cents":100000,"amount_currency":"BRL","saved_money_percentages":[{"id":1,"value":100,"saved_money_id":1,"goal":{"name": "Goal 1", "id": 1},"created_at":"2017-06-10T03:00:00.111Z","updated_at":"2017-06-10T03:00:00.111Z"}]}
#  ]
# }

goals = ['Goal 1', 'Goal 2']
abc = {}

saved_moneys_group_by_period.each  do |period, saved_moneys|
   saved_moneys.each do |saved_money|
      abc[period] = [] if abc[period].nil?
      abc[period] = abc[period] + convert_saved_money_to_unit(saved_money)
   end
end

cde = {}
abc.each do |period, deposit_unit|
   cde[period] = deposit_unit.group_by { |unit| unit[:goal_name] }
end

result = cde.map do |k,v| 
   [k, v.map do |kk,vv| 
         [
            kk, 
            vv.reduce(0) { |sum,deposit| sum+deposit[:value] }
         ]
         end.to_h
   ]  
end.to_h


# {"2017-4"=>{"Goal 1"=>[{:value=>500, :goal_name=>"Goal 1"}]}, 
#  "2017-5"=>{"Goal 1"=>[{:value=>2000, :goal_name=>"Goal 1"}], "Goal 2"=>[{:value=>3000, :goal_name=>"Goal 2"}, {:value=>1000, :goal_name=>"Goal 2"}]}, 
#  "2017-6"=>{"Goal 1"=>[{:value=>1000, :goal_name=>"Goal 1"}]}}

{:objectives=>{"2017-4"=>{"Goal 1"=>500, "Goal 2"=>0}, "2017-5"=>{"Goal 1"=>2500, "Goal 2"=>4000}, "2017-6"=>{"Goal 1"=>3000, "Goal 2"=>4000}}, :goals=>{{:key=>"goal_1"}=>{:label=>"Goal 1"}, {:key=>"goal_2"}=>{:label=>"Goal 2"}}}



result = {"2017-4"=>{"Goal 1"=>500}, "2017-5"=>{"Goal 1"=>2000, "Goal 2"=>4000}, "2017-6"=>{"Goal 1"=>1000}}

final = result.map do |period, goal_balance|  
   [period, goals.map { |goal| 
      [goal, result.fetch(last_period_from_string(period), {}).fetch(goal, 0)+goal_balance.fetch(goal, 0)] }.to_h ]
end.to_h
puts "#{final}"
