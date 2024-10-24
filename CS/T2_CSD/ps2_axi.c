#include <stdio.h>
#include <hf-risc.h>

#define PS2_AXI_BASE         0xe4a90000
#define PS2_AXI_STATUS       (*(volatile uint32_t *)(PS2_AXI_BASE + 0x010))
#define PS2_AXI_DATA         (*(volatile uint32_t *)(PS2_AXI_BASE + 0x020))

#define PS2_STREADY          (1 << 0)
#define PS2_STVALID          (1 << 1)

uint8_t read_ps2_data() {
    while (!(PS2_AXI_STATUS & PS2_STVALID)); // Espera até o dado estar disponível
    return PS2_AXI_DATA;
}

int main(void) {
    printf("Iniciando leitura do teclado...\n");

    while (1) {
        uint8_t tecla = read_ps2_data();
        printf("Tecla pressionada: %02x\n", tecla);
    }

    return 0;
}