#include <criterion/criterion.h>
#include "mylib.h"

Test(test_mylib, simple_test_add)
{
    cr_expect(mylib_add(2,2) == 4, "the result is not what was expected.");
    cr_expect(mylib_add(150, 0) == 150, "the result is not what was expected.");
    cr_expect(mylib_add(0x7FFFFFFF, 2) == (int)0x80000001, "the result is not what was expected.");
}

Test(test_mylib, simple_test_sub)
{
    cr_expect(mylib_sub(2,2) == 0, "the result is not what was expected.");
    cr_expect(mylib_sub(150, 0) == 150, "the result is not what was expected.");
    cr_expect(mylib_sub(0x7FFFFFFF, 2) == 0x7FFFFFFD, "the result is not what was expected.");
}

Test(test_mylib, simple_test_mul)
{
    cr_expect(mylib_mul(4,4) == 0x10, "the result is not what was expected.");
    cr_expect(mylib_mul(150, 0) == 0, "the result is not what was expected.");
    cr_expect(mylib_mul(100, 2) == 200, "the result is not what was expected.");
}

Test(test_mylib, simple_test_div)
{
    cr_expect(mylib_div(4,4) == 0x1, "the result is not what was expected.");
    cr_expect(mylib_div(150, 1) == 150, "the result is not what was expected.");
    cr_expect(mylib_div(100, 2) == 50, "the result is not what was expected.");
}

Test(test_mylib, simple_test_mod4)
{
    cr_expect(MOD4(4) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD4(12) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD4(16) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD4(32) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD4(3) == 3, "the resutl obtained is not what was expected.");
    cr_expect(MOD4(8) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD4(6) == 2, "the result obtained is not what was expected.");

}

Test(test_mylib, simple_test_mod8)
{
    cr_expect(MOD8(7) == 7, "the result obtained is not what was expected.");
    cr_expect(MOD8(8) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD8(16) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD8(24) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD8(32) == 0, "the result obtained is not what was expected.");
    cr_expect(MOD8(34) == 2, "the result obtained is not what was expected.");
    cr_expect(MOD8(38) == 6, "the result obtained is not what was expected.");
}
