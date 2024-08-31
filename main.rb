# frozen_string_literal: true

require_relative('lib/hashmap')

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('kite', 'pink-ish')
test.set('lion', 'golden')
test.set('moon', 'silver')
p test
p test.get('moon')
p test.length
p test.set('moon', 'moon')
p test.length
p test.get('moon')
p test.length
p test.remove('moon')
p test.length

p test.has?('moon')
p test.set('elysia', 'my-beloved')
p test.has?('elysia')
p test.keys
p test.values
p test.entries
test.clear
p test
