## Picked up a few good tips from https://github.com/spaghetticode/game-of-life-ruby
##
class Grid
  # Cellular Automata: Grid of 'cells' that live or die based on
  # the state of their neighbors

  # Neighbors are each adjacent cell (including diagonals).
  #   Note: I'm using row->col ordering in the code, but presented
  #   the locations of neighbors here in x->y order. Doesn't matter
  #   because neighbors are summed in no order, but fyi.
  ADJACENT = [
    [-1,  1],[ 0,  1],[ 1,  1],
    [-1,  0],         [ 1,  0],
    [-1, -1],[ 0, -1],[ 1, -1], 
  ]

  attr_accessor :cells, :neighbor_map

  def initialize(total_rows, total_cols)
    @total_cols = total_cols
    @total_rows = total_rows

    @cells = Array.new(@total_rows) { Array.new(@total_cols) { block_given? ? yield : 0 } }
    @neighbor_map = Array.new(@total_rows) { Array.new(@total_cols) {0} }
  end

  def run
    reset_change

    # Need to create a copy of cells (alternatively, new blank array)
    # in order to sum a snapshot without overwriting. 
    new_cells = copy_cells

    @total_rows.times do |i|
      @total_cols.times do |j|
        s = sum_of_living_neighbors(i, j)
        old_val = @cells[i][j]

        if old_val == 0 && s == 3
          new_val = 1 
          did_change

        elsif old_val == 1 && (s < 2 || s > 3)
          new_val = 0
          did_change

        else
          new_val = old_val
        end

        new_cells[i][j] = new_val

        @neighbor_map[i][j] = s

      end
    end

    @cells = new_cells
    
    changed?
  end

  def to_s
    Grid.print_array(@cells)
  end
  
  def print_neighbors
    Grid.print_array(@neighbor_map)
  end

  def copy_cells
    return Marshal.load(Marshal.dump(@cells))
  end

  def seed(living_cells)
    # Mark as living all cells in the passed in array
    living_cells.each { |p| @cells[p[0]][p[1]] = 1 }
  end

  def sum_of_living_neighbors(row, col)
    ADJACENT.inject(0) do |neighbors, p|
      r = (p[0] + row) % @total_rows
      c = (p[1] + col) % @total_cols

      neighbors + @cells[r][c]
    end
  end

  def did_change
    @has_changed = true
  end

  def reset_change
    @has_changed = false
  end

  def changed?
    @has_changed
  end

  def self.print_array(array)
    array.inject("") do |s, row|
      s << "#{row.join}\n"
    end
  end
end

