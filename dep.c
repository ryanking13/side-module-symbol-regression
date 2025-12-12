#include "dep.h"

int add(int a, int b) {
    return a + b;
}

int calculate(HANDLER handler) { 
    return handler(3, 5);
}