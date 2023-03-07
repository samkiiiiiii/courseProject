from base_version.Fighter import Fighter

coins_to_obtain = 20
delta_attack = -1
delta_defense = -1
delta_speed = -1


class AdvancedFighter(Fighter):
    def __init__(self, NO, HP, attack, defense, speed):
        super(AdvancedFighter, self).__init__(NO, HP, attack, defense, speed)
        self.coins = 0
        self.history_record = []

    def obtain_coins(self):

        if len(self.history_record)  == 3:

            if self.history_record[0] == "W" and self.history_record[1] == "W" and self.history_record[2] == "W":
             
                    # print("coins_to_return",coins_to_obtain * 1.1)

                return coins_to_obtain * 1.1

            elif self.history_record[0] == "L" and self.history_record[1] == "L" and self.history_record[2] == "L":
                return coins_to_obtain* 1.1

        return coins_to_obtain

        
    def buy_prop_upgrade(self):
        while self.coins >=50:
            print("Do you want to upgrade properties for Fighter",self.properties["NO"],"? A for attack.D for defense. S for speed. N for no")
            choice = input()
            if choice == "A":
                self.attack = self.attack +1
                self.coins -= 50
            elif choice == "D":
                self.defense = self.defense + 1
                self.coins -= 50
            elif choice == "S":
                self.speed = self.speed + 1
                self.coins -= 50
            elif choice == "N":
                break;

        
    def update_properties(self):
        global delta_attack
        global delta_speed
        global delta_defense
 
        if len(self.history_record)  == 3:
            # print("i am A")
            if self.history_record[0] == "W" and self.history_record[1] == "W" and self.history_record[2] == "W":
                if(delta_attack == 1):
                    delta_attack = delta_attack+ 1
                else:
                    delta_attack = 1
                delta_speed = 1
                delta_defense = -2                    
                self.history_record.clear()   
                # self.history_record[0] = self.history_record[1]
                # self.history_record[1] = self.history_record[2]
                # self.history_record[2] = self.history_record[3]


            elif self.history_record[0] == "L" and self.history_record[1] == "L" and self.history_record[2] == "L":
                delta_attack =  -2
                delta_speed =  +2
                delta_defense = +2                
                self.history_record.clear()   
            else:
                self.history_record[0] = self.history_record[1]
                self.history_record[1] = self.history_record[2]
                # self.history_record[2] = self.history_record[3]                

        self.attack = max(self.attack + delta_attack,1)
        self.defense = max(self.defense + delta_defense,1)
        self.speed = max(self.speed + delta_speed,1)   


    def record_fight(self, fight_result):
        self.history_record.append(fight_result)

        # check is it 3 consecutive win/lose
        # for a in self.history_record:
        #     print(a)