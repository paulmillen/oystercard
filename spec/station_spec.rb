require 'station'

describe Station do

  subject(:station) { described_class.new }


  describe '#initialize' do

    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :zone }

    it 'initializes' do
      expect(station).not_to be_nil
    end
  end

end
