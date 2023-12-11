#include <criterion/criterion.h>
#include <stdio.h>
#include "project.h"

TestSuite(test1_suite);

Test(test1_suite, simple_add_test) {
	cr_expect(add(2, 2) == 4, "Expected \"simple_add_test\" the sum of 2 + 2 is 4.");
}

int main(void)
{
	printf("hello world !\n");
	return (0);
}
