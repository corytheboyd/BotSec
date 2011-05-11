package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import ui.ContextMessage;

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Door extends Interactive 
	{
		public var locked:Boolean = true;
		public var open:Boolean = false;
		public var image:Spritemap = new Spritemap(GC.GFX_DOOR_TILESET, 32, 96);
		public var contextMessage:ContextMessage = new ContextMessage('DOOR');
		public var hitbox:Hitbox = new Hitbox(32, 96, 0, 0);
		public var hitboxTrigger:Hitbox = new Hitbox(128, 96, -48, 0);
		
		public function Door( x:int, y:int, id:String, locked:Boolean=false ) 
		{
			//add animations
			image.add('locked', [0], 0, true);
			image.add('unlocked', [1], 0, true);
			image.add('open', [2, 3, 4, 5], GC.DOOR_OPEN_SPEED, false);
			image.add('close', [5, 4, 3, 2, 1], GC.DOOR_OPEN_SPEED, false);
			
			graphic = image;
			type = GC.SOLID_TYPE;
			
			this.x = x;
			this.y = y;	
			this.id = id;
			this.locked = isOn = locked;
			
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
			
			mask = hitboxTrigger;
			if ( collide(GC.PLAYER_TYPE, x, y) )
			{				
				if ( !locked ) //door is unlocked
				{
					contextMessage.changeMsg('OPEN')
					contextMessage.isActive = open ? false : true;
					
					type = GC.DOOR_TYPE; //make door uncollidable
					image.play('open');
					open = true;
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
					try 
					{
						type = GC.SOLID_TYPE;
					} catch (err:Error) { trace('Weird door shit\n\t' + err); }
					
					image.play('close');
					open = false;
				}				
			}
			mask = hitbox;
		}
		
	}

}