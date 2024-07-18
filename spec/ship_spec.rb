require 'spec_helper'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new('Cruiser', 3)
        @submarine = Ship.new('Submarine', 2)
    end

    describe "initialize" do
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

    describe "#hit" do
        it 'can take a hit' do
            @cruiser.hit
            expect(@cruiser.health).to eq 2
        end

        it 'shows multiple hits lowering health more' do
            @cruiser.hit
            expect(@cruiser.health).to eq 2
            @cruiser.hit
            expect(@cruiser.health).to eq 1
            @cruiser.hit
            expect(@cruiser.health).to eq 0
        end

        it 'tracks each ship seperately' do
            expect(@cruiser.health).to eq 3
            expect(@submarine.health).to eq 2
            @submarine.hit
            @cruiser.hit
            expect(@cruiser.health).to eq 2
            expect(@submarine.health).to eq 1
        end            
    end

    # describe "#sunk?" do
    #     it 'returns a boolean of the status of the ship' do
    #         expect(@cruiser.sunk?).to eq false
    #     end

    #     it 'can sink the ship when health is 0' do
    #         @cruiser.health = 0
    #         expect(@cruiser.sunk?).to eq true
    #     end
    # end
end