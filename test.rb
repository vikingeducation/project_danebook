def findmaxn(k,arr)
  return false if arr.length < k
  
  (k-1).times do
    arr.delete_at(arr.index(arr.max))
  end
  arr.max
end

def findmaxk(k,arr)
  return false if arr.length < k
  arr.sort
  arr[-k-1]
end


arr=[3,2,1,5,6,4]
k=2
#puts findmaxn(k,arr)
puts findmaxk(k,arr)