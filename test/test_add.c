#include <criterion/criterion.h>
#include <stdio.h>
#include "../inc/project.h"

Test(test1_suite, simple_add_test) {
	cr_expect(add(2, 2) == 4, "Expected \"simple_add_test\" add(2,2) != 4 ? the sum of 2 + 2 is 4.");
	cr_expect(add(143, 0) == 143, "Expected \"simple_add_test\" add(143, 0) != 143 ? the sum of 143 + 0 is 143.");
}
