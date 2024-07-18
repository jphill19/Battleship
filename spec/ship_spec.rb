require 'spec_helper'

RSpec.describe Ship do
    describe "initialize" do
        before(:each) do
            @cruiser = Ship.new('Cruiser', 3)
            @submarine = Ship.new('Submarine', 2)
        end
        it 'exists' do
            expect(@cruiser).to be_a Ship
        end
           
        it 'has two attributes initialized with the arguements' do
            expect(@cruiser.name).to eq 'Cruiser'
            expect(@cruiser.length).to eq 3
        end

        it 'has health assigned to match the length' do
            expect(@cruiser.health).to eq @cruiser.length
            expect(@submarine.health).to eq @submarine.length
        end

    end

    describe "#sunk?" do
    end

    describe "#hit" do
    end
end