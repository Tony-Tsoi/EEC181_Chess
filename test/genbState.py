def genBoard(num):
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
    if num == '1':
        # Position 1: initial board state, Perft(1) = 20
        ROW8 = [BLACK, ROOK, BLACK, KNIGHT, BLACK, BISHOP, BLACK, QUEEN, BLACK, KING, BLACK, BISHOP, BLACK, KNIGHT, BLACK, ROOK]
        ROW7 = 8 * [BLACK, PAWN]
        ROW6 = 8 * [BLACK, EMPTY]
        ROW5 = 8 * [BLACK, EMPTY]
        ROW4 = 8 * [WHITE, EMPTY]
        ROW3 = 8 * [WHITE, EMPTY]
        ROW2 = 8 * [WHITE, PAWN]
        ROW1 = [WHITE, ROOK, WHITE, KNIGHT, WHITE, BISHOP, WHITE, QUEEN, WHITE, KING, WHITE, BISHOP, WHITE, KNIGHT, WHITE, ROOK]
    
    if num == '2':
        # Position 2: Perft(1) = 48, 8 capt, 2 castl (46 pseudo, no castl)
        ROW8 = [BLACK, ROOK, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, KING, BLACK, EMPTY, BLACK, EMPTY, BLACK, ROOK]
        ROW7 = [BLACK, PAWN, BLACK, EMPTY, BLACK, PAWN, BLACK, PAWN, BLACK, QUEEN, BLACK, PAWN, BLACK, BISHOP, BLACK, EMPTY]
        ROW6 = [BLACK, BISHOP, BLACK, KNIGHT, BLACK, EMPTY, BLACK, EMPTY, BLACK, PAWN, BLACK, KNIGHT, BLACK, PAWN, BLACK, EMPTY]
        ROW5 = [BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, WHITE, PAWN, WHITE, KNIGHT, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY]
        ROW4 = [BLACK, EMPTY, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, PAWN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY]
        ROW3 = [BLACK, EMPTY, BLACK, EMPTY, WHITE, KNIGHT, BLACK, EMPTY, BLACK, EMPTY, WHITE, QUEEN, BLACK, EMPTY, BLACK, PAWN]
        ROW2 = [WHITE, PAWN, WHITE, PAWN, WHITE, PAWN, WHITE, BISHOP, WHITE, BISHOP, WHITE, PAWN, WHITE, PAWN, WHITE, PAWN]
        ROW1 = [WHITE, ROOK, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, WHITE, KING, BLACK, EMPTY, BLACK, EMPTY, WHITE, ROOK]
   
    if num == '3':
        # Position 3: Perft(1) = 14, 1 capt, 2 checks (16 pseudo)
        ROW8 = 8*[BLACK, EMPTY]
        ROW7 = [BLACK, EMPTY, BLACK, EMPTY, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY]
        ROW6 = [BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, PAWN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY]
        ROW5 = [WHITE, KING, WHITE, PAWN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, ROOK]
        ROW4 = [BLACK, EMPTY, WHITE, ROOK, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, PAWN, BLACK, EMPTY, BLACK, KING]
        ROW3 = 8*[BLACK, EMPTY]
        ROW2 = [BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, WHITE, PAWN, BLACK, EMPTY, WHITE, PAWN, BLACK, EMPTY]
        ROW1 = 8*[BLACK, EMPTY]
    
    if num == '4':
        # Position 4: Perft(1) = 6 (38 pseudo)
        ROW8 = [BLACK, ROOK, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, KING, BLACK, EMPTY, BLACK, EMPTY, BLACK, ROOK]
        ROW7 = [WHITE, PAWN, BLACK, PAWN, BLACK, PAWN, BLACK, PAWN, BLACK, EMPTY, BLACK, PAWN, BLACK, PAWN, BLACK, PAWN]
        ROW6 = [BLACK, EMPTY, BLACK, BISHOP, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, KNIGHT, BLACK, BISHOP, WHITE, KNIGHT]
        ROW5 = [BLACK, KNIGHT, WHITE, PAWN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY]
        ROW4 = [WHITE, BISHOP, WHITE, BISHOP, WHITE, PAWN, BLACK, EMPTY, WHITE, PAWN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY]
        ROW3 = [BLACK, QUEEN, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, BLACK, EMPTY, WHITE, KNIGHT, BLACK, EMPTY, BLACK, EMPTY]
        ROW2 = [WHITE, PAWN, BLACK, PAWN, BLACK, EMPTY, WHITE, PAWN, BLACK, EMPTY, BLACK, EMPTY, WHITE, PAWN, WHITE, PAWN]
        ROW1 = [WHITE, ROOK, BLACK, EMPTY, BLACK, EMPTY, WHITE, QUEEN, BLACK, EMPTY, WHITE, ROOK, WHITE, KING, BLACK, EMPTY]
       
    if num == '5':
        # Position 5: only row 1 in default
        ROW8 = 8 * [BLACK, EMPTY]
        ROW7 = 8 * [BLACK, EMPTY]
        ROW6 = 8 * [BLACK, EMPTY]
        ROW5 = 8 * [BLACK, EMPTY]
        ROW4 = 8 * [WHITE, EMPTY]
        ROW3 = 8 * [WHITE, EMPTY] 
        ROW2 = 8 * [WHITE, EMPTY]
        ROW1 = [WHITE, ROOK, WHITE, KNIGHT, WHITE, BISHOP, WHITE, KING, WHITE, QUEEN, WHITE, BISHOP, WHITE, KNIGHT, WHITE, ROOK]
       
    if num == '6':
        # Position 6: only pawns, 16 moves
        ROW8 = 8 * [BLACK, EMPTY]
        ROW7 = 8 * [BLACK, EMPTY]
        ROW6 = 8 * [BLACK, EMPTY]
        ROW5 = 8 * [BLACK, EMPTY]
        ROW4 = 8 * [WHITE, EMPTY]
        ROW3 = 8 * [WHITE, EMPTY] 
        ROW2 = 8 * [WHITE, PAWN]
        ROW1 = 8 * [WHITE, EMPTY]
    
    # construct boardstate
    board = ROW8 + ROW7 + ROW6 + ROW5 + ROW4 + ROW3 + ROW2 + ROW1
    board = ''.join(board)
    return board

def main(num):
    import os
    filename = "./../simulation/bstate.txt"
    try:
        os.remove(filename)
    except Exception: pass
    
    g = open(filename, 'w')
    g.write(genBoard(num))
    g.close()

if __name__ == "__main__":
    import sys
    args = len(sys.argv) - 1
    num = '6'
    if args > 0:
        num = sys.argv[1]
    main(num)