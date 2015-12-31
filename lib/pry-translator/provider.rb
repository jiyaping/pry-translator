# encoding : utf-8

module PryTranslator
  class BasicError < StandardError; end

  module Provider
    class ProviderError < PryTranslator::BasicError; end

    class BaseProvider
      def initialize(href, api_param_key)
        @api_href = href
        @api_param_hash = read_config(api_param_key)

        values = @api_param_hash.values
        if values.include? nil or values.include? ''
          puts required_key_tips(api_param_key)
          raise ProviderError.new('init provider error.')
        end
      end

      def read_config(keys)
        config_prefix = 'Pry.config.translator'
        
        keys.inject({}) do |hash, key|
          hash[key] = eval("#{config_prefix}_#{key.to_s}")

          hash
        end
      end

      def required_key_tips(keys, href='')
        config_prefix = 'Pry.config.translator'

        info = "you are using #{ Pry.config.translator ||PryTranslator::DEFAULT_PROVIDER } service, you need configure\n"
        info << keys.inject('') do |str, key| 
          str += "    #{config_prefix}_#{key.to_s} = #{key.to_s.upcase}\n".colorize(:red)
        end

        info << "in ~/.pryrc file"
        info
      end

      def get(api_url, args={})
        conn = Faraday.new(@api_href)

        resp = conn.get api_url, (@api_param_hash.clone.merge! args)

        resp.body
      end
    end
  end
end