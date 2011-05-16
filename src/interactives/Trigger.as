package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.masks.Hitbox;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Trigger extends Entity 
	{
		public var hitbox:Hitbox;
		public var fireOnce:Boolean;		
		public var targetIndexes:Array = []; //index of the target object in the Level.levelInteractives array
		
		protected var isActive:Boolean = false; //true if player standing in it.
		
		public function Trigger( x:Number, y:Number, h:Number, w:Number, fireOnce:Boolean )
		{
			graphic = null;
			type = GC.TRIGGER_TYPE;
			mask = hitbox = new Hitbox(w, h);
			
			this.x = x;
			this.y = y;
			this.fireOnce = fireOnce;
		}
		
		override public function update():void 
		{
			if ( collide(GC.PLAYER_TYPE, x, y) )
			{
				if ( !isActive )
				{
					isActive = true;
					
					for each ( var i:int in targetIndexes )
					{
						GV.CURRENT_LEVEL.levelInteractives[i].sendSignalOn();
					}
				}
			}
			else if ( !fireOnce && isActive ) 
			{
				isActive = false;
				
				for each ( i in targetIndexes )
				{
					GV.CURRENT_LEVEL.levelInteractives[i].sendSignalOff();
				}
			}
		}
		
	}

}