# This spec is mostly copied from the similar spec at:
# => https://github.com/spaghetticode/game-of-life-ruby
# because I couldn't figure out my bug, so I needed to try some tests.
#
# Turns out it was my inability to understand deep copy in ruby...
require './cell.rb'

describe Grid do
	subject { Grid.new(5,5) }

	describe '#cells' do
		it 'should have 5 rows and 5 columns' do
			subject.cells.should == [
		    [0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0],
				[0,0,0,0,0]
			]
		end
	end

	describe '#to_s' do
		it 'should be as expected' do
			subject.to_s.should == "00000\n00000\n00000\n00000\n00000\n"
		end
	end

	describe '#seed' do
		it 'should set expected cells as alive' do
			subject.seed([[0,1], [3,4]])
			subject.to_s.should == "01000\n00000\n00000\n00001\n00000\n"
		end
	end

	describe '#neighbor_count' do
		before { subject.seed([[2,1], [2,2], [2,3]]) }

    # [0,0,0,0,0]
    # [0,0,0,0,0]
    # [0,1,1,1,0]
    # [0,0,0,0,0]
    # [0,0,0,0,0]

    it 'should return 2 for 2,2' do
    	subject.neighbor_count(2,2).should == 2
    end

    it 'should return 3 for 1,2' do
    	subject.neighbor_count(1,2).should == 3
    end

    it 'should return 0 for 0,0' do
    	subject.neighbor_count(0,0).should == 0
    end
  end

  describe '#run' do
  	before { subject.seed([[2,1], [2,2], [2,3]]) }

  	it 'should change as expected' do
  		state_0 = subject.to_s
  		state_1 = "00000\n00100\n00100\n00100\n00000\n"
  		expect { subject.run }.to change(subject, :to_s).to(state_1)
  	end
  end
end
