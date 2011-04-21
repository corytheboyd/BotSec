package doors 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;

	public class Door extends Entity 
	{
		public var locked:Boolean = true;
		public var open:Boolean = false;
		public var image:Spritemap = new Spritemap(GC.GFX_DOOR_TILESET, 32, 96);
		
		public function Door(x:int=0, y:int=0) 
		{
			//add animations
			image.add('locked', [0], 0, true);
			image.add('unlocked', [1], 0, true);
			image.add('open', [2, 3, 4, 5], GC.DOOR_OPEN_SPEED, false);
			image.add('close', [5, 4, 3, 2, 1], GC.DOOR_OPEN_SPEED, false);
			
			graphic = image;
			setHitbox(32, 96);
			type = GC.LEVEL_TYPE;
			
			this.x = x;
			this.y = y;
		}
		
		override public function update():void 
		{			
			if (locked && !open && image.currentAnim != 'open') 
			{				
				image.play('locked');
			}
			else if(!locked && !open && image.currentAnim != 'close')
			{
				image.play('unlocked');
			}
			
			if ( collide(GC.PLAYER_TYPE, x, y) || collide(GC.PLAYER_TYPE, x - 35, y) || collide(GC.PLAYER_TYPE, x + 35, y) )
			{				
				if ( !locked ) //door is unlocked
				{
					GV.CONTEXT_MESSAGE.changeMsg('OPEN');
					GV.CONTEXT_MESSAGE.isActive = open ? false : true;
					
					if ( Input.pressed('Action') )
					{
						type = GC.DOOR_TYPE; //make door uncollidable
						image.play('open');
						open = true;
					}
				}
			}
			else
			{
				GV.CONTEXT_MESSAGE.isActive = false;
				
				if ( open )
				{
					type = GC.LEVEL_TYPE;
					image.play('close');
					open = false;
				}				
			}
		}
		
	}

}