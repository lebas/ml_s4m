require "ml_s4m/version"
require 'nokogiri'
require 'open-uri'
require 'pry'

module MlS4m
  class MercadoLivre
    def initialize 
      @pn = nil
      @url_default = 'http://informatica.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_OrderId_PRICE*DESC_ItemTypeID_N'
      http://informatica.mercadolivre.com.br/me087_DisplayType_LF_OrderId_PRICE*DESC
      @offers = []
    end

    def setPNSearch(partNumber = nil)
      unless partNumber.nil?
        @pn = partNumber.downcase
        url_page = @url_default.gsub('PARTNUMBER', @pn)
        page = Nokogiri::HTML(open(url_page))
        unless page.nil?
          list = page.css('div.section').css('ol#searchResults').css('li')
          list_price = []
          list.each do |item|
            if !item.children[6].nil? && !item.children[6].children[1].nil?
              price = item.children[6].children[1].children[1] unless item.children[6].children[1].children[1].nil? 
              list_price << "#{price.children[0]},#{price.children[1].text}"unless price.nil?
            end
          end
          @offers = list_price.map{ |x| current2int(x) }
        else 
          @offers = 0
        end
      end 
    end

    def top5Offers
       @offers[1..5] if @offers.count > 4 
    end

    private
      def current2int(money = nil)
        money.delete(" R$ ").gsub('.','').gsub(',','.').to_f if !money.nil? && money.class == String
      end
  end
end
