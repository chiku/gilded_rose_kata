module GildedRose
  class Item
    def self.age(item)
      Item.for(item.name, item.sell_in, item.quality).age.to_item
    end

    def self.for(name, sell_in, quality)
      if name.start_with? 'Aged Brie'
        AgedBrie
      elsif name.start_with? 'Backstage pass'
        BackstageItem
      elsif name.start_with? 'Conjured'
        ConjuredItem
      elsif name.start_with? 'Sulfuras'
        SulfurasItem
      else
        NormalItem
      end.new(name, sell_in, quality)
    end

    def initialize(name, sell_in, quality)
      @name = name
      @sell_in = sell_in
      @quality = quality
    end

    def to_item
      ::Item.new(@name, @sell_in, @quality)
    end

    def normalize
      @quality = 0 if quality_minimum?
      @quality = 50 if quality_maximum?
    end

    def quality_maximum?
      @quality >= 50
    end

    def quality_minimum?
      @quality <= 0
    end

    def age
      reduce_sell_in_date
      modify_quality
      normalize
      self
    end
  end

  class NormalItem < Item
    def reduce_sell_in_date
      @sell_in -= 1
    end

    def modify_quality
      if @sell_in > 0
        @quality -= 1
      else
        @quality -= 2
      end
    end
  end

  class AgedBrie < Item
    def reduce_sell_in_date
      @sell_in -= 1
    end

    def modify_quality
      if @sell_in >= 0
        @quality += 1
      else
        @quality += 2
      end
    end
  end

  class BackstageItem < Item
    def reduce_sell_in_date
      @sell_in -= 1
    end

    def modify_quality
      if 10 <= @sell_in
        @quality += 1
      elsif 5 <= @sell_in && @sell_in < 10
        @quality += 2
      elsif 0 <= @sell_in && @sell_in < 5
        @quality += 3
      elsif @sell_in < 0
        @quality = 0
      end
    end
  end

  class SulfurasItem < Item
    def reduce_sell_in_date
    end

    def modify_quality
    end

    def quality_maximum?
      false
    end
  end

  class ConjuredItem < Item
    def reduce_sell_in_date
      @sell_in -= 1
    end

    def modify_quality
      if @sell_in > 0
        @quality -= 2
      else
        @quality -= 4
      end
    end
  end
end

def update_quality(items)
  items.each do |item|
    aged_item = GildedRose::Item.age(item)
    item.quality = aged_item.quality
    item.sell_in = aged_item.sell_in
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
