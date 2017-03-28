require "ml_s4m/version"
require 'nokogiri'
require 'open-uri'
require 'pry'

module MlS4m
  class MercadoLivre
    def initialize 
      @pn = nil
      @url_default = 'http://informatica.mercadolivre.com.br/macbooks/PARTNUMBER_DisplayType_LF_OrderId_PRICE*DESC'
    end

    def setPNSearch(partNumber = nil)
      unless partNumber.nil?
        @pn = partNumber.downcase
        url_page = @url_default.gsub('PARTNUMBER', @pn)
        page = Nokogiri::HTML(open(url_page))
        list = page.css('div.section').css('ol#searchResults').css('li')
        list_price = []
        list.each do |item|
          if !item.children[6].nil? && !item.children[6].children[1].nil?
            price = item.children[6].children[1].children[1] unless item.children[6].children[1].children[1].nil? 
            list_price << "#{price.children[0]},#{price.children[1].text}"unless price.nil?
            list_price = list_price.map{ |x| current2int(x) }
          end
        end
      end 
    end

    def top5Offers
      unless @pn.nil?

      end
    end

    private
      def current2int(money = nil)
        money.gsub(' R$','').gsub('.','').gsub(',','.').to_i unless money.nil?
      end
  end
end
