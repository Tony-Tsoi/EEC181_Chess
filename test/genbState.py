def genBoard():
    # Constants
    WHITE = '0'
    BLACK = '1'
    EMPTY = '000'
    PAWN = '001'
    KNIGHT = '010'
    BISHOP = '011'
    ROOK = '100'
    QUEEN = '101'
    KING = '110'
    
    # Construct board by cols
    COL8 = [BLACK, ROOK,   BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, ROOK]
    COL7 = [BLACK, KNIGHT, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, KNIGHT]
    COL6 = [BLACK, BISHOP, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, BISHOP]
    COL5 = [BLACK, KING,   BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, KING]
    COL4 = [BLACK, QUEEN,  BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, QUEEN]
    COL3 = [BLACK, BISHOP, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, BISHOP]    
    COL2 = [BLACK, KNIGHT, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, KNIGHT]
    COL1 = [BLACK, ROOK,   BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, EMPTY, WHITE, EMPTY, WHITE, PAWN, WHITE, ROOK]
    
    # construct boardstate
    board = COL8 + COL7 + COL6 + COL5 + COL4 + COL3 + COL2 + COL1
    board = ''.join(board)
    return board

def main():
    import os
    filename = "./../simulation/bstate.txt"
    try:
        os.remove(filename)
    except Exception: pass
    
    g = open(filename, 'w')
    g.write(genBoard())
    g.close()

if __name__ == "__main__":
    main()