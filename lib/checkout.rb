class Checkout
  require 'byebug'
  def initialize(rules)
    @items = []
    @rules = rules
  end

  def total
    t = 0
    @items.each do |i|
      rule = @rules.find {|r| r[:item] == i[:name]}
      if rule[:special_offer].any?
        #divides the amount of items by the amount needed for discount and returns the quotient as amount of discounted batches and the remainder as amount of full priced items
        discounted, full_priced = i[:amount].divmod(rule[:special_offer][:amount])
        t += discounted*rule[:special_offer][:price]
        t += full_priced*rule[:price]
      else
        t += ( i[:amount]*rule[:price] )
      end
    end
    t
  end

  def scan(item)
    if f = @items.find {|i| i[:name] == item}
      f[:amount] += 1
    else
      @items << {name: item, amount: 1}
    end
  end
end
