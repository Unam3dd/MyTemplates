#include "hello-world.h"
#include <stdio.h>
#include <string.h>

int main(int ac, char **av)
{
    if (ac != 2) return (1);

    if (!strcmp("name", av[1])) return (1);
    
    say_hello(av[1]);

    puts("this is exemple of debugging PLT & GOT");

    return (0);
}
