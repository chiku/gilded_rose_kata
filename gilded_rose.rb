module GildedRose
  class Item
    def self.age(item)
      Item.for(item.name, item.sell_in, item.quality).age.to_item
    end

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

    def normalize
      @quality = 0 if @quality < 0
      @quality = 50 if @quality > 50
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
      if @sell_in > 0
        @quality -= 1
      else
        @quality -= 2
      end
      normalize
      self
    end

    def normal? # :TBD:
      true
    end
  end

  class AgedBrie < Item
    def age
      @sell_in -= 1
      if @sell_in < 0
        @quality += 2
      else
        @quality += 1
      end
      normalize
      self
    end

    def aged_brie? # :TBD:
      true
    end
  end

  class BackstageItem < Item
    def backstage? # :TBD:
      true
    end

    def age
      @sell_in -= 1
      if 10 <= @sell_in
        @quality += 1
      end
      if 5 <= @sell_in && @sell_in < 10
        @quality += 2
      end
      if 0 <= @sell_in && @sell_in < 5
        @quality += 3
      end
      if @sell_in < 0
        @quality = 0
      end
      normalize
      self
    end
  end

  class SulfurasItem < Item
    def sulfuras? # :TBD:
      true
    end

    def age
      self
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
