#!/usr/bin/env python2.7
"""
This script generates an actionscrip file with embeds for all of the levels.
"""
AS_FILE_TEMPLATE="""package
{{
    public class MAP
    {{
        {code}
    }}
}}"""

EMBED_TEMPLATE="""        [Embed(source = '../map/{tile}.oel', mimeType = 'application/octet-stream')]
        public static const {tile}:Class;"""

alpha = 'abcdefghijklmnopqrstuvwxyz'
num = range(20)
embeds = ""

for alpha_i in range( len(alpha) ):    
    for num_i in num:

        current_tile = alpha[alpha_i] + str(num[num_i])
        embeds += EMBED_TEMPLATE.format(tile = current_tile) + "\n"

f = open('MAP.as', 'w')
f.write(AS_FILE_TEMPLATE.format(code=embeds))
f.close()
