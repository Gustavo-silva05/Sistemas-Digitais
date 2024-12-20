#include <hf-risc.h>

#define PS2_AXI_BASE 0xe4a90000
// #define PS2_AXI_BASE 0x40000000
#define PS2_AXI_STATUS (*(volatile uint32_t *)(PS2_AXI_BASE + 0x010))
#define PS2_AXI_DATA (*(volatile uint32_t *)(PS2_AXI_BASE + 0x020))

#define PS2_STREADY (1 << 0)
#define PS2_STVALID (1 << 1)

uint8_t read_ps2_data()
{
    while (!(PS2_AXI_STATUS & PS2_STVALID))
        ; // Espera até o dado estar disponível
    return PS2_AXI_DATA;
}

char *LUT(uint8_t make_code)
{
    switch (make_code)
    {
    case 0x1C:
        return "A";
    case 0x32:
        return "B";
    case 0x21:
        return "C";
    case 0x23:
        return "D";
    case 0x24:
        return "E";
    case 0x2B:
        return "F";
    case 0x34:
        return "G";
    case 0x33:
        return "H";
    case 0x43:
        return "I";
    case 0x3B:
        return "J";
    case 0x42:
        return "K";
    case 0x4B:
        return "L";
    case 0x3A:
        return "M";
    case 0x31:
        return "N";
    case 0x44:
        return "O";
    case 0x4D:
        return "P";
    case 0x15:
        return "Q";
    case 0x2D:
        return "R";
    case 0x1B:
        return "S";
    case 0x2C:
        return "T";
    case 0x3C:
        return "U";
    case 0x2A:
        return "V";
    case 0x1D:
        return "W";
    case 0x22:
        return "X";
    case 0x35:
        return "Y";
    case 0x1A:
        return "Z";
    case 0x45:
        return "0";
    case 0x16:
        return "1";
    case 0x1E:
        return "2";
    case 0x26:
        return "3";
    case 0x25:
        return "4";
    case 0x2E:
        return "5";
    case 0x36:
        return "6";
    case 0x3D:
        return "7";
    case 0x3E:
        return "8";
    case 0x46:
        return "9";
    case 0x0E:
        return "";
    case 0x4E:
        return "-";
    case 0x55:
        return "=";
    case 0x5D:
        return "\\";
    case 0x66:
        return "BKSP";
    case 0x29:
        return "SPACE";
    case 0x0D:
        return "TAB";
    case 0x58:
        return "CAPS";
    case 0x12:
        return "L SHIFT";
    case 0x14:
        return "L CTRL";
    case 0x11:
        return "L ALT";
    case 0x59:
        return "R SHIFT";
    case 0x5A:
        return "ENTER";
    case 0x76:
        return "ESC";
    case 0x05:
        return "F1";
    case 0x06:
        return "F2";
    case 0x04:
        return "F3";
    case 0x0C:
        return "F4";
    case 0x03:
        return "F5";
    case 0x0B:
        return "F6";
    case 0x83:
        return "F7";
    case 0x0A:
        return "F8";
    case 0x01:
        return "F9";
    case 0x09:
        return "F10";
    case 0x78:
        return "F11";
    case 0x07:
        return "F12";
    case 0x7E:
        return "SCROLL";
    case 0x54:
        return "[";
    case 0x5B:
        return "]";
    case 0x4C:
        return ";";
    case 0x52:
        return "'";
    case 0x41:
        return ",";
    case 0x49:
        return ".";
    case 0x4A:
        return "/";
    default:
        return "";
    }
}

int main(void)
{
    printf("Iniciando leitura do teclado...\n");
    uint8_t tecla = read_ps2_data();
    printf("Tecla pressionada: %s\n", LUT(tecla));
    while (1)
    {
        uint8_t n = read_ps2_data();
        if (n != tecla)
        {
            if (n != 0xF0 && tecla == 0xF0)
            {
                printf("Tecla pressionada: %s\n", LUT(n));
            }
            tecla = n;
        }
    }

    return 0;
}

