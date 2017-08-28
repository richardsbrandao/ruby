### Base Classes ###
class Pizza
	attr_reader :type

	def initialize(type)
		@type = type
	end
end

class PizzaType < Pizza
	def initialize(type)
		super type
	end
end

### Decorator ###
class PizzaPriceOrderManager < SimpleDelegator
	def total_price
		price
	end

	def free_soda?
		return false unless type == 'M'
		price > 27
	end

	def delivery_tax
		return 3 if total_price < 20
		5
	end

	def show
		puts "Total: #{total_price} Promoção de Refrigerante: #{free_soda?} Taxa de Entrega: #{delivery_tax}"
	end
end

### Pizza Types ###
module PizzaPrice
	def price_discovery(price_list)
		return price_list[0] if @type == 'P'
		return price_list[1] if @type == 'M'
		price_list[2] if @type == 'G'
	end
end

class NeapolitanPizza < PizzaType
	include PizzaPrice
	
	def initialize(type)
		super type
	end

	def price
		price_discovery([14, 19, 23])
	end
end

class PeperoniCheese < PizzaType
	include PizzaPrice

	def initialize(type)
		super type
	end

	def price
		price_discovery([12, 17, 21])
	end
end

### Toppics ###
class ExtraCheese < Pizza
	def initialize(pizza)
		@pizza = pizza
		super pizza.type
	end

	def price
		6 + @pizza.price
	end 
end

class AddBacon < Pizza
	def initialize(pizza)
		@pizza = pizza
		super pizza.type
	end

	def price
		4 + @pizza.price
	end 
end

class Border < Pizza
	def initialize(pizza)
		@pizza = pizza
		super pizza.type
	end

	def price
		4.5 + @pizza.price
	end 
end 


### Examples ###
pizza_type = NeapolitanPizza.new('M')
final_order = Border.new(ExtraCheese.new(pizza_type))
pizza_order = PizzaPriceOrderManager.new(final_order)
pizza_order.show

pizza_type = PeperoniCheese.new('P')
final_order = AddBacon.new(pizza_type)
pizza_order = PizzaPriceOrderManager.new(final_order)
pizza_order.show