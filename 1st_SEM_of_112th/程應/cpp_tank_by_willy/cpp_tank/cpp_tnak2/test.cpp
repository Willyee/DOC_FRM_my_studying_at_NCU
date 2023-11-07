#define _CRT_SECURE_NO_WARNINGS
#include <math.h>
#include <stdio.h>
#include <string.h>
#define PI = 3.141592653589793238
typedef struct bits
{
    unsigned char hit : 1;
    unsigned char speedup : 1;
    unsigned char sp_disable : 1;
    unsigned char mp_disable : 1;
    unsigned char freeze : 1;
    unsigned char sp_up : 1;
    unsigned char mp_up : 1;
    unsigned char hp_up : 1;
} bits;

typedef union byte_bits
{
    bits b;
    unsigned char B;
} byte_bits;

typedef struct position
{
    float x;
    float y;
    float theta = 1.57;
} position;

typedef struct velocity
{
    float lin;
    float ang;
} velocity;

typedef struct points
{
    float HP;
    float SP;
    float MP;
} points;

typedef struct profile
{
    char name[20];
    position pos;
    velocity vel;
    points points;
    int t;
    byte_bits status;
} profile;

typedef struct enemy_profile
{
    char name[20];
    position pos;
    points points;
    byte_bits status;
} enemy_profile;



int main()
{
    profile tank_profile;
    printf("what is your name?\n");
    scanf("%s", tank_profile.name);
    printf(tank_profile.name);

    printf("what is your HP?\n");
    scanf("%f", &tank_profile.points.HP);
    printf("what is your SP?\n");
    scanf("%f", &tank_profile.points.SP);
    printf("what is your MP?\n");
    scanf("%f", &tank_profile.points.MP);

    tank_profile.pos.x = 0;
    tank_profile.pos.y = 0;
    tank_profile.pos.theta = 1.57;
    tank_profile.t = 0;

    FILE *fp;
    fp = fopen("profile.dat", "w");
    fprintf(fp, "%s\n", tank_profile.name);
    fprintf(fp, "%f\n%f\n%f\n%i\n", tank_profile.pos.x, tank_profile.pos.y, tank_profile.pos.theta, tank_profile.t);
    fprintf(fp, "%f\n%f\n%f\n", tank_profile.points.HP, tank_profile.points.SP, tank_profile.points.MP);
    fclose(fp);
    printf("profile saved\n");
}