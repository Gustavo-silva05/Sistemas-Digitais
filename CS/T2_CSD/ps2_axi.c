#include <hf-risc.h>

#define PS2_AXI_BASE         0xe4a90000
#define PS2_AXI_STATUS       (*(volatile uint32_t *)(PS2_AXI_BASE + 0x010))
#define PS2_AXI_DATA         (*(volatile uint32_t *)(PS2_AXI_BASE + 0x020))

#define PS2_STREADY          (1 << 0)
#define PS2_STVALID          (1 << 1)

uint8_t read_ps2_data() {
    uint8_t data;
    while (!(PS2_AXI_STATUS & PS2_STVALID)); // Espera até o dado estar disponível
    data = PS2_AXI_DATA;
    return data;
}

int main(void) {
    printf("Iniciando leitura do teclado...\n");

    while (1) {
        uint8_t tecla = read_ps2_data();
        printf("Tecla pressionada: %02x\n", tecla);
        delay_ms(1000);
    }

    return 0;
}

// #include <hf-risc.h>

// #define SW_AXI_BASE			    0xe4a90000
// #define SW_AXI_STATUS			(*(volatile uint32_t *)(SW_AXI_BASE + 0x010))
// #define SW_AXI_SDATA			(*(volatile uint32_t *)(SW_AXI_BASE + 0x020))

// #define SW_AXI_STREADY			(1 << 0)
// #define SW_AXI_STVALID			(1 << 1)



// uint8_t sw_axi()
// {
// 	uint8_t data;
	
// 	data = SW_AXI_SDATA;
// 	while (!(SW_AXI_STATUS & SW_AXI_STVALID));
// 	data = SW_AXI_SDATA;
	
// 	return data;
// }

// int main(void){
// 	printf("hello\n");
	
// 	while (1) {
// 		printf("sw val: %02x\n", sw_axi());
// 		delay_ms(1000);		
// 	}

// 	return 0;
// }
