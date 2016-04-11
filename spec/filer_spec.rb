require 'spec_helper'

describe JpZipCode::Filer do
  before do
    @filer = JpZipCode::Filer.new(type)
  end

  after do
    @filer.clean
  end

  describe 'get hash data (jp)' do
    let(:type) { :jp }

    it do
      data = @filer.fetch_data

      zip_code = '8000001'
      expect(data.key?(zip_code)).to be_truthy
      expect(data[zip_code][:code]).to       eq '40101'
      expect(data[zip_code][:zip_code]).to   eq '8000001'
      expect(data[zip_code][:pref_kana]).to  eq 'ﾌｸｵｶｹﾝ'
      expect(data[zip_code][:city_kana]).to  eq 'ｷﾀｷｭｳｼｭｳｼﾓｼﾞｸ'
      expect(data[zip_code][:town_kana]).to  eq 'ｶｻﾞｼ(4ﾁｮｳﾒ)'
      expect(data[zip_code][:pref_kanji]).to eq '福岡県'
      expect(data[zip_code][:city_kanji]).to eq '北九州市門司区'
      expect(data[zip_code][:town_kanji]).to eq '風師（４丁目）'
    end
  end

  context 'get hash data(roman)' do
    let(:type) { :roman }

    it do
      data = @filer.fetch_data

      zip_code = '8000001'.freeze
      expect(data.key?(zip_code)).to be_truthy
      expect(data[zip_code][:zip_code]).to   eq '8000001'
      expect(data[zip_code][:pref_kanji]).to eq "福岡県"
      expect(data[zip_code][:city_kanji]).to eq "北九州市　門司区"
      expect(data[zip_code][:town_kanji]).to eq "風師（４丁目）"
      expect(data[zip_code][:pref_roman]).to eq 'FUKUOKA KEN'
      expect(data[zip_code][:city_roman]).to eq 'KITAKYUSHU SHI MOJI KU'
      expect(data[zip_code][:town_roman]).to eq 'KAZASHI(4-CHOME)'
    end
  end
end
