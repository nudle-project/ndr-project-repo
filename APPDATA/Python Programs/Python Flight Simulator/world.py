#A script that creates a world ONLY so that i can use the model in the game.
import pygame
import math

# Initialize Pygame
pygame.init()

# Screen dimensions
screen_width = 800
screen_height = 600
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Flight Simulator World")

# Colors
white = (255, 255, 255)
black = (0, 0, 0)
blue = (0, 0, 255)
green = (0, 255, 0)
red = (255, 0, 0)

# Ground properties
ground_height = 100
ground_color = green

# Sky properties
sky_color = blue

# Sun properties
sun_radius = 50
sun_color = (255, 255, 0) # Yellow
sun_x = screen_width - 100
sun_y = 100

# Clouds properties
cloud_color = white
cloud_radius = 30
num_clouds = 5
clouds = []

# Function to create clouds
def create_clouds():
    for _ in range(num_clouds):
        x = random.randint(50, screen_width - 50)
        y = random.randint(50, screen_height // 3)
        clouds.append((x, y))

# Function to draw the ground
def draw_ground():
    pygame.draw.rect(screen, ground_color, (0, screen_height - ground_height, screen_width, ground_height))

# Function to draw the sky
def draw_sky():
    screen.fill(sky_color)

# Function to draw the sun
def draw_sun():
    pygame.draw.circle(screen, sun_color, (sun_x, sun_y), sun_radius)

# Function to draw clouds
def draw_clouds():
    for x, y in clouds:
        pygame.draw.circle(screen, cloud_color, (x, y), cloud_radius)
        pygame.draw.circle(screen, cloud_color, (x + cloud_radius // 2, y - cloud_radius // 4), cloud_radius * 0.8)
        pygame.draw.circle(screen, cloud_color, (x - cloud_radius // 2, y - cloud_radius // 4), cloud_radius * 0.8)

# Main game loop
running = True
clock = pygame.time.Clock()

create_clouds()

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Drawing
    draw_sky()
    draw_sun()
    draw_clouds()
    draw_ground()

    # Update the display
    pygame.display.flip()

    # Cap the frame rate
    clock.tick(60)

pygame.quit()
