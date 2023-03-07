from Cell import Cell


class Map:
    def __init__(self, height, width):
        self._rows = height
        self._cols = width
        self._cells = [[Cell() for x in range(width)] for y in range(height)]
    
    #TODO: rows getter
    @property
    def rows(self):
        return self._rows
    #TODO: cols getter
    @property
    def cols(self):
        return self._cols
        
    def get_cell(self, row, col):
        # TODO: check whether the position is out of boundary 
        #       if not, return the cell at (row, col)
        #       return None otherwise 
        if (row < 0 or row >= self._rows or col < 0 or col >= self._cols): 
            print('\033[1;31;46mNext move is out of boundary!\033[0;0m')
            return None 
        else:
            # return a cell 
            return self._cells[row][col]
        # END TODO 

    def build_cell(self, row, col, cell):
        # TODO: check whether the position is out of boundary 
        #       if not, add a cell (row, col) and return True
        #       return False otherwise 
        if (not (row >= 0 and row < self._rows and col >= 0 and col< self._cols)): 
      
            print('\033[1;31;46mThe position (',row, col,') is out of boundary!\033[0;0m')
            return False 
        else:
            # add a cell
            self._cells[row][col] = cell
            return True 
        # END TODO

    # # return a list of cells which are neighbours of cell (row, col) 
    def get_neighbours(self, row, col):
        returnCells = []
        for i in range(max(0,row-1),min(row + 1, self._rows - 1)+1):
            for j in range(max(0,col -1), min(col+1, self._cols -1)):
                # print("inside ",self._cells[i][j].occupant)
                returnCells.append(self._cells[i][j])
        return returnCells
        

    def display(self):
        # TODO: print the map by calling diplay of each cell 
        print("   ",end='')
        for i in range(0, self._cols):
            print("%d    "%i,end='')
        print("\n")
        for i in range(0, self._rows):
            print("%d "%i,end='')
            for j in range(0, self._cols):
                self._cells[i][j].display()
            print("\n\n",end='')
        # END TODO
