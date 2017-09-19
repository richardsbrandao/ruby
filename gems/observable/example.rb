require 'observer'

class Checkout
  def initialize(stock_manager)
    @stock_manager = stock_manager
  end

  def run
    loop do
      product = @stock_manager.sample
      product.buy!
      break if @stock_manager.empty?
      sleep 0.5
    end
  end
end

class StockManager < SimpleDelegator
  def initialize(products)
    super products
    @products = products
  end

  def select!(product_to_remove)
    @products.select! { |product| product.name != product_to_remove.name }
  end
end

class Product 
  include Observable
  attr_reader :name, :quantity

  def initialize(name, quantity)
    @name, @quantity = name, quantity
  end

  def add!(quantity)
    @quantity = @quantity + quantity
  end

  def buy!(quantity = 1)
    @quantity = @quantity - quantity
    if zero?
      changed
      notify_observers(Time.now, self)
    end
  end

  private

  def zero?
    @quantity == 0
  end
end

class EmptyStockObserver
  def initialize(product, stock_manager)
    @product, @stock_manager = product, stock_manager
    @product.add_observer(self)
  end

  def update(now, product)
    puts "#{product.name} is over at #{now}"
    @stock_manager.select!(product)
  end
end

products = [
  Product.new('Livro 1', 5),
  Product.new('Computador', 10),
  Product.new('Geladeia', 6)
]

stock_manager = StockManager.new(products)
checkout = Checkout.new(stock_manager)
products.each { |product| EmptyStockObserver.new(product, stock_manager) }
checkout.run
