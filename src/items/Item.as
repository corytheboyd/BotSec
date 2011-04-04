package items
{
	import flash.geom.Vector3D;
	import net.bloom.BloomWrapper;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;

	public class Item extends Entity 
	{
		public var image:Image = new Image(GC.GFX_ITEM_DEFAULT); //the texture to display if item in world
		public var respawns:Boolean = false; //true if the item respawns each time the tiles is loaded
		public var spawn:Boolean = true; //true if the item can spawn.
		public var animated:Boolean = true; //true if the item is animated on the world
		protected var startY:int; //the starting position
		
		public function Item( x:int=0, y:int=0 )
		{
			var imageFxWrapper:BloomWrapper = new BloomWrapper(image);
			graphic = imageFxWrapper;
			GV.ITEM_BLOOM_LIGHTING.register(graphic as BloomWrapper);
			
			this.x = x;
			this.y = startY = y;
			
			setHitbox(32, 32);
		}
		
		override public function update():void 
		{
			if( animated ) animate(); //idle animation of item
			
			if ( collide(GC.PLAYER_TYPE, x, y) ) 
			{
				FP.console.log('COLLECTED ITEM:', this);
				GV.INVENTORY.push(this);
				world.remove(this);
				
				if(!respawns)
				{
					for each(var item:Entity in GV.CURRENT_LEVEL.levelItems)
					{
						if ( item == this ) FP.console.log(item + ' removed from level!');
						spawn = false;
					}
				}
			}
		}
		
		protected function animate():void
		{			
			y = GC.ITEM_MOVE_HEIGHT * Math.cos(getTimer() / GC.ITEM_MOVE_RATE + Math.PI) - GC.ITEM_MOVE_HEIGHT + startY;
		}
	}

}