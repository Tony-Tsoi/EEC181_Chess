#include <stdlib.h>
#include <stdio.h>
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

int main()
{
	printf("======Start======\n");
	memmap_start();

	volatile int *led_ptr = (int*) get_virtual_addr(0xC0000000, 0x20010, 0); 
	volatile int *sw_ptr  = (int*) get_virtual_addr(0xC0000000, 0x20000, 0);
	
	volatile int *test_module  = (int*) get_virtual_addr(0xC0000000, 0x0, 0);

//============== Timer stuff ==========================
// Status is high every "startv" number of cycles of the 100 MHz clock.
// Control: Start/stop time.
// Status: Enable bit.
// eoi: Read this to reset timer.
// You need to stop the timer before changing startv.
// Should reset the timer whenever stopping/changing the timer.
// curval: Read this to get current timer count.
	volatile int *startv  = (int*) get_virtual_addr(0xFF200000, 0x00A08000, 0); 
	volatile int *control = (int*) get_virtual_addr(0xFF200000, 0x00A08008, 0);
	volatile int *status  = (int*) get_virtual_addr(0xFF200000, 0x00A08010, 0);
	volatile int *eoi     = (int*) get_virtual_addr(0xFF200000, 0x00A0800C, 0);
	volatile int *curval  = (int*) get_virtual_addr(0xFF200000, 0x00A08004, 0);
//============== End timer stuff ==============================

/*  TESTING READ/WRITE FUNCTIONALITY
	printf("data: \n");
	*test_module = 0;
	printf("*test_module: 0x%x\n", *test_module);
	*test_module = 12;
	printf("*test_module: 0x%x\n", *test_module);
	*led_ptr = 3;
	printf("*test_module: 0x%x\n", *test_module);
	*test_module = 1;
	*test_module = 2;
	*test_module = 3;
	printf("*test_module: 0x%x\n\n", *test_module);
	*test_module = 4;
	
	test_module = (int*) get_virtual_addr(0xC0000000, 0x0, 0);
	printf("*test_module: 0x%x\n", *test_module);
	test_module = (int*) get_virtual_addr(0xC0000000, 0x0, 1);
	printf("*test_module: 0x%x\n", *test_module);
	test_module = (int*) get_virtual_addr(0xC0000000, 0x0, 32767);
	printf("*test_module: 0x%x\n", *test_module);
*/	

//  TESTING HARDCODED MOVE FUNCTIONALITY
	int expected[] = {0b001000010000, 0b001001010001, 0b001010010010,
		0b001011010011, 0b001100010100, 0b001101010101, 0b001110010110,
		0b001111010111, 0b000000001000, 0b000111001111};
	int i;
	*test_module = 0b100; // Reset counter

	for (i = 0; i < 10; i++)
	{
		test_module = (int*) get_virtual_addr(0xC0000000, 0x0, 0);
		*test_module = 0b1; // Start = 1
		while ( (*test_module & 0b10) == 0b00 ){;} // while(done == 0)
		*test_module = *test_module & (~0x00000001); // Start = 0
		
		test_module = (int*) get_virtual_addr(0xC0000000, 0x0, 10);
		printf("GENERATED MOVE: 0x%x\n", *test_module);
		printf("EXPECTED      : 0x%x\n\n", expected[i]);
	}
	
//================== TESTING RAM WIDTH ================================
	test_module = (int*) get_virtual_addr(0xC0000000, 0x0, 11);
	*test_module = 0x10000000;
	
	printf("WRITTEN: 0x10000000\n");
	printf("READ   : 0x%x\n\n", *test_module);
	
	*test_module = 0xFFFFFFFF;
	
	printf("WRITTEN: 0xFFFFFFFF\n");
	printf("READ   : 0x%x\n\n", *test_module);
//================== END TESTING RAM WIDTH ============================

	*control = 0b10; // Stop timer
	*startv = 100000000; // 1 second
	*eoi; // Read eoi to reset timer
	*control = 0b11; // Start timer

	int count = 0;
	int count_p1 = 0;
	while(1)
	{
		if(*status == 1)
		{
			*led_ptr = count;
			count++;
			if (count == 0b10000000000)
			{
				count = 0;
			}
			*eoi;
		}
	}


	memmap_stop();
	return 0;
}
