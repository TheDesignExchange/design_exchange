#ruby
f = File.open('methods.csv', 'r');
counter = 1
methods = []
while (line = f.gets)
    methods << line.downcase().gsub("\n", "");
    counter = counter + 1
end
f.close();
p methods