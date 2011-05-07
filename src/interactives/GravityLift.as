package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class GravityLift extends Entity 
	{
		public var image:Image = new Image(GC.GFX_GRAVLIFT);
		public var speed:int; //speed in px/s that the lift moves the player at
		public var hitbox:Hitbox = new Hitbox(96, 32);
		
		public function GravityLift( x:Number, y:Number, speed:int ) 
		{
			mask = hitbox;
			type = GC.GRAVLIFT_TYPE;
			graphic = image;
			
			this.x = x;
			this.y = y;
			
			this.speed = speed;
		}
		
		override public function update():void 
		{
			var e:Player;
			if ( (e = collide(GC.PLAYER_TYPE, x, y) as Player) )
			{
				if ( !e.isOnGround && e.velocity.y < 0 ) //then move that playa UP, DAWG
				{
					e.velocity.y -= speed;
				}
			}
		}
		
	}

}