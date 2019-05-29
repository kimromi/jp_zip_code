# frozen_string_literal: true

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
      '8000001' => {
        code: '40101',
        old_zip_code: '800',
        zip_code: '8000001',
        pref_kana: 'ﾌｸｵｶｹﾝ',
        city_kana: 'ｷﾀｷｭｳｼｭｳｼﾓｼﾞｸ',
        town_kana: 'ｶｻﾞｼ(4ﾁｮｳﾒ)',
        pref_kanji: '福岡県',
        city_kanji: '北九州市門司区',
        town_kanji: '風師（４丁目）'
      }
    }
  end

  def roman_data
    {
      '8000001' => {
        zip_code: '8000001',
        pref_kanji: '福岡県',
        city_kanji: '北九州市　門司区',
        town_kanji: '風師（４丁目）',
        pref_roman: 'FUKUOKA KEN',
        city_roman: 'KITAKYUSHU SHI MOJI KU',
        town_roman: 'KAZASHI(4-CHOME)'
      }
    }
  end

  def merged
    {
      '8000001' => {
        code: '40101',
        old_zip_code: '800',
        zip_code: '8000001',
        pref_kana: 'ﾌｸｵｶｹﾝ',
        city_kana: 'ｷﾀｷｭｳｼｭｳｼﾓｼﾞｸ',
        town_kana: 'ｶｻﾞｼ(4ﾁｮｳﾒ)',
        pref_kanji: '福岡県',
        city_kanji: '北九州市門司区',
        town_kanji: '風師（４丁目）',
        pref_roman: 'FUKUOKA KEN',
        city_roman: 'KITAKYUSHU SHI MOJI KU',
        town_roman: 'KAZASHI(4-CHOME)'
      }
    }
  end
end
