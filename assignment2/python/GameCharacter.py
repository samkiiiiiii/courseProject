from abc import ABCMeta
from abc import abstractmethod

class GameCharacter(metaclass=ABCMeta):
    def __init__(self, row, col):
        self._row = row
        self._col = col
        self._occupying = None
        self._name = None
        self._active = True
        self._character = None 
        self._color = '\033[1;31m'
    
    #TODO: name getter
    @property
    def name(self):
        return self._name
    
    @name.setter
    def name(self,name):
        self._name = name 
    
    #TODO: row getter
    @property
    def row(self):
        return self._row

    @row.setter
    def row(self,row):
        self._row = row

    #TODO: col getter
    @property
    def col(self):
        return self._col
    @col.setter
    def col(self,col):
        self._col = col
    
    #TODO: active getter and setter
    @property
    def active(self):
        return self._active

    @active.setter
    def active(self,active):
        self._active = active

    #TODO: occupying getter and setter
    @property
    def occupying(self):
        return self._occupying

    @occupying.setter
    def occupying(self,occupying):
        self._occupying = occupying 

    def cmd_to_pos(self, char):
        next_pos = [self._row, self._col]
        if char == 'L':
            next_pos[1] -= 1
        elif char == 'R':
            next_pos[1] += 1
        elif char == 'U':
            next_pos[0] -= 1
        elif char == 'D':
            next_pos[0] += 1
        else:
            print('Invalid Move.')
        return next_pos

    @abstractmethod
    def act(self, map):
        pass

    @abstractmethod
    def interact_with(self, comer):
        pass
    
    def display(self):
        # TODO: return _color followed by _character for displaying 
        return "%s%s"%(self._color,self._character)
        # END TODO 


class Player(GameCharacter):
    def __init__(self, row, col, h, o):
        GameCharacter.__init__(self, row, col)
        self._valid_actions = ['U', 'D', 'R', 'L']
        self._hp = h
        self._oxygen = o
        self._name = 'Player'
        self._character = 'A'

    #TODO: hp getter and setter
    @property
    def hp(self):
        return self._hp

    @hp.setter
    def hp(self,hp):
        self._hp = hp

    #TODO: oxygen getter and setter
    @property
    def oxygen(self):
        return self._oxygen

    @oxygen.setter
    def oxygen(self,oxygen):
        self._oxygen = oxygen


    def act(self, map):
        next_cell = None
        next_pos = [0, 0]
        while next_cell == None:
            #todo
            correctAct = False
            while (not correctAct):
                action = input("Next move (U, D, R, L): ".format(self._row, self._col))
                nextAct = action[0]
                # print("check length",len(self._valid_actions))
                for i in range(len(self._valid_actions)):
                    if(self._valid_actions[i] == nextAct):
                        correctAct = True
                        break
                if(len(action) > 1):
                    correctAct = False
                if(not correctAct):
                    print("Invalid command. Please enter one of {U, D, R, L}.", );
                else:
                    next_pos = self.cmd_to_pos(nextAct)
            next_cell = map.get_cell(next_pos[0],next_pos[1])
            if(next_cell != None and next_cell.set_occupant(self)):
                self._row = next_pos[0]
                self._col = next_pos[1]
                self._oxygen -= self._occupying.hours;
                self._occupying.remove_occupant()
                self.occupying =next_cell

            else:
                next_cell = None
            # END TODO 

    # return whether comer entering the cell successfully or not
    def interact_with(self, comer):
        if comer.name == 'Goblin':
            print('\033[1;31;46mPlayer meets a Goblin! Player\'s HP - ',comer.damage,'.\033[0m' )
             # TODO: interact_with method 
            self.hp -= comer.damage
            comer.active = False
            return False
        return False
            # END TODO 


class Goblin(GameCharacter):
    def __init__(self, row, col, actions):
        GameCharacter.__init__(self, row, col)
        self._actions = actions
        self._cur_act = 0
        self._damage = 1
        self._name = 'Goblin'
        self._character = 'G'

    #TODO: damage getter
    @property 
    def damage(self):
        return self._damage

    @damage.setter
    def damage(self,damage):
        self._damage = damage

    def act(self, map):
        # TODO: act method of a Goblin 
        # get the next cell according to _actions and _cur_act
        nextMove = self._actions[self._cur_act % len(self._actions)]
        nextPos = self.cmd_to_pos(nextMove)
        nextCell = map.get_cell(nextPos[0],nextPos[1])
        self._cur_act += 1
        if (nextCell != None and nextCell.set_occupant(self)):
            self.row = nextPos[0]
            self.col = nextPos[1]
    
            self.occupying.remove_occupant()
            self.occupying=nextCell
            print("\033[1;31;46mGoblin enters the cell (",self._row,self._col,").\033[0;0m" )
        if (not self.active):
            print("\033[1;31;46mGoblin dies right after the movement.\033[0;0m")
            self.occupying = None      # END TODO 

    # return whether comer entering the cell successfully or not
    def interact_with(self, comer):
        if comer.name == 'Player':
            print(
                "\033[1;31;46mA goblin at cell (%d, %d) meets Player. The goblin died. Player' s HP - 1.\033[0;0m]"%(self.row,self.col))
            
            # TODO: update properties of the player and the Goblin 
            #       return whether the Player successfully enter the cell 
            comer.hp = comer.hp - self._damage
            self.active = False
            return True
        return False
            # END TODO
