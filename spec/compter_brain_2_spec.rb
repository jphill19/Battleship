require 'spec_helper'

RSpec.describe Cell do
    before(:each) do
        @player_board = Board.new
        @ship = Ship.new("cruiser",3)
        @player_board.place(@ship, ['A1','A2','A3'])
        @computer_brain = ComputerBrain.new(@player_board)
    end

    describe "initialize" do
        it "can initialize" do
            expect(@computer_brain).to be_an_instance_of(ComputerBrain)
        end
    end

    describe "random_shot" do
        it "random shot returns a random coordinate inside player_board" do
            expect(@player_board.cells.keys).to include(@computer_brain.random_shot) 
        end
    end

    describe "check_if_shot_hit" do
        it "returns true if the shot hit a ship" do
          shot = 'A1'
          @player_board.cells[shot].fire_upon
          expect(@computer_brain.check_if_shot_hit(shot)).to be true
        end
    
        it "returns false if the shot missed" do
          shot = 'B1'
          @player_board.cells[shot].fire_upon
          expect(@computer_brain.check_if_shot_hit(shot)).to be false
        end
    end

    describe "update_shots_taken" do
        it "adds the shot to shots_taken" do
          shot = 'A1'
          @computer_brain.update_shots_taken(shot)
          expect(@computer_brain.instance_variable_get(:@shots_taken)).to include(shot)
        end
    end

    describe "update_available_shots" do
        it "removes the shot from available_shots" do
          shot = 'A1'
          @computer_brain.update_available_shots(shot)
          expect(@computer_brain.instance_variable_get(:@available_shots)).not_to include(shot)
        end
    end

    describe "decide_shot" do
        it "returns a valid shot" do
          shot = @computer_brain.decide_shot
          expect(@player_board.cells.keys).to include(shot)
        end
    end

    describe "aimed_shots" do
        it "returns a valid aimed shot" do
          @computer_brain.instance_variable_set(:@current_hits, ['A1'])
          shot = @computer_brain.aimed_shots
          expect(@player_board.cells.keys).to include(shot)
          expect(shot).not_to eq('A1') # Should not aim at the same spot
        end
    end

    describe "delete_sunk_ships" do
        it "removes sunk ship coordinates from the current hits list" do
          @computer_brain.instance_variable_set(:@current_hits, ['A1', 'A2', 'A3'])
          @player_board.cells['A1'].fire_upon
          @player_board.cells['A2'].fire_upon
          @player_board.cells['A3'].fire_upon
          @computer_brain.delete_sunk_ships(@computer_brain.instance_variable_get(:@current_hits))
          expect(@computer_brain.instance_variable_get(:@current_hits)).to be_empty
        end
      end
    
      describe "valid_shot?" do
        it "returns true for a valid shot" do
          shot = 'A1'
          expect(@computer_brain.valid_shot?(shot)).to be true
        end
    
        it "returns false for an invalid shot" do
          shot = 'Z9'
          expect(@computer_brain.valid_shot?(shot)).to be false
        end
    
        it "returns false for a previously taken shot" do
          shot = 'A1'
          @computer_brain.update_shots_taken(shot)
          expect(@computer_brain.valid_shot?(shot)).to be false
        end
    end
    describe "find_correlation" do
        it "finds correlation in rows" do
          @computer_brain.instance_variable_set(:@current_hits, ['A1', 'A2', 'A3'])
          @computer_brain.find_correlation
          expect(@computer_brain.instance_variable_get(:@same_col_hits)).to eq(['A1', 'A2', 'A3'])
          expect(@computer_brain.instance_variable_get(:@same_row_hits)).to be_empty
        end
    
        it "finds correlation in columns" do
          @computer_brain.instance_variable_set(:@current_hits, ['A1', 'B1', 'C1'])
          @computer_brain.find_correlation
          expect(@computer_brain.instance_variable_get(:@same_row_hits)).to eq(['A1', 'B1', 'C1'])
          expect(@computer_brain.instance_variable_get(:@same_col_hits)).to be_empty
        end
    
        it "does not find correlation if hits are not aligned" do
          @computer_brain.instance_variable_set(:@current_hits, ['A1', 'B2', 'C3'])
          @computer_brain.find_correlation
          expect(@computer_brain.instance_variable_get(:@same_row_hits)).to be_empty
          expect(@computer_brain.instance_variable_get(:@same_col_hits)).to be_empty
        end
    
        it "wipes current hits after finding correlation" do
          @computer_brain.instance_variable_set(:@current_hits, ['A1', 'A2', 'A3'])
          @computer_brain.find_correlation
          expect(@computer_brain.instance_variable_get(:@current_hits)).to be_empty
        end
      end

    describe "aim_in_direction" do
        it "returns the correct shot aiming left" do
          shot = @computer_brain.aim_in_direction('A2', :left)
          expect(shot).to eq('A1')
        end
    
        it "returns the correct shot aiming right" do
          shot = @computer_brain.aim_in_direction('A1', :right)
          expect(shot).to eq('A2')
        end
    
        it "returns the correct shot aiming up" do
          shot = @computer_brain.aim_in_direction('B1', :up)
          expect(shot).to eq('A1')
        end
    
        it "returns the correct shot aiming down" do
          shot = @computer_brain.aim_in_direction('A1', :down)
          expect(shot).to eq('B1')
        end
    
        it "returns nil for invalid left shot" do
          shot = @computer_brain.aim_in_direction('A1', :left)
          expect(shot).to be_nil
        end
    
        it "returns nil for invalid right shot" do
          shot = @computer_brain.aim_in_direction('A4', :right)
          expect(shot).to be_nil
        end
    
        it "returns nil for invalid up shot" do
          shot = @computer_brain.aim_in_direction('A1', :up)
          expect(shot).to be_nil
        end
    
        it "returns nil for invalid down shot" do
          shot = @computer_brain.aim_in_direction('D1', :down)
          expect(shot).to be_nil
        end
    end
end