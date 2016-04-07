require 'spec_helper'

describe JpZipCode do
  it 'search address data' do
    zip_code_data = JpZipCode.search '8000001'
    expect(zip_code_data.zip_code).to eq '8000001'
    expect(zip_code_data.pref_kana).to eq "ﾌｸｵｶｹﾝ"
    expect(zip_code_data.city_kana).to eq "ｷﾀｷｭｳｼｭｳｼﾓｼﾞｸ"
    expect(zip_code_data.town_kana).to eq "ｶｻﾞｼ"
    expect(zip_code_data.pref_kanji).to eq "福岡県"
    expect(zip_code_data.city_kanji).to eq "北九州市門司区"
    expect(zip_code_data.town_kanji).to eq "風師"
    expect(zip_code_data.pref_roman).to eq 'Fukuoka-Ken'
    expect(zip_code_data.city_roman).to eq 'Kitakyushu-Shi Moji-Ku'
    expect(zip_code_data.town_roman).to eq 'Kazashi'

    [
      nil,
      123_456,
      12_345_678,
      '123456',
      '123-456',
      '12345678',
      '123-45678',
      'abcdefg',
      '0000000'
    ].each do |error_zip|
      expect(JpZipCode.search(error_zip)).to eq nil
    end
  end
end
