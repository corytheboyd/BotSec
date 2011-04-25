package doors 
{
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	/*
	 * Horizontal door, acts the same as Door but sideways!
	 * ...
	 * @author Cory Boyd
	 */
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
			type = GC.SOLID_TYPE;
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{
			if (locked && !open) 
			{
				image.play('locked');
			}
			else if(!locked && !open)
			{
				image.play('unlocked');
			}
			
			if ( collide(GC.PLAYER_TYPE, x, y) || collide(GC.PLAYER_TYPE, x, y - 35) || collide(GC.PLAYER_TYPE, x, y + 35) )
			{
				if ( !locked )
				{
					contextMessage.changeMsg('OPEN')
					contextMessage.isActive = open ? false : true;
					
					if ( Input.pressed('Action') )
					{
						type = GC.DOOR_TYPE; //make door uncollidable
						image.play('open');
						open = true;
					}
				}
				else
				{
					contextMessage.changeMsg('LOCKED')
					contextMessage.isActive = true;
				}
			}
			else
			{
				contextMessage.isActive = false;
				if ( open )
				{
					image.play('close');
				}
			}
		}
		
	}

}