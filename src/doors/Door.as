package doors 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;

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
			image.add('open', [2, 3, 4, 5], 20, false);
			image.add('close', [5, 4, 3, 2, 1], 20, false);
			
			graphic = image;
			setHitbox(32, 64);
			
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
			
			if ( collide(GC.PLAYER_TYPE, x, y) )
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