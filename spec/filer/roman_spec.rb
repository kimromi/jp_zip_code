require 'spec_helper'

describe JpZipCode::Filer::Roman do
  before do
    @filer = JpZipCode::Filer::Roman.new
  end

  after do
    @filer.clean
  end

  it 'get hash data' do
    data = @filer.fetch_data

    Test_zip_code = '8000001'.freeze
    expect(data.key?(Test_zip_code)).to be_truthy
    expect(data[Test_zip_code][:zip_code]).to   eq '8000001'
    expect(data[Test_zip_code][:pref_kanji]).to eq "福岡県"
    expect(data[Test_zip_code][:city_kanji]).to eq "北九州市　門司区"
    expect(data[Test_zip_code][:town_kanji]).to eq "風師"
    expect(data[Test_zip_code][:pref_roman]).to eq 'Fukuoka-Ken'
    expect(data[Test_zip_code][:city_roman]).to eq 'Kitakyushu-Shi Moji-Ku'
    expect(data[Test_zip_code][:town_roman]).to eq 'Kazashi'
  end
end
