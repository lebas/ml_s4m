require "ml_s4m/version"
require 'nokogiri'
require 'open-uri'
require 'pry'

module MlS4m
  class MercadoLivre
    def initialize 
      @pn = nil
      @url = {
        :ML_INFO => 'http://informatica.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_OrderId_PRICE*DESC_ItemTypeID_N',
        :ML_CAMERA => 'http://cameras.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_OrderId_PRICE*DESC_ItemTypeID_N',
        :ML_PHONE => 'http://celulares.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_OrderId_PRICE*DESC_ItemTypeID_N'
      }
      @url_default = nil
      @offers = []
    end

    def setPNSearch(partNumber = nil, category = nil)
      unless partNumber.nil?
        @pn = partNumber.downcase
        @url_default = @url[category.to_sym] unless category.nil?
        url_page = @url_default.gsub('PARTNUMBER', @pn)
        begin
          page = Nokogiri::HTML(open(url_page))
          unless page.nil?
            list = page.css('ol#searchResults.list-view.srv').css('li')
            list_price = []
            list.each do |item|
              if item.children[6].nil? 
                if !item.children[6].children[1].nil? && item.children[6].children[1].children[1].nil?
                  price = item.children[6].children[1].children[1].text 
                  price.gsub('R$ ','').gsub('.','') unless price.nil?
                  list_price << price unless price.nil?
                end
              end
            end
            if list_price.empty? 
              list = page.css('div').css('section').css('ol#searchResults').css('li')
              list_price = []
              list.each do |item|
              if item.children[6].nil? 
                item.children[1].children[1].children[1].children[2].children[1].nil? || item.children[1].children[1].children[1].children[2].children[1].children[3].nil? 
                price = item.children[1].children[1].children[1].children[2].children[1].children[3].text
                list_price << price unless price.nil?
              end
            end
            @offers = list_price.map{ |x| current2int(x) }  
          end
        rescue OpenURI::HTTPError
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
