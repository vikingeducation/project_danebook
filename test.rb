def wiggle(arr)
  return false if arr.length < 3
  arr.sort
  i=0
  (arr.length/2).times do 
    arr[i], arr[i-2] = arr[i-2], arr[i]
    i+=2
  end
  arr
end


arr=[1,2,3,4,5]
print wiggle(arr)
arr=[ 1, 10, 2, 99, 55, 77]
print wiggle(arr)
#arr=[ 1, 10, 2, 99, 55, 77]
