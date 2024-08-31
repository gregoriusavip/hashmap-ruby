# frozen_string_literal: true

# HashMap with separate chaining collision handling
class HashMap
  attr_reader :length

  def initialize
    self.capacity = 16
    self.buckets = Array.new(capacity) { [] }
    self.load_factor = 0.75
    self.length = 0
  end

  def set(key, value)
    increase_bucket?
    index = valid_index(key)
    buckets[index].each { |node| return node[1] = value if node[0].eql?(key) }
    self.length += 1
    buckets[index].push([key, value])
  end

  def get(key)
    buckets[valid_index(key)].each { |node| return node[1] if node[0].eql?(key) }
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
    keys = []
    traverse_buckets { |key, _| keys << key }
    keys
  end

  def values
    values = []
    traverse_buckets { |_, value| values << value }
    values
  end

  def entries
    key_val_pair = []
    traverse_buckets { |key, value| key_val_pair << [key, value] }
    key_val_pair
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def valid_index(key, buckets_length = @buckets.length)
    index = hash(key) % capacity
    raise IndexError if index.negative? || index >= buckets_length

    index
  end

  def traverse_buckets
    buckets.each do |bucket|
      bucket.each { |node| yield(node[0], node[1]) unless node.empty? }
    end
  end

  def resize_helper(buckets, key, value)
    index = valid_index(key, buckets.length)
    buckets[index].each { |node| return node[1] = value if node[0].eql?(key) }
    buckets[index].push([key, value])
  end

  def increase_bucket?
    return unless (capacity * load_factor).ceil <= length

    self.capacity *= 2
    new_buckets = Array.new(capacity) { [] }
    traverse_buckets { |key, value| resize_helper(new_buckets, key, value) }
    self.buckets = new_buckets
  end

  attr_writer :length
  attr_accessor :capacity, :buckets, :load_factor
end
