package items
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import flash.utils.getTimer;
	import ui.*;

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Item extends Entity 
	{
		public var image:Image = new Image(GC.GFX_ITEM_DEFAULT); //the texture to display if item in world
		public var respawns:Boolean = false; //true if the item respawns each time the tiles is loaded
		public var spawn:Boolean = true; //true if the item can spawn.
		public var animated:Boolean = true; //true if the item is animated on the world
		protected var startY:int; //the starting position
		protected var animOffset:Number = Math.random() * 3; //offsets the animation so that all animated things are a little different
		
		public function Item( x:int, y:int )
		{
			graphic = image;
			type = GC.ITEM_TYPE;
			
			this.x = x;
			this.y = startY = y;
			
			setHitbox(32, 32);
		}
		
		override public function added():void 
		{
			layer = 1;
		}
		
		override public function update():void 
		{
			if ( animated ) animate(); //idle animation of item
			
			if ( collide(GC.PLAYER_TYPE, x, y) ) 
			{
				world.add( new Message(this + ' GET!', GC.MSG_DURATION) );
				
				GV.INVENTORY.push(this); //add to players inventory
				world.remove(this);
				
				if(!respawns)
				{
					for each(var item:Entity in GV.CURRENT_LEVEL.levelItems)
					{
						spawn = false;
					}
				}
			}
		}
		
		public function animate():void
		{			
			y = GC.ITEM_MOVE_HEIGHT * Math.cos( getTimer() / GC.ITEM_MOVE_RATE + Math.PI + animOffset ) - GC.ITEM_MOVE_HEIGHT + startY;
		}
	}

}