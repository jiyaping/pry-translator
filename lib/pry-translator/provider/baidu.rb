# encoding : utf-8

module PryTranslator
  module Provider
    class Baidu < BaseProvider
      def initialize
        api_key_param = [:appid, :appsecret]
        api_href = 'http://api.fanyi.baidu.com'

        super(api_href, api_key_param)
      end

      def translate(text, args={})
        args['to']   = 'auto'
        args['from'] = 'auto'
        args['q']    = text
        args['salt'] = SecureRandom.hex
        args['sign'] = create_sign(args)

        begin
          result = JSON.parse(get('/api/trans/vip/translate', args))
          #result = format(result)
        rescue JSON::ParserError => e
          raise ProviderError.new('failed parsing response from baidu.')
        rescue
          raise e
        end

        pretty_string result
      end

      def create_sign(args)
        md5 = Digest::MD5.new

        md5.update "#{@api_param_hash[:appid]}#{args['q']}#{args['salt']}#{@api_param_hash[:appsecret]}".encode('utf-8')
        
        md5.hexdigest
      end

      def pretty_string(hash)
        hash = format(hash)
        str = hash['translation'].colorize(:red)

        str
      end

      def format(hash)
        h = {}

        h['translation'] = hash['trans_result'].first['dst'] if hash['trans_result']

        h
      end
    end
  end
end