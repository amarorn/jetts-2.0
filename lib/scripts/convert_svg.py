import cairosvg
import os

def convert_svg_to_png():
    # Criar diretório se não existir
    os.makedirs('assets/images', exist_ok=True)
    
    # Converter SVG para PNG
    cairosvg.svg2png(
        url='assets/images/app_icon.svg',
        write_to='assets/images/app_icon.png',
        output_width=1024,
        output_height=1024
    )

if __name__ == '__main__':
    convert_svg_to_png() 