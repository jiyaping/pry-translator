# encoding : utf-8

require 'minitest/autorun'
require 'pry-translator'

class ProviderYoudaoTest < Minitest::Test
  include PryTranslator

  def setup
    Pry.config.translator = :youdao
    Pry.config.translator_keyfrom = 'jiyaping'
    Pry.config.translator_key = '1984909703'
    @youdao = Provider::Youdao.new
  end

  def test_youdao_setup
    assert @youdao
  end

  def test_youdao_format
    hash = {
      'translation'=> 'ok',
      'explains'=> ['2','4','5'],
      'errorCode'=> '500'
    }

    expect = {
      'translation'=> 'ok',
      'explains'=> ['2','4','5'],
      'error'=> '500'
    }

    assert @youdao.format(hash), expect
  end

  def test_youdao_translate
    assert @youdao.translate('hello')
  end
end