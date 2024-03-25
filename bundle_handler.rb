class BundleHandler
  def self.generate_combinations(products)
    product_ids = products.map { |product| product[:product_id] }
    all_combinations(product_ids)
  end

  def self.filter_valid_combinations(combinations)
    valid_combinations = []
    combinations.each do |combination|
      if valid_combination?(combination)
        valid_combinations << combination
      end
    end
    valid_combinations
  end

  private

  def self.all_combinations(products, index = 0, combination = [], result = [])
    result << combination.dup

    (index...products.size).each do |i|
      combination.push(products[i])
      all_combinations(products, i + 1, combination, result)
      combination.pop
    end

    result
  end

  def self.valid_combination?(combination)
    return false unless combination.include?(1)

    if combination.include?(2) && !combination.include?(1)
      return false
    end

    if combination.include?(3) && combination.count(1) < 2
      return false
    end

    combination.include?(4) || !combination.include?(5)
  end
end

# Example products
products = [
  { product_id: 1, price: 10, quantity: 10 },
  { product_id: 2, price: 15, quantity: 5 },
  { product_id: 3, price: 20, quantity: 3 },
  { product_id: 4, price: 25, quantity: 8 },
  { product_id: 5, price: 30, quantity: 6 }
]

# Generate all combinations
combinations = BundleHandler.generate_combinations(products)

# Filter valid combinations
valid_combinations = BundleHandler.filter_valid_combinations(combinations)

puts "Valid Combinations: #{valid_combinations.inspect}"
