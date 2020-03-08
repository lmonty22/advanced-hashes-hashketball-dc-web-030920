def game_hash
  hash = {
    :home =>{
      :team_name => "Brooklyn Nets",
      :colors => ["Black", "White"],
      :players => [
        {:player_name =>"Alan Anderson", 
        :number => 0,
        :shoe =>16, 
        :points =>22, 
        :rebounds =>12, 
        :assists =>12, 
        :steals =>3, 
        :blocks =>1, 
        :slam_dunks =>1, 
        },
        {:player_name =>"Reggie Evans", 
        :number =>30,
        :shoe =>14, 
        :points =>12, 
        :rebounds =>12, 
        :assists =>12, 
        :steals =>12, 
        :blocks =>12, 
        :slam_dunks =>7, 
        },
       {:player_name =>"Brook Lopez", 
        :number =>11,
        :shoe =>17, 
        :points =>17, 
        :rebounds =>19, 
        :assists =>10, 
        :steals =>3, 
        :blocks =>1, 
        :slam_dunks =>15, 
        },
        {:player_name =>"Mason Plumlee", 
        :number =>1,
        :shoe =>19, 
        :points =>26, 
        :rebounds =>11, 
        :assists =>6, 
        :steals =>3, 
        :blocks =>8, 
        :slam_dunks =>5, 
        },
        {:player_name =>"Jason Terry", 
        :number =>31,
        :shoe =>15, 
        :points =>19, 
        :rebounds =>2, 
        :assists =>2, 
        :steals =>4, 
        :blocks =>11, 
        :slam_dunks =>1, 
        }
        ]
    },
    :away =>{
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"],
      :players => [
         {:player_name =>"Jeff Adrien", 
        :number =>4,
        :shoe =>18, 
        :points =>10, 
        :rebounds =>1, 
        :assists =>1, 
        :steals =>2, 
        :blocks =>7, 
        :slam_dunks =>2, 
        },
        {:player_name =>"Bismack Biyombo", 
        :number =>0,
        :shoe =>16, 
        :points =>12, 
        :rebounds =>4, 
        :assists =>7, 
        :steals =>22, 
        :blocks =>15, 
        :slam_dunks =>10, 
        },
       {:player_name =>"DeSagna Diop", 
        :number =>2,
        :shoe =>14, 
        :points =>24, 
        :rebounds =>12, 
        :assists =>12, 
        :steals =>4, 
        :blocks =>5, 
        :slam_dunks =>5, 
        },
        {:player_name =>"Ben Gordon", 
        :number =>8,
        :shoe =>15, 
        :points =>33, 
        :rebounds =>3, 
        :assists =>2, 
        :steals =>1, 
        :blocks =>1, 
        :slam_dunks =>0, 
        },
        {:player_name =>"Kemba Walker", 
        :number =>33,
        :shoe =>15, 
        :points =>6, 
        :rebounds =>12, 
        :assists =>12, 
        :steals =>7, 
        :blocks =>5, 
        :slam_dunks =>12, 
        }]
    },
  }
end

def get_stat(input_player, stat)
game_hash.each do |location, team| 
    team[:players].each do |player|
      return player[stat] if player[:player_name] == input_player
    end
  end
end

def num_points_scored (input_player)
  get_stat(input_player, :points)
end

def shoe_size (input_player)
  get_stat(input_player, :shoe)
end

def team_colors (input_team)
  game_hash.each do |location, team|
    return team[:colors] if team[:team_name] == input_team
  end
end

def team_names
  game_hash.map do |location, team|
    team[:team_name]
  end
end

#when nesting within an hash, I have a hard time using map... how can I remove the numbers array and use map to return an array?
def player_numbers(input_team)
numbers = []
game_hash.each do |place, team|
  if team[:team_name] == input_team
    team.each do |attribute, data|
      next unless attribute == :players
        data.each do |player| #passing through an array 
        numbers.push(player[:number])
        end 
      end
    end
  end
numbers
end 

#same issue as above, can't seem to get map to work while working within a nested hash... 
def players_names_array 
  player_names = []
  game_hash.each do |place,team|
    team.each do |attribute, data|
      next unless attribute == :players
        data.each do |player| 
          player_names.push(player[:player_name])
        end
    end
  end
  player_names
end

def player_with_most(stat)
  stat_amount = 0 
  player_with_most_name = nil 
  players_names_array.each do |player_name| 
    if get_stat(player_name, stat).is_a? String 
        if (get_stat(player_name, stat)).length > stat_amount
          stat_amount = (get_stat(player_name, stat)).length 
          player_with_most_name = player_name 
        end 
    else
      if get_stat(player_name, stat) > stat_amount
          stat_amount = get_stat(player_name, stat)
          player_with_most_name = player_name 
      end 
    end 
  end
player_with_most_name  
end

def player_stats (input_player)
  stat = {}
  game_hash.each do |location, team|
    team[:players].each do |player|
      if player[:player_name] == input_player
        stat = player
      end
  end
end
stat.delete(:player_name)
stat
end

def big_shoe_rebounds
get_stat(player_with_most(:shoe),:rebounds)
end

def most_points_scored
  player_with_most(:points)
end

def player_with_longest_name
  player_with_most(:player_name)
end

def long_name_steals_a_ton?
  player_with_most(:player_name) == player_with_most(:steals)
end

def team_score(input_team)
  total = 0 
  game_hash.each do |location, team|
    if team[:team_name] == input_team
      team[:players].each do |player|
        total += player[:points]
      end
    end
    end
  total
end

def winning_team 
  scores = {}
  game_hash.each do |location, team|
    scores[(team[:team_name])] = team_score(team[:team_name])
  end 
  scores.max_by {|key, value| value }.first
end 