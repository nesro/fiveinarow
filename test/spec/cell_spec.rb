

$LOAD_PATH << './'
require 'rspec'
require_relative 'spec_helper'
require '../../lib/fiveinarow/cell'

describe Cell do

  context 'with predefined values' do
    subject(:cell) { Cell.new(4, 5, Cell::EMPTY) }

    it { expect(cell.value).to eq Cell::EMPTY }
    it { expect(cell.row).to eq 4 }
    it { expect(cell.col).to eq 5 }

  end

  it 'should store its value' do
    true.should == false
  end
end