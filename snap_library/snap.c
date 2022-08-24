#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "snap.h"
#include <cairo/cairo.h>
#include <cairo/cairo-xlib.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <string.h>

void snap_shot(int argc, char** argv)
{
      Display *disp;
    Window root;
    cairo_surface_t *surface;
    int scr;

    disp = XOpenDisplay(NULL);
    scr = DefaultScreen(disp);
    root = DefaultRootWindow(disp);
    printf("getting root\n");
    surface = cairo_xlib_surface_create(disp, root, DefaultVisual(disp, scr),
            DisplayWidth(disp, scr), DisplayHeight(disp, scr));
    cairo_surface_write_to_png(
            surface,
            "screen01.png");
   printf("cairo_surface_write_to_png\n");
  cairo_surface_destroy(surface);
     printf("cairo_surface_destroy\n");
printf("bhjkbjhbhb\n");

}

int main(int argc, char** argv) {

    printf("jbhbjhbhbbh\n");
        char** backwards = (char *[]){"hello", "world"};
        snap_shot(0, backwards);
        // print_events();
    return 0;
}
