package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import ui.ContextMessage;
	import ui.Message;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class SaveBeacon extends Entity 
	{
		protected var image:Spritemap = new Spritemap(GC.GFX_SAVE, 32, 64);
		protected var isActive:Boolean = false;
		
		public var initialSpawn:Boolean = false; //true if this is the games first spawn point
		public var contextMessage:ContextMessage = new ContextMessage('SAVE');
		
		public function SaveBeacon( x:Number=0, y:Number=0 ) 
		{
			image.add('off', [0], 0, false);
			image.add('on', [1], 0, false);
			
			graphic = image;
			setHitbox(32, 64);
			
			this.x = x;
			this.y = y;
		}
		
		override public function added():void 
		{
			if ( initialSpawn && GV.CURRENT_SAVE_ROOM == '' )
			{
				GV.CURRENT_SAVE_ROOM = GV.CURRENT_LEVEL.levelName;
				image.play('on');
				isActive = true;
			}
			
			else if ( GV.CURRENT_LEVEL.levelName == GV.CURRENT_SAVE_ROOM )
			{
				image.play('on');
				isActive = true;
			}
			else image.play('off');
		}
		
		override public function update():void 
		{
			if ( collide(GC.PLAYER_TYPE, x, y) && !isActive )
			{	
				contextMessage.isActive = true;
				
				if ( Input.pressed('Action') )
				{
					world.add( new Message('Game Saved!', GC.MSG_DURATION) );
					
					image.play('on');
					GV.CURRENT_SAVE_ROOM = GV.CURRENT_LEVEL.levelName;
					isActive = true;
				}
			}
			else
			{
				contextMessage.isActive = false;
			}
		}
		
	}

}