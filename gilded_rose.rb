module GildedRose
  # merge as a class method on Item
  class ItemFactory
    def initialize(name, sell_in, quality)
      if name.start_with? 'Aged Brie'
        Item.new(name, sell_in, quality)
      elsif name.start_with? 'Backstage pass'
        Item.new(name, sell_in, quality)
      elsif name.start_with? 'Sulfuras'
        Item.new(name, sell_in, quality)
      else
        NormalItem.new(name, sell_in, quality)
      end
    end
  end

  class Item
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
  end

  class NormalItem < Item
    def age
      @quality -= 1 if @quality > 0
      self
    end
  end
end

def update_quality(items)
      items.each do |item|
            if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
                  if item.quality > 0
                        if item.name != 'Sulfuras, Hand of Ragnaros'
                              item.quality = GildedRose::NormalItem.new(item.name, item.sell_in, item.quality).age.to_item.quality
                        end
                  end
            else
                  if item.quality < 50
                        item.quality += 1
                        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
                              if item.sell_in < 11
                                    if item.quality < 50
                                          item.quality += 1
                                    end
                              end
                              if item.sell_in < 6
                                    if item.quality < 50
                                          item.quality += 1
                                    end
                              end
                        end
                  end
            end
            if item.name != 'Sulfuras, Hand of Ragnaros'
                  item.sell_in -= 1
            end
            if item.sell_in < 0
                  if item.name != "Aged Brie"
                        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
                              if item.quality > 0
                                    if item.name != 'Sulfuras, Hand of Ragnaros'
                                          item.quality -= 1
                                    end
                              end
                        else
                              item.quality = 0
                        end
                  else
                        if item.quality < 50
                              item.quality += 1
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

