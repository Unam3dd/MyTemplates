#ifndef MYLIB_H
#define MYLIB_H

#define MOD2(x) (x & 0x1)
#define MOD4(x) (x & 0x3)
#define MOD8(x) (x & 0x7)
#define MOD16(x) (x & 0xF)
#define MOD32(x) (x & 0x1F)

int mylib_add(int a, int b);
int mylib_mul(int a, int b);
int mylib_sub(int a, int b);
int mylib_div(int a, int b);

#endif
