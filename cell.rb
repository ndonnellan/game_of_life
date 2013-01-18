## Picked up a few good tips from https://github.com/spaghetticode/game-of-life-ruby
##
class Grid
  attr_accessor :cells, :neighbor_map

  def copy_cells
    return Marshal.load(Marshal.dump(@cells))
  end

  def initialize(total_rows, total_cols)
    @total_cols = total_cols
    @total_rows = total_rows
    @cells = Array.new(@total_rows) { Array.new(@total_cols) {0} }
    @neighbor_map = Array.new(@total_rows) { Array.new(@total_cols) {0} }
  end
  
  def seed(living_cells)
    living_cells.each { |pos| @cells[ pos[0] ][ pos[1] ] = 1 }
  end
  
  def random_seed(pct = 0.5)
    (0...@total_rows).each do |r|
      (0...@total_cols).each do |c| 
        @cells[r][c] = (rand > pct) ? 1 : 0
      end
    end
  end

  def to_s
    @cells.inject("") do |s, row|
      row.each do |cell|
        s << cell.to_s
      end
      s << "\n"
    end
  end

  def print_neighbors
    @neighbor_map.inject("") do |s, row|
      row.each do |cell|
        s << cell.to_s
      end
      s << "\n"
    end
  end

  def neighbor_count(row, col)
    neighbors = 0

    # Neighbors are each adjacent cell (including diagonals)
    [[ 1,  1], [ 0,  1], [-1,  1], [ 1,  0],
     [ 1, -1], [ 0, -1], [-1, -1], [-1,  0]].each do |p|

      nrow = p[0] + row
      ncol = p[1] + col

      nrow = 0 unless nrow < @total_rows
      ncol = 0 unless ncol < @total_cols

      val = @cells[nrow][ncol]

      neighbors += val
    end

    return neighbors
  end

  def run
    @has_changed = false
    old_cells = copy_cells

    (0...@total_rows).each do |irows|
      (0...@total_cols).each do |icols|
        neighbors = neighbor_count(irows, icols)
        old_val = @cells[irows][icols]

        if old_val == 0 && neighbors == 3
          new_val = 1 
          @has_changed = true
        elsif old_val == 1 && (neighbors < 2 || neighbors > 3)
          new_val = 0
          @has_changed = true
        else
          new_val = old_val
        end

        old_cells[irows][icols] = new_val

        @neighbor_map[irows][icols] = neighbors

      end
    end

    @cells = old_cells
    return @has_changed
  end

  attr_accessor :has_changed
end

