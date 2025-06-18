#include <math.h>

#define PI 3.14159265358979323846

// External function assumed to exist
void draw(double x0, double y0, double x1, double y1) {

}

// Draws one hexagon edge starting from center (cx, cy), from angle_start to angle_end
void draw_edge(double cx, double cy, double side, int angle_index) {
    double angle1 = PI / 3 * angle_index;
    double angle2 = PI / 3 * (angle_index + 1);
    double x1 = cx + side * cos(angle1);
    double y1 = cy + side * sin(angle1);
    double x2 = cx + side * cos(angle2);
    double y2 = cy + side * sin(angle2);
    draw(x1, y1, x2, y2);
}

// Function to draw a hexagonal mesh with no duplicate edges
void draw_hex_mesh(int rows, int cols, double hex_side) {
    double dx = 1.5 * hex_side;
    double dy = sqrt(3.0) * hex_side;

    for (int row = 0; row < rows; ++row) {
        for (int col = 0; col < cols; ++col) {
            double cx = col * dx;
            double cy = row * dy;
            if (col % 2 == 1) {
                cy += dy / 2.0;
            }

            // Only draw 3 edges per hexagon to avoid duplicates
            // Draw right (0-1), lower-right (1-2), and lower-left (2-3) edges
            draw_edge(cx, cy, hex_side, 0); // right
            draw_edge(cx, cy, hex_side, 1); // lower-right
            draw_edge(cx, cy, hex_side, 2); // lower-left

            // Optional: draw top-left edge for first row
            if (row == 0) {
                draw_edge(cx, cy, hex_side, 5); // top-left
            }

            // Optional: draw top-right edge for first column
            if (col == 0) {
                draw_edge(cx, cy, hex_side, 4); // top-right
            }
        }
    }
}
