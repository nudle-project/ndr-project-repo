import pygame
import os
class SpriteLoader:
    def __init__(self):
        self._cache = {}
    def load_image(self, path, colorkey=None, scale=None):
        if path in self._cache:
            return self._cache[path]
        if not os.path.exists(path):
            raise FileNotFoundError(f"File not found: {path}")
        try:
            image = pygame.image.load(path).convert_alpha()
        except pygame.error as e:
            raise RuntimeError(f"Failed to load image {path}: {e}")
        if colorkey is not None:
            if colorkey == -1:
                colorkey = image.get_at((0, 0))
            image.set_colorkey(colorkey)
        if scale:
            image = pygame.transform.scale(image, scale)
        self._cache[path] = image
        return image
    def loadsprite(self, path, frame_width, frame_height, colorkey=None, scale=None):
        sheet = self.load_image(path, colorkey)
        sheet_width, sheet_height = sheet.get_size()
        frames = []
        for y in range(0, sheet_height, frame_height):
            for x in range(0, sheet_width, frame_width):
                frame = sheet.subsurface((x, y, frame_width, frame_height)).copy()
                if scale:
                    frame = pygame.transform.scale(frame, scale)
                frames.append(frame)
        return frames