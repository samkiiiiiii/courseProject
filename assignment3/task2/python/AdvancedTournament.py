from base_version.Team import Team
from base_version.Tournament import Tournament
from .AdvancedFighter import AdvancedFighter
import advanced_version.AdvancedFighter as AdvancedFighterFile


class AdvancedTournament(Tournament):
    def __init__(self):
        super(AdvancedTournament, self).__init__()
        self.team1 = None
        self.team2 = None
        self.round_cnt = 1
        self.defeat_record = []

    def update_fighter_properties_and_award_coins(self, fighter, flag_defeat=False, flag_rest=False):
        # handle coins
        #rest
        # print("hi")
        if(flag_rest):
            # print("I am rest")
            fighter.coins = fighter.coins + fighter.obtain_coins() *0.5
            AdvancedFighterFile.delta_attack = 1
            AdvancedFighterFile.delta_defense = 1
            AdvancedFighterFile.delta_speed = 1

        if(flag_defeat):
            fighter.coins = fighter.coins + fighter.obtain_coins() *2

            AdvancedFighterFile.delta_attack = 1     
            AdvancedFighterFile.delta_defense = -1
            AdvancedFighterFile.delta_speed = -1               
            # self.defeat_record.clear()     

  

            


        else:
            fighter.coins = fighter.coins + fighter.obtain_coins() 

        fighter.update_properties()  
        # print("Before AdvancedFighter.delta_attack ",AdvancedFighterFile.delta_attack )
        AdvancedFighterFile.delta_attack = -1
        AdvancedFighterFile.delta_defense = -1
        AdvancedFighterFile.delta_speed = -1
        # print("After AdvancedFighter.delta_attack ",AdvancedFighterFile.delta_attack )


        # print("NO: ",fighter.NO ," coins: ",fighter.coins )
        # print("hihiihi")
        # print("fighter.delta_attack ",fighter.delta_attack)
        # fighter.delta_attack += 1
        # if(flag_rest):
        #     print("Before",fighter.delta_attack)
            
        #     fighter.coins = fighter.coins + fighter.obtain_coins() *0.5
        #     print(fighter.delta_attack)
        # else:
        #     print(fighter.properties["NO"])
        #     fighter.update_properties()
            # print("outside",AdvancedFighterFile.delta_attack)
            # fighter.coins = fighter.coins + fighter.obtain_coins()
        # print(fighter.coins)
        # consecutive win / lose
        # elif(flag_defeat):
        #     fighter.coins = fighter.coins + fighter.obtain_coins() *2




    def input_fighters(self, team_NO):
        print("Please input properties for fighters in Team {}".format(team_NO))
        fighter_list_team = []
        for fighter_idx in range(4 * (team_NO - 1) + 1, 4 * (team_NO - 1) + 5):
            while True:
                properties = input().split(" ")
                properties = [int(prop) for prop in properties]
                HP, attack, defence, speed = properties
                if HP + 10 * (attack + defence + speed) <= 500:
                    fighter = AdvancedFighter(fighter_idx, HP, attack, defence, speed)
                    fighter_list_team.append(fighter)
                    break
                print("Properties violate the constraint")
        return fighter_list_team

    def play_one_round(self):
    
        #play one round
        fight_cnt = 1

        print("Round {}:".format(self.round_cnt))
 
        while True:
            fighter_one_defeat=False
            fighter_two_defeat=False            
            team1_fighter = self.team1.get_next_fighter()
            team2_fighter = self.team2.get_next_fighter()

            # print(team1_fighter.properties["NO"])
            if team1_fighter is None or team2_fighter is None:
                break
            # upgrade properties  
            # print(fighter.properties["NO"])
            team1_fighter.buy_prop_upgrade()
            team2_fighter.buy_prop_upgrade()  

            fighter_first = team1_fighter
            fighter_second = team2_fighter
            if team1_fighter.properties["speed"] < team2_fighter.properties["speed"]:
                fighter_first = team2_fighter
                fighter_second = team1_fighter

            properties_first = fighter_first.properties
            properties_second = fighter_second.properties

            damage_first = max(properties_first["attack"] - properties_second["defense"], 1)
            fighter_second.reduce_HP(damage_first)
            # fighter one defeated fighter two 
            if(fighter_second.check_defeated()):
                fighter_one_defeat = True

            damage_second = None
            if not fighter_second.check_defeated():
                damage_second = max(properties_second["attack"] - properties_first["defense"], 1)
                fighter_first.reduce_HP(damage_second)
                if fighter_first.check_defeated():
                    # fighter second defeated fighter one
                    fighter_two_defeat = True

        
            winner_info = "tie"
            if damage_second is None:
                winner_info = "Fighter {} wins".format(fighter_first.properties["NO"])
                fighter_first.record_fight("W")
                fighter_second.record_fight("L")

            else:
                if damage_first > damage_second:
                    winner_info = "Fighter {} wins".format(fighter_first.properties["NO"])
                    fighter_first.record_fight("W")
                    fighter_second.record_fight("L")
                elif damage_second > damage_first:
                    winner_info = "Fighter {} wins".format(fighter_second.properties["NO"])
                    fighter_second.record_fight("W")
                    fighter_first.record_fight("L")
            print("Duel {}: Fighter {} VS Fighter {}, {}".format(fight_cnt, team1_fighter.properties["NO"],
                    team2_fighter.properties["NO"], winner_info))
            team1_fighter.print_info()
            team2_fighter.print_info()
            fight_cnt += 1
            
            self.update_fighter_properties_and_award_coins(fighter_first,fighter_one_defeat,False)
            self.update_fighter_properties_and_award_coins(fighter_second,fighter_two_defeat,False)


        print("Fighters at rest:")

        for team in [self.team1, self.team2]:
            if team is self.team1:
                team_fighter = team1_fighter
            else:
                team_fighter = team2_fighter
            while True:
                if team_fighter is not None:
                    team_fighter.record_fight("R")

                    team_fighter.print_info()
                    self.update_fighter_properties_and_award_coins(team_fighter,False,True)

                else:
                    break;
                team_fighter = team.get_next_fighter()
  
        self.round_cnt += 1

    # update_fighter_properties_and_award_coins



