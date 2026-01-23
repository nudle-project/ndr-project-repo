#include <stdio.h>
void sys_list(void *args)
{
    printf("[Kernel] Listing directory...\n");
}
void sys_chdir(void *args)
{
    printf("[Kernel] Changing directory to: %s\n", (char *)args);
}
void sys_chdsk(void *args)
{
    printf("[Kernel] Checking disk...\n");
}
void sys_mount(void *args)
{
    printf("[Kernel] Mounting: %s\n", (char *)args);
}
