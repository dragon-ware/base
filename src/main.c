#include <stddef.h>
#include <stdint.h>
#include "uart.h"
#include "mmio.h"
#include "util.h"

#if defined(__cplusplus)
extern "C" /* Use C linkage for kernel_main. */
#endif

void bootloader_main(uint32_t r0, uint32_t r1, uint32_t atags)
{
	// Declare as unused
	(void) r0;
	(void) r1;
	(void) atags;
 
	uart_init();
	printf("Hello, kernel World!\r\n");	
 
	while (1)
	{
		uart_putc(uart_getc());
	}
}
