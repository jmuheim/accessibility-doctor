require 'rails_helper'

describe TrialSessionRequestHelper do
  describe '#offset_for_time_zone' do
    it 'returns the offset in hours for a given time zone string' do
      expect(offset_for_time_zone('Riga')).to eq 'Riga (+02:00)'
    end

    it 'raises an exception if no valid time zone given' do
      expect(offset_for_time_zone('Entenhausen')).to raise_error
    end
  end
end
