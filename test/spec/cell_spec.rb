#!/usr/bin/env ruby

$LOAD_PATH << './'
require 'rspec'
require_relative 'spec_helper'
require 'fiveinarow/cell'

describe Cell do

  context 'with predefined values' do
    subject(:cell) { Cell.new(4, 5, Cell::EMPTY) }

    it { expect(cell.value).to eq Cell::EMPTY }
    it { expect(cell.row).to eq 4 }
    it { expect(cell.col).to eq 5 }
    it { expect(cell.e?).to eq true }
    it { expect(cell.a?).to eq false }
    it { expect(cell.b?).to eq false }

  end

  context 'with changed value' do
    subject(:cell) { Cell.new(9, 3, Cell::PLAYER_A) }

    it { expect(cell.set(Cell::PLAYER_A)).to eq false }
    it { expect(cell.value).to eq Cell::PLAYER_A }
    it { expect(cell.row).to eq 9 }
    it { expect(cell.col).to eq 3 }
    it { expect(cell.e?).to eq false }
    it { expect(cell.a?).to eq true }
    it { expect(cell.b?).to eq false }
  end

end