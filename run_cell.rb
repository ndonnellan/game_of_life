require './cell.rb'

grid = Grid.new(20, 40) { rand > 0.5 ? 1 : 0 }

# grid.seed([[2,1], [2,2], [2,3], [1,3], [0,2]])

100.times do |t|
  print "\e[2J\e[f"
  puts grid.to_s.gsub("0", " ").gsub("1", "*")
  if !grid.run
    Process.exit(0)
  end
  puts "-"*10
  # puts grid.print_neighbors
  sleep(0.1)
end