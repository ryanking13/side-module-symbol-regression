#ifdef __EMSCRIPTEN__
#include <emscripten.h>
#endif
#include "dep.h"

int do_calculate() {
    return calculate(add);
}

