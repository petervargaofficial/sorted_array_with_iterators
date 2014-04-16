class SortedArray
  attr_accessor :internal_arr

  def initialize(input_arr=[])
    @internal_arr = []
    input_arr.each do |element|
      self.add(element)
    end
  end

  def add(new_ele)
    @internal_arr.insert(first_larger_index(new_ele), new_ele)
  end

  def size
    @internal_arr.size
  end

  def length
    size
  end

  def count
    size
  end
  
  def [](index)
    @internal_arr[index]
  end

  def first_larger_index(target, start_ind=0, end_ind=@internal_arr.size)
    # At the start of the method,
    # we know that if result is the value we want to return
    # (there's no variable called result, it's what we're looking for)
    # start_ind <= result <= end_ind


    if start_ind == end_ind
      # since start_ind == end_ind
      # and start_ind <= result <= end_ind
      # start_ind == result == end_ind
      return start_ind
    else

      mid_ind = (end_ind-start_ind)/2 + start_ind
      # We could also use (start_ind + end_ind)/2
      # Get the halfway element
      mid_ele = @internal_arr[mid_ind]
      # We could also use (start_ind + end_ind)/2

      if mid_ele >= target
        # Since the middle element is > than the target
        # We know the first larger element index is <= mid_ind
        # result <= mid_ind.
        first_larger_index(target, start_ind, mid_ind)
      elsif mid_ele < target
        # Since the middle element is < than the target
        # We know the first larger element index is > mid_ind
        # result > mid_ind
        first_larger_index(target, mid_ind+1, end_ind)
      end
    end
  end

  def first_larger_index_loop(target, start_ind=0, end_ind=@internal_arr.size)
    start_ind = 0
    end_ind = @internal_arr.size

    while start_ind < end_ind
      # At the start of the loop,
      # we know that if result is the value we want to return
      # (there's no variable called result, it's what we're looking for)
      # start_ind <= result <= end_ind

      # Calculate the halfway location
      mid_ind = (end_ind-start_ind)/2 + start_ind
      # We could also use (start_ind + end_ind)/2

      # Get the halfway element
      mid_ele = @internal_arr[mid_ind]

      if mid_ele >= target
        # Since the middle element is >= than the target
        # We know the first larger element index is <= mid_ind
        # result <= mid_ind
        end_ind = mid_ind
      elsif mid_ele < target
        # Since the middle element is < than the target
        # We know the first larger element index is > mid_ind
        # result > mid_ind
        start_ind = mid_ind + 1
      end
    end
    # At this point, we've narrowed down the search space to one element.
    # start_ind == end_ind.
    # So start_ind == result == end_ind

    return start_ind
  end

  def index(target, start_ind=0, end_ind=@internal_arr.length)
     # If start_ind > end_ind, the target can't be in the search space.
    until start_ind >= end_ind
      # Calculate the halfway point

      mid_ind = (end_ind-start_ind)/2 + start_ind
      # We could also use (start_ind + end_ind)/2

      # Get the halfway element
      mid_ele = @internal_arr[mid_ind]
      # Is the target right in the middle?
      if mid_ele == target
        return mid_ind # return it.
      elsif mid_ele > target
        # Since the middle element is > than the target
        # We know the target is in the left half of the search space
        end_ind = mid_ind
      elsif mid_ele < target
        # Since the middle element is < than the target
        # We know the target is in the right half of the search space
        start_ind = mid_ind + 1
      end
    end
    return nil
  end

  def each &block
    # loop over all elements in @internal_arr
    # yield to each element

    # let's keep track of our index
    i = 0
    while i < @internal_arr.size
      yield(@internal_arr[i])
      i += 1
    end

    return @internal_arr
  end

  def each_with_index &block
    # expect block to operate with item and index of given item
    # If no block is given, an enumerator is returned instead. = to be implemented
    # if !(block_given?) 
    i = 0
    @internal_arr.each do |item| 
      yield(item,i)
      i += 1
    end
  end

  def map &block
    array = []
    @internal_arr.each {|x| array.push(yield(x))}
    return array
  end

  def map! &block
    @internal_arr.each_with_index {|item,index| @internal_arr[index] = (yield(item))}
  end

  def find &block
    # http://ruby-doc.org/core-2.1.1/Enumerable.html#method-i-find
    @internal_arr.each do |item| 
      if yield(item)
        return item
      end
    end
    return nil
  end

  def inject(accumulator = 0, &block)
    puts "internal_arr"
    @internal_arr.each do |item|
      accumulator = yield(accumulator, item)
    end
    return accumulator
  end
end