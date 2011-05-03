#!/usr/bin/env python2.7
"""
This script generates a grid of blank ogmo levels.
"""

LEVEL_TEMPLATE = """<level tile_name="{name}" zone="" tile_left="{left}" tile_right="{right}" tile_up="{up}" tile_down="{down}">
  <width>{width}</width>
  <height>{height}</height>
</level>"""

alpha = 'abcdefghijklmnopqrstuvwxyz'
num = range(20)

LEVEL_WIDTH = 1200
LEVEL_HEIGHT = 960

for alpha_i in range( len(alpha) ):    
    for num_i in num:
        #get up tile alpha
        if alpha_i > 0 :
            up_alpha = alpha[alpha_i - 1]
        else:
            up_alpha = 'null'
        #get down tile alpha   
        if alpha_i < len(alpha) - 1 :
            down_alpha = alpha[alpha_i + 1]
        else:
            down_alpha = 'null'
        #get left tile num
        if num_i > 0:
            left_num = num[num_i - 1]
        else:
            left_num = 'null'
        #get right tile num
        if num_i < len(num) - 1:
            right_num = num[num_i + 1]
        else:
            right_num = 'null'

        #Assign values for tiles
        current_tile = alpha[alpha_i] + str(num[num_i])
                
        if(up_alpha != 'null'):
            up_tile = up_alpha + str(num[num_i])
        else:
            up_tile = 'null'
            
        if(down_alpha != 'null'):
            down_tile = down_alpha + str(num[num_i])
        else:
            down_tile = 'null'

        if(left_num != 'null'):
            left_tile = alpha[alpha_i] + str(left_num)
        else:
            left_tile = 'null'

        if(right_num != 'null'):
            right_tile = alpha[alpha_i] + str(right_num)
        else:
            right_tile = 'null'
        
        #print( LEVEL_TEMPLATE.format(name=current_tile, left=left_tile, right=right_tile, up=up_tile, down=down_tile, height=LEVEL_HEIGHT, width=LEVEL_WIDTH) )
        f = open('./' + current_tile + '.oel', 'w')
        f.write(LEVEL_TEMPLATE.format(name=current_tile, left=left_tile, right=right_tile, up=up_tile, down=down_tile, height=LEVEL_HEIGHT, width=LEVEL_WIDTH))
        f.close()
