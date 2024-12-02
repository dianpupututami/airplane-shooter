import os
from PIL import Image

def reduce_image_resolution(image_path, new_width, new_height):
    """Reduces the resolution of an image to the specified width and height."""
    with Image.open(image_path) as img:
        img = img.resize((new_width, new_height), Image.ANTIALIAS)
        img.save(image_path)

def process_images_in_directory(directory, max_width, max_height, reduction_percentage):
    """Processes images in a directory and its subdirectories."""
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.lower().endswith(('.jpg', '.jpeg', '.png')):
                image_path = os.path.join(root, file)
                with Image.open(image_path) as img:
                    width, height = img.size
                    if width > max_width or height > max_height:
                        new_width = int(width * (1 - reduction_percentage / 100))
                        new_height = int(height * (1 - reduction_percentage / 100))
                        reduce_image_resolution(image_path, new_width, new_height)

# Example usage
directory_path = "./"  # Replace with the actual directory path
max_width = 256
max_height = 256
reduction_percentage = 20

process_images_in_directory(directory_path, max_width, max_height, reduction_percentage)