#include <stdio.h>
#include <dlfcn.h>
#include <assert.h>

int main() {
    void *h;
    int (*f)();

    h = dlopen("/libbase.so", RTLD_NOW | RTLD_LOCAL);
    assert(h);
    f = dlsym(h, "do_calculate");
    assert(f);
    int result = f();
    dlclose(h);

    printf("Ok: %d\n", result);
    return 0;
}