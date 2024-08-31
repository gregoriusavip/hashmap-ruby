# frozen_string_literal: true

# HashMap with separate chaining collision handling
class HashMap
  def initialize
    self.capacity = 16
    self.buckets = Array.new(capacity) { [] }
    self.load_factor = 0.75
    self.length = 0
  end

  def set(key, value)
    buckets[valid_index(key)].each { |node| return node[1] = value if node[0].eql?(key) }
    self.length += 1
    buckets[valid_index(key)].push([key, value])
  end

  def get(key)
    buckets[valid_index(key)].each { |node| return node[2] if node[0].eql?(key) }
    nil
  end

  def has?(key)
    buckets[valid_index(key)].each { |node| return true if node[0].eql?(key) }
    false
  end

  def remove(key)
    bucket_index = valid_index(key)
    buckets[bucket_index].each_with_index do |node, index|
      next unless node[0].eql?(key)

      buckets[bucket_index].delete_at(index)[1]
      self.length -= 1
      return node[1]
    end
    nil
  end

  def clear
    initialize
  end

  def keys
    buckets.each { |bucket| }
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def valid_index(key)
    index = hash(key) % capacity
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  attr_accessor :capacity, :buckets, :load_factor, :length
end
