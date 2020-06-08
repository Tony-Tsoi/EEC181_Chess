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
       
    if num == '7':
        # Position 7: En passant 1, enp_flags = 8'haa, moves = 4/11
        ROW8 = 8 * [BLACK, EMPTY]
        ROW7 = 8 * [BLACK, EMPTY]
        ROW6 = 8 * [BLACK, EMPTY]
        ROW5 = 4 * [WHITE, PAWN, BLACK, PAWN]
        ROW4 = 8 * [WHITE, EMPTY]
        ROW3 = 8 * [WHITE, EMPTY] 
        ROW2 = 8 * [WHITE, EMPTY]
        ROW1 = 8 * [WHITE, EMPTY]
    
    if num == '8':
        # Position 8: En passant 2, enp_flags = 8'h55, moves = 4/11
        ROW8 = 8 * [BLACK, EMPTY]
        ROW7 = 8 * [BLACK, EMPTY]
        ROW6 = 8 * [BLACK, EMPTY]
        ROW5 = 4 * [BLACK, PAWN, WHITE, PAWN]
        ROW4 = 8 * [WHITE, EMPTY]
        ROW3 = 8 * [WHITE, EMPTY] 
        ROW2 = 8 * [WHITE, EMPTY]
        ROW1 = 8 * [WHITE, EMPTY]
    
    if num == '9':
        # Position 9: No en passants, enp_flags = 8'hff, moves = 8/8
        ROW8 = 8 * [BLACK, EMPTY]
        ROW7 = 8 * [BLACK, EMPTY]
        ROW6 = 8 * [BLACK, EMPTY]
        ROW5 = 8 * [WHITE, PAWN]
        ROW4 = 8 * [WHITE, EMPTY]
        ROW3 = 8 * [WHITE, EMPTY] 
        ROW2 = 8 * [WHITE, EMPTY]
        ROW1 = 8 * [WHITE, EMPTY]
    
    # construct boardstate
    # reverse each item in row
    R8R1 = [ROW8[14], ROW8[15], ROW8[12], ROW8[13], ROW8[10], ROW8[11], ROW8[8], ROW8[9]]
    R8R2 = [ROW8[6], ROW8[7], ROW8[4], ROW8[5], ROW8[2], ROW8[3], ROW8[0], ROW8[1]]
    R7R1 = [ROW7[14], ROW7[15], ROW7[12], ROW7[13], ROW7[10], ROW7[11], ROW7[8], ROW7[9]]
    R7R2 = [ROW7[6], ROW7[7], ROW7[4], ROW7[5], ROW7[2], ROW7[3], ROW7[0], ROW7[1]]
    R6R1 = [ROW6[14], ROW6[15], ROW6[12], ROW6[13], ROW6[10], ROW6[11], ROW6[8], ROW6[9]]
    R6R2 = [ROW6[6], ROW6[7], ROW6[4], ROW6[5], ROW6[2], ROW6[3], ROW6[0], ROW6[1]]
    R5R1 = [ROW5[14], ROW5[15], ROW5[12], ROW5[13], ROW5[10], ROW5[11], ROW5[8], ROW5[9]]
    R5R2 = [ROW5[6], ROW5[7], ROW5[4], ROW5[5], ROW5[2], ROW5[3], ROW5[0], ROW5[1]]
    R4R1 = [ROW4[14], ROW4[15], ROW4[12], ROW4[13], ROW4[10], ROW4[11], ROW4[8], ROW4[9]]
    R4R2 = [ROW4[6], ROW4[7], ROW4[4], ROW4[5], ROW4[2], ROW4[3], ROW4[0], ROW4[1]]
    R3R1 = [ROW3[14], ROW3[15], ROW3[12], ROW3[13], ROW3[10], ROW3[11], ROW3[8], ROW3[9]]
    R3R2 = [ROW3[6], ROW3[7], ROW3[4], ROW3[5], ROW3[2], ROW3[3], ROW3[0], ROW3[1]]
    R2R1 = [ROW2[14], ROW2[15], ROW2[12], ROW2[13], ROW2[10], ROW2[11], ROW2[8], ROW2[9]]
    R2R2 = [ROW2[6], ROW2[7], ROW2[4], ROW2[5], ROW2[2], ROW2[3], ROW2[0], ROW2[1]]
    R1R1 = [ROW1[14], ROW1[15], ROW1[12], ROW1[13], ROW1[10], ROW1[11], ROW1[8], ROW1[9]]
    R1R2 = [ROW1[6], ROW1[7], ROW1[4], ROW1[5], ROW1[2], ROW1[3], ROW1[0], ROW1[1]]
    
    board = R8R1 + R8R2 + R7R1 + R7R2 + R6R1 + R6R2 + R5R1 + R5R2 + R4R1 + R4R2 + R3R1 + R3R2 + R2R1 + R2R2 + R1R1 + R1R2
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