require 'spec_helper'

describe JpZipCode::Filer::Jp do
  before do
    @filer = JpZipCode::Filer::Jp.new
  end

  after do
    @filer.clean
  end

  it 'get hash data' do
    data = @filer.fetch_data

    Test_zip_code = '8000001'.freeze
    expect(data.key?(Test_zip_code)).to be_truthy
    expect(data[Test_zip_code][:code]).to       eq '40101'
    expect(data[Test_zip_code][:zip_code]).to   eq '8000001'
    expect(data[Test_zip_code][:pref_kana]).to  eq 'ﾌｸｵｶｹﾝ'
    expect(data[Test_zip_code][:city_kana]).to  eq 'ｷﾀｷｭｳｼｭｳｼﾓｼﾞｸ'
    expect(data[Test_zip_code][:town_kana]).to  eq 'ｶｻﾞｼ(4ﾁｮｳﾒ)'
    expect(data[Test_zip_code][:pref_kanji]).to eq '福岡県'
    expect(data[Test_zip_code][:city_kanji]).to eq '北九州市門司区'
    expect(data[Test_zip_code][:town_kanji]).to eq '風師（４丁目）'
  end
end
