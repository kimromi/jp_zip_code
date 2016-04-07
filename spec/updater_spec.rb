require 'spec_helper'

describe JpZipCode::Updater do
  before do
    @updater = JpZipCode::Updater.new
  end

  it 'update json data' do
    expect(@updater.execute).to be_truthy
  end

  it 'merge data' do
    expect(@updater.merge(jp_data, roman_data)).to eq merged
  end

  it 'update file' do
    expect(@updater.update_file(merged)).to eq nil
  end

  def jp_data
    {
      '0600000' => {
        code: '01101',
        old_zip_code: '060  ',
        zip_code: '0600000',
        pref_kana: "ﾎｯｶｲﾄﾞｳ",
        city_kana: "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
        town_kana: '',
        pref_kanji: "北海道",
        city_kanji: "札幌市中央区",
        town_kanji: '',
        pref_code: '1'
      }
    }
  end

  def roman_data
    {
      '0600000' => {
        zip_code: '0600000',
        pref_kanji: "北海道",
        city_kanji: "札幌市　中央区",
        town_kanji: "以下に掲載がない場合",
        pref_roman: 'Hokkaido',
        city_roman: 'Sapporo-Shi Chuo-Ku',
        town_roman: 'Ikanikeisaiganaibaai'
      }
    }
  end

  def merged
    {
      '0600000' => {
        code: '01101',
        old_zip_code: '060  ',
        zip_code: '0600000',
        pref_kana: "ﾎｯｶｲﾄﾞｳ",
        city_kana: "ｻｯﾎﾟﾛｼﾁｭｳｵｳｸ",
        town_kana: '',
        pref_kanji: "北海道",
        city_kanji: "札幌市中央区",
        town_kanji: '',
        pref_code: '1',
        pref_roman: 'Hokkaido',
        city_roman: 'Sapporo-Shi Chuo-Ku',
        town_roman: 'Ikanikeisaiganaibaai'
      }
    }
  end
end
