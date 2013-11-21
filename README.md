Game of Life
============
Conway's game of life in ruby
-----------------------------
Some initial inspiration taken from [spaghetticode](https://github.com/spaghetticode/game-of-life-ruby)


                                         *  
    * *                                  ** 
       * **                                 
      *  **                               * 
    **                                     *
                 ***                        
                                            
                                            
                                            
                                            
                                            
                                            
                                            
    *                                       
    **                                      
      *                        **          *
      **                       **           
                                          * 
       *                                 *  
       *                                 *  
    ----------------------------------------

Run the game of life for a 20x40 grid for up to 100 cycles

    >> ruby run_cell.rb

Run for N cycles by specifying an integer (i.e. 20)

    >> ruby run_cell.rb 20

Specify your own grid and run without printing, seeding randomly

    grid = Grid.new(99, 201) { rand > 0.5 ? 1 : 0}

    while grid.run
      # Your code
      ...
    end

Seed the grid with living cells at any point by using the `seed` method

    grid.seed([[2,1], [2,2]])

Print the state of the grid using builtin `.to_s` method. Use `gsub` to make it more readable.

    grid = Grid.new(10,20) { rand > 0.5 ? 1 : 0}
    puts grid

    01000100000101111111
    10111011100010000101
    11100111111100100101
    00110011010111110111
    00010111001110010010
    01101001110001011000
    01100000111001101101
    11111010100011000001
    00111000001010111000
    10000010111000011101

    puts grid.to_s.gsub("0", " ").gsub("1", "+")

     +   +     + +++++++
    + +++ +++   +    + +
    +++  +++++++  +  + +
      ++  ++ + +++++ +++
       + +++  +++  +  + 
     ++ +  +++   + ++   
     ++     +++  ++ ++ +
    +++++ + +   ++     +
      +++     + + +++   
    +     + +++    +++ +

