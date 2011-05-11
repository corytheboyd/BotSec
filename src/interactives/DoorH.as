package interactives 
{
	import net.flashpunk.masks.Hitbox;
	import ui.*;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	/*
	 * Horizontal door, acts the same as Door but sideways!
	 * ...
	 * @author Cory Boyd
	 */
	public class DoorH extends Door 
	{
		
		public function DoorH( x:int, y:int, id:String, locked:Boolean=false ) 
		{
			super(x, y, id, locked);
			
			image = new Spritemap(GC.GFX_DOORH_TILESET, 96, 32);
			
			image.add('locked', [0], 0, true);
			image.add('unlocked', [1], 0, true);
			image.add('open', [2, 3, 4, 5], GC.DOOR_OPEN_SPEED, false);
			image.add('close', [5, 4, 3, 2, 1], GC.DOOR_OPEN_SPEED, false);
			
			hitboxTrigger = new Hitbox(96, 128, 0, -48);
			hitbox = new Hitbox(96, 32, 0, 0);			
			
			graphic = image;
			type = GC.SOLID_TYPE;
			
			mask = hitbox; 
		}
		
		/*
		 * On signal sent from a switch
		 * */
		override public function sendSignalOn():void 
		{
			locked = false;
		}
		
		/*
		 * On signal sent from a switch
		 * */
		override public function sendSignalOff():void 
		{
			locked = true;
		}
		
	}

}