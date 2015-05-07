class MyHashSet
  def initialize
    @store = {}
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store.has_key?(el)
  end

  def delete(el)
    if @store.include?(el)
      @store.delete(el)
      true
    else
      false
    end
  end

  def to_a
    @store.keys
  end

  def union(set2)
    @store.merge(set2)
  end

  def intersect(set2)
    new_hash = {}
    @store.each do |key, value|
      new_hash[key] = value if set2.has_key?(key)
    end

    new_hash
  end

  def minus(set2)
    new_hash = {}
    @store.each do |key, value|
      new_hash[key] = value unless set2.has_key?(key)
    end

    new_hash
  end
end

example = MyHashSet.new
example.insert(3)
p example.delete(3)
example.insert(6)
example.insert(17)
p example.to_a
set2 = {10 => 'a', 17 => true}
p example.union(set2)
p example.intersect(set2)
p example.minus(set2)
