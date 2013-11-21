require './cell.rb'

GRID_L = 20
GRID_W = 40

grid = Grid.new(GRID_L, GRID_W) { rand > 0.5 ? 1 : 0 }

# Example for seeding
# grid.seed([[2,1], [2,2], [2,3], [1,3], [0,2]])

MAX_T = 100

t = ARGV[0] ? ARGV[0].to_i : MAX_T

while t > 0
  print "\e[2J\e[f"
  puts grid.to_s.gsub("0", " ").gsub("1", "*")

  if !grid.run
    # Stop if no change from last step.
    # Note: does not detect cycles
    Process.exit(0)
  end

  puts "-"*GRID_W
  
  sleep(0.1)

  t -= 1
end