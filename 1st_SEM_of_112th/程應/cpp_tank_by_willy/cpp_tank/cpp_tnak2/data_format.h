#pragma once

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
