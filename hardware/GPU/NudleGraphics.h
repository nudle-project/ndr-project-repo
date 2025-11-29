//The header file for the driver.
#ifndef NUDLE_GRAPHICS_H
#define NUDLE_GRAPHICS_H

#include <cstdint> // For standard integer types
#include <vector>  // For dynamic arrays of graphics data

namespace NudleOS {
namespace Hardware {
namespace GPU {

// Define a simple structure for a vertex
struct Vertex {
    float x, y, z;      // Position
    float r, g, b, a;   // Color
    float u, v;         // Texture coordinates
};

// Define a simple structure for a command buffer entry
enum GraphicsCommandType {
    CLEAR_BUFFER,
    DRAW_TRIANGLES,
    PRESENT_FRAME
};

struct GraphicsCommand {
    GraphicsCommandType type;
    union {
        struct {
            uint32_t color;
        } clear;
        struct {
            uint32_t vertexCount;
            uint32_t startIndex; // Index into a global vertex buffer
        } drawTriangles;
    };
};

class NudleGraphics {
public:
    NudleGraphics();
    ~NudleGraphics();

    // Initializes the graphics driver and hardware
    bool initialize();

    // Shuts down the graphics driver and releases resources
    void shutdown();

    // Clears the framebuffer with a specified color
    void clear(uint32_t color);

    // Submits a batch of vertices to be drawn as triangles
    void drawTriangles(const std::vector<Vertex>& vertices);

    // Presents the rendered frame to the display
    void present();

    // Get the current framebuffer width
    uint32_t getFramebufferWidth() const { return m_framebufferWidth; }
    // Get the current framebuffer height
    uint32_t getFramebufferHeight() const { return m_framebufferHeight; }

private:
    // Internal state variables
    bool m_initialized;
    uint32_t m_framebufferWidth;
    uint32_t m_framebufferHeight;

    // A simple command buffer to queue rendering operations
    std::vector<GraphicsCommand> m_commandBuffer;
    std::vector<Vertex> m_vertexBuffer; // A temporary buffer for submitted vertices

    // Private helper methods
    void processCommandBuffer();
    void renderClear(const GraphicsCommand& cmd);
    void renderTriangles(const GraphicsCommand& cmd);
};

} // namespace GPU
} // namespace Hardware
} // namespace NudleOS

#endif // NUDLE_GRAPHICS_H