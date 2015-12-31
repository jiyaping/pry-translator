# encoding : utf-8

require 'minitest/autorun'
require 'pry-translator'

class PryTranslatorTest < Minitest::Test
  include PryTranslator

  def setup
    Pry.config.translator_key1 = '1'
    Pry.config.translator_key2 = '2'
    @wapper = Provider::BaseProvider.new('http://example.com', [:key1, :key2])
  end

  def test_gem_setup_ok
    assert PryTranslator::VERSION
  end

  def test_provider_wapper
    assert @wapper
  end

  def test_provider_wapper_read_config
    assert_equal (@wapper.read_config [:key]), {:key=> nil}
  end

  def test_provider_wapper_read_config
    keys = [:key1, :key2]
    expect_config = {
      :key1 => '1',
      :key2 => '2' 
    }

    #puts @wapper.read_config keys

    assert_equal (@wapper.read_config keys), expect_config
  end

  def test_provider_wapper_read_config2
    keys = [:key1, :key2]
    expect_config = {
      :key1 => '1',
      :key2 => '2' 
    }


    Pry.config.translator_key1 = '1'
    Pry.config.translator_key2 = '3'

    #puts @wapper.read_config keys

    refute_equal (@wapper.read_config keys), expect_config
  end

  def test_provider_wapper_requied_key_tips
    assert @wapper.required_key_tips [:a, :b]
  end

  def test_provider_wapper_gets
    pass
  end
end
