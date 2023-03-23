class Player
    attr_accessor :name, :player_class, :life_points

    def initialize(name, player_class)
        @name = name
        @player_class = player_class
        @life_points = 100
        @shield_points = 0
    end

    def attack
      puts "I have attacked!"
    end

    def defend
        return unless @shield_points < 100
        
        @shield_points += 100
    end

    def use_potion
        @life_points = @life_points + @life_points * 25 / 100
    end

    def info
        {"Life Points" => @life_points, "Name"=> @name, "Shield Points"=> @shield_points, "Class"=> @player_class }
    end
end

