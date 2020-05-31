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
    
    # Construct board by rows
    ROW8 = [BLACK, ROOK, BLACK, KNIGHT, BLACK, BISHOP, BLACK, QUEEN, BLACK, KING, BLACK, BISHOP, BLACK, KNIGHT, BLACK, ROOK]
    ROW7 = 8 * [BLACK, PAWN]
    ROW6 = 8 * [BLACK, EMPTY]
    ROW5 = 8 * [BLACK, EMPTY]
    ROW4 = 8 * [WHITE, EMPTY]
    ROW3 = 8 * [WHITE, EMPTY]
    ROW2 = 8 * [WHITE, PAWN]
    ROW1 = [WHITE, ROOK, WHITE, KNIGHT, WHITE, BISHOP, WHITE, QUEEN, WHITE, KING, WHITE, BISHOP, WHITE, KNIGHT, WHITE, ROOK]
    
    # construct boardstate
    board = ROW1 + ROW2 + ROW3 + ROW4 + ROW5 + ROW6 + ROW7 + ROW8
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