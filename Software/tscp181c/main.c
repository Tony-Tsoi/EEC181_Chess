/*
 *	MAIN.C
 *	Tom Kerrigan's Simple Chess Program (TSCP)
 *
 *	Copyright 2019 Tom Kerrigan
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include "defs.h"
#include "data.h"
#include "protos.h"
#include <math.h>

//============= MY CODE ================================================
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <time.h>

#define HW_REGS_BASE 0xC0000000 // 0xC0000000, 0xfc000000
#define HW_REGS_SPAN 0x40000000 // 0x40000000, 0x04000000
#define HW_REGS_MASK HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST 0xff200000

void *virtual_base;
int fd;
volatile int *Main_Pointer;
//============== Timer stuff ==========================
// Status is high every "startv" number of cycles of the 100 MHz clock.
// Control: Start/stop time.
// Status: Enable bit.
// eoi: Read this to reset timer.
// You need to stop the timer before changing startv.
// Should reset the timer whenever stopping/changing the timer.
// curval: Read this to get current timer count.
volatile int *startv; 
volatile int *control;
volatile int *status;
volatile int *eoi;
volatile int *curval;

volatile int initTime;
volatile int endval;
volatile int SW_to_HW_Timer; // The raw cycle counter read from timer
volatile int HW_to_SW_Timer;
volatile int end_HW_to_SW_Timer; // Subtract this from HW_to_SW_Timer to get HW_to_SW_Cycles
int SW_to_HW_Cycles; // Number of cycles it takes to transfer from SW to HW
int HW_to_SW_Cycles;
int TotalCycles;
double TotalMilliseconds; // Time in milliseconds to transfer from SW to HW
double SW_to_HW_ms;
double HW_to_SW_ms;

double timer_array[1000]; // For total time
double SW_HW_array[1000];
double HW_SW_array[1000];

int computer_side;

// flip_horiz is needed to get the correct DARK side move from the HW
// generated chess move.
int flip_horiz[64] = {
	  7,   6,   5,   4,   3,   2,   1,   0,
	 15,  14,  13,  12,  11,  10,   9,   8,
	 23,  22,  21,  20,  19,  18,  17,  16,
	 31,  30,  29,  28,  27,  26,  25,  24,
	 39,  38,  37,  36,  35,  34,  33,  32,
	 47,  46,  45,  44,  43,  42,  41,  40,
	 55,  54,  53,  52,  51,  50,  49,  48,
	 63,  62,  61,  60,  59,  58,  57,  56
};

void computer_move(int output, int messages)
{
	
	think(output, messages); // 1 for normal output, 2 for xboard
	
	if (!pv[0][0].u) { 
		computer_side = EMPTY;
		//printf("Passing control to user.\n");
		return;
	}
	
	if (messages){printf("move %s\n", move_str(pv[0][0].b));}
	
	//if (makemove(pv[0][0].b) == FALSE)
	//{
	//	printf("INVALID MOVE!!! STOPPING!!\n");
	//	while(1){;}
	//}
		
	makemove(pv[0][0].b);
	ply = 0;
	gen();
	if (messages){print_result();}
}

void init_timer()
{
	startv  = (int*) get_virtual_addr(0xFF200000, 0x00A08000, 0); 
	control = (int*) get_virtual_addr(0xFF200000, 0x00A08008, 0);
	status  = (int*) get_virtual_addr(0xFF200000, 0x00A08010, 0);
	eoi     = (int*) get_virtual_addr(0xFF200000, 0x00A0800C, 0);
	curval  = (int*) get_virtual_addr(0xFF200000, 0x00A08004, 0);
}

void start_timer()
{
	*control = 0b10; // Stop timer
	*startv = 0xffffffff; //
	*eoi; // Read eoi to reset timer
	*control = 0b11; // Start timer
	initTime = *curval;
}

void stop_timer()
{
	endval = *curval;
	TotalCycles =  initTime - endval;
	*control = 0b10; // stop timer
	TotalMilliseconds = TotalCycles/100000.0;
	
	
	SW_to_HW_Cycles = initTime - SW_to_HW_Timer;
	HW_to_SW_Cycles = HW_to_SW_Timer - endval; //end_HW_to_SW_Timer
	SW_to_HW_ms = SW_to_HW_Cycles/100000.0;
	HW_to_SW_ms = HW_to_SW_Cycles/100000.0;
}

void load1(char* s)
{
	init_board();
	
    int i; // Loop variable
    int k; // Loop variable
    int j = 0; // Square position
    // Extract the first token
    char* token = strtok(s, "/");
    // loop through the string to extract all other tokens
    while (token != NULL)
    {
        //printf(" %s\n", token); //printing each token
        i = 0;
        while (token[i] != NULL)
        {
            switch (token[i])
            {
            case 'p': color[j] = DARK; piece[j] = PAWN; break;
            case 'r': color[j] = DARK; piece[j] = ROOK; break;
            case 'n': color[j] = DARK; piece[j] = KNIGHT; break;
            case 'b': color[j] = DARK; piece[j] = BISHOP; break;
            case 'q': color[j] = DARK; piece[j] = QUEEN; break;
            case 'k': color[j] = DARK; piece[j] = KING; break;
            case 'P': color[j] = LIGHT; piece[j] = PAWN; break;
            case 'R': color[j] = LIGHT; piece[j] = ROOK; break;
            case 'N': color[j] = LIGHT; piece[j] = KNIGHT; break;
            case 'B': color[j] = LIGHT; piece[j] = BISHOP; break;
            case 'Q': color[j] = LIGHT; piece[j] = QUEEN; break;
            case 'K': color[j] = LIGHT; piece[j] = KING; break; 
            case '/': j--; break;
            case '1': for (k = 0; k < 1; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } break;
            case '2': for (k = 0; k < 2; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j++; break;
            case '3': for (k = 0; k < 3; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j += 2; break;
            case '4': for (k = 0; k < 4; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j += 3; break;
            case '5': for (k = 0; k < 5; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j += 4; break;
            case '6': for (k = 0; k < 6; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j += 5; break;
            case '7': for (k = 0; k < 7; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j += 6; break;
            case '8': for (k = 0; k < 8; k++) { color[j+k] = EMPTY; piece[j+k] = EMPTY; } j += 7; break;
            default:;
            }
            j++;
            i++;
        }
        token = strtok(NULL, "/");
    }
    
    set_hash();

}

void perft(int i)
{
	char s[256];
	
	switch(i)
	{
		case 2: sprintf(s, "r3k2r/p1ppqpb1/bn2pnp1/3PN3/1p2P3/2N2Q1p/PPPBBPPP/R3K2R"); break;
		case 3: sprintf(s, "8/2p5/3p4/KP5r/1R3p1k/8/4P1P1/8"); break;
		case 4: sprintf(s, "r3k2r/Pppp1ppp/1b3nbN/nP6/BBP1P3/q4N2/Pp1P2PP/R2Q1RK1"); break;
		case 5: sprintf(s, "rnbq1k1r/pp1Pbppp/2p5/8/2B5/8/PPP1NnPP/RNBQK2R"); break;
		case 6: sprintf(s, "r4rk1/1pp1qppp/p1np1n2/2b1p1B1/2B1P1b1/P1NP1N2/1PP1QPPP/R4RK1"); break;
		default: sprintf(s, "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"); break; // Default board
	}
	
	load1(s);
}

//=====================================================================
// send_board_state: Sends the current boardstate from SW to HW
//=====================================================================
void send_board_state()
{
	volatile int *SW_HW_Data  = (int*) get_virtual_addr(0xC0000000, 0x0, 0);
	int i, j; // i: loop variable, j: counter
	int current_color;  // 1 bit color data (EMPTY is 6 in TSCP)
	//int current_piece;  // 3 bit piece data (EMPTY is 6 in TSCP)
	int current_square; // 4 bit square data
	int current_word;   // 32 bit that's written
	//int from;
	//int to;
	
	current_word = 0;
	j = 2;
	
	//======= Transfer board state to HW ============
	for (i = 0; i<64; i++)
	{
		current_color = color[flip[i]];
		
		// If AI is LIGHT then maximize LIGHT i.e. LIGHT pieces
		// are written to memory as LIGHT pieces (bit 3 = 0).
		if(side == LIGHT) 
		{
			switch (current_color)
			{
				case LIGHT:
					current_square = piece[flip[i]] + 1; // +1 because our encoding was 1 off from TSCP's
					break;
				case DARK:
					current_square = 0b1000 | (piece[flip[i]] + 1);
					break;
				default: // EMPTY
					current_square = 0;
			}
			current_word = current_word | (current_square << ((i%8) << 2));
		}
		
		// If AI is DARK then maximize DARK i.e. DARK pieces
		// are written to memory as LIGHT pieces (bit 3 = 0).
		// Remember: Hardware is always maximizing LIGHT
		else // side == DARK
		{
			switch (current_color)
			{
				case DARK:
					current_square = piece[flip[i]] + 1; // +1 because our encoding was 1 off from TSCP's
					break;
				case LIGHT:
					current_square = 0b1000 | (piece[flip[i]] + 1);
					break;
				default: // EMPTY
					current_square = 0;
			}
			current_word = current_word | (current_square << ((7-(i%8)) << 2));
		}
		
		
		
		if (i%8 == 7)
		{
			if (side == LIGHT)
			{
				SW_HW_Data = (int*) get_virtual_addr(0xC0000000, 0x0, j);
				*SW_HW_Data = current_word;
			}
			else // If dark, then we need to write the rows in reverse order
			{
				SW_HW_Data = (int*) get_virtual_addr(0xC0000000, 0x0, 11-j);
				*SW_HW_Data = current_word;
			}
			//printf("current_word: 0x%x\n", current_word);
			current_word = 0;
			j++;
		}
	}
}


//=====================================================================
// get_virtual_addr: Just like the name says, it returns the virtual
// 				     address of a spot in hardware memory.
//
// hw_base    : Hardware base address.
// offset     : Memory address offset from the base address.
// word_offset: Another memory address offset but this value offsets by
//              32 bit words. 0x1 value here would add 0x4 to the final
//              address.
//=====================================================================
unsigned int get_virtual_addr(unsigned int hw_base, unsigned int offset, unsigned int word_offset)
{
	unsigned int address;
	address = (unsigned int)virtual_base + ((unsigned int)(hw_base + offset + (word_offset<<2)) & (unsigned int)(HW_REGS_MASK));
	return address;
}

void memmap_start() 
{	
	if ((fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1)
	{
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
	}
	
	virtual_base = mmap(NULL, HW_REGS_SPAN, PROT_READ|PROT_WRITE, MAP_SHARED, fd, HW_REGS_BASE);
	
	if( virtual_base == MAP_FAILED ) 
	{
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
	}
}

void memmap_stop()
{
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) 
	{
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
	}

	close( fd );
}

int my_parse_move(int from, int to)
{
	int i;

	for (i = 0; i < first_move[1]; ++i)
		if (gen_dat[i].m.b.from == from && gen_dat[i].m.b.to == to) {
				/* if the move is a promotion, handle the promotion piece;
			   assume that the promotion moves occur consecutively in
			   gen_dat. */
			if (gen_dat[i].m.b.bits & 32)
				return QUEEN;
			return i; // returns 1
		}

	// didn't find the move
	return -1;
}


//============= END MY CODE ============================================


/* get_ms() returns the milliseconds elapsed since midnight,
   January 1, 1970. */

#include <sys/timeb.h>
BOOL ftime_ok = FALSE;  /* does ftime return milliseconds? */
int get_ms()
{
	struct timeb timebuffer;
	ftime(&timebuffer);
	if (timebuffer.millitm != 0)
		ftime_ok = TRUE;
	return (timebuffer.time * 1000) + timebuffer.millitm;
}


/* main() is basically an infinite loop that either calls
   think() when it's the computer's turn to move or prompts
   the user for a command (and deciphers it). */

int main()
{
	
	memmap_start();
	Main_Pointer  = (int*) get_virtual_addr(0xC0000000, 0x0, 0);
	init_timer();
	int i,j,k; // Loop variables for main()

	char s[256];
	int m;

	printf("\n");
	printf("Tom Kerrigan's Simple Chess Program (TSCP)\n");
	printf("version 1.81c, 2/3/19\n");
	printf("Copyright 2019 Tom Kerrigan\n");
	printf("\n");
	printf("\"help\" displays a list of commands.\n");
	printf("\n");
	init_hash();
	init_board();
	//open_book();
	
	gen();
	printf("INITIAL GEN COMPLETE\n");
	computer_side = EMPTY;
	max_time = 1 << 25;
	max_depth = 4;

	
	for (;;) {
		if (side == computer_side) {  /* computer's turn */
			computer_move(1, 1);
			continue;	
		}

		/* get user input */
		printf("tscp> ");
		if (scanf("%s", s) == EOF) // scanf is the user input function
			return 0;
			
			
		if (!strcmp(s, "on")) {
			computer_side = side;
			continue;
		}
		if (!strcmp(s, "off")) {
			computer_side = EMPTY;
			continue;
		}
		if (!strcmp(s, "st")) {
			scanf("%d", &max_time);
			max_time *= 1000;
			max_depth = 32;
			continue;
		}
		if (!strcmp(s, "sd")) {
			scanf("%d", &max_depth);
			max_time = 1 << 25;
			continue;
		}
		if (!strcmp(s, "undo")) {
			if (!hply)
				continue;
			computer_side = EMPTY;
			takeback();
			ply = 0;
			gen();
			continue;
		}
		if (!strcmp(s, "new")) {
			computer_side = EMPTY;
			init_board();
			gen();
			continue;
		}
		if (!strcmp(s, "d")) {
			print_board();
			continue;
		}
		if (!strcmp(s, "bench")) {
			computer_side = EMPTY;
			bench();
			continue;
		}
		if (!strcmp(s, "bye")) {
			printf("Share and enjoy!\n");
			break;
		}
		if (!strcmp(s, "xboard")) {
			xboard();
			break;
		}
		if (!strcmp(s, "help")) {
			printf("on - computer plays for the side to move\n");
			printf("off - computer stops playing\n");
			printf("st n - search for n seconds per move\n");
			printf("sd n - search n ply per move\n");
			printf("undo - takes back a move\n");
			printf("new - starts a new game\n");
			printf("d - display the board\n");
			printf("bench - run the built-in benchmark\n");
			printf("bye - exit the program\n");
			printf("xboard - switch to XBoard mode\n");
			printf("Enter moves in coordinate notation, e.g., e2e4, e7e8Q\n");
			continue;
		}
		
		//================= INPUTS I ADDED ============================
		char s1[256];

		if (!strcmp(s, "load1")) {
			printf("Board> ");
			scanf("%s", s1);
			//printf("s1: %s\n", s1);
			computer_side = EMPTY;
			load1(s1);
			gen();
			continue;
		}
		
		int userNum;
		
		if (!strcmp(s, "perft")) {
			printf("Insert # from 1 to 6> ");
			scanf("%d", &userNum);
			computer_side = EMPTY;
			perft(userNum);
			gen();
			continue;
		}
		
		if (!strcmp(s, "bench1")) { // Benchmark for testing move decision time
			double sum = 0.0;
			double sum1 = 0.0; // Used in getting variance
			double average = 0.0;
			double variance = 0.0;
			double stdev = 0.0;
			
			printf("Insert # from 1 to 6> ");
			scanf("%d", &userNum);
			
			for (i = 0; i<1000; i++)
			{
				computer_side = EMPTY;
				perft(userNum);
				gen();
				computer_side = side;
				start_timer();
				computer_move(1, 0);
				stop_timer();
				//printf("Milliseconds: %f ms\n", TotalMilliseconds);
				timer_array[i] = TotalMilliseconds;
				sum = sum + TotalMilliseconds;
			}
			
			average = sum / ((float) 1000);
			
			for (i = 0; i<1000; i++)
			{
				sum1 = sum1 + pow((timer_array[i] - average), 2);
			}
			
			variance = sum1 / ((float) 1000);
			stdev = sqrt(variance);
			
			printf("Average time: %f ms\n", average);
			printf("Standard Deviation: %f ms\n", stdev);
			
			computer_side = EMPTY;
			continue;
		}
		
		if (!strcmp(s, "bench2")) { // Benchmark for testing pseudo move gen time
			double total_sum = 0.0;
			double total_sum1 = 0.0; // Used in getting variance
			double total_average = 0.0;
			double total_variance = 0.0;
			double total_stdev = 0.0;
			
			double SW_HW_sum = 0.0;
			double SW_HW_sum1 = 0.0; // Used in getting variance
			double SW_HW_average = 0.0;
			double SW_HW_variance = 0.0;
			double SW_HW_stdev = 0.0;

			double HW_SW_sum = 0.0;
			double HW_SW_sum1 = 0.0; // Used in getting variance
			double HW_SW_average = 0.0;
			double HW_SW_variance = 0.0;
			double HW_SW_stdev = 0.0;
			
			printf("Insert # from 1 to 6> ");
			scanf("%d", &userNum);
			
			for (i = 0; i<1000; i++)
			{
				computer_side = EMPTY;
				perft(userNum);
				start_timer();
				gen();
				stop_timer();

				timer_array[i] = TotalMilliseconds;
				total_sum = total_sum + TotalMilliseconds;
				
				SW_HW_array[i] = SW_to_HW_ms;
				SW_HW_sum = SW_HW_sum + SW_to_HW_ms;
				
				HW_SW_array[i] = HW_to_SW_ms;
				HW_SW_sum = HW_SW_sum + HW_to_SW_ms;
			}
			
			total_average = total_sum / ((float) 1000);
			SW_HW_average = SW_HW_sum / ((float) 1000);
			HW_SW_average = HW_SW_sum / ((float) 1000);
			
			for (i = 0; i<1000; i++)
			{
				total_sum1 = total_sum1 + pow((timer_array[i] - total_average), 2);
				SW_HW_sum1 = SW_HW_sum1 + pow((SW_HW_array[i] - SW_HW_average), 2);
				HW_SW_sum1 = HW_SW_sum1 + pow((HW_SW_array[i] - HW_SW_average), 2);
			}
			
			total_variance = total_sum1 / ((float) 1000);
			total_stdev = sqrt(total_variance);
			
			SW_HW_variance = SW_HW_sum1 / ((float) 1000);
			SW_HW_stdev = sqrt(SW_HW_variance);
			
			HW_SW_variance = HW_SW_sum1 / ((float) 1000);
			HW_SW_stdev = sqrt(HW_SW_variance);
			
			
			printf("Total Average: %f ms\n", total_average);
			printf("Total Stdev: %f ms\n\n", total_stdev);
			printf("SW_HW Average: %f ms\n", SW_HW_average);
			printf("SW_HW Stdev: %f ms\n\n", SW_HW_stdev);
			printf("HW_SW Average: %f ms\n", HW_SW_average);
			printf("HW_SW Stdev: %f ms\n\n", HW_SW_stdev);
			printf("HW Only Time: %f ms\n\n", total_average - SW_HW_average - HW_SW_average);
			computer_side = EMPTY;
			continue;
		}
		//================= END INPUTS I ADDED =========================
			
		
		/* maybe the user entered a move? */
		m = parse_move(s);
		if (m == -1 || !makemove(gen_dat[m].m.b))
			printf("Illegal move.\n");
		else {
			ply = 0;
			gen();
			print_result();
		}
	}
	close_book();
	memmap_stop();
	return 0;
}


/* parse the move s (in coordinate notation) and return the move's
   index in gen_dat, or -1 if the move is illegal */

int parse_move(char *s)
{
	int from, to, i;

	/* make sure the string looks like a move */
	if (s[0] < 'a' || s[0] > 'h' ||
			s[1] < '0' || s[1] > '9' ||
			s[2] < 'a' || s[2] > 'h' ||
			s[3] < '0' || s[3] > '9')
		return -1;

	from = s[0] - 'a';
	from += 8 * (8 - (s[1] - '0'));
	to = s[2] - 'a';
	to += 8 * (8 - (s[3] - '0'));


	for (i = 0; i < first_move[1]; ++i)
		if (gen_dat[i].m.b.from == from && gen_dat[i].m.b.to == to) {

			/* if the move is a promotion, handle the promotion piece;
			   assume that the promotion moves occur consecutively in
			   gen_dat. */
			if (gen_dat[i].m.b.bits & 32)
				switch (s[4]) { // **** s[4] is NULL therefore we always assume Queen promotion
					case 'N':
					case 'n':
						return i; // returns 1
					case 'B':
					case 'b':
						return i + 1;
					case 'R':
					case 'r':
						return i + 2;
					default:  /* assume it's a queen */
						return i + 3;
				}
			return i; // returns 1
		}

	/* didn't find the move */
	return -1;
}


/* move_str returns a string with move m in coordinate notation */

char *move_str(move_bytes m)
{
	static char str[6];

	char c;

	if (m.bits & 32) {
		switch (m.promote) {
			case KNIGHT:
				c = 'n';
				break;
			case BISHOP:
				c = 'b';
				break;
			case ROOK:
				c = 'r';
				break;
			default:
				c = 'q';
				break;
		}
		sprintf(str, "%c%d%c%d%c",
				COL(m.from) + 'a',
				8 - ROW(m.from),
				COL(m.to) + 'a',
				8 - ROW(m.to),
				c);
	}
	else
		sprintf(str, "%c%d%c%d",
				COL(m.from) + 'a',
				8 - ROW(m.from),
				COL(m.to) + 'a',
				8 - ROW(m.to));
	return str;
}


/* print_board() prints the board */

void print_board()
{
	int i;
	
	printf("\n8 ");
	for (i = 0; i < 64; ++i) {
		switch (color[i]) {
			case EMPTY:
				printf(" .");
				break;
			case LIGHT:
				printf(" %c", piece_char[piece[i]]);
				break;
			case DARK:
				printf(" %c", piece_char[piece[i]] + ('a' - 'A'));
				break;
		}
		if ((i + 1) % 8 == 0 && i != 63)
			printf("\n%d ", 7 - ROW(i));
	}
	printf("\n\n   a b c d e f g h\n\n");
}


/* xboard() is a substitute for main() that is XBoard
   and WinBoard compatible. See the following page for details:
   http://www.research.digital.com/SRC/personal/mann/xboard/engine-intf.html */

void xboard()
{
	char line[256], command[256];
	int m;
	int post = 0;

	signal(SIGINT, SIG_IGN);
	printf("\n");
	init_board();
	gen();
	computer_side = EMPTY;
	
//================ MY CODE =============================================
	//volatile int *led_ptr      = (int*) get_virtual_addr(0xC0000000, 0x20010, 0); 
	//volatile int *sw_ptr       = (int*) get_virtual_addr(0xC0000000, 0x20000, 0);
	//Main_Pointer  = (int*) get_virtual_addr(0xC0000000, 0x0, 0);
	
	//*Main_Pointer = 0b100; // Reset counter
	//*Main_Pointer = 0;
	
//================ END MY CODE =========================================
	
	for (;;) {
		fflush(stdout);
		if (side == computer_side) {
			/*
			//================ MY CODE =======================
			send_board_state();
			int from;
			int to;
			
			//======= HW to SW ============
			Main_Pointer = (int*) get_virtual_addr(0xC0000000, 0x0, 0);
			*Main_Pointer = *Main_Pointer | 0b1; // Start = 1
			while ( (*Main_Pointer & 0b10) == 0b00 ){;} // while(done == 0)
			*Main_Pointer = *Main_Pointer & (~0x00000001); // Start = 0
			
			Main_Pointer = (int*) get_virtual_addr(0xC0000000, 0x0, 10); // HW to SW
			from = flip[(*Main_Pointer & 0b111111000000)>>6]; // Extract "from" position
			to   = flip[*Main_Pointer & 0b111111]; // Extract "to" position
			
			//======= Move Validation and Perform Move ========	
			if (side == LIGHT) m = my_parse_move(from, to);	
			else m = my_parse_move(flip_horiz[flip[from]], flip_horiz[flip[to]]);	
			
			if (!gen_dat[m].m.u) { // Not 100% sure about this part.
				computer_side = EMPTY;
				continue;
			}
			
			if (m == -1 || !makemove(gen_dat[m].m.b))
			{
				printf("Illegal move by chess engine.\n");
				printf("Computer's move: %s\n", move_str(gen_dat[m].m.b));
				printf("HIT CTRL-C\n");
				while(1){;}
			}
			else 
			{
				printf("move %s\n", move_str(gen_dat[m].m.b));
				ply = 0;
				gen();
				print_result();
				continue;
			}
			* */
			
			computer_move(post, 1);
			continue;

//================ END MY CODE ===================
			
			/*
			think(post);
			if (!pv[0][0].u) {
				computer_side = EMPTY;
				continue;
			}
			
			printf("move %s\n", move_str(pv[0][0].b));
			makemove(pv[0][0].b);
			
			ply = 0;
			gen();
			print_result();
			continue;
			*/
			
			
		}
		if (!fgets(line, 256, stdin))
			return;
		if (line[0] == '\n')
			continue;
		sscanf(line, "%s", command);
		if (!strcmp(command, "xboard"))
			continue;
		if (!strcmp(command, "new")) {
			init_board();
			gen();
			computer_side = DARK;
			continue;
		}
		if (!strcmp(command, "quit"))
			return;
		if (!strcmp(command, "force")) {
			computer_side = EMPTY;
			continue;
		}
		if (!strcmp(command, "white")) {
			side = LIGHT;
			xside = DARK;
			gen();
			computer_side = DARK;
			continue;
		}
		if (!strcmp(command, "black")) {
			side = DARK;
			xside = LIGHT;
			gen();
			computer_side = LIGHT;
			continue;
		}
		if (!strcmp(command, "st")) {
			sscanf(line, "st %d", &max_time);
			max_time *= 1000;
			max_depth = 32;
			continue;
		}
		if (!strcmp(command, "sd")) {
			sscanf(line, "sd %d", &max_depth);
			max_time = 1 << 25;
			continue;
		}
		if (!strcmp(command, "time")) {
			sscanf(line, "time %d", &max_time);
			max_time *= 10;
			max_time /= 30;
			max_depth = 32;
			continue;
		}
		if (!strcmp(command, "otim")) {
			continue;
		}
		if (!strcmp(command, "go")) {
			computer_side = side;
			continue;
		}
		if (!strcmp(command, "hint")) {
			think(0, 1);
			if (!pv[0][0].u)
				continue;
			printf("Hint: %s\n", move_str(pv[0][0].b));
			continue;
		}
		if (!strcmp(command, "undo")) {
			if (!hply)
				continue;
			takeback();
			ply = 0;
			gen();
			continue;
		}
		if (!strcmp(command, "remove")) {
			if (hply < 2)
				continue;
			takeback();
			takeback();
			ply = 0;
			gen();
			continue;
		}
		if (!strcmp(command, "post")) {
			post = 2;
			continue;
		}
		if (!strcmp(command, "nopost")) {
			post = 0;
			continue;
		}
		m = parse_move(line);
		if (m == -1 || !makemove(gen_dat[m].m.b))
			printf("Error (unknown command): %s\n", command);
		else {
			ply = 0;
			gen();
			print_result();
		}
	}
}


/* print_result() checks to see if the game is over, and if so,
   prints the result. */

void print_result()
{
	int i;

	/* is there a legal move? */
	for (i = 0; i < first_move[1]; ++i)
		if (makemove(gen_dat[i].m.b)) {
			takeback();
			break;
		}
	if (i == first_move[1]) {
		if (in_check(side)) {
			if (side == LIGHT)
				printf("0-1 {Black mates}\n");
			else
				printf("1-0 {White mates}\n");
		}
		else
			printf("1/2-1/2 {Stalemate}\n");
	}
	else if (reps() == 2)
		printf("1/2-1/2 {Draw by repetition}\n");
	else if (fifty >= 100)
		printf("1/2-1/2 {Draw by fifty move rule}\n");
}


/* bench: This is a little benchmark code that calculates how many
   nodes per second TSCP searches.
   It sets the position to move 17 of Bobby Fischer vs. J. Sherwin,
   New Jersey State Open Championship, 9/2/1957.
   Then it searches five ply three times. It calculates nodes per
   second from the best time. */

int bench_color[64] = {
	6, 1, 1, 6, 6, 1, 1, 6,
	1, 6, 6, 6, 6, 1, 1, 1,
	6, 1, 6, 1, 1, 6, 1, 6,
	6, 6, 6, 1, 6, 6, 0, 6,
	6, 6, 1, 0, 6, 6, 6, 6,
	6, 6, 0, 6, 6, 6, 0, 6,
	0, 0, 0, 6, 6, 0, 0, 0,
	0, 6, 0, 6, 0, 6, 0, 6
};

int bench_piece[64] = {
	6, 3, 2, 6, 6, 3, 5, 6,
	0, 6, 6, 6, 6, 0, 0, 0,
	6, 0, 6, 4, 0, 6, 1, 6,
	6, 6, 6, 1, 6, 6, 1, 6,
	6, 6, 0, 0, 6, 6, 6, 6,
	6, 6, 0, 6, 6, 6, 0, 6,
	0, 0, 4, 6, 6, 0, 2, 0,
	3, 6, 2, 6, 3, 6, 5, 6
};

void bench()
{
	int i;
	int t[3];
	double nps;

	/* setting the position to a non-initial position confuses the opening
	   book code. */
	close_book();

	for (i = 0; i < 64; ++i) {
		color[i] = bench_color[i];
		piece[i] = bench_piece[i];
	}
	side = LIGHT;
	xside = DARK;
	castle = 0;
	ep = -1;
	fifty = 0;
	ply = 0;
	hply = 0;
	set_hash();
	print_board();
	max_time = 1 << 25;
	max_depth = 5;
	for (i = 0; i < 3; ++i) {
		think(1, 1);
		t[i] = get_ms() - start_time;
		printf("Time: %d ms\n", t[i]);
	}
	if (t[1] < t[0])
		t[0] = t[1];
	if (t[2] < t[0])
		t[0] = t[2];
	printf("\n");
	printf("Nodes: %d\n", nodes);
	printf("Best time: %d ms\n", t[0]);
	if (!ftime_ok) {
		printf("\n");
		printf("Your compiler's ftime() function is apparently only accurate\n");
		printf("to the second. Please change the get_ms() function in main.c\n");
		printf("to make it more accurate.\n");
		printf("\n");
		return;
	}
	if (t[0] == 0) {
		printf("(invalid)\n");
		return;
	}
	nps = (double)nodes / (double)t[0];
	nps *= 1000.0;

	/* Score: 1.000 = my Athlon XP 2000+ */
	printf("Nodes per second: %d (Score: %.3f)\n", (int)nps, (float)nps/243169.0);

	init_board();
	open_book();
	gen();
}
