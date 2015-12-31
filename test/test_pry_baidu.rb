# encoding : utf-8
require 'minitest/autorun'
require 'pry-translator'

class BaiduTest < Minitest::Test
  include PryTranslator

  def setup
    Pry.config.translator = :baidu
    Pry.config.translator_appid = '2015063000000001'
    Pry.config.translator_appsecret = '12345678'

    @baidu = Provider::Baidu.new
  end

  def test_create_sign
    args = {
      'q' => 'apple',
      'salt' => '1435660288'
    }

    assert_equal @baidu.create_sign(args), 'f89f9594663708c1605f3d736d01d2d4'
  end

  def test_baidu_translate
    assert @baidu.translate('apple')
  end
end