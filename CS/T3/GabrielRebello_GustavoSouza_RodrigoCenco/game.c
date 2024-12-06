#include <hf-risc.h>
#include "vga_drv.h"

#define NUM_INIMIES 12
#define MAX_BULLETS 21
#define NUM_BARRIER 5
#define HERO_HEARTS 5

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

char explosion1[8][11] = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0},
	{0, 0, 0, 4, 6, 6, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 6, 6, 4, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

};

char explosion2[8][11] = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0},
	{0, 0, 0, 4, 4, 6, 4, 0, 0, 0, 0},
	{0, 0, 4, 6, 6, 6, 4, 0, 0, 0, 0},
	{0, 0, 0, 4, 6, 6, 6, 4, 0, 0, 0},
	{0, 0, 0, 4, 6, 4, 4, 0, 0, 0, 0},
	{0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

};
char explosion3[8][11] = {
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	{0, 0, 4, 4, 4, 0, 4, 4, 0, 0, 0},
	{0, 0, 4, 6, 6, 4, 6, 4, 0, 0, 0},
	{0, 0, 0, 6, 6, 6, 6, 4, 0, 0, 0},
	{0, 0, 0, 4, 6, 6, 4, 0, 0, 0, 0},
	{0, 0, 4, 6, 4, 6, 6, 4, 0, 0, 0},
	{0, 0, 4, 4, 0, 4, 4, 4, 0, 0, 0},
	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

};

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

char missil1[7][3] = {
	{0, 4, 0},
	{0, 8, 0},
	{0, 8, 0},
	{0, 8, 0},
	{8, 8, 8},
	{0, 6, 0},
	{0, 0, 0}};

char missil2[7][3] = {
	{0, 4, 0},
	{0, 8, 0},
	{0, 8, 0},
	{0, 8, 0},
	{8, 8, 8},
	{0, 6, 0},
	{0, 6, 0}};

char missil_b1[7][3] = {
	{0, 0, 0},
	{0, 6, 0},
	{8, 8, 8},
	{0, 8, 0},
	{0, 8, 0},
	{0, 8, 0},
	{0, 4, 0}};

char missil_b2[7][3] = {
	{0, 6, 0},
	{0, 6, 0},
	{8, 8, 8},
	{0, 8, 0},
	{0, 8, 0},
	{0, 8, 0},
	{0, 4, 0}};

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

/*Objetos usados*/
struct object_s hero, boss, explo;
struct object_s coracoes[HERO_HEARTS];
struct object_s barrier[NUM_BARRIER];
struct object_s bullets[MAX_BULLETS];
struct object_s enemies[NUM_INIMIES];
struct object_s bomb[5];
int n_bullets = 1;
int n_inimigos;
int pontos, saldo, m;
char pontuacao[20], p[20], b[20];

/*Metodo que inicia objeto*/
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
/*Metodo de desenho de objetos*/
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

/*Metodo que atualiza posição do objeto de acordo com as velocidades iniciadas*/
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
	/*Se tocar na parede esquerda da tela vira a direção e vai para baixo*/
	if (obj->posx == 0 + obj->spriteszx && obj->sprite_frame[0] != hero.sprite_frame[0])
	{
		draw_object(&oldobj, 0, 0);
		obj->dx = 1;
		if (obj->posy <= 120 && obj->posy >= 30)
		{
			obj->posy += 9;
			obj->posx++;
		}
	}
	/*Se tocar na parede direita da tela vira a direção e vai para baixo*/
	else if (obj->posx == (VGA_WIDTH - obj->spriteszx) && obj->sprite_frame[0] != hero.sprite_frame[0])
	{
		draw_object(&oldobj, 0, 0);
		obj->dx = -1;
		if (obj->posy <= 160 && obj->posy >= 30)
		{
			obj->posy += 9;
			obj->posx--;
		}
	}
	/*se obj tocar no teto ou chão da tela limpa e desativa*/
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

/*verifica se algum tiro inimigo ainda esta ativa*/
int check_active_bullet()
{
	for (int i = 1; i < MAX_BULLETS; i++)
	{
		if (bullets[i].active)
			return 1;
	}
	return 0;
}
/*verifica se misseis do chefe ainda estão ativos*/
int check_boss_missil()
{
	return (bomb[1].active || bomb[2].active || bomb[3].active) ? 0 : 1;
}

/*verifica pontuação do jogador do jogar, se chegar a multiplo de 100 adicinona missel ao player*/
void check_points()
{
	if (saldo >= 100 && saldo > 0)
	{
		sprintf(p, "x%d", m);
		display_print(p, 20, 200, 1, BLACK);
		saldo -= 100;
		m++;
	}
}

/*metodo de desenho de explosão geral*/
void explosao(struct object_s *enemy)
{
	init_object(&explo, explosion1[0], 0, 0, 11, 8, enemy->posx, enemy->posy, 0, 0, 1, 1, 0);
	draw_object(&explo, 0, -1);
	explo.sprite_frame[0] = explosion2[0];
	delay_ms(10);
	draw_object(&explo, 0, 0);
	draw_object(&explo, 0, -1);
	explo.sprite_frame[0] = explosion3[0];
	delay_ms(10);
	draw_object(&explo, 0, 0);
	draw_object(&explo, 0, -1);
	explo.sprite_frame[0] = explosion2[0];
	delay_ms(10);
	draw_object(&explo, 0, 0);
}

// Metodo que cria o objeto tiro quando o botao eh apertado, com base na posicao da nave*/
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
			/*Esta parte cria uma rajada de tiros inimigos  em uma so vez*/
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
/*	metodo que cria objeto missil apartir da posição da nave que criou,
	valido so para player e boss
*/
void create_missil(struct object_s *obj)
{
	if (obj->sprite_frame[0] == MileniumFalcon[0])
	{
		init_object(&bomb[0], missil1[0], missil2[0], 0, 3, 7,
					obj->posx - 1 + (obj->spriteszx / 2),
					obj->posy - 7, 0, -1, 0, 1, 1);
	}
	else if (obj->sprite_frame[0] == DeathStar[0])
	{
		for (int i = 1; i < 4; i++)
		{
			init_object(&bomb[i], missil_b1[0], missil_b2[0], 0, 3, 7,
						obj->posx - 15 + (obj->spriteszx / 2) + (5 * i),
						obj->posy + obj->spriteszy, (i - 2), 1, 3, 1, 1);
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
/*Avalia entrada dos botoes exclusivo para player*/
void get_input_hero()
{
	hero.dx = 0;
	if (GPIOB->IN & MASK_P8)
	{
		if (!bomb[0].active)
		{
			if (m > 0)
			{
				create_missil(&hero);
				sprintf(p, "x%d", m);
				display_print(p, 20, 200, 1, BLACK);
				m--;
			}
		}
	}
	if (GPIOB->IN & MASK_P9)
	{
		if (!bullets[0].active)
			create_bullet(&hero, 'h');
	}
	if (GPIOB->IN & MASK_P10)
	{
		if ((hero.posx - hero.spriteszx - 5 != 0))
			hero.dx = -1;
	}
	if (GPIOB->IN & MASK_P11)
	{
		if (hero.posx + hero.spriteszx + 5 != VGA_WIDTH)
			hero.dx = 1;
	}
	if (GPIOB->IN & MASK_P12)
	{
	}
}
/*	exlusivo para o MENU */
int get_input_menu()
{
	int key = 1;
	if (GPIOB->IN & MASK_P8)
	{
		key = 0;
	}

	return key;
}

// verifica se o tiro/missil atigiu algo
int check_collision(struct object_s *bullet, struct object_s *enemy)
{
	int overlap_x = !(bullet->posx + bullet->spriteszx < enemy->posx ||
					  bullet->posx > enemy->posx + enemy->spriteszx);
	int overlap_y = !(bullet->posy + bullet->spriteszy < enemy->posy ||
					  bullet->posy > enemy->posy + enemy->spriteszy);

	return overlap_x && overlap_y;
}

// atualiza a posicao do tiro e verifica se bateu em algo
void update_bullets()
{
	for (int i = 0; i < n_bullets; i++)
	{
		if (!(bullets[i].active))
			continue;
		move_object(&bullets[i]);

		// verificação do boss e atualização conforme a vida
		if (boss.active && check_collision(&bullets[i], &boss))
		{
			bullets[i].active = 0;
			draw_object(&bullets[i], 0, 0);
			sprintf(b, "boss:%2d", boss.lives);
			display_print(b, 240, 5, 1, BLACK);

			if (boss.lives == 1)
			{
				draw_object(&boss, 0, 0);
				boss.active = 0;
				return;
			}
			else
			{
				boss.lives--;
				continue;
			}
		}
		// verificação de cada nave inimiga e atualização conforme a vida
		for (int j = 0; j < NUM_INIMIES; j++)
		{
			if (!(enemies[j].active))
				continue;
			if (!bullets[i].active)
				break;
			if (check_collision(&bullets[i], &enemies[j]))
			{
				bullets[i].active = 0;
				draw_object(&bullets[i], 0, 0);
				if (bullets[i].dy == -1)
				{
					if (enemies[j].lives == 1)
					{
						n_inimigos--;
						enemies[j].active = 0;
						draw_object(&enemies[j], 0, 0);
						explosao(&enemies[j]);
						sprintf(pontuacao, "Pontos:%d", pontos);
						display_print(pontuacao, 10, 5, 1, BLACK);
						if (enemies[j].sprite_frame[0] == cassa1a[0])
						{
							pontos += 10;
							saldo += 10;
						}
						else if (enemies[j].sprite_frame[0] == tay2a[0])
						{
							pontos += 20;
							saldo += 20;
						}
						else
						{
							saldo += 30;
							pontos += 30;
						}
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
		/* verifica tiros do inimigos no player*/
		if (check_collision(&bullets[i], &hero))
		{
			bullets[i].active = 0;
			draw_object(&bullets[i], 0, 0);
			if (hero.lives == 1)
			{
				printf("perdeu\n");
				draw_object(&hero, 0, 0);
				hero.active = 0;
				explosao(&hero);
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
		// atualiza versao da barreira
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
					if (barrier[j].lives == 10)
					{
						barrier[j].sprite_frame[0] = barrierDamaged[0];
						draw_object(&barrier[j], 1, -1);
					}
					else if (barrier[j].lives == 5)
					{
						barrier[j].sprite_frame[0] = barrierBroken[0];
						draw_object(&barrier[j], 1, -1);
					}
					else if (barrier[j].lives == 1)
					{
						barrier[j].active = 0;
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

/*mesmo metodo de verificação que o anterior, agora para misseis*/
void atualiza_missil()
{
	for (int i = 0; i < 4; i++)
	{
		if (!(bomb[i].active))
			continue;
		move_object(&bomb[i]);
		if (check_collision(&bomb[i], &boss))
		{
			bomb[i].active = 0;
			draw_object(&bomb[i], 0, 0);
			sprintf(b, "boss:%2d", boss.lives);
			display_print(b, 240, 5, 1, BLACK);
			if (boss.lives <= 5)
			{
				draw_object(&boss, 0, 0);
				boss.active = 0;
				return;
			}
			else
				boss.lives -= 5;
			continue;
		}
		for (int j = 0; j < NUM_INIMIES; j++)
		{
			if (!(enemies[j].active))
				continue;
			if (!bomb[i].active)
				break;
			if (check_collision(&bomb[i], &enemies[j]))
			{
				bomb[i].active = 0;
				draw_object(&bomb[i], 0, 0);
				if (bomb[i].dy == -1)
				{
					n_inimigos--;
					enemies[j].active = 0;
					draw_object(&enemies[j], 0, 0);
					explosao(&enemies[j]);
					sprintf(pontuacao, "Pontos:%d", pontos);
					display_print(pontuacao, 10, 5, 1, BLACK);
					if (enemies[j].sprite_frame[0] == cassa1a[0])
					{
						pontos += 10;
						saldo += 10;
					}
					else if (enemies[j].sprite_frame[0] == tay2a[0])
					{
						pontos += 20;
						saldo += 20;
					}
					else
					{
						pontos += 30;
						saldo += 30;
					}
				}
			}
		}
		if (check_collision(&bomb[i], &hero))
		{
			bomb[i].active = 0;
			draw_object(&bomb[i], 0, 0);
			draw_object(&hero, 0, 0);
			hero.active = 0;
			explosao(&hero);
			return;
		}
		for (int j = 0; j < NUM_BARRIER; j++)
		{
			if (!barrier[j].active)
				continue;
			if (!bomb[i].active)
				break;
			if (check_collision(&bomb[i], &barrier[j]))
			{
				bomb[i].active = 0;
				draw_object(&bomb[i], 0, 0);
				if (bomb[i].dy == 1)
				{
					if (barrier[j].lives <= 5)
					{
						draw_object(&barrier[j], 0, 0);
						barrier[j].active = 0;
					}
					else
					{
						barrier[j].lives -= 5;
					}
					break;
				}
			}
		}
	}
}


/*Move todas esprites, exceto tiros, ainda ativas*/
void update_sprites()
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
	for (int i = 0; i < HERO_HEARTS; i++)
	{
		if (!coracoes[i].active)
			continue;
		move_object(&coracoes[i]);
	}
	if (boss.active)
	{
		move_object(&boss);
		sprintf(b, "boss:%2d", boss.lives);
		display_print(b, 240, 5, 1, WHITE);
	}

	check_points();
	sprintf(pontuacao, "Pontos:%d", pontos);
	display_print(pontuacao, 10, 5, 1, WHITE);
	sprintf(p, "x%d", m);
	display_print(p, 20, 200, 1, WHITE);

	move_object(&hero);
	move_object(&bomb[4]);
}

/*Inicia barreiras*/
void init_enemies(int level)
{
	int q = NUM_INIMIES / 3;
	for (int i = 0; i < NUM_INIMIES / 3; i++)
	{
		if (level == 1)
		{
			init_object(&enemies[i], cassa1a[0], cassa1b[0], 0, 11, 8, (20 + i * 20), 56, 1, 0, 5, 5, 1);

			init_object(&enemies[1 * q + i], tay2a[0], tay2b[0], 0, 11, 8, (20 + i * 20), 48, -1, 0, 4, 4, 2);

			init_object(&enemies[2 * q + i], monster3a[0], monster3b[0], 0, 11, 8, (20 + i * 20), 30, 1, 0, 6, 6, 3);
		}
		else
		{
			init_object(&enemies[i], cassa1a[0], cassa1b[0], 0, 11, 8, (20 + i * 20), 56, -1, 0, 5, 5, 1);

			init_object(&enemies[1 * q + i], tay2a[0], tay2b[0], 0, 11, 8, (20 + i * 20), 48, -1, 0, 4, 4, 2);

			init_object(&enemies[2 * q + i], monster3a[0], monster3b[0], 0, 11, 8, (20 + i * 20), 30, 1, 0, 6, 6, 3);
		}
	}
}
void init_barrier()
{
	int q = VGA_WIDTH / (NUM_BARRIER + 1);
	for (int i = 0; i < NUM_BARRIER; i++)
	{
		init_object(&barrier[i], barrierFull[0], 0, 0, 14, 10, (q * (i + 1) - 7), 179, 0, 0, 10, 10, 15);
	}
}
void init_hero()
{
	init_object(&hero, MileniumFalcon[0], 0, 0, 10, 10, 145, 207, 0, 0, 3, 3, HERO_HEARTS);
	init_object(&bomb[4], missil1[0], 0, 0, 3, 7, 15, 200, 0, 0, 5, 5, 0);
}

void init_hearts()
{
	for (int i = 0; i < HERO_HEARTS; i++)
	{
		init_object(&coracoes[i], coracao[0], 0, 0, 7, 6, 10 + (i * 10), (VGA_HEIGHT - 7), 0, 0, 10, 10, 0);
	}
}

int clk, time, timer;
//metodo espera usuario apertar botao central
void wait()
{
	int button = get_input_menu();
	while (button)
	{
		display_print("Press center button", (VGA_WIDTH / 2) - 80, (VGA_HEIGHT / 2) + 50, 1, BLUE);
		delay_ms(400);
		display_print("Press center button", (VGA_WIDTH / 2) - 80, (VGA_HEIGHT / 2) + 50, 1, BLACK);
		delay_ms(400);
		button = get_input_menu();
	}
}

void Level_boss()
{
	init_display();
	display_print("FINAL BOSS", (VGA_WIDTH / 2) - 115, (VGA_HEIGHT / 2) - 30, 3, WHITE);
	delay_ms(2000);
	display_background(BLACK);

	init_object(&boss, DeathStar[0], 0, 0, 22, 20, (VGA_WIDTH / 2) - 22, 5, -1, 0, 8, 8, 20);
	init_enemies(2);
	init_barrier();

	n_inimigos = NUM_INIMIES;
	clk = TIMER0;
	time = 0;
	timer = random() % 400;

	while (hero.active && boss.active)
	{
		clk = TIMER0 - clk;
		time += clk;
		if (time > timer)
		{
			create_bullet(&hero, 'e');
			time = 0;
			timer = 700 + random() % 500;
		}
		get_input_hero(&hero);
		update_bullets();
		update_sprites();
		atualiza_missil();
		if (check_boss_missil())
		{
			create_missil(&boss);
		}
		delay_ms(2);
		clk = TIMER0;
	}

	delay_ms(2000);
	display_background(BLACK);

	if (hero.active)
		display_print("VITORIA", 100, 80, 2, GREEN);
	else
		display_print("DERROTA", 100, 80, 2, RED);

	wait();
	delay_ms(1000);
	display_background(BLACK);
	Menu();
}

void LEVEL_1()
{
	init_display();
	init_hero();
	init_hearts();
	init_barrier();
	init_enemies(1);
	n_inimigos = NUM_INIMIES;
	clk = TIMER0;
	time = 0;
	timer = random() % 750;
	while (hero.active)
	{
		clk = TIMER0 - clk;
		time += clk;
		if (time > timer)
		{
			create_bullet(&hero, 'e');
			time = 0;
			timer = 1000 + random() % 800;
		}
		get_input_hero();
		update_sprites();
		update_bullets();
		atualiza_missil();
		delay_ms(2);
		if (n_inimigos == 0)
			break;
		clk = TIMER0;
	}
	display_background(BLACK);
	delay_ms(2000);
	if (hero.active)
		Level_boss();
	else
	{
		display_print("DERROTA", 100, 80, 2, RED);
		wait();
		delay_ms(2000);
		display_background(BLACK);
		Menu();
	}
}
/*Menu inicial*/
void Menu()
{
	init_display();
	init_input();
	m = 0;
	pontos = 0;
	saldo = 0;
	boss.active = 0;
	display_print("SPACE", (VGA_WIDTH / 2) - 60, (VGA_HEIGHT / 2) - 60, 3, GREEN);
	display_print("INVADERS", (VGA_WIDTH / 2) - 85, (VGA_HEIGHT / 2) - 30, 3, GREEN);
	wait();
	display_background(BLACK);
	display_print("LEVEL 1", (VGA_WIDTH / 2) - 85, (VGA_HEIGHT / 2) - 30, 3, WHITE);
	delay_ms(2000);
	LEVEL_1();
}

/* main game loop */
int main(void)
{
	Menu();
}