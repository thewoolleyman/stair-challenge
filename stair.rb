class Stair
  def run(n:, print: false)
    solutions = []
    solve(stair_steps: [], blocks_left: n, solutions: solutions, print: print)
    puts "SOLUTIONS:" if print
    p solutions if print
    solutions
  end

  def solve(stair_steps:, blocks_left:, solutions:, print:)
    puts "Recursion depth: #{stair_steps.size}" if print
    if blocks_left == 1
      puts "ONLY 1 BLOCKS LEFT, BREAKING" if print
      
      # last 2 steps can't both be 1 high
      return if stair_steps.last == 1
      
      stair_steps << blocks_left
      p stair_steps if print
      solutions << stair_steps
      return
    end

    1.upto(blocks_left) do |blocks_left_for_next_recursion|
      current_step_size = blocks_left - blocks_left_for_next_recursion

      if print
      p '--------------------'
      p "stair_steps: #{stair_steps}"
      p "blocks_left: #{blocks_left}"
      p "blocks_left_for_next_recursion: #{blocks_left_for_next_recursion}"
      p "current_step_size: #{current_step_size}"
      p '--------------------'
      end

      # skip if the current step size is greater than the previous step size
      if stair_steps.last && current_step_size >= stair_steps.last
        puts "SKIPPING STEP BECAUSE IT WOULDN'T BE SMALLER" if print
        next
      end
      
      stair_steps << current_step_size
      puts "RECURSING" if print
      # recurse
      solve(
        stair_steps: stair_steps.dup, 
        blocks_left: blocks_left_for_next_recursion.dup, 
        solutions: solutions,
        print: print)
    end
  end
end

class StairTest
  def test_all
    # @print = false
    @print = true

    # test_stair(3, 1)
    # test_stair(4, 1)
    # test_stair(5, 2)
    # test_stair(6, 3)
    # test_stair(7, 4)
    # test_stair(8, 5)
    # test_stair(9, 7)
    test_stair(10, 9)
    test_stair(20, 63)
    test_stair(50, 3657)
    test_stair(200, 487067745)
  end

  def test_stair(n, expected)
    puts "TESTING STAIR WITH #{n} BLOCKS, expecting #{expected} solutions"
    actual = Stair.new.run(n: n, print: @print).size
    unless expected == actual
      raise "Expected #{expected} but got #{actual} for #{n} blocks"
    end
  end
end

StairTest.new.test_all
