require "ml_s4m/version"
require 'nokogiri'
require 'open-uri'
require 'pry'

module MlS4m
  class MercadoLivre
    def initialize
      @url = {
        :ML_INFO => 'https://informatica.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_ItemTypeID_N',
        :ML_CAMERA => 'https://cameras.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_ItemTypeID_N',
        :ML_PHONE => 'https://celulares.mercadolivre.com.br/PARTNUMBER_DisplayType_LF_ItemTypeID_N',
        :ML_DRONE => 'https://eletronicos.mercadolivre.com.br/drones-e-acessorios-drone/PARTNUMBER_DisplayType_LF_ItemTypeID_N'
      }
      @url_default = nil
      @offers = []
    end

    def setPNSearch(partNumber = nil, category = nil)
      unless partNumber.nil?
        @offers = []
        ppn = partNumber.downcase
        @url_default = @url[category.to_sym] unless category.nil?
        pn = ["#{ppn.gsub(' ','%20')}", "#{ppn.gsub(' ','%20')}ll", "#{ppn.gsub(' ','%20')}bz"]
        pn.each do |pnumber|
          url_page = @url_default.gsub('PARTNUMBER', pnumber.gsub(' ','%20'))
          begin
            page = Nokogiri::HTML(open(url_page))
            @offers += crawler_list(page) unless page.nil?
          rescue OpenURI::HTTPError
            puts "[ERROR] - Nesta categoria não há anúncios que coincidam com a sua busca - #{pnumber}"
          end
        end
        return @offers
      end
    end

    def top5Offers
       @offers[1..5] if @offers.count > 4
    end

    private
      def current2int(money = nil)
        money.delete(" R$ ").gsub('.','').gsub(',','.').to_f if !money.nil? && money.class == String
      end

      def crawler_list(page = nil)
        unless page.nil?
          begin
            list = page.css('div').css('section').css('ol#searchResults').css('li')
            list_price = []
            list.each do |item|
              puts item
              unless item.children[1].nil?
                unless item.css('.price-fraction').nil?
                  price = item.css('.price-fraction').text
                  list_price << price unless price.nil?
                end
              end
            end
            return list_price.map{ |x| current2int(x) }
          rescue StandardError  => e
            puts "[ML] error 1 - crawler_list  #{e}"
          end
        end
      end
  end
end
