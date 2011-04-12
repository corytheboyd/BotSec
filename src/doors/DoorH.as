package doors 
{
	import net.flashpunk.graphics.Spritemap;
	
	/*
	 * Horizontal door, acts the same as Door but sideways!
	 * */
	public class DoorH extends Door 
	{		
		public function DoorH(x:int=0, y:int=0) 
		{
			image = new Spritemap(GC.GFX_DOORH_TILESET, 96, 32);
			image.add('locked', [0], 0, true);
			image.add('unlocked', [1], 0, true);
			image.add('open', [2, 3, 4, 5], GC.DOOR_OPEN_SPEED, false);
			image.add('close', [5, 4, 3, 2, 1], GC.DOOR_OPEN_SPEED, false);
			
			graphic = image;
			setHitbox(96, 32);
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			if (locked && !open) 
			{
				type = GC.LEVEL_TYPE;
				image.play('locked');
			}
			else if(!locked && !open)
			{
				type = GC.DOOR_TYPE;
				image.play('unlocked');
			}
			
			if ( collide(GC.PLAYER_TYPE, x, y + 45) || collide(GC.PLAYER_TYPE, x, y -45) )
			{
				if ( !locked )
				{
					image.play('open');
					open = true;
				}
			}
			else if ( open )
			{
				image.play('close');
			}
		}
		
	}

}