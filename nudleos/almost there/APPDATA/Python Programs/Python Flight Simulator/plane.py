import pygame
GRAVITY = 0.1
import math
pygame.init()
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))
pygame.display.set_caption("Python Flight Simulator")
WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
BLUE = (0, 0, 255)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
plane_x = SCREEN_WIDTH // 2
plane_y = SCREEN_HEIGHT // 2
plane_speed = 5
plane_angle = 0
running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT]:
        plane_angle += 5
    if keys[pygame.K_RIGHT]:
        plane_angle -= 5
    if keys[pygame.K_UP]:
        plane_x += plane_speed * math.cos(math.radians(plane_angle))
        plane_y -= plane_speed * math.sin(math.radians(plane_angle))
    if keys[pygame.K_DOWN]:
        plane_x -= plane_speed * math.cos(math.radians(plane_angle))
        plane_y += plane_speed * math.sin(math.radians(plane_angle))
    plane_x = max(0, min(plane_x, SCREEN_WIDTH))
    plane_y = max(0, min(plane_y, SCREEN_HEIGHT))
    screen.fill(BLACK)
    nose_x = plane_x + 20 * math.cos(math.radians(plane_angle))
    nose_y = plane_y - 20 * math.sin(math.radians(plane_angle))
    wing1_x = plane_x - 15 * math.cos(math.radians(plane_angle + 90))
    wing1_y = plane_y + 15 * math.sin(math.radians(plane_angle + 90))
    wing2_x = plane_x - 15 * math.cos(math.radians(plane_angle - 90))
    wing2_y = plane_y + 15 * math.sin(math.radians(plane_angle - 90))
    pygame.draw.polygon(screen, RED, [(nose_x, nose_y), (wing1_x, wing1_y), (wing2_x, wing2_y)])
    pygame.display.flip()
pygame.quit()
