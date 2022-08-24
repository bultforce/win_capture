#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "snap.h"
#include <cairo/cairo.h>
#include <cairo/cairo-xlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <string.h>
void snap_shot(char *str, int length)
{
  Display *disp;
    Window root;
    cairo_surface_t *surface;
    int scr;
    disp = XOpenDisplay(NULL);
    scr = DefaultScreen(disp);
    root = DefaultRootWindow(disp);
    surface = cairo_xlib_surface_create(disp, root, DefaultVisual(disp, scr),
            DisplayWidth(disp, scr), DisplayHeight(disp, scr));
    char c[100]="";
    strncpy(c, reverse(str, length),100);
    cairo_surface_write_to_png(
            surface,
            c);
  cairo_surface_destroy(surface);
}

int main(int argc, char** argv) {


         char* backwards = "backwards";
            printf("%s reversed is %s\n", backwards, reverse(backwards, 9));

        // print_events();
    return 0;
}
char *reverse(char *str, int length)
{
    // Allocates native memory in C.
    char *reversed_str = (char *)malloc((length + 1) * sizeof(char));
    for (int i = 0; i < length; i++)
    {
        reversed_str[i] = str[i];
    }
    reversed_str[length] = str[length];
    return reversed_str;
}