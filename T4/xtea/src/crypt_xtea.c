#include "crypt_xtea.h"

//-----------------------------------------------------------------------------
// XTEA: 128-bits
//-----------------------------------------------------------------------------
void xtea_enc(unsigned int **dest, const unsigned int **v, const unsigned int **k) {
    char i;
    unsigned int y0 = *v[0], z0 = *v[1], y1 = *v[2], z1 = *v[3];
    unsigned int sum = 0, delta = 0x9E3779B9;

    for(i = 0; i < 32; i++) {
        y0  += ((z0 << 4 ^ z0 >> 5) + z0) ^ (sum + *k[sum & 3]);
        printf("encriptacao (%d):\t", i);
        printf("%08X_", z1);
        printf("%08X_", y1);
        printf("%08X_", z0);
        printf("%08X\n", y0);
        y1  += ((z1 << 4 ^ z1 >> 5) + z1) ^ (sum + *k[sum & 3]);
        printf("encriptacao (%d):\t", i);
        printf("%08X_", z1);
        printf("%08X_", y1);
        printf("%08X_", z0);
        printf("%08X\n", y0);
        sum += delta;
        z0  += ((y0 << 4 ^ y0 >> 5) + y0) ^ (sum + *k[sum>>11 & 3]);
        printf("encriptacao (%d):\t", i);
        printf("%08X_", z1);
        printf("%08X_", y1);
        printf("%08X_", z0);
        printf("%08X\n", y0);
        z1  += ((y1 << 4 ^ y1 >> 5) + y1) ^ (sum + *k[sum>>11 & 3]);
        printf("encriptacao (%d):\t", i);
        printf("%08X_", z1);
        printf("%08X_", y1);
        printf("%08X_", z0);
        printf("%08X\n", y0);
    }
    *dest[0]=y0; *dest[1]=z0; *dest[2]=y1; *dest[3]=z1;
}

void xtea_dec(unsigned int **dest, const unsigned int **v, const unsigned int **k) {
    char i;
    unsigned int y0 = *v[0], z0 = *v[1], y1 = *v[2], z1 = *v[3];
    unsigned int sum = 0xC6EF3720, delta = 0x9E3779B9;
    for(i = 0; i < 32; i++) {
        z1  -= ((y1 << 4 ^ y1 >> 5) + y1) ^ (sum + *k[sum>>11 & 3]);
        z0  -= ((y0 << 4 ^ y0 >> 5) + y0) ^ (sum + *k[sum>>11 & 3]);
        sum -= delta;
        y1  -= ((z1 << 4 ^ z1 >> 5) + z1) ^ (sum + *k[sum & 3]);
        y0  -= ((z0 << 4 ^ z0 >> 5) + z0) ^ (sum + *k[sum & 3]);
    }
    *dest[0]=y0; *dest[1]=z0; *dest[2]=y1; *dest[3]=z1;
}

void xtea(unsigned int* key, unsigned int* input, unsigned int *output, char encript) {
    int i;
    unsigned int* d[4];
    const unsigned int* v[4];
    const unsigned int* k[4];

    for(i = 0; i < 4; i++) {
        d[i] = &output[3-i];
        v[i] = &input[3-i];
        k[i] = &key[3-i];
    }

    if (encript)
        xtea_enc(d, v, k);
    else
        xtea_dec(d, v, k);
}

//-----------------------------------------------------------------------------
// Main Function
//-----------------------------------------------------------------------------
int crypt_xtea(void) {
    unsigned int key[4], input[4], output[4];

    printf("-- XTEA (ENC) --\n");

    // Write the KEY
    key[0] = 0xDEADBEEF;
    key[1] = 0x01234567;
    key[2] = 0x89ABCDEF;
    key[3] = 0xDEADBEEF;

    // Write the plain text to be encripted
    input[0] = 0xA5A5A5A5;
    input[1] = 0x01234567;
    input[2] = 0xFEDCBA98;
    input[3] = 0x5A5A5A5A;

    printf("input:\t");
    printf("%08X_", input[0]);
    printf("%08X_", input[1]);
    printf("%08X_", input[2]);
    printf("%08X\n", input[3]);

    xtea(key, input, output, ENC); // C Application

    // Shows the result
    printf("output:\t");
    printf("%08X_", output[0]);
    printf("%08X_", output[1]);
    printf("%08X_", output[2]);
    printf("%08X\n", output[3]);
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    printf("-- XTEA (DEC) --\n");
    // Write the chiper text to be decripted
    input[0] = 0x089975E9;
    input[1] = 0x2555F334;
    input[2] = 0xCE76E4F2;
    input[3] = 0x4D932AB3;

    printf("input:\t");
    printf("%08X_", input[0]);
    printf("%08X_", input[1]);
    printf("%08X_", input[2]);
    printf("%08X\n", input[3]);

    xtea(key, input, output, DEC); // C Application

    // Shows the result
    printf("output:\t");
    printf("%08X_", output[0]);
    printf("%08X_", output[1]);
    printf("%08X_", output[2]);
    printf("%08X\n", output[3]);

	return 0;
}