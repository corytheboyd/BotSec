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
		public var image:Spritemap = new Spritemap(GC.GFX_SAVE, 32, 64);
		public var isActive:Boolean = false;
		
		public var initialSpawn:Boolean = false; //true if this is the games first spawn point
		public var contextMessage:ContextMessage = new ContextMessage('SAVE');
		
		public function SaveBeacon( x:Number, y:Number, isActive:Boolean ) 
		{
			image.add('off', [0], 0, false);
			image.add('on', [1], 0, false);
			
			graphic = image;
			setHitbox(32, 64);
			
			this.x = x;
			this.y = y;
			this.isActive = isActive;
		}
		
		override public function added():void 
		{
			trace('BEACON ADDED. ISACTIVE?', isActive, 'CURRENT SAVE ROOM:', GV.CURRENT_SAVE_ROOM, 'IS ROOM CACHED?', GV.CURRENT_LEVEL.cached);
			
			if ( initialSpawn && GV.CURRENT_SAVE_ROOM == '' && !GV.CURRENT_LEVEL.cached )
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
			else 
			{
				trace('NOT THE CURRENT SAVE, DEACTIVIATING THIS ROOMS SAVE BEACON');
				
				image.play('off');
				isActive = false;
			}
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