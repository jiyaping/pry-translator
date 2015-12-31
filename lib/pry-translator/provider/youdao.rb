# encoding : utf-8

module PryTranslator
  module Provider
    class Youdao < BaseProvider
      def initialize
        api_key_param = [:keyfrom, :key]
        api_href = 'http://fanyi.youdao.com/'

        super(api_href, api_key_param)
      end

      def translate(text, args={})
        args['type']    = 'data'
        args['version'] = '1.1'
        args['doctype'] = 'json'
        args['q']       = text

        begin
          result = JSON.parse(get('/openapi.do', args))
          #result = format(result)
        rescue JSON::ParserError => e
          raise ProviderError.new('failed parsing response from youdao.')
        rescue
          raise e
        end

        pretty_string result
      end

      def pretty_string(hash)
        hash = format(hash)
        str = hash['translation'].join(' ').colorize(:red)
        str << "\n#{PryTranslator::INDENT}" << hash['explains'].join("\n#{PryTranslator::INDENT}") if hash['explains']

        str
      end

      def format(hash)
        h = {}

        h['translation'] = hash['translation']
        h['explains']    = hash['basic']['explains'] if hash['basic']
        h['code']        = hash['errorCode']

        h
      end
    end
  end
end