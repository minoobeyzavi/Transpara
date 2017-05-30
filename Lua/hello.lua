-- comments
--[[
multiline comment
]]

print("Hello Minoo")
num = 70


while num < 77 do
  num = num + 1
  io.write("Miracles\n")
end


function h(x) print(x.key1) end
h{key1 = 'Programming in Lua'}


line = io.read()
if line == "1" then
  print("one")
elseif line =="2" then
  print("two")
else
  print("Seven")
end


for i = 1, 7 do
  print (i)
end


for j = 7, 1, -1 do
  print (j)
end


n = 7
repeat
  print(n)
  n = n - 1
until n == 0


function fib(n)
  if n < 2 then return 1 end
  return fib(n - 2) + fib(n - 1)
end

print (fib(7))


function adder(x)
  return function (y) return x + y ^ 2 end
end

a = adder(1)
b = adder(21)
print (a(7))
print (b(7))


t = {key7 = "seven"}
t.key1 = 7
print(t.key1, "->", t.key7)


function h(x) return print(x.key1) end
h{key1 = "miracles"}

u = {[1] = "one", [2] = "two"}
for key, val in pairs(u) do
  print (key, val)
end


print (u[1] == "one")


l = {'one', 'two', 'seven'}
for i = 1, #l do print (l[i]) end

io.write(type(l), "\n")

longString = [[
I am a very very long
string.]]

io.write(longString, "\n")
