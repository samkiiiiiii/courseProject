from Cell import Mountain 

class Volcano(Mountain):
	def __init__(self, row, col, freq):
		Mountain.__init__(self, row, col)
		self._countdown = freq 
		self._frequency = freq
		self._color = '\u001b[41m'
		self._active = True 

	# TODO: _active getter
	@property
	def active(self):
		return self._active
	def act(self,map):
		self._countdown -= 1
		if(self._countdown == 0):
			print("\033[1;33;41mVolcano erupts! \033[0;0m")
			self._countdown = self._frequency
			cells = map.get_neighbours(self._row,self._col)
			for i in range(len(cells)):
				occ = cells[i]._occupant
				if(occ != None):
					if (occ.name == "Goblin"):
						occ.active = False
						occ.occupying.remove_occupant()
					elif(occ.name == "Player"):
						occ.hp = occ.hp - 1

        	# add game logic 
        # END TODO 

	def display(self):
		# TODO: print a colored string representing the Volcano together with countdown information. 
		# print(self._color," \033[2;97m",self._countdown,self._color," \033[0m   ", end='');
  #       print("%s %s%s \033[0m  "%(self._color,self._occupant.display(),self._color),end='')
		# System.out.format("%s \033[2;97m%d%s \033[0m   ", this.color, this.countdown, this.color);
		print("%s \033[2;97m%d%s \033[0m  "%(self._color, self._countdown, self._color),end='');

        # END TODO 