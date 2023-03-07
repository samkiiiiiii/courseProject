from Map import Map
from Cell import Plain, Mountain, Swamp
from GameCharacter import Player, Goblin
from Trap import Trap 
from Volcano import Volcano

import re
class NewEngine:
    def __init__(self, data_file):
        self._actors = []
        self._map = None 
        self._player = None 
        with open(data_file, 'r') as fp:
            line = fp.readline()
            if not line:
                return None
            else:
                items = line.split()
                if len(items) != 7:
                    print('INVALID DATA FILE.')
                    return None
                num_of_row = int(items[0])
                num_of_col = int(items[1])
                p_ox = int(items[2])
                p_hp = int(items[3])
                num_of_goblins = int(items[4])
                num_of_traps = int(items[5])
                num_of_volcanoes = int(items[6])

            self._map = Map(num_of_row, num_of_col)
            
            # TODO: initialize each cell of the map object 
            #       using the build_cell method
            for i in range(num_of_row):
                tempString = fp.readline();
                splitArr = []
                splitArr = re.split('\\s+',tempString)
                for j in range(len(splitArr)):
                    if(splitArr[j] == "P"):
                        self._map.build_cell(i,j,Plain(i,j))
                    elif(splitArr[j] == "M"):
                        self._map.build_cell(i,j,Mountain(i,j))
                    elif(splitArr[j] == "S"):
                        self._map.build_cell(i,j,Swamp(i,j))            
            # END TODO
            
            self._player = Player(num_of_row - 1, 0, p_hp, p_ox)
            initCell = self._map.get_cell(num_of_row -1 ,0)
            initCell.set_occupant (self._player)
            self._player.occupying= initCell
            self._actors.append(self._player)          
            # TODO: initilize the position of the player 
            #       using the set_occupant and occupying setter;
            #       add the player to _actors array

            for gno in range(num_of_goblins):
                # TODO: initilize each Goblin on the map
                #       using the set_occupant and occupying setter;
                #       add each Goblin to _actors array 
                tempString = fp.readline();
                splitArr = []
                splitArr = re.split('\\s+',tempString)
                splitArr = splitArr[:-1]
                # END TOD
                goblinRow = int(splitArr[0])
                goblinCol = int(splitArr[1])
                goblinActions = []
                for j in range(2,len(splitArr)):
                    # not sure
                    # print("j",j)
                    # print(goblinActions)
                    goblinActions.append(splitArr[j][0])
                    # goblinActions[j-2] = splitArr[j][0]
                gob = Goblin(goblinRow,goblinCol,goblinActions)
                self._actors.append(gob)
                initCell = self._map.get_cell(goblinRow,goblinCol)
                initCell.set_occupant(gob)
                # print(initCell.occupant)
                gob.occupying = initCell
            
                # END TODO 

            for tno in range(num_of_traps):
                # TODO: initilize each Trap on the map
                #       using the set_occupant and occupying setter;
                tempString = fp.readline();         
                splitArr = []
                splitArr = re.split('\\s+',tempString)
                trapRow = int(splitArr[0])
                trapCol = int(splitArr[1])
                trap = Trap(trapRow,trapCol)
                initCell = self._map.get_cell(trapRow,trapCol)
                initCell.set_occupant(trap)
                # print(initCell.occupant)
                trap.occupying = initCell

                # END TODO 

            for vno in range(num_of_volcanoes):
                # TODO: initilize each Volcano of the map object 
                #       using the build_cell method 
                #       add each volcano to _actors array 
                tempString = fp.readline();         
                splitArr = []
                splitArr = re.split('\\s+',tempString)
                volcanoRow = int(splitArr[0])
                volcanoCol = int(splitArr[1])
                volconaFreq = int(splitArr[2])
                vol = Volcano(volcanoRow,volcanoCol,volconaFreq)
                self._actors.append(vol)
                self._map.build_cell(volcanoRow,volcanoCol,vol)
                # END TODO 

    def run(self):
        # main rountine of the game
        self.print_info()
        while not self.state():            
            for obj in self._actors:
                if obj.active: 
                    obj.act(self._map)
            self.print_info()
            self.clean_up()
        self.print_result()

    def clean_up(self):
        # TODO: remove all objects in _actors which is not active 
        for it in self._actors:
            if(not it.active):
                self._actors.remove(it)
        # END TODO 

    # check if the game ends and return if the player win or not.
    def state(self):
         # TODO: check if the game ends and 
        #       return an integer for the game status 
        if (self._player.hp <= 0 or self._player.oxygen <= 0):
            return -1
        elif( self._player.row == 0 and self._player.col == self._map.cols -1):
            return 1
        else:
            return 0
        # END TODO 

    def print_info(self):
        self._map.display()
        # TODO: display the remaining oxygen, HP 
        #       and the number of traps surrounding the player 
        trapNum = 0
        cells = []
        cells = self._map.get_neighbours(self._player.row, self._player.col)
        for i in cells:
            occ = i.occupant
            if(occ != None ):
                if(occ.name == "Trap"):
                    trapNum += 1

        print("Oxygen: ",self._player.oxygen,", HP: ",self._player.hp,"Trap:",trapNum)
        

        # END TODO

    def print_result(self):
        if self.state() == 1:
            print('\033[1;33;41mCongrats! You win!\033[0;0m')
        if self.state() == -1:
            print('\033[1;33;41mBad Luck! You lose.\033[0;0m')

        
