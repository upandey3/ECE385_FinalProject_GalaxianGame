from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
#import glob, os
#import re
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)

#for name in glob.glob('sprite_originals/*'):
#    filename = name
#    filename = re.sub('sprite_originals/', '', filename)
#    filename = re.sub('.png', '', filename)       
#    print ("%s" %filename)


filename = raw_input("What's the image name? ")
#    new_w = 16
#    new_h = 16
new_w, new_h = map(int, raw_input("What's the new height x width? Like 28 28. ").split(' '))
palette_hex = ['0x000000', '0x0D35DA', '0x116BDB', '0x2BFBDE', '0x1EB9DC', '0xDEDEDE', '0xFC291C', '0x2AF72D', '0xFC44DC', '0xFDB72B', '0xDB4819', '0xFEF937', '0x963ADB', '0x169696']
palette_rgb = [hex_to_rgb(color) for color in palette_hex]


pixel_tree = KDTree(palette_rgb)
im = Image.open("./sprite_originals/" + filename+ ".png") #Can be many different formats.
im = im.convert("RGBA")
layer = Image.new('RGBA',(new_w, new_h), (0,0,0,0))
layer.paste(im, (0, 0))
im = layer
#im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize
pix = im.load()
pix_freqs = Counter([pix[x, y] for x in range(im.size[0]) for y in range(im.size[1])])
pix_freqs_sorted = sorted(pix_freqs.items(), key=lambda x: x[1])
pix_freqs_sorted.reverse()
print(pix)
outImg = Image.new('RGB', im.size, color='white')
outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
i = 0
m = 0
outFile.write("%s <= \n" %filename)
outFile.write("'{ \n")
for y in range(im.size[1]):
    for x in range(im.size[0]):
        pixel = im.getpixel((x,y))
        print(pixel)
        
        if(pixel[3] < 200):
            outImg.putpixel((x,y), palette_rgb[0])
            outFile.write("%x\n" %(0))
            print(i)
        else:
            index = pixel_tree.query(pixel[:3])[1]
            outImg.putpixel((x,y), palette_rgb[index])
            if m == 0:
                outFile.write("'{ ")   
            outFile.write("%x" %(index))
            if m == new_w - 1:  # 223: if m == 15:
                if i == (new_h * new_w) - 1: #if i == 255 :
                    outFile.write(" } \n")
                else :  
                    outFile.write(" }, \n")

            else :
                outFile.write(", ")
        m = (m+1) % new_w           
        #m = (m+1) % 224
        #m = (m + 1) % 16
        i += 1
outFile.write("};")
outFile.close()
outImg.save("./sprite_converted/" + filename + ".png" )


