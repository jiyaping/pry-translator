# encoding : utf-8

require 'pry'
require 'faraday'
require 'json'
require 'colorize'
require 'securerandom'
require 'digest'

require 'pry-translator/provider'
require 'pry-translator/version'

require 'pry-translator/provider/youdao'
require 'pry-translator/provider/baidu'

module PryTranslator
  DEFAULT_PROVIDER = :youdao
  INDENT           = ' ' * 4

  Commands = Pry::CommandSet.new do
    create_command 't', 'translate your input.' do
      def process
        provider = Pry.config.translator || PryTranslator::DEFAULT_PROVIDER

        begin
          engine = eval("PryTranslator::Provider::#{provider.to_s.capitalize}").new
          output.puts engine.translate(args.join(' '))
        rescue Exception => e
          puts e.to_s
        end
      end
    end
  end
end

Pry.commands.import PryTranslator::Commands