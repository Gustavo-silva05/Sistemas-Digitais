#include <hf-risc.h>
#include "vga_drv.h"

#define NUM_INIMIES 6
#define MAX_BULLETS 20
#define NUM_BARRIER 4
#define HERO_HEARTS 5

/* sprites and sprite drawing */
// char monster1a[8][11] = {
// 	{0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0},
// 	{2, 0, 0, 2, 0, 0, 0, 2, 0, 0, 2},
// 	{2, 0, 2, 2, 2, 2, 2, 2, 2, 0, 2},
// 	{2, 2, 2, 0, 2, 2, 2, 0, 2, 2, 2},
// 	{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
// 	{0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
// 	{0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0},
// 	{0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0}};

// char monster1b[8][11] = {
// 	{0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0},
// 	{0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0},
// 	{0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0},
// 	{0, 2, 2, 0, 2, 2, 2, 0, 2, 2, 0},
// 	{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
// 	{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
// 	{2, 0, 2, 0, 0, 0, 0, 0, 2, 0, 2},
// 	{0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0}};

// char monster2a[8][8] = {
// 	{0, 0, 0, 6, 6, 0, 0, 0},
// 	{0, 0, 6, 6, 6, 6, 0, 0},
// 	{0, 6, 6, 6, 6, 6, 6, 0},
// 	{6, 6, 0, 6, 6, 0, 6, 6},
// 	{6, 6, 6, 6, 6, 6, 6, 6},
// 	{0, 6, 0, 6, 6, 0, 6, 0},
// 	{6, 0, 0, 0, 0, 0, 0, 6},
// 	{0, 6, 0, 0, 0, 0, 6, 0}};

// char monster2b[8][8] = {
// 	{0, 0, 0, 6, 6, 0, 0, 0},
// 	{0, 0, 6, 6, 6, 6, 0, 0},
// 	{0, 6, 6, 6, 6, 6, 6, 0},
// 	{6, 6, 0, 6, 6, 0, 6, 6},
// 	{6, 6, 6, 6, 6, 6, 6, 6},
// 	{0, 0, 6, 0, 0, 6, 0, 0},
// 	{0, 6, 0, 6, 6, 0, 6, 0},
// 	{6, 0, 6, 0, 0, 6, 0, 6}};

// char monster3a[8][12] = {
// 	{0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
// 	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
// 	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
// 	{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0},
// 	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
// 	{0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0},
// 	{0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0},
// 	{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}};

// char monster3b[8][12] = {
// 	{0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
// 	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
// 	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
// 	{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0},
// 	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
// 	{0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0},
// 	{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0},
// 	{0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0}};

// char misteryShip[7][14] = {
// 	{0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0},
// 	{0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0},
// 	{0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0},
// 	{0, 4, 4, 0, 4, 0, 4, 4, 0, 4, 0, 4, 4, 0},
// 	{4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
// 	{0, 0, 4, 4, 4, 0, 4, 4, 0, 4, 4, 4, 0, 0},
// 	{0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0}};

// char barrierFull[10][14] = {
// 	{0, 0, 0, 0, 0, 8, 8, 8, 8, 0, 0, 0, 0, 0},
// 	{0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0},
// 	{0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0},
// 	{0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0},
// 	{0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0},
// 	{8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 8, 8, 0, 0, 8, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8}};

// char barrierDamaged[10][14] = {
// 	{0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0, 0},
// 	{0, 0, 0, 0, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0},
// 	{0, 0, 0, 8, 0, 8, 0, 0, 8, 8, 8, 0, 0, 0},
// 	{0, 0, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0},
// 	{0, 8, 8, 0, 8, 8, 0, 0, 8, 8, 8, 8, 8, 0},
// 	{8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 8, 8, 0, 0, 8, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8}};

// char barrierBroken[10][14] = {
// 	{0, 0, 0, 0, 0, 8, 8, 0, 8, 0, 0, 0, 0, 0},
// 	{0, 0, 0, 0, 8, 0, 0, 8, 8, 8, 0, 0, 0, 0},
// 	{0, 0, 0, 8, 8, 8, 0, 8, 8, 0, 0, 0, 0, 0},
// 	{0, 0, 8, 8, 0, 8, 0, 8, 0, 8, 8, 8, 0, 0},
// 	{0, 8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8, 8, 0},
// 	{8, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8},
// 	{0, 8, 8, 0, 8, 8, 0, 0, 8, 8, 8, 8, 0, 8},
// 	{8, 8, 8, 0, 8, 0, 0, 0, 0, 8, 0, 0, 8, 8},
// 	{8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 8, 8, 8, 8},
// 	{8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8}};

// char spaceShip[8][11] = {
// 	{0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0},
// 	{0, 0, 0, 0, 7, 7, 7, 0, 0, 0, 0},
// 	{0, 0, 0, 0, 7, 8, 7, 0, 0, 0, 0},
// 	{0, 0, 0, 7, 7, 8, 7, 7, 0, 0, 0},
// 	{4, 4, 4, 7, 7, 7, 7, 7, 4, 4, 4},
// 	{7, 7, 7, 7, 6, 6, 6, 7, 7, 7, 7},
// 	{0, 7, 7, 7, 7, 0, 7, 7, 7, 7, 0},
// 	{0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0}};

// char bulletShip[4][1] = {
// 	{7},
// 	{7},
// 	{7},
// 	{7}};

// char bullet1a[4][2] = {
// 	{0, 7},
// 	{7, 0},
// 	{0, 7},
// 	{7, 0}};

// char bullet1b[4][2] = {
// 	{7, 0},
// 	{0, 7},
// 	{7, 0},
// 	{0, 7}};

// char bullet2a[4][3] = {
// 	{0, 7, 0},
// 	{0, 7, 0},
// 	{7, 7, 7},
// 	{0, 7, 0}};

// char bullet2b[4][3] = {
// 	{0, 7, 0},
// 	{7, 7, 7},
// 	{0, 7, 0},
// 	{0, 7, 0}};

char cassa1a[8][11] = {
	{8, 8, 0, 0, 0, 0, 0, 0, 0, 8, 8},
	{8, 8, 0, 0, 8, 8, 8, 0, 0, 8, 8},
	{8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8},
	{8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8},
	{8, 8, 0, 0, 8, 8, 8, 0, 0, 8, 8},
	{8, 8, 0, 0, 0, 0, 0, 0, 0, 8, 8}};

char cassa1b[8][11] = {
	{0, 8, 8, 0, 0, 0, 0, 0, 8, 8, 0},
	{8, 8, 0, 0, 8, 8, 8, 0, 0, 8, 8},
	{8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8},
	{8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8},
	{8, 8, 0, 0, 4, 8, 4, 0, 0, 8, 8},
	{0, 8, 8, 0, 0, 0, 0, 0, 8, 8, 0}};

char tay2a[8][11] = {
	{0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 0, 8, 8, 0, 0, 0},
	{0, 8, 8, 8, 8, 0, 8, 8, 8, 8, 0},
	{8, 8, 0, 0, 4, 8, 4, 0, 0, 8, 8},
	{8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8}};

char tay2b[8][11] = {
	{0, 0, 0, 8, 0, 8, 0, 8, 0, 0, 0},
	{0, 0, 8, 8, 0, 8, 0, 8, 8, 0, 0},
	{0, 8, 8, 0, 0, 8, 0, 0, 8, 8, 0},
	{0, 8, 0, 0, 8, 8, 8, 0, 0, 8, 0},
	{8, 8, 0, 8, 8, 0, 8, 8, 0, 8, 8},
	{8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8},
	{0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}};

char monster3a[8][11] = {
	{0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0},
	{0, 0, 8, 8, 0, 0, 0, 8, 8, 0, 0},
	{0, 8, 8, 8, 0, 0, 0, 8, 8, 8, 0},
	{8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8},
	{0, 0, 0, 0, 8, 4, 8, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 4, 8, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 4, 8, 0, 0, 0, 0}};

char monster3b[8][11] = {
	{0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0},
	{0, 0, 8, 8, 0, 0, 0, 8, 8, 0, 0},
	{0, 8, 8, 4, 0, 0, 0, 4, 8, 8, 0},
	{8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8},
	{0, 0, 0, 0, 8, 4, 8, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 4, 8, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 4, 8, 0, 0, 0, 0}};

char misteryShip[7][14] = {
	{0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0},
	{0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0},
	{0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0},
	{0, 4, 4, 0, 4, 0, 4, 4, 0, 4, 0, 4, 4, 0},
	{4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
	{0, 0, 4, 4, 4, 0, 4, 4, 0, 4, 4, 4, 0, 0},
	{0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0}};

char barrierFull[10][14] = {
	{0, 0, 0, 0, 0, 8, 8, 8, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0},
	{0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0},
	{0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0},
	{8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 8, 0, 0, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8}};

char barrierDamaged[10][14] = {
	{0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 8, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 0, 8, 0, 0, 8, 8, 8, 0, 0, 0},
	{0, 0, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 0, 0},
	{0, 8, 8, 0, 8, 8, 0, 0, 8, 8, 8, 8, 8, 0},
	{8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 8, 0, 0, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8}};

char barrierBroken[10][14] = {
	{0, 0, 0, 0, 0, 8, 8, 0, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 8, 0, 8, 8, 0, 0, 0, 0, 0},
	{0, 0, 8, 8, 0, 8, 0, 8, 0, 8, 8, 8, 0, 0},
	{0, 8, 8, 0, 8, 8, 8, 8, 8, 0, 8, 8, 8, 0},
	{8, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8},
	{0, 8, 8, 0, 8, 8, 0, 0, 8, 8, 8, 8, 0, 8},
	{8, 8, 8, 0, 8, 0, 0, 0, 0, 8, 0, 0, 8, 8},
	{8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 8, 8, 8, 8},
	{8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8}};

char Rebel1[8][11] = {
	{0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{8, 0, 0, 0, 4, 8, 4, 0, 0, 0, 8},
	{8, 0, 0, 0, 4, 8, 4, 0, 0, 0, 8},
	{8, 0, 0, 0, 8, 1, 8, 0, 0, 0, 8},
	{8, 8, 0, 8, 8, 1, 8, 8, 0, 8, 8},
	{8, 4, 4, 8, 8, 8, 8, 8, 4, 4, 8},
	{0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0},
	{0, 0, 0, 8, 0, 0, 0, 8, 0, 0, 0}};

char MileniumFalcon[10][10] = {
	{0, 0, 0, 1, 0, 1, 0, 0, 0, 0},
	{0, 0, 8, 8, 0, 8, 8, 0, 0, 0},
	{0, 0, 8, 8, 0, 8, 4, 0, 1, 1},
	{0, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 0, 0, 0, 8, 0, 8, 8},
	{8, 4, 8, 0, 8, 0, 0, 0, 4, 4},
	{8, 8, 8, 0, 0, 0, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 8, 8, 4, 8, 8},
	{0, 8, 0, 8, 0, 8, 0, 8, 0, 0},
	{0, 0, 8, 8, 8, 8, 8, 0, 0, 0}};

char bullet_dark[4][1] = {
	{4},
	{4},
	{4},
	{4}};

char bullet_light[4][1] = {
	{2},
	{2},
	{2},
	{2}};

char DeathStar[20][22] = {
	{0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 8, 8, 0, 0, 0},
	{0, 0, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 8, 8, 8, 0, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0},
	{0, 8, 8, 8, 0, 7, 7, 8, 0, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{8, 8, 8, 8, 0, 7, 7, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 0, 0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{8, 8, 8, 8, 8, 8, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8},
	{0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0},
	{0, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 8, 8, 8, 0},
	{0, 0, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 0, 0, 0, 0},
	{0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0},
	{0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0}};

char VITORIA[15][63] = {
	{2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 0, 0},
	{2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 2, 2, 0},
	{2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 2},
	{2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2},
	{0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 2},
	{0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 2, 2, 0, 2, 2, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2},
	{0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 0, 0, 0, 2, 2, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 0, 0, 0, 2, 2}};

char DERROTA[15][63] = {
	{4, 4, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 0, 0},
	{4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 0},
	{4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 4, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 0, 4, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 4, 0, 0, 4, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4},
	{4, 4, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 4, 4}};

char coracao[6][7] = {
	{0, 4, 0, 0, 0, 4, 0},
	{4, 4, 4, 0, 4, 4, 4},
	{4, 4, 4, 4, 4, 4, 4},
	{0, 4, 4, 4, 4, 4, 0},
	{0, 0, 4, 4, 4, 0, 0},
	{0, 0, 0, 4, 0, 0, 0}};

void draw_sprite(unsigned int x, unsigned int y, char *sprite,
				 unsigned int sizex, unsigned int sizey, int color)
{
	unsigned int px, py;

	if (color < 0)
	{
		for (py = 0; py < sizey; py++)
			for (px = 0; px < sizex; px++)
				display_pixel(x + px, y + py, sprite[py * sizex + px]);
	}
	else
	{
		for (py = 0; py < sizey; py++)
			for (px = 0; px < sizex; px++)
				display_pixel(x + px, y + py, color & 0xf);
	}
}

/* sprite based objects */
struct object_s
{
	char *sprite_frame[3];
	char spriteszx, spriteszy, sprites;
	int cursprite;
	unsigned int posx, posy;
	int dx, dy;
	int speedx, speedy;
	int speedxcnt, speedycnt;
	int lives;
	int active; // 1 = ativo, 0 = inativo
};

struct object_s fim;
struct object_s hero;
struct object_s coracoes[HERO_HEARTS];
struct object_s boss;
struct object_s barrier[NUM_BARRIER];
struct object_s bullets[MAX_BULLETS];
struct object_s enemies[NUM_INIMIES];
int n_bullets = 1;
int n_inimigos = NUM_INIMIES;

void init_object(struct object_s *obj, char *spritea, char *spriteb,
				 char *spritec, char spriteszx, char spriteszy, int posx, int posy,
				 int dx, int dy, int spx, int spy, int lives)
{
	obj->sprite_frame[0] = spritea;
	obj->sprite_frame[1] = spriteb;
	obj->sprite_frame[2] = spritec;
	obj->spriteszx = spriteszx;
	obj->spriteszy = spriteszy;
	obj->cursprite = 0;
	obj->posx = posx;
	obj->posy = posy;
	obj->dx = dx;
	obj->dy = dy;
	obj->speedx = spx;
	obj->speedy = spy;
	obj->speedxcnt = spx;
	obj->speedycnt = spy;
	obj->active = 1;
	obj->lives = lives;
}

void draw_object(struct object_s *obj, char chgsprite, int color)
{
	if (chgsprite)
	{
		obj->cursprite++;
		if (obj->sprite_frame[obj->cursprite] == 0)
			obj->cursprite = 0;
	}

	draw_sprite(obj->posx, obj->posy, obj->sprite_frame[obj->cursprite],
				obj->spriteszx, obj->spriteszy, color);
}

void move_object(struct object_s *obj)
{

	struct object_s oldobj;

	memcpy(&oldobj, obj, sizeof(struct object_s));

	if (--obj->speedxcnt == 0)
	{
		obj->speedxcnt = obj->speedx;
		obj->posx = obj->posx + obj->dx;
	}
	if (--obj->speedycnt == 0)
	{
		obj->speedycnt = obj->speedy;
		obj->posy = obj->posy + obj->dy;
	}
	if (obj->posx == 0 + obj->spriteszx)
	{
		draw_object(&oldobj, 0, 0);
		obj->dx = 1;
		if (obj->posy <= 120 && obj->posy >= 30)
		{
			obj->posy += 9;
		}
	}
	if (obj->posx == (VGA_WIDTH - obj->spriteszx))
	{
		draw_object(&oldobj, 0, 0);
		obj->dx = -1;
		if (obj->posy <= 160 && obj->posy >= 30)
		{
			obj->posy += 9;
		}
	}
	if (obj->posy == 0 || obj->posy + obj->spriteszy == VGA_HEIGHT)
	{
		draw_object(&oldobj, 0, 0);
		obj->active = 0;
	}
	else if ((obj->speedx == obj->speedxcnt) || (obj->speedy == obj->speedycnt))
	{
		draw_object(&oldobj, 0, 0);
		draw_object(obj, 1, -1);
	}
}

/* display and input */
void init_display()
{
	display_background(BLACK);
}

int check_active_bullet()
{
	int active = 0;
	for (int i = 0; i < MAX_BULLETS; i++)
	{
		if (bullets[i].active)
			active++;
	}
	return active;
}

// cria o objeto tiro quando o botao eh apertado, com base na posicao da nave

void create_bullet(struct object_s *hero, char type)
{
	if (n_bullets < MAX_BULLETS - 1)
	{
		if (type == 'h')
		{
			init_object(&bullets[0], bullet_light[0], 0, 0, 1, 4,
						hero->posx - 1 + (hero->spriteszx / 2),
						hero->posy - 4, 0, -1, 0, 1, 1);
		}
		else
		{
			int shots = 0;
			if (n_inimigos >= 4)
			{
				for (int i = 0; i < NUM_INIMIES; i++)
				{
					if (shots < 4)
					{
						if (n_bullets == MAX_BULLETS - 1)
							return;
						if (!(enemies[i].active))
							continue;
						init_object(&bullets[n_bullets], bullet_dark[0], 0, 0, 1, 4,
									enemies[i].posx - 1 + (enemies[i].spriteszx / 2),
									enemies[i].posy + enemies[i].spriteszy + 1, 0, 1, 1, 1, 1);
						shots++;
						n_bullets++;
					}
					else
						return;
				}
			}
			else
			{
				for (int i = 0; i < n_inimigos; i++)
				{
					printf("%d inimigos\n", n_inimigos);
					for (int j = 0; j < NUM_INIMIES; j++)
					{
						if (n_bullets == MAX_BULLETS - 1)
							return;
						if (!(enemies[j].active))
							continue;
						init_object(&bullets[n_bullets], bullet_dark[0], 0, 0, 1, 4,
									enemies[j].posx - 1 + (enemies[j].spriteszx / 2),
									enemies[j].posy + enemies[j].spriteszy + 1, 0, 1, 1, 1, 1);
						n_bullets++;
						break;
					}
				}
			}
		}
	}
	else
	{
		int a = check_active_bullet();
		if (a == 0)
		{
			n_bullets = 1;
		}
	}
}

enum
{
	KEY_CENTER = 0x01,
	KEY_UP = 0x02,
	KEY_LEFT = 0x04,
	KEY_RIGHT = 0x08,
	KEY_DOWN = 0x10
};

void init_input()
{
	/* configure GPIOB pins 8 .. 12 as inputs */
	GPIOB->DDR &= ~(MASK_P8 | MASK_P9 | MASK_P10 | MASK_P11 | MASK_P12);
}

int get_input(struct object_s *hero)
{
	int keys = 0;
	hero->dx = 0;
	if (GPIOB->IN & MASK_P8)
	{
		keys |= KEY_CENTER;
	}
	if (GPIOB->IN & MASK_P9)
	{
		if (!bullets[0].active)
			create_bullet(hero, 'h');

		// create_bullet(hero, 'h');
	}
	if (GPIOB->IN & MASK_P10)
	{
		keys |= KEY_LEFT;
		hero->dx = -1;
	}
	if (GPIOB->IN & MASK_P11)
	{
		keys |= KEY_RIGHT;
		hero->dx = 1;
	}
	if (GPIOB->IN & MASK_P12)
	{
		keys |= KEY_DOWN;
	}

	return keys;
}

// verifica se o tiro bateu em algum monstro
int check_collision(struct object_s *bullet, struct object_s *enemy)
{
	int overlap_x = !(bullet->posx + bullet->spriteszx < enemy->posx ||
					  bullet->posx > enemy->posx + enemy->spriteszx);
	int overlap_y = !(bullet->posy + bullet->spriteszy < enemy->posy ||
					  bullet->posy > enemy->posy + enemy->spriteszy);

	return overlap_x && overlap_y;
}

// atualiza a posicao do tiro e verifica se bateu em algum monstro
void update_bullets()
{
	for (int i = 0; i < n_bullets; i++)
	{
		if (!(bullets[i].active))
			continue;
		move_object(&bullets[i]);
		if (check_collision(&bullets[i], &hero))
		{
			bullets[i].active = 0;
			draw_object(&bullets[i], 0, 0);
			if (hero.lives == 1)
			{
				printf("perdeu\n");
				draw_object(&hero, 0, 0);
				hero.active = 0;
				return;
			}
			else
			{
				draw_object(&coracoes[hero.lives - 1], 0, 0);
				coracoes[hero.lives - 1].active = 0;
				printf("hero attacked\n");
				hero.lives--;
				continue;
			}
		}
		if (boss.active && check_collision(&bullets[i], &boss))
		{
			bullets[i].active = 0;
			draw_object(&bullets[i], 0, 0);
			if (boss.lives == 1)
			{
				printf("ganhou\n");
				draw_object(&boss, 0, 0);
				boss.active = 0;
				return;
			}
			else
			{
				printf("boss attacked\n");
				boss.lives--;
				continue;
			}
		}
		for (int j = 0; j < NUM_INIMIES; j++)
		{
			if (!(enemies[j].active))
				continue;
			if (!bullets[i].active)
				break;
			if (check_collision(&bullets[i], &enemies[j]))
			{
				if (bullets[i].dy == -1)
				{
					bullets[i].active = 0;
					draw_object(&bullets[i], 0, 0);
					if (enemies[j].lives == 1)
					{
						n_inimigos--;
						enemies[j].active = 0;
						draw_object(&enemies[j], 0, 0);
						break;
					}
					else
					{
						enemies[j].lives--;
						continue;
					}
				}
			}
		}
		for (int j = 0; j < NUM_BARRIER; j++)
		{
			if (!barrier[j].active)
				continue;
			if (!bullets[i].active)
				break;
			if (check_collision(&bullets[i], &barrier[j]))
			{
				bullets[i].active = 0;
				draw_object(&bullets[i], 0, 0);
				if (bullets[i].dy == 1)
				{
					draw_object(&barrier[j], 0, 0);
					if (barrier[j].lives == 6)
					{
						barrier[j].sprite_frame[0] = barrierDamaged[0];
						draw_object(&barrier[j], 1, -1);
					}
					else if (barrier[j].lives == 4)
					{
						barrier[j].sprite_frame[0] = barrierBroken[0];
						draw_object(&barrier[j], 1, -1);
					}
					else if (barrier[j].lives == 1)
					{
						barrier->active = 0;
					}
					barrier[j].lives--;
				}
				break;
			}
		}
		for (int j = 0; j < HERO_HEARTS; j++)
		{
			if (check_collision(&bullets[i], &coracoes[j]))
			{
				draw_object(&bullets[i], 0, 0);
			}
		}
	}
}

void update()
{
	for (int i = 0; i < NUM_BARRIER; i++)
	{
		if (!(barrier[i].active))
			continue;
		move_object(&barrier[i]);
	}
	for (int i = 0; i < NUM_INIMIES; i++)
	{
		if (!enemies[i].active)
			continue;
		move_object(&enemies[i]);
	}
	if (boss.active)
		move_object(&boss);
	for (int i = 0; i < HERO_HEARTS; i++)
	{
		if (!coracoes[i].active)
			continue;
		move_object(&coracoes[i]);
	}
}

void init_enemies()
{
	int q = NUM_INIMIES / 3;
	for (int i = 0; i < NUM_INIMIES / 3; i++)
	{
		init_object(&enemies[i], cassa1a[0], cassa1b[0], 0, 11, 8, (20 + i * 20), 56, 1, 0, 5, 5, 1);

		init_object(&enemies[1 * q + i], tay2a[0], tay2b[0], 0, 11, 8, (20 + i * 20), 48, -1, 0, 4, 4, 2);

		init_object(&enemies[2 * q + i], monster3a[0], monster3b[0], 0, 11, 8, (20 + i * 20), 30, 1, 0, 6, 6, 3);
	}
}
void init_barrier()
{
	int q = VGA_WIDTH / (NUM_BARRIER + 1);
	for (int i = 0; i < NUM_BARRIER; i++)
	{
		init_object(&barrier[i], barrierFull[0], 0, 0, 14, 10, (q * (i + 1) - 7), 179, 0, 0, 10, 10, 8);
	}
}
void init_hero()
{
	init_object(&hero, MileniumFalcon[0], 0, 0, 10, 10, 145, 207, 0, 0, 3, 3, HERO_HEARTS);
}

void init_hearts()
{
	for (int i = 0; i < HERO_HEARTS; i++)
	{
		init_object(&coracoes[i], coracao[0], 0, 0, 7, 6, 10 + (i * 10), (VGA_HEIGHT - 7), 0, 0, 10, 10, 0);
	}
}

void Level_boss()
{

	init_display();
	delay_ms(2000);
	init_object(&boss, DeathStar[0], 0, 0, 22, 20, (VGA_WIDTH / 2) - 22, 5, -1, 0, 8, 8, 10);
	init_enemies();
	init_barrier();
	n_inimigos = NUM_INIMIES;
	int clk = TIMER0;
	int time = 0;
	int timer = random() % 400;
	while (hero.active && boss.active)
	{
		clk = TIMER0 - clk;
		time += clk;
		if (time > timer)
		{
			create_bullet(&hero, 'e');
			time = 0;
			timer = random() % 600;
		}
		update_bullets();
		update();
		get_input(&hero);
		move_object(&hero);
		delay_ms(5);
		clk = TIMER0;
	}
	delay_ms(2000);
	display_background(BLACK);
	if (hero.active)
		init_object(&fim, VITORIA[0], 0, 0, 63, 15, 114, 102, 0, 0, 1, 1, 0);
	else
		init_object(&fim, DERROTA[0], 0, 0, 63, 15, 114, 102, 0, 0, 1, 1, 0);
	move_object(&fim);
}

void LEVEL_2()
{
	return;
}

void LEVEL_1()
{
	init_display();
	init_input();
	init_hero();
	init_hearts();
	init_barrier();
	init_enemies();
	int clk = TIMER0;
	int time = 0;
	int timer = random() % 750;
	while (hero.active)
	{
		clk = TIMER0 - clk;
		time += clk;
		if (time > timer)
		{
			create_bullet(&hero, 'e');
			time = 0;
			timer = random() % 1000;
		}
		update();
		update_bullets();
		get_input(&hero);
		move_object(&hero);
		delay_ms(5);
		if (n_inimigos == 0)
			break;
		clk = TIMER0;
	}
	delay_ms(2000);
	display_background(BLACK);
	if (hero.active)
		Level_boss();
	else
	{
		init_object(&fim, DERROTA[0], 0, 0, 63, 15, 114, 102, 0, 0, 1, 1, 0);
		move_object(&fim);
	}
}

void Menu (){
	init_display();
	display_print("SPACE", (VGA_WIDTH/2) - 60, (VGA_HEIGHT/2)-60, 3, 2);
	display_print("INVADERS", (VGA_WIDTH/2) - 85, (VGA_HEIGHT/2)-30, 3, 2);
}

/* main game loop */
int main(void)
{
	// LEVEL_1();
	Menu();
	
}