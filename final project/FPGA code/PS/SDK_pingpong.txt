
#include <stdio.h>
#include "platform.h"
#include "xscugic.h"
#include "xil_exception.h"
#include "xparameters.h"		// 參數集.
#include "xgpio.h"	// 簡化PS對PL的GPIO操作的函數庫.

#include "xil_cache.h"
#include "xil_printf.h"
#include "xil_io.h"

#define INT_CFG0_OFFSET 0x00000C00

// Parameter definitions
#define SW1_INT_ID              61

#define INTC_DEVICE_ID          XPAR_PS7_SCUGIC_0_DEVICE_ID
#define INT_TYPE_RISING_EDGE    0x03
#define INT_TYPE_HIGHLEVEL      0x01
#define INT_TYPE_MASK           0x03
#define addr_lite 0x43C00000

static XScuGic INTCInst;

static void SW_intr_Handler(void *param);
int InterruptSystemSetup(XScuGic *XScuGicInstancePtr);
static int IntcInitFunction(u16 DeviceId);
int value;
static void SW_intr_Handler(void *param)
{
    XGpio LED_XGpio;		// 宣告一個GPIO用的結構.
    XGpio_Initialize(&LED_XGpio, XPAR_AXI_GPIO_0_DEVICE_ID);	// 初始化LED_XGpio.
    XGpio_SetDataDirection(&LED_XGpio, 1, 0);		// 設置通道.

	value = Xil_In32(addr_lite);
	XGpio_DiscreteWrite(&LED_XGpio, 1, value);		// LED_XGpio通道,送LED_num值進去.
	printf("%u\n", value);
}
// 延遲用.
void delay(int dly)
{
    int i, j;
    for (i = 0; i < dly; i++) {
    	for (j = 0; j < 0xffff; j++) {
    		;
        }
    }
}
void IntcTypeSetup(XScuGic *InstancePtr, int intId, int intType)
{
    int mask;

    intType &= INT_TYPE_MASK;
    mask = XScuGic_DistReadReg(InstancePtr, INT_CFG0_OFFSET + (intId/16)*4);
    mask &= ~(INT_TYPE_MASK << (intId%16)*2);
    mask |= intType << ((intId%16)*2);
    XScuGic_DistWriteReg(InstancePtr, INT_CFG0_OFFSET + (intId/16)*4, mask);
}

int IntcInitFunction(u16 DeviceId)
{
    XScuGic_Config *IntcConfig;
    int status;

    // Interrupt controller initialisation
    IntcConfig = XScuGic_LookupConfig(DeviceId);
    status = XScuGic_CfgInitialize(&INTCInst, IntcConfig, IntcConfig->CpuBaseAddress);
    if(status != XST_SUCCESS) return XST_FAILURE;

    // Call to interrupt setup
    Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
                                 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
                                 &INTCInst);
    Xil_ExceptionEnable();

    // Connect SW1~SW3 interrupt to handler
    status = XScuGic_Connect(&INTCInst,
                             SW1_INT_ID,
                             (Xil_ExceptionHandler)SW_intr_Handler,
                             (void *)1);
    if(status != XST_SUCCESS) return XST_FAILURE;



    // Set interrupt type of SW1~SW3 to rising edge
    IntcTypeSetup(&INTCInst, SW1_INT_ID, INT_TYPE_RISING_EDGE);


    // Enable SW1~SW3 interrupts in the controller
    XScuGic_Enable(&INTCInst, SW1_INT_ID);


    return XST_SUCCESS;
}

int main(void)
{
    init_platform();


    IntcInitFunction(INTC_DEVICE_ID);




	Xil_DCacheDisable();

	while(1){


    	delay(100);
	}


    return 0;
}
