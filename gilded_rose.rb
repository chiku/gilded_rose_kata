module GildedRose
  class Item
    def self.for(name, sell_in, quality)
      if name.start_with? 'Aged Brie'
        AgedBrie.new(name, sell_in, quality)
      elsif name.start_with? 'Backstage pass'
        BackstageItem.new(name, sell_in, quality)
      elsif name.start_with? 'Sulfuras'
        SulfurasItem.new(name, sell_in, quality)
      else
        NormalItem.new(name, sell_in, quality)
      end
    end

    def initialize(name, sell_in, quality)
      @name = name
      @sell_in = sell_in
      @quality = quality
    end

    def to_item
      ::Item.new(@name, @sell_in, @quality)
    end

    def age
      #no-op
      self
    end

    def normal? # :TBD:
      false
    end

    def aged_brie? # :TBD:
      false
    end

    def backstage? # :TBD:
      false
    end

    def sulfuras? # :TBD:
      false
    end
  end

  class NormalItem < Item
    def age
      @sell_in -= 1
      @quality -= 1 if @sell_in < 0
      @quality -= 1 if @quality > 0

      self
    end

    def normal? # :TBD:
      true
    end
  end

  class AgedBrie < Item
    def aged_brie? # :TBD:
      true
    end
  end

  class BackstageItem < Item
    def backstage? # :TBD:
      true
    end
  end

  class SulfurasItem < Item
    def sulfuras? # :TBD:
      true
    end
  end
end

def update_quality(items)
      items.each do |item|
            gr_item = GildedRose::Item.for(item.name, item.sell_in, item.quality)
            gr_item.age

            if gr_item.normal?
                  item.sell_in -= 1
                  item.quality -= 1 if item.sell_in < 0
                  item.quality -= 1 if item.quality > 0
                  item = gr_item.to_item
            end

            if gr_item.aged_brie?
                  if item.quality < 50
                        item.quality += 1
                        if false
                              if item.sell_in < 11
                                    item.quality += 1
                              end
                              if item.sell_in < 6
                                    item.quality += 1
                              end
                        end
                  end

                  if true
                        item.sell_in -= 1
                        if item.sell_in < 0
                              if item.quality < 50
                                    item.quality += 1
                              end
                        end
                  end

                  if false
                        item.sell_in -= 1
                        if item.sell_in < 0
                              item.quality = 0
                              if item.quality > 0
                                    item.quality -= 1
                              end
                        end
                  end
            end

            if gr_item.backstage?
                  if item.quality < 50
                        item.quality += 1
                        if true
                              if item.sell_in < 11
                                    item.quality += 1
                              end
                              if item.sell_in < 6
                                    item.quality += 1
                              end
                        end
                  end
            
                  if false
                        item.sell_in -= 1
                        if item.sell_in < 0
                              if item.quality < 50
                                    item.quality += 1
                              end
                        end
                  end
            
                  if true
                        item.sell_in -= 1
                        if item.sell_in < 0
                              item.quality = 0
                              if item.quality > 0
                                    item.quality -= 1
                              end
                        end
                  end
            end
            
            if gr_item.sulfuras?
                  if item.quality < 50
                        item.quality += 1
                        if false
                              if item.sell_in < 11
                                    item.quality += 1
                              end
                              if item.sell_in < 6
                                    item.quality += 1
                              end
                        end
                  end
            
                  if false
                        item.sell_in -= 1
                        if item.sell_in < 0
                              if item.quality < 50
                                    item.quality += 1
                              end
                        end
                  end
            
                  if false
                        item.sell_in -= 1
                        if item.sell_in < 0
                              item.quality = 0
                              if item.quality > 0
                                    item.quality -= 1
                              end
                        end
                  end
            end
      end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
