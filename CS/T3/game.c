#include <hf-risc.h>
#include "vga_drv.h"

#define NUM_INIMIES 15
#define MAX_BULLETS 200
#define NUM_BARRIER 4

/* sprites and sprite drawing */
char monster1a[8][11] = {
	{0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0},
	{2, 0, 0, 2, 0, 0, 0, 2, 0, 0, 2},
	{2, 0, 2, 2, 2, 2, 2, 2, 2, 0, 2},
	{2, 2, 2, 0, 2, 2, 2, 0, 2, 2, 2},
	{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
	{0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0},
	{0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0},
	{0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0}};

char monster1b[8][11] = {
	{0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0},
	{0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0},
	{0, 0, 2, 2, 2, 2, 2, 2, 2, 0, 0},
	{0, 2, 2, 0, 2, 2, 2, 0, 2, 2, 0},
	{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
	{2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
	{2, 0, 2, 0, 0, 0, 0, 0, 2, 0, 2},
	{0, 0, 0, 2, 2, 0, 2, 2, 0, 0, 0}};

char monster2a[8][8] = {
	{0, 0, 0, 6, 6, 0, 0, 0},
	{0, 0, 6, 6, 6, 6, 0, 0},
	{0, 6, 6, 6, 6, 6, 6, 0},
	{6, 6, 0, 6, 6, 0, 6, 6},
	{6, 6, 6, 6, 6, 6, 6, 6},
	{0, 6, 0, 6, 6, 0, 6, 0},
	{6, 0, 0, 0, 0, 0, 0, 6},
	{0, 6, 0, 0, 0, 0, 6, 0}};

char monster2b[8][8] = {
	{0, 0, 0, 6, 6, 0, 0, 0},
	{0, 0, 6, 6, 6, 6, 0, 0},
	{0, 6, 6, 6, 6, 6, 6, 0},
	{6, 6, 0, 6, 6, 0, 6, 6},
	{6, 6, 6, 6, 6, 6, 6, 6},
	{0, 0, 6, 0, 0, 6, 0, 0},
	{0, 6, 0, 6, 6, 0, 6, 0},
	{6, 0, 6, 0, 0, 6, 0, 6}};

char monster3a[8][12] = {
	{0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0},
	{1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}};

char monster3b[8][12] = {
	{0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0},
	{0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0},
	{0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0},
	{0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0}};

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

char spaceShip[8][11] = {
	{0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0},
	{0, 0, 0, 0, 7, 7, 7, 0, 0, 0, 0},
	{0, 0, 0, 0, 7, 8, 7, 0, 0, 0, 0},
	{0, 0, 0, 7, 7, 8, 7, 7, 0, 0, 0},
	{4, 4, 4, 7, 7, 7, 7, 7, 4, 4, 4},
	{7, 7, 7, 7, 6, 6, 6, 7, 7, 7, 7},
	{0, 7, 7, 7, 7, 0, 7, 7, 7, 7, 0},
	{0, 0, 4, 4, 0, 0, 0, 4, 4, 0, 0}};

char bulletShip[4][1] = {
	{7},
	{7},
	{7},
	{7}};

char bullet1a[4][2] = {
	{0, 7},
	{7, 0},
	{0, 7},
	{7, 0}};

char bullet1b[4][2] = {
	{7, 0},
	{0, 7},
	{7, 0},
	{0, 7}};

char bullet2a[4][3] = {
	{0, 7, 0},
	{0, 7, 0},
	{7, 7, 7},
	{0, 7, 0}};

char bullet2b[4][3] = {
	{0, 7, 0},
	{7, 7, 7},
	{0, 7, 0},
	{0, 7, 0}};

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
	int active; // 1 = ativo, 0 = inativo
};

struct object_s hero;
struct object_s barrier[NUM_BARRIER];
struct object_s bullets[MAX_BULLETS];
// struct object_s e_bullets[MAX_BULLETS];
struct object_s enemies[NUM_INIMIES];
int n_bullets = 0;
int n_inimigos = NUM_INIMIES;

void init_object(struct object_s *obj, char *spritea, char *spriteb,
				 char *spritec, char spriteszx, char spriteszy, int posx, int posy,
				 int dx, int dy, int spx, int spy)
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

	// logica para a colisao, se chegar na parede, inverte a direcao
	if (obj->posx == 0)
	{
		obj->dx = 1;
	}
	if (obj->posx == (VGA_WIDTH - obj->spriteszx))
	{
		obj->dx = -1;
	}
}

/* display and input */
void init_display()
{
	display_background(BLACK);
}

// cria o objeto tiro quando o botao eh apertado, com base na posicao da nave

void create_bullet(struct object_s *hero, char type)
{
	if (n_bullets < MAX_BULLETS)
	{
		if (type == 'h')
		{
			init_object(&bullets[n_bullets], bullet2a[0], bullet2b[0], 0, 3, 4,
						hero->posx - 1 + (hero->spriteszx / 2),
						hero->posy - 4, 0, -1, 0, 1);
			n_bullets++;
		}
		else
		{
			int shots = 0;
			if (n_inimigos >= 3)
			{
				for (int i = 0; i < NUM_INIMIES; i++)
				{
					if (shots < 3)
					{
						if (!(enemies[i].active))
							continue;
						init_object(&bullets[n_bullets], bullet1a[0], bullet1b[0], 0, 2, 4,
									enemies[i].posx - 1 + (enemies[i].spriteszx / 2),
									enemies[i].posy + enemies[i].spriteszy + 1, 0, 1, 1, 1);
						shots++;
						n_bullets++;
						if (n_bullets == MAX_BULLETS)
							return;
					}
					else
						return;
				}
			}
			else
			{
				for (int i = 0; i < n_inimigos; i++)
				{
					for (int i = 0; i < NUM_INIMIES; i++)
					{
						if (!(enemies[i].active))
							continue;
						init_object(&bullets[n_bullets], bullet1a[0], bullet1b[0], 0, 2, 4,
									enemies[i].posx - 1 + (enemies[i].spriteszx / 2),
									enemies[i].posy + enemies[i].spriteszy + 1, 0, 1, 1, 1);
						shots++;
						n_bullets++;
						if (n_bullets == MAX_BULLETS)
							return;
						break;
					}
				}
			}
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
		while (GPIOB->IN & MASK_P9)
			;
		create_bullet(hero, 'h');
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
			draw_object(&bullets[i], 0, 0);
			draw_object(&hero, 0, 0);
			hero.active = 0;
			return;
		}
		for (int j = 0; j < NUM_INIMIES; j++)
		{
			if (!(enemies[j].active))
				continue;
			if (check_collision(&bullets[i], &enemies[j]))
			{
				if (bullets[i].dy == -1)
				{
					n_inimigos--;
					bullets[i].active = 0;
					enemies[j].active = 0;
					draw_object(&bullets[i], 0, 0);
					draw_object(&enemies[j], 0, 0);
					break;
				}
			}
		}
		for (int j = 0; j < NUM_BARRIER; j++)
		{
			if (!barrier[j].active)
				continue;
			if (check_collision(&bullets[i], &barrier[j]))
			{
				bullets[i].active = 0;
				draw_object(&bullets[i], 0, 0);
				if (bullets[i].dy == 1)
				{
					draw_object(&barrier[j], 0, 0);
					if (barrier[j].sprite_frame[0] == barrierFull[0])
					{
						barrier[j].sprite_frame[0] = barrierDamaged[0];
						move_object(&barrier[j]);
					}
					else if (barrier[j].sprite_frame == barrierDamaged[0])
					{
						barrier[j].sprite_frame[0] = barrierBroken[0];
						move_object(&barrier[j]);
					}
					else
					{
						barrier[j].active = 0;
					}
				}
				break;
			}
		}
	}
}
// inicia a criacao dos enimigos, por categoria, e coloca-os num vetor
void init_enemies()
{
	int q = NUM_INIMIES / 3;
	for (int i = 0; i < NUM_INIMIES / 3; i++)
	{
		init_object(&enemies[i], monster1a[0], monster1b[0], 0, 11, 8, (20 + i * 20), 90, 1, 0, 5, 5);

		init_object(&enemies[1 * q + i], monster2a[0], monster2b[0], 0, 8, 8, (20 + i * 20), 60, 1, 0, 3, 3);

		init_object(&enemies[2 * q + i], monster3a[0], monster3b[0], 0, 12, 8, (20 + i * 20), 30, 1, 0, 2, 2);
	}
}
void init_barrier()
{
	for (int i = 0; i < NUM_BARRIER; i++)
	{
		init_object(&barrier[i], barrierFull[0], 0, 0, 14, 10, (80 + i * 80), 140, 0, 0, 10, 10);
	}
}

void update_barrier()
{
	for (int i = 0; i < NUM_BARRIER; i++)
	{
		if (!(barrier[i].active))
			continue;
		move_object(&barrier[i]);
	}
}

void update_enimies()
{
// 	if (n_inimigos == 0)
// 	{
// 		hero.active = 0;
// 		return;
// 	}
	for (int i = 0; i < NUM_INIMIES; i++)
	{
		if (!enemies[i].active)
			continue;
		move_object(&enemies[i]);
	}
}

void init_hero()
{
	init_object(&hero, spaceShip[0], spaceShip[0], 0, 11, 8, 150, 209, 0, 0, 1, 1);
}

/* main game loop */
int main(void)
{

	init_display();
	init_input();
	int clk = TIMER0;
	init_hero();
	init_barrier();
	init_enemies();
	int time = 0;
	while (hero.active)
	{
		clk = TIMER0 - clk;
		time += clk;
		if (time > 630)
		{
			create_bullet(&hero, 'e');
			time = 0;
		}
		update_enimies();
		update_bullets(&hero);
		update_barrier();
		get_input(&hero);
		move_object(&hero);
		delay_ms(20);
		clk = TIMER0;
	}

	return 0;
}