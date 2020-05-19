`define W_PAWN 4'b0001  //input encoding that represents each piece
`define W_KNIGHT 4'b0010
`define W_BISHOP 4'b0011
`define W_ROOK 4'b0100
`define W_QUEEN 4'b0101
`define W_KING 4'b0110
`define B_PAWN 4'b1001
`define B_KNIGHT 4'b1010
`define B_BISHOP 4'b1011
`define B_ROOK 4'b1100
`define B_QUEEN 4'b1101
`define B_KING 4'b1110

`define PAWN_VALUE 100 //base value of each piece
`define KNIGHT_VALUE 300
`define BISHOP_VALUE 300
`define ROOK_VALUE 500
`define QUEEN_VALUE 900
`define KING_VALUE 2000

`timescale 1ns/10ps

module BoardEvaluation(
	input [255:0] boardIn, //state of the chess board, an 8x8 array of 4 bit numbers
	input start,
	input clk,
	output signed [13:0] score //sum of all of the pieces + positional values
);

wire [3:0] board [63:0]; //sorts the board input into a 64 entry array
reg signed [11:0] squareScore[63:0];
wire [383:0] pawnMap;
wire [383:0] knightMap;
wire [383:0] bishopMap;
wire [383:0] rookMap;
wire [383:0] queenMap;
wire [383:0] kingMap;
reg signed [13:0] totalScore;
reg signed [13:0] totalScore_c;
wire signed [11:0] pawnValueSigned;
wire signed [11:0] knightValueSigned;
wire signed [11:0] bishopValueSigned;
wire signed [11:0] rookValueSigned;
wire signed [11:0] queenValueSigned;
wire signed [11:0] kingValueSigned;

/*parameter `PAWN_VALUE = 100; //base value of each piece
parameter `KNIGHT_VALUE = 300;
parameter `BISHOP_VALUE = 300;
parameter `ROOK_VALUE = 500;
parameter `QUEEN_VALUE = 900;
parameter `KING_VALUE = 2000;*/

PawnMapROM	PawnMapROMA(//ROM's that contain the positional modifiers for each piece type
       .dataOut(pawnMap)
       );
KnightMapROM	KnightMapROMA(
       .dataOut(knightMap)
       );
BishopMapROM	BishopMapROMA(
       .dataOut(bishopMap)
       );
RookMapROM	RookMapROMA(
       .dataOut(rookMap)
       );
QueenMapROM QueenMapROMA(
       .dataOut(queenMap)
       );
KingMapROM	KingMapROMA(
       .dataOut(kingMap)
       );

assign score = totalScore;	
assign pawnValueSigned = `PAWN_VALUE;	 
assign knightValueSigned = `KNIGHT_VALUE;
assign bishopValueSigned = `BISHOP_VALUE;
assign rookValueSigned = `ROOK_VALUE;
assign queenValueSigned = `QUEEN_VALUE;
assign kingValueSigned = `KING_VALUE;
assign board[0] = boardIn[3:0];
assign board[1] = boardIn[7:4];
assign board[2] = boardIn[11:8];
assign board[3] = boardIn[15:12];
assign board[4] = boardIn[19:16];
assign board[5] = boardIn[23:20];
assign board[6] = boardIn[27:24];
assign board[7] = boardIn[31:28];
assign board[8] = boardIn[35:32];
assign board[9] = boardIn[39:36];
assign board[10] = boardIn[43:40];
assign board[11] = boardIn[47:44];
assign board[12] = boardIn[51:48];
assign board[13] = boardIn[55:52];
assign board[14] = boardIn[59:56];
assign board[15] = boardIn[63:60];
assign board[16] = boardIn[67:64];
assign board[17] = boardIn[71:68];
assign board[18] = boardIn[75:72];
assign board[19] = boardIn[79:76];
assign board[20] = boardIn[83:80];
assign board[21] = boardIn[87:84];
assign board[22] = boardIn[91:88];
assign board[23] = boardIn[95:92];
assign board[24] = boardIn[99:96];
assign board[25] = boardIn[103:100];
assign board[26] = boardIn[107:104];
assign board[27] = boardIn[111:108];
assign board[28] = boardIn[115:112];
assign board[29] = boardIn[119:116];
assign board[30] = boardIn[123:120];
assign board[31] = boardIn[127:124];
assign board[32] = boardIn[131:128];
assign board[33] = boardIn[135:132];
assign board[34] = boardIn[139:136];
assign board[35] = boardIn[143:140];
assign board[36] = boardIn[147:144];
assign board[37] = boardIn[151:148];
assign board[38] = boardIn[155:152];
assign board[39] = boardIn[159:156];
assign board[40] = boardIn[163:160];
assign board[41] = boardIn[167:164];
assign board[42] = boardIn[171:168];
assign board[43] = boardIn[175:172];
assign board[44] = boardIn[179:176];
assign board[45] = boardIn[183:180];
assign board[46] = boardIn[187:184];
assign board[47] = boardIn[191:188];
assign board[48] = boardIn[195:192];
assign board[49] = boardIn[199:196];
assign board[50] = boardIn[203:200];
assign board[51] = boardIn[207:204];
assign board[52] = boardIn[211:208];
assign board[53] = boardIn[215:212];
assign board[54] = boardIn[219:216];
assign board[55] = boardIn[223:220];
assign board[56] = boardIn[227:224];
assign board[57] = boardIn[231:228];
assign board[58] = boardIn[235:232];
assign board[59] = boardIn[239:236];
assign board[60] = boardIn[243:240];
assign board[61] = boardIn[247:244];
assign board[62] = boardIn[251:248];
assign board[63] = boardIn[255:252];


always @(*) begin
	squareScore[0] = squareScore[0];
	squareScore[1] = squareScore[1];
	squareScore[2] = squareScore[2];
	squareScore[3] = squareScore[3];
	squareScore[4] = squareScore[4];
	squareScore[5] = squareScore[5];
	squareScore[6] = squareScore[6];
	squareScore[7] = squareScore[7];
	squareScore[8] = squareScore[8];
	squareScore[9] = squareScore[9];
	squareScore[10] = squareScore[10];
	squareScore[11] = squareScore[11];
	squareScore[12] = squareScore[12];
	squareScore[13] = squareScore[13];
	squareScore[14] = squareScore[14];
	squareScore[15] = squareScore[15];
	squareScore[16] = squareScore[16];
	squareScore[17] = squareScore[17];
	squareScore[18] = squareScore[18];
	squareScore[19] = squareScore[19];
	squareScore[20] = squareScore[20];
	squareScore[21] = squareScore[21];
	squareScore[22] = squareScore[22];
	squareScore[23] = squareScore[23];
	squareScore[24] = squareScore[24];
	squareScore[25] = squareScore[25];
	squareScore[26] = squareScore[26];
	squareScore[27] = squareScore[27];
	squareScore[28] = squareScore[28];
	squareScore[29] = squareScore[29];
	squareScore[30] = squareScore[30];
	squareScore[31] = squareScore[31];
	squareScore[32] = squareScore[32];
	squareScore[33] = squareScore[33];
	squareScore[34] = squareScore[34];
	squareScore[35] = squareScore[35];
	squareScore[36] = squareScore[36];
	squareScore[37] = squareScore[37];
	squareScore[38] = squareScore[38];
	squareScore[39] = squareScore[39];
	squareScore[40] = squareScore[40];
	squareScore[41] = squareScore[41];
	squareScore[42] = squareScore[42];
	squareScore[43] = squareScore[43];
	squareScore[44] = squareScore[44];
	squareScore[45] = squareScore[45];
	squareScore[46] = squareScore[46];
	squareScore[47] = squareScore[47];
	squareScore[48] = squareScore[48];
	squareScore[49] = squareScore[49];
	squareScore[50] = squareScore[50];
	squareScore[51] = squareScore[51];
	squareScore[52] = squareScore[52];
	squareScore[53] = squareScore[53];
	squareScore[54] = squareScore[54];
	squareScore[55] = squareScore[55];
	squareScore[56] = squareScore[56];
	squareScore[57] = squareScore[57];
	squareScore[58] = squareScore[58];
	squareScore[59] = squareScore[59];
	squareScore[60] = squareScore[60];
	squareScore[61] = squareScore[61];
	squareScore[62] = squareScore[62];
	squareScore[63] = squareScore[63];

	if(start == 1) begin
		
		case (board[0]) //square 0
			`W_PAWN: squareScore[0] = pawnValueSigned + $signed(pawnMap[5:0]);
			`W_KNIGHT: squareScore[0] = knightValueSigned + $signed(knightMap[5:0]);
			`W_BISHOP: squareScore[0] = bishopValueSigned + $signed(bishopMap[5:0]);
			`W_ROOK: squareScore[0] = rookValueSigned + $signed(rookMap[5:0]);
			`W_QUEEN: squareScore[0] = queenValueSigned + $signed(queenMap[5:0]);
			`W_KING: squareScore[0] = kingValueSigned + $signed(kingMap[5:0]);
			`B_PAWN: squareScore[0] = -1 * (pawnValueSigned + $signed(pawnMap[383:378]));
			`B_KNIGHT: squareScore[0] = -1 * (knightValueSigned + $signed(knightMap[383:378]));
			`B_BISHOP: squareScore[0] = -1 * (bishopValueSigned + $signed(bishopMap[383:378]));
			`B_ROOK: squareScore[0] = -1 * (rookValueSigned + $signed(rookMap[383:378]));
			`B_QUEEN: squareScore[0] = -1 * (queenValueSigned + $signed(queenMap[383:378]));
			`B_KING: squareScore[0] = -1 * (kingValueSigned + $signed(kingMap[383:378]));
			default: squareScore[0] = 0;
		endcase
		
		case (board[1]) //square 1
			`W_PAWN: squareScore[1] = pawnValueSigned + $signed(pawnMap[11:6]);
			`W_KNIGHT: squareScore[1] = knightValueSigned + $signed(knightMap[11:6]);
			`W_BISHOP: squareScore[1] = bishopValueSigned + $signed(bishopMap[11:6]);
			`W_ROOK: squareScore[1] = rookValueSigned + $signed(rookMap[11:6]);
			`W_QUEEN: squareScore[1] = queenValueSigned + $signed(queenMap[11:6]);
			`W_KING: squareScore[1] = kingValueSigned + $signed(kingMap[11:6]);
			`B_PAWN: squareScore[1] = -1 * (pawnValueSigned + $signed(pawnMap[377:372]));
			`B_KNIGHT: squareScore[1] = -1 * (knightValueSigned + $signed(knightMap[377:372]));
			`B_BISHOP: squareScore[1] = -1 * (bishopValueSigned + $signed(bishopMap[377:372]));
			`B_ROOK: squareScore[1] = -1 * (rookValueSigned + $signed(rookMap[377:372]));
			`B_QUEEN: squareScore[1] = -1 * (queenValueSigned + $signed(queenMap[377:372]));
			`B_KING: squareScore[1] = -1 * (kingValueSigned + $signed(kingMap[377:372]));
			default: squareScore[1] = 0;
		endcase
		
		case (board[2]) //square 2
			`W_PAWN: squareScore[2] = pawnValueSigned + $signed(pawnMap[17:12]);
			`W_KNIGHT: squareScore[2] = knightValueSigned + $signed(knightMap[17:12]);
			`W_BISHOP: squareScore[2] = bishopValueSigned + $signed(bishopMap[17:12]);
			`W_ROOK: squareScore[2] = rookValueSigned + $signed(rookMap[17:12]);
			`W_QUEEN: squareScore[2] = queenValueSigned + $signed(queenMap[17:12]);
			`W_KING: squareScore[2] = kingValueSigned + $signed(kingMap[17:12]);
			`B_PAWN: squareScore[2] = -1 * (pawnValueSigned + $signed(pawnMap[371:366]));
			`B_KNIGHT: squareScore[2] = -1 * (knightValueSigned + $signed(knightMap[371:366]));
			`B_BISHOP: squareScore[2] = -1 * (bishopValueSigned + $signed(bishopMap[371:366]));
			`B_ROOK: squareScore[2] = -1 * (rookValueSigned + $signed(rookMap[371:366]));
			`B_QUEEN: squareScore[2] = -1 * (queenValueSigned + $signed(queenMap[371:366]));
			`B_KING: squareScore[2] = -1 * (kingValueSigned + $signed(kingMap[371:366]));
			default: squareScore[2] = 0;
		endcase
		
		case (board[3]) //square 3
			`W_PAWN: squareScore[3] = pawnValueSigned + $signed(pawnMap[23:18]);
			`W_KNIGHT: squareScore[3] = knightValueSigned + $signed(knightMap[23:18]);
			`W_BISHOP: squareScore[3] = bishopValueSigned + $signed(bishopMap[23:18]);
			`W_ROOK: squareScore[3] = rookValueSigned + $signed(rookMap[23:18]);
			`W_QUEEN: squareScore[3] = queenValueSigned + $signed(queenMap[23:18]);
			`W_KING: squareScore[3] = kingValueSigned + $signed(kingMap[23:18]);
			`B_PAWN: squareScore[3] = -1 * (pawnValueSigned + $signed(pawnMap[365:360]));
			`B_KNIGHT: squareScore[3] = -1 * (knightValueSigned + $signed(knightMap[365:360]));
			`B_BISHOP: squareScore[3] = -1 * (bishopValueSigned + $signed(bishopMap[365:360]));
			`B_ROOK: squareScore[3] = -1 * (rookValueSigned + $signed(rookMap[365:360]));
			`B_QUEEN: squareScore[3] = -1 * (queenValueSigned + $signed(queenMap[365:360]));
			`B_KING: squareScore[3] = -1 * (kingValueSigned + $signed(kingMap[365:360]));
			default: squareScore[3] = 0;
		endcase
		
		case (board[4]) //square 4
			`W_PAWN: squareScore[4] = pawnValueSigned + $signed(pawnMap[29:24]);
			`W_KNIGHT: squareScore[4] = knightValueSigned + $signed(knightMap[29:24]);
			`W_BISHOP: squareScore[4] = bishopValueSigned + $signed(bishopMap[29:24]);
			`W_ROOK: squareScore[4] = rookValueSigned + $signed(rookMap[29:24]);
			`W_QUEEN: squareScore[4] = queenValueSigned + $signed(queenMap[29:24]);
			`W_KING: squareScore[4] = kingValueSigned + $signed(kingMap[29:24]);
			`B_PAWN: squareScore[4] = -1 * (pawnValueSigned + $signed(pawnMap[359:354]));
			`B_KNIGHT: squareScore[4] = -1 * (knightValueSigned + $signed(knightMap[359:354]));
			`B_BISHOP: squareScore[4] = -1 * (bishopValueSigned + $signed(bishopMap[359:354]));
			`B_ROOK: squareScore[4] = -1 * (rookValueSigned + $signed(rookMap[359:354]));
			`B_QUEEN: squareScore[4] = -1 * (queenValueSigned + $signed(queenMap[359:354]));
			`B_KING: squareScore[4] = -1 * (kingValueSigned + $signed(kingMap[359:354]));
			default: squareScore[4] = 0;
		endcase
		
		case (board[5]) //square 5
			`W_PAWN: squareScore[5] = pawnValueSigned + $signed(pawnMap[35:30]);
			`W_KNIGHT: squareScore[5] = knightValueSigned + $signed(knightMap[35:30]);
			`W_BISHOP: squareScore[5] = bishopValueSigned + $signed(bishopMap[35:30]);
			`W_ROOK: squareScore[5] = rookValueSigned + $signed(rookMap[35:30]);
			`W_QUEEN: squareScore[5] = queenValueSigned + $signed(queenMap[35:30]);
			`W_KING: squareScore[5] = kingValueSigned + $signed(kingMap[35:30]);
			`B_PAWN: squareScore[5] = -1 * (pawnValueSigned + $signed(pawnMap[353:348]));
			`B_KNIGHT: squareScore[5] = -1 * (knightValueSigned + $signed(knightMap[353:348]));
			`B_BISHOP: squareScore[5] = -1 * (bishopValueSigned + $signed(bishopMap[353:348]));
			`B_ROOK: squareScore[5] = -1 * (rookValueSigned + $signed(rookMap[353:348]));
			`B_QUEEN: squareScore[5] = -1 * (queenValueSigned + $signed(queenMap[353:348]));
			`B_KING: squareScore[5] = -1 * (kingValueSigned + $signed(kingMap[353:348]));
			default: squareScore[5] = 0;
		endcase
		
		case (board[6]) //square 6
			`W_PAWN: squareScore[6] = pawnValueSigned + $signed(pawnMap[41:36]);
			`W_KNIGHT: squareScore[6] = knightValueSigned + $signed(knightMap[41:36]);
			`W_BISHOP: squareScore[6] = bishopValueSigned + $signed(bishopMap[41:36]);
			`W_ROOK: squareScore[6] = rookValueSigned + $signed(rookMap[41:36]);
			`W_QUEEN: squareScore[6] = queenValueSigned + $signed(queenMap[41:36]);
			`W_KING: squareScore[6] = kingValueSigned + $signed(kingMap[41:36]);
			`B_PAWN: squareScore[6] = -1 * (pawnValueSigned + $signed(pawnMap[347:342]));
			`B_KNIGHT: squareScore[6] = -1 * (knightValueSigned + $signed(knightMap[347:342]));
			`B_BISHOP: squareScore[6] = -1 * (bishopValueSigned + $signed(bishopMap[347:342]));
			`B_ROOK: squareScore[6] = -1 * (rookValueSigned + $signed(rookMap[347:342]));
			`B_QUEEN: squareScore[6] = -1 * (queenValueSigned + $signed(queenMap[347:342]));
			`B_KING: squareScore[6] = -1 * (kingValueSigned + $signed(kingMap[347:342]));
			default: squareScore[6] = 0;
		endcase
		
		case (board[7]) //square 7
			`W_PAWN: squareScore[7] = pawnValueSigned + $signed(pawnMap[47:42]);
			`W_KNIGHT: squareScore[7] = knightValueSigned + $signed(knightMap[47:42]);
			`W_BISHOP: squareScore[7] = bishopValueSigned + $signed(bishopMap[47:42]);
			`W_ROOK: squareScore[7] = rookValueSigned + $signed(rookMap[47:42]);
			`W_QUEEN: squareScore[7] = queenValueSigned + $signed(queenMap[47:42]);
			`W_KING: squareScore[7] = kingValueSigned + $signed(kingMap[47:42]);
			`B_PAWN: squareScore[7] = -1 * (pawnValueSigned + $signed(pawnMap[341:336]));
			`B_KNIGHT: squareScore[7] = -1 * (knightValueSigned + $signed(knightMap[341:336]));
			`B_BISHOP: squareScore[7] = -1 * (bishopValueSigned + $signed(bishopMap[341:336]));
			`B_ROOK: squareScore[7] = -1 * (rookValueSigned + $signed(rookMap[341:336]));
			`B_QUEEN: squareScore[7] = -1 * (queenValueSigned + $signed(queenMap[341:336]));
			`B_KING: squareScore[7] = -1 * (kingValueSigned + $signed(kingMap[341:336]));
			default: squareScore[7] = 0;
		endcase
		
		case (board[8]) //square 8
			`W_PAWN: squareScore[8] = pawnValueSigned + $signed(pawnMap[53:48]);
			`W_KNIGHT: squareScore[8] = knightValueSigned + $signed(knightMap[53:48]);
			`W_BISHOP: squareScore[8] = bishopValueSigned + $signed(bishopMap[53:48]);
			`W_ROOK: squareScore[8] = rookValueSigned + $signed(rookMap[53:48]);
			`W_QUEEN: squareScore[8] = queenValueSigned + $signed(queenMap[53:48]);
			`W_KING: squareScore[8] = kingValueSigned + $signed(kingMap[53:48]);
			`B_PAWN: squareScore[8] = -1 * (pawnValueSigned + $signed(pawnMap[335:330]));
			`B_KNIGHT: squareScore[8] = -1 * (knightValueSigned + $signed(knightMap[335:330]));
			`B_BISHOP: squareScore[8] = -1 * (bishopValueSigned + $signed(bishopMap[335:330]));
			`B_ROOK: squareScore[8] = -1 * (rookValueSigned + $signed(rookMap[335:330]));
			`B_QUEEN: squareScore[8] = -1 * (queenValueSigned + $signed(queenMap[335:330]));
			`B_KING: squareScore[8] = -1 * (kingValueSigned + $signed(kingMap[335:330]));
			default: squareScore[8] = 0;
		endcase
		
		case (board[9]) //square 9
			`W_PAWN: squareScore[9] = pawnValueSigned + $signed(pawnMap[59:54]);
			`W_KNIGHT: squareScore[9] = knightValueSigned + $signed(knightMap[59:54]);
			`W_BISHOP: squareScore[9] = bishopValueSigned + $signed(bishopMap[59:54]);
			`W_ROOK: squareScore[9] = rookValueSigned + $signed(rookMap[59:54]);
			`W_QUEEN: squareScore[9] = queenValueSigned + $signed(queenMap[59:54]);
			`W_KING: squareScore[9] = kingValueSigned + $signed(kingMap[59:54]);
			`B_PAWN: squareScore[9] = -1 * (pawnValueSigned + $signed(pawnMap[329:324]));
			`B_KNIGHT: squareScore[9] = -1 * (knightValueSigned + $signed(knightMap[329:324]));
			`B_BISHOP: squareScore[9] = -1 * (bishopValueSigned + $signed(bishopMap[329:324]));
			`B_ROOK: squareScore[9] = -1 * (rookValueSigned + $signed(rookMap[329:324]));
			`B_QUEEN: squareScore[9] = -1 * (queenValueSigned + $signed(queenMap[329:324]));
			`B_KING: squareScore[9] = -1 * (kingValueSigned + $signed(kingMap[329:324]));
			default: squareScore[9] = 0;
		endcase
		
		case (board[10]) //square 10
			`W_PAWN: squareScore[10] = pawnValueSigned + $signed(pawnMap[65:60]);
			`W_KNIGHT: squareScore[10] = knightValueSigned + $signed(knightMap[65:60]);
			`W_BISHOP: squareScore[10] = bishopValueSigned + $signed(bishopMap[65:60]);
			`W_ROOK: squareScore[10] = rookValueSigned + $signed(rookMap[65:60]);
			`W_QUEEN: squareScore[10] = queenValueSigned + $signed(queenMap[65:60]);
			`W_KING: squareScore[10] = kingValueSigned + $signed(kingMap[65:60]);
			`B_PAWN: squareScore[10] = -1 * (pawnValueSigned + $signed(pawnMap[323:318]));
			`B_KNIGHT: squareScore[10] = -1 * (knightValueSigned + $signed(knightMap[323:318]));
			`B_BISHOP: squareScore[10] = -1 * (bishopValueSigned + $signed(bishopMap[323:318]));
			`B_ROOK: squareScore[10] = -1 * (rookValueSigned + $signed(rookMap[323:318]));
			`B_QUEEN: squareScore[10] = -1 * (queenValueSigned + $signed(queenMap[323:318]));
			`B_KING: squareScore[10] = -1 * (kingValueSigned + $signed(kingMap[323:318]));
			default: squareScore[10] = 0;
		endcase
		
		case (board[11]) //square 11
			`W_PAWN: squareScore[11] = pawnValueSigned + $signed(pawnMap[71:66]);
			`W_KNIGHT: squareScore[11] = knightValueSigned + $signed(knightMap[71:66]);
			`W_BISHOP: squareScore[11] = bishopValueSigned + $signed(bishopMap[71:66]);
			`W_ROOK: squareScore[11] = rookValueSigned + $signed(rookMap[71:66]);
			`W_QUEEN: squareScore[11] = queenValueSigned + $signed(queenMap[71:66]);
			`W_KING: squareScore[11] = kingValueSigned + $signed(kingMap[71:66]);
			`B_PAWN: squareScore[11] = -1 * (pawnValueSigned + $signed(pawnMap[317:312]));
			`B_KNIGHT: squareScore[11] = -1 * (knightValueSigned + $signed(knightMap[317:312]));
			`B_BISHOP: squareScore[11] = -1 * (bishopValueSigned + $signed(bishopMap[317:312]));
			`B_ROOK: squareScore[11] = -1 * (rookValueSigned + $signed(rookMap[317:312]));
			`B_QUEEN: squareScore[11] = -1 * (queenValueSigned + $signed(queenMap[317:312]));
			`B_KING: squareScore[11] = -1 * (kingValueSigned + $signed(kingMap[317:312]));
			default: squareScore[11] = 0;
		endcase
		
		case (board[12]) //square 12
			`W_PAWN: squareScore[12] = pawnValueSigned + $signed(pawnMap[77:72]);
			`W_KNIGHT: squareScore[12] = knightValueSigned + $signed(knightMap[77:72]);
			`W_BISHOP: squareScore[12] = bishopValueSigned + $signed(bishopMap[77:72]);
			`W_ROOK: squareScore[12] = rookValueSigned + $signed(rookMap[77:72]);
			`W_QUEEN: squareScore[12] = queenValueSigned + $signed(queenMap[77:72]);
			`W_KING: squareScore[12] = kingValueSigned + $signed(kingMap[77:72]);
			`B_PAWN: squareScore[12] = -1 * (pawnValueSigned + $signed(pawnMap[311:306]));
			`B_KNIGHT: squareScore[12] = -1 * (knightValueSigned + $signed(knightMap[311:306]));
			`B_BISHOP: squareScore[12] = -1 * (bishopValueSigned + $signed(bishopMap[311:306]));
			`B_ROOK: squareScore[12] = -1 * (rookValueSigned + $signed(rookMap[311:306]));
			`B_QUEEN: squareScore[12] = -1 * (queenValueSigned + $signed(queenMap[311:306]));
			`B_KING: squareScore[12] = -1 * (kingValueSigned + $signed(kingMap[311:306]));
			default: squareScore[12] = 0;
		endcase
		
		case (board[13]) //square 13
			`W_PAWN: squareScore[13] = pawnValueSigned + $signed(pawnMap[83:78]);
			`W_KNIGHT: squareScore[13] = knightValueSigned + $signed(knightMap[83:78]);
			`W_BISHOP: squareScore[13] = bishopValueSigned + $signed(bishopMap[83:78]);
			`W_ROOK: squareScore[13] = rookValueSigned + $signed(rookMap[83:78]);
			`W_QUEEN: squareScore[13] = queenValueSigned + $signed(queenMap[83:78]);
			`W_KING: squareScore[13] = kingValueSigned + $signed(kingMap[83:78]);
			`B_PAWN: squareScore[13] = -1 * (pawnValueSigned + $signed(pawnMap[305:300]));
			`B_KNIGHT: squareScore[13] = -1 * (knightValueSigned + $signed(knightMap[305:300]));
			`B_BISHOP: squareScore[13] = -1 * (bishopValueSigned + $signed(bishopMap[305:300]));
			`B_ROOK: squareScore[13] = -1 * (rookValueSigned + $signed(rookMap[305:300]));
			`B_QUEEN: squareScore[13] = -1 * (queenValueSigned + $signed(queenMap[305:300]));
			`B_KING: squareScore[13] = -1 * (kingValueSigned + $signed(kingMap[305:300]));
			default: squareScore[13] = 0;
		endcase
		
		case (board[14]) //square 14
			`W_PAWN: squareScore[14] = pawnValueSigned + $signed(pawnMap[89:84]);
			`W_KNIGHT: squareScore[14] = knightValueSigned + $signed(knightMap[89:84]);
			`W_BISHOP: squareScore[14] = bishopValueSigned + $signed(bishopMap[89:84]);
			`W_ROOK: squareScore[14] = rookValueSigned + $signed(rookMap[89:84]);
			`W_QUEEN: squareScore[14] = queenValueSigned + $signed(queenMap[89:84]);
			`W_KING: squareScore[14] = kingValueSigned + $signed(kingMap[89:84]);
			`B_PAWN: squareScore[14] = -1 * (pawnValueSigned + $signed(pawnMap[299:294]));
			`B_KNIGHT: squareScore[14] = -1 * (knightValueSigned + $signed(knightMap[299:294]));
			`B_BISHOP: squareScore[14] = -1 * (bishopValueSigned + $signed(bishopMap[299:294]));
			`B_ROOK: squareScore[14] = -1 * (rookValueSigned + $signed(rookMap[299:294]));
			`B_QUEEN: squareScore[14] = -1 * (queenValueSigned + $signed(queenMap[299:294]));
			`B_KING: squareScore[14] = -1 * (kingValueSigned + $signed(kingMap[299:294]));
			default: squareScore[14] = 0;
		endcase
		
		case (board[15]) //square 15
			`W_PAWN: squareScore[15] = pawnValueSigned + $signed(pawnMap[95:90]);
			`W_KNIGHT: squareScore[15] = knightValueSigned + $signed(knightMap[95:90]);
			`W_BISHOP: squareScore[15] = bishopValueSigned + $signed(bishopMap[95:90]);
			`W_ROOK: squareScore[15] = rookValueSigned + $signed(rookMap[95:90]);
			`W_QUEEN: squareScore[15] = queenValueSigned + $signed(queenMap[95:90]);
			`W_KING: squareScore[15] = kingValueSigned + $signed(kingMap[95:90]);
			`B_PAWN: squareScore[15] = -1 * (pawnValueSigned + $signed(pawnMap[293:288]));
			`B_KNIGHT: squareScore[15] = -1 * (knightValueSigned + $signed(knightMap[293:288]));
			`B_BISHOP: squareScore[15] = -1 * (bishopValueSigned + $signed(bishopMap[293:288]));
			`B_ROOK: squareScore[15] = -1 * (rookValueSigned + $signed(rookMap[293:288]));
			`B_QUEEN: squareScore[15] = -1 * (queenValueSigned + $signed(queenMap[293:288]));
			`B_KING: squareScore[15] = -1 * (kingValueSigned + $signed(kingMap[293:288]));
			default: squareScore[15] = 0;
		endcase
		
		case (board[16]) //square 16
			`W_PAWN: squareScore[16] = pawnValueSigned + $signed(pawnMap[101:96]);
			`W_KNIGHT: squareScore[16] = knightValueSigned + $signed(knightMap[101:96]);
			`W_BISHOP: squareScore[16] = bishopValueSigned + $signed(bishopMap[101:96]);
			`W_ROOK: squareScore[16] = rookValueSigned + $signed(rookMap[101:96]);
			`W_QUEEN: squareScore[16] = queenValueSigned + $signed(queenMap[101:96]);
			`W_KING: squareScore[16] = kingValueSigned + $signed(kingMap[101:96]);
			`B_PAWN: squareScore[16] = -1 * (pawnValueSigned + $signed(pawnMap[287:282]));
			`B_KNIGHT: squareScore[16] = -1 * (knightValueSigned + $signed(knightMap[287:282]));
			`B_BISHOP: squareScore[16] = -1 * (bishopValueSigned + $signed(bishopMap[287:282]));
			`B_ROOK: squareScore[16] = -1 * (rookValueSigned + $signed(rookMap[287:282]));
			`B_QUEEN: squareScore[16] = -1 * (queenValueSigned + $signed(queenMap[287:282]));
			`B_KING: squareScore[16] = -1 * (kingValueSigned + $signed(kingMap[287:282]));
			default: squareScore[16] = 0;
		endcase
		
		case (board[17]) //square 17
			`W_PAWN: squareScore[17] = pawnValueSigned + $signed(pawnMap[107:102]);
			`W_KNIGHT: squareScore[17] = knightValueSigned + $signed(knightMap[107:102]);
			`W_BISHOP: squareScore[17] = bishopValueSigned + $signed(bishopMap[107:102]);
			`W_ROOK: squareScore[17] = rookValueSigned + $signed(rookMap[107:102]);
			`W_QUEEN: squareScore[17] = queenValueSigned + $signed(queenMap[107:102]);
			`W_KING: squareScore[17] = kingValueSigned + $signed(kingMap[107:102]);
			`B_PAWN: squareScore[17] = -1 * (pawnValueSigned + $signed(pawnMap[281:276]));
			`B_KNIGHT: squareScore[17] = -1 * (knightValueSigned + $signed(knightMap[281:276]));
			`B_BISHOP: squareScore[17] = -1 * (bishopValueSigned + $signed(bishopMap[281:276]));
			`B_ROOK: squareScore[17] = -1 * (rookValueSigned + $signed(rookMap[281:276]));
			`B_QUEEN: squareScore[17] = -1 * (queenValueSigned + $signed(queenMap[281:276]));
			`B_KING: squareScore[17] = -1 * (kingValueSigned + $signed(kingMap[281:276]));
			default: squareScore[17] = 0;
		endcase
		
		case (board[18]) //square 18
			`W_PAWN: squareScore[18] = pawnValueSigned + $signed(pawnMap[113:108]);
			`W_KNIGHT: squareScore[18] = knightValueSigned + $signed(knightMap[113:108]);
			`W_BISHOP: squareScore[18] = bishopValueSigned + $signed(bishopMap[113:108]);
			`W_ROOK: squareScore[18] = rookValueSigned + $signed(rookMap[113:108]);
			`W_QUEEN: squareScore[18] = queenValueSigned + $signed(queenMap[113:108]);
			`W_KING: squareScore[18] = kingValueSigned + $signed(kingMap[113:108]);
			`B_PAWN: squareScore[18] = -1 * (pawnValueSigned + $signed(pawnMap[275:270]));
			`B_KNIGHT: squareScore[18] = -1 * (knightValueSigned + $signed(knightMap[275:270]));
			`B_BISHOP: squareScore[18] = -1 * (bishopValueSigned + $signed(bishopMap[275:270]));
			`B_ROOK: squareScore[18] = -1 * (rookValueSigned + $signed(rookMap[275:270]));
			`B_QUEEN: squareScore[18] = -1 * (queenValueSigned + $signed(queenMap[275:270]));
			`B_KING: squareScore[18] = -1 * (kingValueSigned + $signed(kingMap[275:270]));
			default: squareScore[18] = 0;
		endcase
		
		case (board[19]) //square 19
			`W_PAWN: squareScore[19] = pawnValueSigned + $signed(pawnMap[119:114]);
			`W_KNIGHT: squareScore[19] = knightValueSigned + $signed(knightMap[119:114]);
			`W_BISHOP: squareScore[19] = bishopValueSigned + $signed(bishopMap[119:114]);
			`W_ROOK: squareScore[19] = rookValueSigned + $signed(rookMap[119:114]);
			`W_QUEEN: squareScore[19] = queenValueSigned + $signed(queenMap[119:114]);
			`W_KING: squareScore[19] = kingValueSigned + $signed(kingMap[119:114]);
			`B_PAWN: squareScore[19] = -1 * (pawnValueSigned + $signed(pawnMap[269:264]));
			`B_KNIGHT: squareScore[19] = -1 * (knightValueSigned + $signed(knightMap[269:264]));
			`B_BISHOP: squareScore[19] = -1 * (bishopValueSigned + $signed(bishopMap[269:264]));
			`B_ROOK: squareScore[19] = -1 * (rookValueSigned + $signed(rookMap[269:264]));
			`B_QUEEN: squareScore[19] = -1 * (queenValueSigned + $signed(queenMap[269:264]));
			`B_KING: squareScore[19] = -1 * (kingValueSigned + $signed(kingMap[269:264]));
			default: squareScore[19] = 0;
		endcase
		
		case (board[20]) //square 20
			`W_PAWN: squareScore[20] = pawnValueSigned + $signed(pawnMap[125:120]);
			`W_KNIGHT: squareScore[20] = knightValueSigned + $signed(knightMap[125:120]);
			`W_BISHOP: squareScore[20] = bishopValueSigned + $signed(bishopMap[125:120]);
			`W_ROOK: squareScore[20] = rookValueSigned + $signed(rookMap[125:120]);
			`W_QUEEN: squareScore[20] = queenValueSigned + $signed(queenMap[125:120]);
			`W_KING: squareScore[20] = kingValueSigned + $signed(kingMap[125:120]);
			`B_PAWN: squareScore[20] = -1 * (pawnValueSigned + $signed(pawnMap[263:258]));
			`B_KNIGHT: squareScore[20] = -1 * (knightValueSigned + $signed(knightMap[263:258]));
			`B_BISHOP: squareScore[20] = -1 * (bishopValueSigned + $signed(bishopMap[263:258]));
			`B_ROOK: squareScore[20] = -1 * (rookValueSigned + $signed(rookMap[263:258]));
			`B_QUEEN: squareScore[20] = -1 * (queenValueSigned + $signed(queenMap[263:258]));
			`B_KING: squareScore[20] = -1 * (kingValueSigned + $signed(kingMap[263:258]));
			default: squareScore[20] = 0;
		endcase
		
		case (board[21]) //square 21
			`W_PAWN: squareScore[21] = pawnValueSigned + $signed(pawnMap[131:126]);
			`W_KNIGHT: squareScore[21] = knightValueSigned + $signed(knightMap[131:126]);
			`W_BISHOP: squareScore[21] = bishopValueSigned + $signed(bishopMap[131:126]);
			`W_ROOK: squareScore[21] = rookValueSigned + $signed(rookMap[131:126]);
			`W_QUEEN: squareScore[21] = queenValueSigned + $signed(queenMap[131:126]);
			`W_KING: squareScore[21] = kingValueSigned + $signed(kingMap[131:126]);
			`B_PAWN: squareScore[21] = -1 * (pawnValueSigned + $signed(pawnMap[257:252]));
			`B_KNIGHT: squareScore[21] = -1 * (knightValueSigned + $signed(knightMap[257:252]));
			`B_BISHOP: squareScore[21] = -1 * (bishopValueSigned + $signed(bishopMap[257:252]));
			`B_ROOK: squareScore[21] = -1 * (rookValueSigned + $signed(rookMap[257:252]));
			`B_QUEEN: squareScore[21] = -1 * (queenValueSigned + $signed(queenMap[257:252]));
			`B_KING: squareScore[21] = -1 * (kingValueSigned + $signed(kingMap[257:252]));
			default: squareScore[21] = 0;
		endcase
		
		case (board[22]) //square 22
			`W_PAWN: squareScore[22] = pawnValueSigned + $signed(pawnMap[137:132]);
			`W_KNIGHT: squareScore[22] = knightValueSigned + $signed(knightMap[137:132]);
			`W_BISHOP: squareScore[22] = bishopValueSigned + $signed(bishopMap[137:132]);
			`W_ROOK: squareScore[22] = rookValueSigned + $signed(rookMap[137:132]);
			`W_QUEEN: squareScore[22] = queenValueSigned + $signed(queenMap[137:132]);
			`W_KING: squareScore[22] = kingValueSigned + $signed(kingMap[137:132]);
			`B_PAWN: squareScore[22] = -1 * (pawnValueSigned + $signed(pawnMap[251:246]));
			`B_KNIGHT: squareScore[22] = -1 * (knightValueSigned + $signed(knightMap[251:246]));
			`B_BISHOP: squareScore[22] = -1 * (bishopValueSigned + $signed(bishopMap[251:246]));
			`B_ROOK: squareScore[22] = -1 * (rookValueSigned + $signed(rookMap[251:246]));
			`B_QUEEN: squareScore[22] = -1 * (queenValueSigned + $signed(queenMap[251:246]));
			`B_KING: squareScore[22] = -1 * (kingValueSigned + $signed(kingMap[251:246]));
			default: squareScore[22] = 0;
		endcase
		
		case (board[23]) //square 23
			`W_PAWN: squareScore[23] = pawnValueSigned + $signed(pawnMap[143:138]);
			`W_KNIGHT: squareScore[23] = knightValueSigned + $signed(knightMap[143:138]);
			`W_BISHOP: squareScore[23] = bishopValueSigned + $signed(bishopMap[143:138]);
			`W_ROOK: squareScore[23] = rookValueSigned + $signed(rookMap[143:138]);
			`W_QUEEN: squareScore[23] = queenValueSigned + $signed(queenMap[143:138]);
			`W_KING: squareScore[23] = kingValueSigned + $signed(kingMap[143:138]);
			`B_PAWN: squareScore[23] = -1 * (pawnValueSigned + $signed(pawnMap[245:240]));
			`B_KNIGHT: squareScore[23] = -1 * (knightValueSigned + $signed(knightMap[245:240]));
			`B_BISHOP: squareScore[23] = -1 * (bishopValueSigned + $signed(bishopMap[245:240]));
			`B_ROOK: squareScore[23] = -1 * (rookValueSigned + $signed(rookMap[245:240]));
			`B_QUEEN: squareScore[23] = -1 * (queenValueSigned + $signed(queenMap[245:240]));
			`B_KING: squareScore[23] = -1 * (kingValueSigned + $signed(kingMap[245:240]));
			default: squareScore[23] = 0;
		endcase
		
		case (board[24]) //square 24
			`W_PAWN: squareScore[24] = pawnValueSigned + $signed(pawnMap[149:144]);
			`W_KNIGHT: squareScore[24] = knightValueSigned + $signed(knightMap[149:144]);
			`W_BISHOP: squareScore[24] = bishopValueSigned + $signed(bishopMap[149:144]);
			`W_ROOK: squareScore[24] = rookValueSigned + $signed(rookMap[149:144]);
			`W_QUEEN: squareScore[24] = queenValueSigned + $signed(queenMap[149:144]);
			`W_KING: squareScore[24] = kingValueSigned + $signed(kingMap[149:144]);
			`B_PAWN: squareScore[24] = -1 * (pawnValueSigned + $signed(pawnMap[239:234]));
			`B_KNIGHT: squareScore[24] = -1 * (knightValueSigned + $signed(knightMap[239:234]));
			`B_BISHOP: squareScore[24] = -1 * (bishopValueSigned + $signed(bishopMap[239:234]));
			`B_ROOK: squareScore[24] = -1 * (rookValueSigned + $signed(rookMap[239:234]));
			`B_QUEEN: squareScore[24] = -1 * (queenValueSigned + $signed(queenMap[239:234]));
			`B_KING: squareScore[24] = -1 * (kingValueSigned + $signed(kingMap[239:234]));
			default: squareScore[24] = 0;
		endcase
		
		case (board[25]) //square 25
			`W_PAWN: squareScore[25] = pawnValueSigned + $signed(pawnMap[155:150]);
			`W_KNIGHT: squareScore[25] = knightValueSigned + $signed(knightMap[155:150]);
			`W_BISHOP: squareScore[25] = bishopValueSigned + $signed(bishopMap[155:150]);
			`W_ROOK: squareScore[25] = rookValueSigned + $signed(rookMap[155:150]);
			`W_QUEEN: squareScore[25] = queenValueSigned + $signed(queenMap[155:150]);
			`W_KING: squareScore[25] = kingValueSigned + $signed(kingMap[155:150]);
			`B_PAWN: squareScore[25] = -1 * (pawnValueSigned + $signed(pawnMap[233:228]));
			`B_KNIGHT: squareScore[25] = -1 * (knightValueSigned + $signed(knightMap[233:228]));
			`B_BISHOP: squareScore[25] = -1 * (bishopValueSigned + $signed(bishopMap[233:228]));
			`B_ROOK: squareScore[25] = -1 * (rookValueSigned + $signed(rookMap[233:228]));
			`B_QUEEN: squareScore[25] = -1 * (queenValueSigned + $signed(queenMap[233:228]));
			`B_KING: squareScore[25] = -1 * (kingValueSigned + $signed(kingMap[233:228]));
			default: squareScore[25] = 0;
		endcase
		
		case (board[26]) //square 26
			`W_PAWN: squareScore[26] = pawnValueSigned + $signed(pawnMap[161:156]);
			`W_KNIGHT: squareScore[26] = knightValueSigned + $signed(knightMap[161:156]);
			`W_BISHOP: squareScore[26] = bishopValueSigned + $signed(bishopMap[161:156]);
			`W_ROOK: squareScore[26] = rookValueSigned + $signed(rookMap[161:156]);
			`W_QUEEN: squareScore[26] = queenValueSigned + $signed(queenMap[161:156]);
			`W_KING: squareScore[26] = kingValueSigned + $signed(kingMap[161:156]);
			`B_PAWN: squareScore[26] = -1 * (pawnValueSigned + $signed(pawnMap[227:222]));
			`B_KNIGHT: squareScore[26] = -1 * (knightValueSigned + $signed(knightMap[227:222]));
			`B_BISHOP: squareScore[26] = -1 * (bishopValueSigned + $signed(bishopMap[227:222]));
			`B_ROOK: squareScore[26] = -1 * (rookValueSigned + $signed(rookMap[227:222]));
			`B_QUEEN: squareScore[26] = -1 * (queenValueSigned + $signed(queenMap[227:222]));
			`B_KING: squareScore[26] = -1 * (kingValueSigned + $signed(kingMap[227:222]));
			default: squareScore[26] = 0;
		endcase
		
		case (board[27]) //square 27
			`W_PAWN: squareScore[27] = pawnValueSigned + $signed(pawnMap[167:162]);
			`W_KNIGHT: squareScore[27] = knightValueSigned + $signed(knightMap[167:162]);
			`W_BISHOP: squareScore[27] = bishopValueSigned + $signed(bishopMap[167:162]);
			`W_ROOK: squareScore[27] = rookValueSigned + $signed(rookMap[167:162]);
			`W_QUEEN: squareScore[27] = queenValueSigned + $signed(queenMap[167:162]);
			`W_KING: squareScore[27] = kingValueSigned + $signed(kingMap[167:162]);
			`B_PAWN: squareScore[27] = -1 * (pawnValueSigned + $signed(pawnMap[221:216]));
			`B_KNIGHT: squareScore[27] = -1 * (knightValueSigned + $signed(knightMap[221:216]));
			`B_BISHOP: squareScore[27] = -1 * (bishopValueSigned + $signed(bishopMap[221:216]));
			`B_ROOK: squareScore[27] = -1 * (rookValueSigned + $signed(rookMap[221:216]));
			`B_QUEEN: squareScore[27] = -1 * (queenValueSigned + $signed(queenMap[221:216]));
			`B_KING: squareScore[27] = -1 * (kingValueSigned + $signed(kingMap[221:216]));
			default: squareScore[27] = 0;
		endcase
		
		case (board[28]) //square 28
			`W_PAWN: squareScore[28] = pawnValueSigned + $signed(pawnMap[173:168]);
			`W_KNIGHT: squareScore[28] = knightValueSigned + $signed(knightMap[173:168]);
			`W_BISHOP: squareScore[28] = bishopValueSigned + $signed(bishopMap[173:168]);
			`W_ROOK: squareScore[28] = rookValueSigned + $signed(rookMap[173:168]);
			`W_QUEEN: squareScore[28] = queenValueSigned + $signed(queenMap[173:168]);
			`W_KING: squareScore[28] = kingValueSigned + $signed(kingMap[173:168]);
			`B_PAWN: squareScore[28] = -1 * (pawnValueSigned + $signed(pawnMap[215:210]));
			`B_KNIGHT: squareScore[28] = -1 * (knightValueSigned + $signed(knightMap[215:210]));
			`B_BISHOP: squareScore[28] = -1 * (bishopValueSigned + $signed(bishopMap[215:210]));
			`B_ROOK: squareScore[28] = -1 * (rookValueSigned + $signed(rookMap[215:210]));
			`B_QUEEN: squareScore[28] = -1 * (queenValueSigned + $signed(queenMap[215:210]));
			`B_KING: squareScore[28] = -1 * (kingValueSigned + $signed(kingMap[215:210]));
			default: squareScore[28] = 0;
		endcase
		
		case (board[29]) //square 29
			`W_PAWN: squareScore[29] = pawnValueSigned + $signed(pawnMap[179:174]);
			`W_KNIGHT: squareScore[29] = knightValueSigned + $signed(knightMap[179:174]);
			`W_BISHOP: squareScore[29] = bishopValueSigned + $signed(bishopMap[179:174]);
			`W_ROOK: squareScore[29] = rookValueSigned + $signed(rookMap[179:174]);
			`W_QUEEN: squareScore[29] = queenValueSigned + $signed(queenMap[179:174]);
			`W_KING: squareScore[29] = kingValueSigned + $signed(kingMap[179:174]);
			`B_PAWN: squareScore[29] = -1 * (pawnValueSigned + $signed(pawnMap[209:204]));
			`B_KNIGHT: squareScore[29] = -1 * (knightValueSigned + $signed(knightMap[209:204]));
			`B_BISHOP: squareScore[29] = -1 * (bishopValueSigned + $signed(bishopMap[209:204]));
			`B_ROOK: squareScore[29] = -1 * (rookValueSigned + $signed(rookMap[209:204]));
			`B_QUEEN: squareScore[29] = -1 * (queenValueSigned + $signed(queenMap[209:204]));
			`B_KING: squareScore[29] = -1 * (kingValueSigned + $signed(kingMap[209:204]));
			default: squareScore[29] = 0;
		endcase
		
		case (board[30]) //square 30
			`W_PAWN: squareScore[30] = pawnValueSigned + $signed(pawnMap[185:180]);
			`W_KNIGHT: squareScore[30] = knightValueSigned + $signed(knightMap[185:180]);
			`W_BISHOP: squareScore[30] = bishopValueSigned + $signed(bishopMap[185:180]);
			`W_ROOK: squareScore[30] = rookValueSigned + $signed(rookMap[185:180]);
			`W_QUEEN: squareScore[30] = queenValueSigned + $signed(queenMap[185:180]);
			`W_KING: squareScore[30] = kingValueSigned + $signed(kingMap[185:180]);
			`B_PAWN: squareScore[30] = -1 * (pawnValueSigned + $signed(pawnMap[203:198]));
			`B_KNIGHT: squareScore[30] = -1 * (knightValueSigned + $signed(knightMap[203:198]));
			`B_BISHOP: squareScore[30] = -1 * (bishopValueSigned + $signed(bishopMap[203:198]));
			`B_ROOK: squareScore[30] = -1 * (rookValueSigned + $signed(rookMap[203:198]));
			`B_QUEEN: squareScore[30] = -1 * (queenValueSigned + $signed(queenMap[203:198]));
			`B_KING: squareScore[30] = -1 * (kingValueSigned + $signed(kingMap[203:198]));
			default: squareScore[30] = 0;
		endcase
		
		case (board[31]) //square 31
			`W_PAWN: squareScore[31] = pawnValueSigned + $signed(pawnMap[191:186]);
			`W_KNIGHT: squareScore[31] = knightValueSigned + $signed(knightMap[191:186]);
			`W_BISHOP: squareScore[31] = bishopValueSigned + $signed(bishopMap[191:186]);
			`W_ROOK: squareScore[31] = rookValueSigned + $signed(rookMap[191:186]);
			`W_QUEEN: squareScore[31] = queenValueSigned + $signed(queenMap[191:186]);
			`W_KING: squareScore[31] = kingValueSigned + $signed(kingMap[191:186]);
			`B_PAWN: squareScore[31] = -1 * (pawnValueSigned + $signed(pawnMap[197:192]));
			`B_KNIGHT: squareScore[31] = -1 * (knightValueSigned + $signed(knightMap[197:192]));
			`B_BISHOP: squareScore[31] = -1 * (bishopValueSigned + $signed(bishopMap[197:192]));
			`B_ROOK: squareScore[31] = -1 * (rookValueSigned + $signed(rookMap[197:192]));
			`B_QUEEN: squareScore[31] = -1 * (queenValueSigned + $signed(queenMap[197:192]));
			`B_KING: squareScore[31] = -1 * (kingValueSigned + $signed(kingMap[197:192]));
			default: squareScore[31] = 0;
		endcase
		
		case (board[32]) //square 32
			`W_PAWN: squareScore[32] = pawnValueSigned + $signed(pawnMap[197:192]);
			`W_KNIGHT: squareScore[32] = knightValueSigned + $signed(knightMap[197:192]);
			`W_BISHOP: squareScore[32] = bishopValueSigned + $signed(bishopMap[197:192]);
			`W_ROOK: squareScore[32] = rookValueSigned + $signed(rookMap[197:192]);
			`W_QUEEN: squareScore[32] = queenValueSigned + $signed(queenMap[197:192]);
			`W_KING: squareScore[32] = kingValueSigned + $signed(kingMap[197:192]);
			`B_PAWN: squareScore[32] = -1 * (pawnValueSigned + $signed(pawnMap[191:186]));
			`B_KNIGHT: squareScore[32] = -1 * (knightValueSigned + $signed(knightMap[191:186]));
			`B_BISHOP: squareScore[32] = -1 * (bishopValueSigned + $signed(bishopMap[191:186]));
			`B_ROOK: squareScore[32] = -1 * (rookValueSigned + $signed(rookMap[191:186]));
			`B_QUEEN: squareScore[32] = -1 * (queenValueSigned + $signed(queenMap[191:186]));
			`B_KING: squareScore[32] = -1 * (kingValueSigned + $signed(kingMap[191:186]));
			default: squareScore[32] = 0;
		endcase
		
		case (board[33]) //square 33
			`W_PAWN: squareScore[33] = pawnValueSigned + $signed(pawnMap[203:198]);
			`W_KNIGHT: squareScore[33] = knightValueSigned + $signed(knightMap[203:198]);
			`W_BISHOP: squareScore[33] = bishopValueSigned + $signed(bishopMap[203:198]);
			`W_ROOK: squareScore[33] = rookValueSigned + $signed(rookMap[203:198]);
			`W_QUEEN: squareScore[33] = queenValueSigned + $signed(queenMap[203:198]);
			`W_KING: squareScore[33] = kingValueSigned + $signed(kingMap[203:198]);
			`B_PAWN: squareScore[33] = -1 * (pawnValueSigned + $signed(pawnMap[185:180]));
			`B_KNIGHT: squareScore[33] = -1 * (knightValueSigned + $signed(knightMap[185:180]));
			`B_BISHOP: squareScore[33] = -1 * (bishopValueSigned + $signed(bishopMap[185:180]));
			`B_ROOK: squareScore[33] = -1 * (rookValueSigned + $signed(rookMap[185:180]));
			`B_QUEEN: squareScore[33] = -1 * (queenValueSigned + $signed(queenMap[185:180]));
			`B_KING: squareScore[33] = -1 * (kingValueSigned + $signed(kingMap[185:180]));
			default: squareScore[33] = 0;
		endcase
		
		case (board[34]) //square 34
			`W_PAWN: squareScore[34] = pawnValueSigned + $signed(pawnMap[209:204]);
			`W_KNIGHT: squareScore[34] = knightValueSigned + $signed(knightMap[209:204]);
			`W_BISHOP: squareScore[34] = bishopValueSigned + $signed(bishopMap[209:204]);
			`W_ROOK: squareScore[34] = rookValueSigned + $signed(rookMap[209:204]);
			`W_QUEEN: squareScore[34] = queenValueSigned + $signed(queenMap[209:204]);
			`W_KING: squareScore[34] = kingValueSigned + $signed(kingMap[209:204]);
			`B_PAWN: squareScore[34] = -1 * (pawnValueSigned + $signed(pawnMap[179:174]));
			`B_KNIGHT: squareScore[34] = -1 * (knightValueSigned + $signed(knightMap[179:174]));
			`B_BISHOP: squareScore[34] = -1 * (bishopValueSigned + $signed(bishopMap[179:174]));
			`B_ROOK: squareScore[34] = -1 * (rookValueSigned + $signed(rookMap[179:174]));
			`B_QUEEN: squareScore[34] = -1 * (queenValueSigned + $signed(queenMap[179:174]));
			`B_KING: squareScore[34] = -1 * (kingValueSigned + $signed(kingMap[179:174]));
			default: squareScore[34] = 0;
		endcase
		
		case (board[35]) //square 35
			`W_PAWN: squareScore[35] = pawnValueSigned + $signed(pawnMap[215:210]);
			`W_KNIGHT: squareScore[35] = knightValueSigned + $signed(knightMap[215:210]);
			`W_BISHOP: squareScore[35] = bishopValueSigned + $signed(bishopMap[215:210]);
			`W_ROOK: squareScore[35] = rookValueSigned + $signed(rookMap[215:210]);
			`W_QUEEN: squareScore[35] = queenValueSigned + $signed(queenMap[215:210]);
			`W_KING: squareScore[35] = kingValueSigned + $signed(kingMap[215:210]);
			`B_PAWN: squareScore[35] = -1 * (pawnValueSigned + $signed(pawnMap[173:168]));
			`B_KNIGHT: squareScore[35] = -1 * (knightValueSigned + $signed(knightMap[173:168]));
			`B_BISHOP: squareScore[35] = -1 * (bishopValueSigned + $signed(bishopMap[173:168]));
			`B_ROOK: squareScore[35] = -1 * (rookValueSigned + $signed(rookMap[173:168]));
			`B_QUEEN: squareScore[35] = -1 * (queenValueSigned + $signed(queenMap[173:168]));
			`B_KING: squareScore[35] = -1 * (kingValueSigned + $signed(kingMap[173:168]));
			default: squareScore[35] = 0;
		endcase
		
		case (board[36]) //square 36
			`W_PAWN: squareScore[36] = pawnValueSigned + $signed(pawnMap[221:216]);
			`W_KNIGHT: squareScore[36] = knightValueSigned + $signed(knightMap[221:216]);
			`W_BISHOP: squareScore[36] = bishopValueSigned + $signed(bishopMap[221:216]);
			`W_ROOK: squareScore[36] = rookValueSigned + $signed(rookMap[221:216]);
			`W_QUEEN: squareScore[36] = queenValueSigned + $signed(queenMap[221:216]);
			`W_KING: squareScore[36] = kingValueSigned + $signed(kingMap[221:216]);
			`B_PAWN: squareScore[36] = -1 * (pawnValueSigned + $signed(pawnMap[167:162]));
			`B_KNIGHT: squareScore[36] = -1 * (knightValueSigned + $signed(knightMap[167:162]));
			`B_BISHOP: squareScore[36] = -1 * (bishopValueSigned + $signed(bishopMap[167:162]));
			`B_ROOK: squareScore[36] = -1 * (rookValueSigned + $signed(rookMap[167:162]));
			`B_QUEEN: squareScore[36] = -1 * (queenValueSigned + $signed(queenMap[167:162]));
			`B_KING: squareScore[36] = -1 * (kingValueSigned + $signed(kingMap[167:162]));
			default: squareScore[36] = 0;
		endcase
		
		case (board[37]) //square 37
			`W_PAWN: squareScore[37] = pawnValueSigned + $signed(pawnMap[227:222]);
			`W_KNIGHT: squareScore[37] = knightValueSigned + $signed(knightMap[227:222]);
			`W_BISHOP: squareScore[37] = bishopValueSigned + $signed(bishopMap[227:222]);
			`W_ROOK: squareScore[37] = rookValueSigned + $signed(rookMap[227:222]);
			`W_QUEEN: squareScore[37] = queenValueSigned + $signed(queenMap[227:222]);
			`W_KING: squareScore[37] = kingValueSigned + $signed(kingMap[227:222]);
			`B_PAWN: squareScore[37] = -1 * (pawnValueSigned + $signed(pawnMap[161:156]));
			`B_KNIGHT: squareScore[37] = -1 * (knightValueSigned + $signed(knightMap[161:156]));
			`B_BISHOP: squareScore[37] = -1 * (bishopValueSigned + $signed(bishopMap[161:156]));
			`B_ROOK: squareScore[37] = -1 * (rookValueSigned + $signed(rookMap[161:156]));
			`B_QUEEN: squareScore[37] = -1 * (queenValueSigned + $signed(queenMap[161:156]));
			`B_KING: squareScore[37] = -1 * (kingValueSigned + $signed(kingMap[161:156]));
			default: squareScore[37] = 0;
		endcase
		
		case (board[38]) //square 38
			`W_PAWN: squareScore[38] = pawnValueSigned + $signed(pawnMap[233:228]);
			`W_KNIGHT: squareScore[38] = knightValueSigned + $signed(knightMap[233:228]);
			`W_BISHOP: squareScore[38] = bishopValueSigned + $signed(bishopMap[233:228]);
			`W_ROOK: squareScore[38] = rookValueSigned + $signed(rookMap[233:228]);
			`W_QUEEN: squareScore[38] = queenValueSigned + $signed(queenMap[233:228]);
			`W_KING: squareScore[38] = kingValueSigned + $signed(kingMap[233:228]);
			`B_PAWN: squareScore[38] = -1 * (pawnValueSigned + $signed(pawnMap[155:150]));
			`B_KNIGHT: squareScore[38] = -1 * (knightValueSigned + $signed(knightMap[155:150]));
			`B_BISHOP: squareScore[38] = -1 * (bishopValueSigned + $signed(bishopMap[155:150]));
			`B_ROOK: squareScore[38] = -1 * (rookValueSigned + $signed(rookMap[155:150]));
			`B_QUEEN: squareScore[38] = -1 * (queenValueSigned + $signed(queenMap[155:150]));
			`B_KING: squareScore[38] = -1 * (kingValueSigned + $signed(kingMap[155:150]));
			default: squareScore[38] = 0;
		endcase
		
		case (board[39]) //square 39
			`W_PAWN: squareScore[39] = pawnValueSigned + $signed(pawnMap[239:234]);
			`W_KNIGHT: squareScore[39] = knightValueSigned + $signed(knightMap[239:234]);
			`W_BISHOP: squareScore[39] = bishopValueSigned + $signed(bishopMap[239:234]);
			`W_ROOK: squareScore[39] = rookValueSigned + $signed(rookMap[239:234]);
			`W_QUEEN: squareScore[39] = queenValueSigned + $signed(queenMap[239:234]);
			`W_KING: squareScore[39] = kingValueSigned + $signed(kingMap[239:234]);
			`B_PAWN: squareScore[39] = -1 * (pawnValueSigned + $signed(pawnMap[149:144]));
			`B_KNIGHT: squareScore[39] = -1 * (knightValueSigned + $signed(knightMap[149:144]));
			`B_BISHOP: squareScore[39] = -1 * (bishopValueSigned + $signed(bishopMap[149:144]));
			`B_ROOK: squareScore[39] = -1 * (rookValueSigned + $signed(rookMap[149:144]));
			`B_QUEEN: squareScore[39] = -1 * (queenValueSigned + $signed(queenMap[149:144]));
			`B_KING: squareScore[39] = -1 * (kingValueSigned + $signed(kingMap[149:144]));
			default: squareScore[39] = 0;
		endcase
		
		case (board[40]) //square 40
			`W_PAWN: squareScore[40] = pawnValueSigned + $signed(pawnMap[245:240]);
			`W_KNIGHT: squareScore[40] = knightValueSigned + $signed(knightMap[245:240]);
			`W_BISHOP: squareScore[40] = bishopValueSigned + $signed(bishopMap[245:240]);
			`W_ROOK: squareScore[40] = rookValueSigned + $signed(rookMap[245:240]);
			`W_QUEEN: squareScore[40] = queenValueSigned + $signed(queenMap[245:240]);
			`W_KING: squareScore[40] = kingValueSigned + $signed(kingMap[245:240]);
			`B_PAWN: squareScore[40] = -1 * (pawnValueSigned + $signed(pawnMap[143:138]));
			`B_KNIGHT: squareScore[40] = -1 * (knightValueSigned + $signed(knightMap[143:138]));
			`B_BISHOP: squareScore[40] = -1 * (bishopValueSigned + $signed(bishopMap[143:138]));
			`B_ROOK: squareScore[40] = -1 * (rookValueSigned + $signed(rookMap[143:138]));
			`B_QUEEN: squareScore[40] = -1 * (queenValueSigned + $signed(queenMap[143:138]));
			`B_KING: squareScore[40] = -1 * (kingValueSigned + $signed(kingMap[143:138]));
			default: squareScore[40] = 0;
		endcase
		
		case (board[41]) //square 41
			`W_PAWN: squareScore[41] = pawnValueSigned + $signed(pawnMap[251:246]);
			`W_KNIGHT: squareScore[41] = knightValueSigned + $signed(knightMap[251:246]);
			`W_BISHOP: squareScore[41] = bishopValueSigned + $signed(bishopMap[251:246]);
			`W_ROOK: squareScore[41] = rookValueSigned + $signed(rookMap[251:246]);
			`W_QUEEN: squareScore[41] = queenValueSigned + $signed(queenMap[251:246]);
			`W_KING: squareScore[41] = kingValueSigned + $signed(kingMap[251:246]);
			`B_PAWN: squareScore[41] = -1 * (pawnValueSigned + $signed(pawnMap[137:132]));
			`B_KNIGHT: squareScore[41] = -1 * (knightValueSigned + $signed(knightMap[137:132]));
			`B_BISHOP: squareScore[41] = -1 * (bishopValueSigned + $signed(bishopMap[137:132]));
			`B_ROOK: squareScore[41] = -1 * (rookValueSigned + $signed(rookMap[137:132]));
			`B_QUEEN: squareScore[41] = -1 * (queenValueSigned + $signed(queenMap[137:132]));
			`B_KING: squareScore[41] = -1 * (kingValueSigned + $signed(kingMap[137:132]));
			default: squareScore[41] = 0;
		endcase
		
		case (board[42]) //square 42
			`W_PAWN: squareScore[42] = pawnValueSigned + $signed(pawnMap[257:252]);
			`W_KNIGHT: squareScore[42] = knightValueSigned + $signed(knightMap[257:252]);
			`W_BISHOP: squareScore[42] = bishopValueSigned + $signed(bishopMap[257:252]);
			`W_ROOK: squareScore[42] = rookValueSigned + $signed(rookMap[257:252]);
			`W_QUEEN: squareScore[42] = queenValueSigned + $signed(queenMap[257:252]);
			`W_KING: squareScore[42] = kingValueSigned + $signed(kingMap[257:252]);
			`B_PAWN: squareScore[42] = -1 * (pawnValueSigned + $signed(pawnMap[131:126]));
			`B_KNIGHT: squareScore[42] = -1 * (knightValueSigned + $signed(knightMap[131:126]));
			`B_BISHOP: squareScore[42] = -1 * (bishopValueSigned + $signed(bishopMap[131:126]));
			`B_ROOK: squareScore[42] = -1 * (rookValueSigned + $signed(rookMap[131:126]));
			`B_QUEEN: squareScore[42] = -1 * (queenValueSigned + $signed(queenMap[131:126]));
			`B_KING: squareScore[42] = -1 * (kingValueSigned + $signed(kingMap[131:126]));
			default: squareScore[42] = 0;
		endcase
		
		case (board[43]) //square 43
			`W_PAWN: squareScore[43] = pawnValueSigned + $signed(pawnMap[263:258]);
			`W_KNIGHT: squareScore[43] = knightValueSigned + $signed(knightMap[263:258]);
			`W_BISHOP: squareScore[43] = bishopValueSigned + $signed(bishopMap[263:258]);
			`W_ROOK: squareScore[43] = rookValueSigned + $signed(rookMap[263:258]);
			`W_QUEEN: squareScore[43] = queenValueSigned + $signed(queenMap[263:258]);
			`W_KING: squareScore[43] = kingValueSigned + $signed(kingMap[263:258]);
			`B_PAWN: squareScore[43] = -1 * (pawnValueSigned + $signed(pawnMap[125:120]));
			`B_KNIGHT: squareScore[43] = -1 * (knightValueSigned + $signed(knightMap[125:120]));
			`B_BISHOP: squareScore[43] = -1 * (bishopValueSigned + $signed(bishopMap[125:120]));
			`B_ROOK: squareScore[43] = -1 * (rookValueSigned + $signed(rookMap[125:120]));
			`B_QUEEN: squareScore[43] = -1 * (queenValueSigned + $signed(queenMap[125:120]));
			`B_KING: squareScore[43] = -1 * (kingValueSigned + $signed(kingMap[125:120]));
			default: squareScore[43] = 0;
		endcase
		
		case (board[44]) //square 44
			`W_PAWN: squareScore[44] = pawnValueSigned + $signed(pawnMap[269:264]);
			`W_KNIGHT: squareScore[44] = knightValueSigned + $signed(knightMap[269:264]);
			`W_BISHOP: squareScore[44] = bishopValueSigned + $signed(bishopMap[269:264]);
			`W_ROOK: squareScore[44] = rookValueSigned + $signed(rookMap[269:264]);
			`W_QUEEN: squareScore[44] = queenValueSigned + $signed(queenMap[269:264]);
			`W_KING: squareScore[44] = kingValueSigned + $signed(kingMap[269:264]);
			`B_PAWN: squareScore[44] = -1 * (pawnValueSigned + $signed(pawnMap[119:114]));
			`B_KNIGHT: squareScore[44] = -1 * (knightValueSigned + $signed(knightMap[119:114]));
			`B_BISHOP: squareScore[44] = -1 * (bishopValueSigned + $signed(bishopMap[119:114]));
			`B_ROOK: squareScore[44] = -1 * (rookValueSigned + $signed(rookMap[119:114]));
			`B_QUEEN: squareScore[44] = -1 * (queenValueSigned + $signed(queenMap[119:114]));
			`B_KING: squareScore[44] = -1 * (kingValueSigned + $signed(kingMap[119:114]));
			default: squareScore[44] = 0;
		endcase
		
		case (board[45]) //square 45
			`W_PAWN: squareScore[45] = pawnValueSigned + $signed(pawnMap[275:270]);
			`W_KNIGHT: squareScore[45] = knightValueSigned + $signed(knightMap[275:270]);
			`W_BISHOP: squareScore[45] = bishopValueSigned + $signed(bishopMap[275:270]);
			`W_ROOK: squareScore[45] = rookValueSigned + $signed(rookMap[275:270]);
			`W_QUEEN: squareScore[45] = queenValueSigned + $signed(queenMap[275:270]);
			`W_KING: squareScore[45] = kingValueSigned + $signed(kingMap[275:270]);
			`B_PAWN: squareScore[45] = -1 * (pawnValueSigned + $signed(pawnMap[113:108]));
			`B_KNIGHT: squareScore[45] = -1 * (knightValueSigned + $signed(knightMap[113:108]));
			`B_BISHOP: squareScore[45] = -1 * (bishopValueSigned + $signed(bishopMap[113:108]));
			`B_ROOK: squareScore[45] = -1 * (rookValueSigned + $signed(rookMap[113:108]));
			`B_QUEEN: squareScore[45] = -1 * (queenValueSigned + $signed(queenMap[113:108]));
			`B_KING: squareScore[45] = -1 * (kingValueSigned + $signed(kingMap[113:108]));
			default: squareScore[45] = 0;
		endcase
		
		case (board[46]) //square 46
			`W_PAWN: squareScore[46] = pawnValueSigned + $signed(pawnMap[281:276]);
			`W_KNIGHT: squareScore[46] = knightValueSigned + $signed(knightMap[281:276]);
			`W_BISHOP: squareScore[46] = bishopValueSigned + $signed(bishopMap[281:276]);
			`W_ROOK: squareScore[46] = rookValueSigned + $signed(rookMap[281:276]);
			`W_QUEEN: squareScore[46] = queenValueSigned + $signed(queenMap[281:276]);
			`W_KING: squareScore[46] = kingValueSigned + $signed(kingMap[281:276]);
			`B_PAWN: squareScore[46] = -1 * (pawnValueSigned + $signed(pawnMap[107:102]));
			`B_KNIGHT: squareScore[46] = -1 * (knightValueSigned + $signed(knightMap[107:102]));
			`B_BISHOP: squareScore[46] = -1 * (bishopValueSigned + $signed(bishopMap[107:102]));
			`B_ROOK: squareScore[46] = -1 * (rookValueSigned + $signed(rookMap[107:102]));
			`B_QUEEN: squareScore[46] = -1 * (queenValueSigned + $signed(queenMap[107:102]));
			`B_KING: squareScore[46] = -1 * (kingValueSigned + $signed(kingMap[107:102]));
			default: squareScore[46] = 0;
		endcase
		
		case (board[47]) //square 47
			`W_PAWN: squareScore[47] = pawnValueSigned + $signed(pawnMap[287:282]);
			`W_KNIGHT: squareScore[47] = knightValueSigned + $signed(knightMap[287:282]);
			`W_BISHOP: squareScore[47] = bishopValueSigned + $signed(bishopMap[287:282]);
			`W_ROOK: squareScore[47] = rookValueSigned + $signed(rookMap[287:282]);
			`W_QUEEN: squareScore[47] = queenValueSigned + $signed(queenMap[287:282]);
			`W_KING: squareScore[47] = kingValueSigned + $signed(kingMap[287:282]);
			`B_PAWN: squareScore[47] = -1 * (pawnValueSigned + $signed(pawnMap[101:96]));
			`B_KNIGHT: squareScore[47] = -1 * (knightValueSigned + $signed(knightMap[101:96]));
			`B_BISHOP: squareScore[47] = -1 * (bishopValueSigned + $signed(bishopMap[101:96]));
			`B_ROOK: squareScore[47] = -1 * (rookValueSigned + $signed(rookMap[101:96]));
			`B_QUEEN: squareScore[47] = -1 * (queenValueSigned + $signed(queenMap[101:96]));
			`B_KING: squareScore[47] = -1 * (kingValueSigned + $signed(kingMap[101:96]));
			default: squareScore[47] = 0;
		endcase
		
		case (board[48]) //square 48
			`W_PAWN: squareScore[48] = pawnValueSigned + $signed(pawnMap[293:288]);
			`W_KNIGHT: squareScore[48] = knightValueSigned + $signed(knightMap[293:288]);
			`W_BISHOP: squareScore[48] = bishopValueSigned + $signed(bishopMap[293:288]);
			`W_ROOK: squareScore[48] = rookValueSigned + $signed(rookMap[293:288]);
			`W_QUEEN: squareScore[48] = queenValueSigned + $signed(queenMap[293:288]);
			`W_KING: squareScore[48] = kingValueSigned + $signed(kingMap[293:288]);
			`B_PAWN: squareScore[48] = -1 * (pawnValueSigned + $signed(pawnMap[95:90]));
			`B_KNIGHT: squareScore[48] = -1 * (knightValueSigned + $signed(knightMap[95:90]));
			`B_BISHOP: squareScore[48] = -1 * (bishopValueSigned + $signed(bishopMap[95:90]));
			`B_ROOK: squareScore[48] = -1 * (rookValueSigned + $signed(rookMap[95:90]));
			`B_QUEEN: squareScore[48] = -1 * (queenValueSigned + $signed(queenMap[95:90]));
			`B_KING: squareScore[48] = -1 * (kingValueSigned + $signed(kingMap[95:90]));
			default: squareScore[48] = 0;
		endcase
		
		case (board[49]) //square 49
			`W_PAWN: squareScore[49] = pawnValueSigned + $signed(pawnMap[299:294]);
			`W_KNIGHT: squareScore[49] = knightValueSigned + $signed(knightMap[299:294]);
			`W_BISHOP: squareScore[49] = bishopValueSigned + $signed(bishopMap[299:294]);
			`W_ROOK: squareScore[49] = rookValueSigned + $signed(rookMap[299:294]);
			`W_QUEEN: squareScore[49] = queenValueSigned + $signed(queenMap[299:294]);
			`W_KING: squareScore[49] = kingValueSigned + $signed(kingMap[299:294]);
			`B_PAWN: squareScore[49] = -1 * (pawnValueSigned + $signed(pawnMap[89:84]));
			`B_KNIGHT: squareScore[49] = -1 * (knightValueSigned + $signed(knightMap[89:84]));
			`B_BISHOP: squareScore[49] = -1 * (bishopValueSigned + $signed(bishopMap[89:84]));
			`B_ROOK: squareScore[49] = -1 * (rookValueSigned + $signed(rookMap[89:84]));
			`B_QUEEN: squareScore[49] = -1 * (queenValueSigned + $signed(queenMap[89:84]));
			`B_KING: squareScore[49] = -1 * (kingValueSigned + $signed(kingMap[89:84]));
			default: squareScore[49] = 0;
		endcase
		
		case (board[50]) //square 50
			`W_PAWN: squareScore[50] = pawnValueSigned + $signed(pawnMap[305:300]);
			`W_KNIGHT: squareScore[50] = knightValueSigned + $signed(knightMap[305:300]);
			`W_BISHOP: squareScore[50] = bishopValueSigned + $signed(bishopMap[305:300]);
			`W_ROOK: squareScore[50] = rookValueSigned + $signed(rookMap[305:300]);
			`W_QUEEN: squareScore[50] = queenValueSigned + $signed(queenMap[305:300]);
			`W_KING: squareScore[50] = kingValueSigned + $signed(kingMap[305:300]);
			`B_PAWN: squareScore[50] = -1 * (pawnValueSigned + $signed(pawnMap[83:78]));
			`B_KNIGHT: squareScore[50] = -1 * (knightValueSigned + $signed(knightMap[83:78]));
			`B_BISHOP: squareScore[50] = -1 * (bishopValueSigned + $signed(bishopMap[83:78]));
			`B_ROOK: squareScore[50] = -1 * (rookValueSigned + $signed(rookMap[83:78]));
			`B_QUEEN: squareScore[50] = -1 * (queenValueSigned + $signed(queenMap[83:78]));
			`B_KING: squareScore[50] = -1 * (kingValueSigned + $signed(kingMap[83:78]));
			default: squareScore[50] = 0;
		endcase
		
		case (board[51]) //square 51
			`W_PAWN: squareScore[51] = pawnValueSigned + $signed(pawnMap[311:306]);
			`W_KNIGHT: squareScore[51] = knightValueSigned + $signed(knightMap[311:306]);
			`W_BISHOP: squareScore[51] = bishopValueSigned + $signed(bishopMap[311:306]);
			`W_ROOK: squareScore[51] = rookValueSigned + $signed(rookMap[311:306]);
			`W_QUEEN: squareScore[51] = queenValueSigned + $signed(queenMap[311:306]);
			`W_KING: squareScore[51] = kingValueSigned + $signed(kingMap[311:306]);
			`B_PAWN: squareScore[51] = -1 * (pawnValueSigned + $signed(pawnMap[77:72]));
			`B_KNIGHT: squareScore[51] = -1 * (knightValueSigned + $signed(knightMap[77:72]));
			`B_BISHOP: squareScore[51] = -1 * (bishopValueSigned + $signed(bishopMap[77:72]));
			`B_ROOK: squareScore[51] = -1 * (rookValueSigned + $signed(rookMap[77:72]));
			`B_QUEEN: squareScore[51] = -1 * (queenValueSigned + $signed(queenMap[77:72]));
			`B_KING: squareScore[51] = -1 * (kingValueSigned + $signed(kingMap[77:72]));
			default: squareScore[51] = 0;
		endcase
		
		case (board[52]) //square 52
			`W_PAWN: squareScore[52] = pawnValueSigned + $signed(pawnMap[317:312]);
			`W_KNIGHT: squareScore[52] = knightValueSigned + $signed(knightMap[317:312]);
			`W_BISHOP: squareScore[52] = bishopValueSigned + $signed(bishopMap[317:312]);
			`W_ROOK: squareScore[52] = rookValueSigned + $signed(rookMap[317:312]);
			`W_QUEEN: squareScore[52] = queenValueSigned + $signed(queenMap[317:312]);
			`W_KING: squareScore[52] = kingValueSigned + $signed(kingMap[317:312]);
			`B_PAWN: squareScore[52] = -1 * (pawnValueSigned + $signed(pawnMap[71:66]));
			`B_KNIGHT: squareScore[52] = -1 * (knightValueSigned + $signed(knightMap[71:66]));
			`B_BISHOP: squareScore[52] = -1 * (bishopValueSigned + $signed(bishopMap[71:66]));
			`B_ROOK: squareScore[52] = -1 * (rookValueSigned + $signed(rookMap[71:66]));
			`B_QUEEN: squareScore[52] = -1 * (queenValueSigned + $signed(queenMap[71:66]));
			`B_KING: squareScore[52] = -1 * (kingValueSigned + $signed(kingMap[71:66]));
			default: squareScore[52] = 0;
		endcase
		
		case (board[53]) //square 53
			`W_PAWN: squareScore[53] = pawnValueSigned + $signed(pawnMap[323:318]);
			`W_KNIGHT: squareScore[53] = knightValueSigned + $signed(knightMap[323:318]);
			`W_BISHOP: squareScore[53] = bishopValueSigned + $signed(bishopMap[323:318]);
			`W_ROOK: squareScore[53] = rookValueSigned + $signed(rookMap[323:318]);
			`W_QUEEN: squareScore[53] = queenValueSigned + $signed(queenMap[323:318]);
			`W_KING: squareScore[53] = kingValueSigned + $signed(kingMap[323:318]);
			`B_PAWN: squareScore[53] = -1 * (pawnValueSigned + $signed(pawnMap[65:60]));
			`B_KNIGHT: squareScore[53] = -1 * (knightValueSigned + $signed(knightMap[65:60]));
			`B_BISHOP: squareScore[53] = -1 * (bishopValueSigned + $signed(bishopMap[65:60]));
			`B_ROOK: squareScore[53] = -1 * (rookValueSigned + $signed(rookMap[65:60]));
			`B_QUEEN: squareScore[53] = -1 * (queenValueSigned + $signed(queenMap[65:60]));
			`B_KING: squareScore[53] = -1 * (kingValueSigned + $signed(kingMap[65:60]));
			default: squareScore[53] = 0;
		endcase
		
		case (board[54]) //square 54
			`W_PAWN: squareScore[54] = pawnValueSigned + $signed(pawnMap[329:324]);
			`W_KNIGHT: squareScore[54] = knightValueSigned + $signed(knightMap[329:324]);
			`W_BISHOP: squareScore[54] = bishopValueSigned + $signed(bishopMap[329:324]);
			`W_ROOK: squareScore[54] = rookValueSigned + $signed(rookMap[329:324]);
			`W_QUEEN: squareScore[54] = queenValueSigned + $signed(queenMap[329:324]);
			`W_KING: squareScore[54] = kingValueSigned + $signed(kingMap[329:324]);
			`B_PAWN: squareScore[54] = -1 * (pawnValueSigned + $signed(pawnMap[59:54]));
			`B_KNIGHT: squareScore[54] = -1 * (knightValueSigned + $signed(knightMap[59:54]));
			`B_BISHOP: squareScore[54] = -1 * (bishopValueSigned + $signed(bishopMap[59:54]));
			`B_ROOK: squareScore[54] = -1 * (rookValueSigned + $signed(rookMap[59:54]));
			`B_QUEEN: squareScore[54] = -1 * (queenValueSigned + $signed(queenMap[59:54]));
			`B_KING: squareScore[54] = -1 * (kingValueSigned + $signed(kingMap[59:54]));
			default: squareScore[54] = 0;
		endcase
		
		case (board[55]) //square 55
			`W_PAWN: squareScore[55] = pawnValueSigned + $signed(pawnMap[335:330]);
			`W_KNIGHT: squareScore[55] = knightValueSigned + $signed(knightMap[335:330]);
			`W_BISHOP: squareScore[55] = bishopValueSigned + $signed(bishopMap[335:330]);
			`W_ROOK: squareScore[55] = rookValueSigned + $signed(rookMap[335:330]);
			`W_QUEEN: squareScore[55] = queenValueSigned + $signed(queenMap[335:330]);
			`W_KING: squareScore[55] = kingValueSigned + $signed(kingMap[335:330]);
			`B_PAWN: squareScore[55] = -1 * (pawnValueSigned + $signed(pawnMap[53:48]));
			`B_KNIGHT: squareScore[55] = -1 * (knightValueSigned + $signed(knightMap[53:48]));
			`B_BISHOP: squareScore[55] = -1 * (bishopValueSigned + $signed(bishopMap[53:48]));
			`B_ROOK: squareScore[55] = -1 * (rookValueSigned + $signed(rookMap[53:48]));
			`B_QUEEN: squareScore[55] = -1 * (queenValueSigned + $signed(queenMap[53:48]));
			`B_KING: squareScore[55] = -1 * (kingValueSigned + $signed(kingMap[53:48]));
			default: squareScore[55] = 0;
		endcase
		
		case (board[56]) //square 56
			`W_PAWN: squareScore[56] = pawnValueSigned + $signed(pawnMap[341:336]);
			`W_KNIGHT: squareScore[56] = knightValueSigned + $signed(knightMap[341:336]);
			`W_BISHOP: squareScore[56] = bishopValueSigned + $signed(bishopMap[341:336]);
			`W_ROOK: squareScore[56] = rookValueSigned + $signed(rookMap[341:336]);
			`W_QUEEN: squareScore[56] = queenValueSigned + $signed(queenMap[341:336]);
			`W_KING: squareScore[56] = kingValueSigned + $signed(kingMap[341:336]);
			`B_PAWN: squareScore[56] = -1 * (pawnValueSigned + $signed(pawnMap[47:42]));
			`B_KNIGHT: squareScore[56] = -1 * (knightValueSigned + $signed(knightMap[47:42]));
			`B_BISHOP: squareScore[56] = -1 * (bishopValueSigned + $signed(bishopMap[47:42]));
			`B_ROOK: squareScore[56] = -1 * (rookValueSigned + $signed(rookMap[47:42]));
			`B_QUEEN: squareScore[56] = -1 * (queenValueSigned + $signed(queenMap[47:42]));
			`B_KING: squareScore[56] = -1 * (kingValueSigned + $signed(kingMap[5:0]));
			default: squareScore[56] = 0;
		endcase
		
		case (board[57]) //square 57
			`W_PAWN: squareScore[57] = pawnValueSigned + $signed(pawnMap[347:342]);
			`W_KNIGHT: squareScore[57] = knightValueSigned + $signed(knightMap[347:342]);
			`W_BISHOP: squareScore[57] = bishopValueSigned + $signed(bishopMap[347:342]);
			`W_ROOK: squareScore[57] = rookValueSigned + $signed(rookMap[347:342]);
			`W_QUEEN: squareScore[57] = queenValueSigned + $signed(queenMap[347:342]);
			`W_KING: squareScore[57] = kingValueSigned + $signed(kingMap[347:342]);
			`B_PAWN: squareScore[57] = -1 * (pawnValueSigned + $signed(pawnMap[41:36]));
			`B_KNIGHT: squareScore[57] = -1 * (knightValueSigned + $signed(knightMap[41:36]));
			`B_BISHOP: squareScore[57] = -1 * (bishopValueSigned + $signed(bishopMap[41:36]));
			`B_ROOK: squareScore[57] = -1 * (rookValueSigned + $signed(rookMap[41:36]));
			`B_QUEEN: squareScore[57] = -1 * (queenValueSigned + $signed(queenMap[41:36]));
			`B_KING: squareScore[57] = -1 * (kingValueSigned + $signed(kingMap[11:6]));
			default: squareScore[57] = 0;
		endcase
		
		case (board[58]) //square 58
			`W_PAWN: squareScore[58] = pawnValueSigned + $signed(pawnMap[353:348]);
			`W_KNIGHT: squareScore[58] = knightValueSigned + $signed(knightMap[353:348]);
			`W_BISHOP: squareScore[58] = bishopValueSigned + $signed(bishopMap[353:348]);
			`W_ROOK: squareScore[58] = rookValueSigned + $signed(rookMap[353:348]);
			`W_QUEEN: squareScore[58] = queenValueSigned + $signed(queenMap[353:348]);
			`W_KING: squareScore[58] = kingValueSigned + $signed(kingMap[353:348]);
			`B_PAWN: squareScore[58] = -1 * (pawnValueSigned + $signed(pawnMap[35:30]));
			`B_KNIGHT: squareScore[58] = -1 * (knightValueSigned + $signed(knightMap[35:30]));
			`B_BISHOP: squareScore[58] = -1 * (bishopValueSigned + $signed(bishopMap[35:30]));
			`B_ROOK: squareScore[58] = -1 * (rookValueSigned + $signed(rookMap[35:30]));
			`B_QUEEN: squareScore[58] = -1 * (queenValueSigned + $signed(queenMap[35:30]));
			`B_KING: squareScore[58] = -1 * (kingValueSigned + $signed(kingMap[17:12]));
			default: squareScore[58] = 0;
		endcase
		
		case (board[59]) //square 59
			`W_PAWN: squareScore[59] = pawnValueSigned + $signed(pawnMap[359:354]);
			`W_KNIGHT: squareScore[59] = knightValueSigned + $signed(knightMap[359:354]);
			`W_BISHOP: squareScore[59] = bishopValueSigned + $signed(bishopMap[359:354]);
			`W_ROOK: squareScore[59] = rookValueSigned + $signed(rookMap[359:354]);
			`W_QUEEN: squareScore[59] = queenValueSigned + $signed(queenMap[359:354]);
			`W_KING: squareScore[59] = kingValueSigned + $signed(kingMap[359:354]);
			`B_PAWN: squareScore[59] = -1 * (pawnValueSigned + $signed(pawnMap[29:24]));
			`B_KNIGHT: squareScore[59] = -1 * (knightValueSigned + $signed(knightMap[29:24]));
			`B_BISHOP: squareScore[59] = -1 * (bishopValueSigned + $signed(bishopMap[29:24]));
			`B_ROOK: squareScore[59] = -1 * (rookValueSigned + $signed(rookMap[29:24]));
			`B_QUEEN: squareScore[59] = -1 * (queenValueSigned + $signed(queenMap[29:24]));
			`B_KING: squareScore[59] = -1 * (kingValueSigned + $signed(kingMap[23:18]));
			default: squareScore[59] = 0;
		endcase
		
		case (board[60]) //square 60
			`W_PAWN: squareScore[60] = pawnValueSigned + $signed(pawnMap[365:360]);
			`W_KNIGHT: squareScore[60] = knightValueSigned + $signed(knightMap[365:360]);
			`W_BISHOP: squareScore[60] = bishopValueSigned + $signed(bishopMap[365:360]);
			`W_ROOK: squareScore[60] = rookValueSigned + $signed(rookMap[365:360]);
			`W_QUEEN: squareScore[60] = queenValueSigned + $signed(queenMap[365:360]);
			`W_KING: squareScore[60] = kingValueSigned + $signed(kingMap[365:360]);
			`B_PAWN: squareScore[60] = -1 * (pawnValueSigned + $signed(pawnMap[23:18]));
			`B_KNIGHT: squareScore[60] = -1 * (knightValueSigned + $signed(knightMap[23:18]));
			`B_BISHOP: squareScore[60] = -1 * (bishopValueSigned + $signed(bishopMap[23:18]));
			`B_ROOK: squareScore[60] = -1 * (rookValueSigned + $signed(rookMap[23:18]));
			`B_QUEEN: squareScore[60] = -1 * (queenValueSigned + $signed(queenMap[23:18]));
			`B_KING: squareScore[60] = -1 * (kingValueSigned + $signed(kingMap[29:24]));
			default: squareScore[60] = 0;
		endcase
		
		case (board[61]) //square 61
			`W_PAWN: squareScore[61] = pawnValueSigned + $signed(pawnMap[371:366]);
			`W_KNIGHT: squareScore[61] = knightValueSigned + $signed(knightMap[371:366]);
			`W_BISHOP: squareScore[61] = bishopValueSigned + $signed(bishopMap[371:366]);
			`W_ROOK: squareScore[61] = rookValueSigned + $signed(rookMap[371:366]);
			`W_QUEEN: squareScore[61] = queenValueSigned + $signed(queenMap[371:366]);
			`W_KING: squareScore[61] = kingValueSigned + $signed(kingMap[371:366]);
			`B_PAWN: squareScore[61] = -1 * (pawnValueSigned + $signed(pawnMap[17:12]));
			`B_KNIGHT: squareScore[61] = -1 * (knightValueSigned + $signed(knightMap[17:12]));
			`B_BISHOP: squareScore[61] = -1 * (bishopValueSigned + $signed(bishopMap[17:12]));
			`B_ROOK: squareScore[61] = -1 * (rookValueSigned + $signed(rookMap[17:12]));
			`B_QUEEN: squareScore[61] = -1 * (queenValueSigned + $signed(queenMap[17:12]));
			`B_KING: squareScore[61] = -1 * (kingValueSigned + $signed(kingMap[35:30]));
			default: squareScore[61] = 0;
		endcase
		
		case (board[62]) //square 62
			`W_PAWN: squareScore[62] = pawnValueSigned + $signed(pawnMap[377:372]);
			`W_KNIGHT: squareScore[62] = knightValueSigned + $signed(knightMap[377:372]);
			`W_BISHOP: squareScore[62] = bishopValueSigned + $signed(bishopMap[377:372]);
			`W_ROOK: squareScore[62] = rookValueSigned + $signed(rookMap[377:372]);
			`W_QUEEN: squareScore[62] = queenValueSigned + $signed(queenMap[377:372]);
			`W_KING: squareScore[62] = kingValueSigned + $signed(kingMap[377:372]);
			`B_PAWN: squareScore[62] = -1 * (pawnValueSigned + $signed(pawnMap[11:6]));
			`B_KNIGHT: squareScore[62] = -1 * (knightValueSigned + $signed(knightMap[11:6]));
			`B_BISHOP: squareScore[62] = -1 * (bishopValueSigned + $signed(bishopMap[11:6]));
			`B_ROOK: squareScore[62] = -1 * (rookValueSigned + $signed(rookMap[11:6]));
			`B_QUEEN: squareScore[62] = -1 * (queenValueSigned + $signed(queenMap[11:6]));
			`B_KING: squareScore[62] = -1 * (kingValueSigned + $signed(kingMap[41:36]));
			default: squareScore[62] = 0;
		endcase
		
		case (board[63]) //square 63
			`W_PAWN: squareScore[63] = pawnValueSigned + $signed(pawnMap[383:378]);
			`W_KNIGHT: squareScore[63] = knightValueSigned + $signed(knightMap[383:378]);
			`W_BISHOP: squareScore[63] = bishopValueSigned + $signed(bishopMap[383:378]);
			`W_ROOK: squareScore[63] = rookValueSigned + $signed(rookMap[383:378]);
			`W_QUEEN: squareScore[63] = queenValueSigned + $signed(queenMap[383:378]);
			`W_KING: squareScore[63] = kingValueSigned + $signed(kingMap[383:378]);
			`B_PAWN: squareScore[63] = -1 * (pawnValueSigned + $signed(pawnMap[5:0]));
			`B_KNIGHT: squareScore[63] = -1 * (knightValueSigned + $signed(knightMap[5:0]));
			`B_BISHOP: squareScore[63] = -1 * (bishopValueSigned + $signed(bishopMap[5:0]));
			`B_ROOK: squareScore[63] = -1 * (rookValueSigned + $signed(rookMap[5:0]));
			`B_QUEEN: squareScore[63] = -1 * (queenValueSigned + $signed(queenMap[5:0]));
			`B_KING: squareScore[63] = -1 * (kingValueSigned + $signed(kingMap[47:42]));
			default: squareScore[63] = 0;
		endcase
	end//end if(start == 1)
	
	totalScore_c = squareScore[0] + squareScore[1] + squareScore[2] + squareScore[3] + squareScore[4] + squareScore[5] + squareScore[6] + squareScore[7] + squareScore[8] + squareScore[9] + squareScore[10] + squareScore[11] + squareScore[12] + squareScore[13] + squareScore[14] + squareScore[15] + squareScore[16] + squareScore[17] + squareScore[18] + squareScore[19] + squareScore[20] + squareScore[21] + squareScore[22] + squareScore[23] + squareScore[24] + squareScore[25] + squareScore[26] + squareScore[27] + squareScore[28] + squareScore[29] + squareScore[30] + squareScore[31] + squareScore[32] + squareScore[33] + squareScore[34] + squareScore[35] + squareScore[36] + squareScore[37] + squareScore[38] + squareScore[39] + squareScore[40] + squareScore[41] + squareScore[42] + squareScore[43] + squareScore[44] + squareScore[45] + squareScore[46] + squareScore[47] + squareScore[48] + squareScore[49] + squareScore[50] + squareScore[51] + squareScore[52] + squareScore[53] + squareScore[54] + squareScore[55] + squareScore[56] + squareScore[57] + squareScore[58] + squareScore[59] + squareScore[60] + squareScore[61] + squareScore[62] + squareScore[63];
	
end

always @(posedge clk) begin
	totalScore <= #1 totalScore_c;
end

endmodule
