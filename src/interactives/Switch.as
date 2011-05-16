package interactives 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import ui.ContextMessage;
	import ui.Message;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Switch extends Entity 
	{
		public var image:Spritemap = new Spritemap(GC.GFX_SWITCH, 16, 32);
		public var hitbox:Hitbox = new Hitbox(80, 32, -38, 0);
		public var flipped:Boolean; //true if this is a flipped switch
		public var isOn:Boolean; //the initial state of the switch, default locked (false)
		public var contextMessage:ContextMessage = new ContextMessage('SWITCH'); //context message
		
		public var useOnce:Boolean; //true if the switch can only be thrown once
		public var used:Boolean = false; //true if the switch has been used
		
		public var targetIndexes:Array = []; //index of the target object in the Level.levelInteractives array	
		
		/*
		 * Create switch
		 * Must provide (x,y) position and target Interactive object 
		 * */
		public function Switch( x:Number, y:Number, useOnce:Boolean, isOn:Boolean=false, flipped:Boolean=false ) 
		{
			image.add('on', [1], 0, false);
			image.add('off', [0], 0, false);
			
			this.x = x;
			this.y = y;
			this.isOn = isOn;
			this.useOnce = useOnce;
			
			image.play( isOn ? 'on' : 'off' );
			
			image.flipped = flipped;
			
			mask = hitbox;
			graphic = image;
			type = GC.SWITCH_TYPE;
		}
		
		override public function update():void 
		{
			if ( collide(GC.PLAYER_TYPE, x, y) )
			{
				if ( (useOnce && !used) || !useOnce )
				{
					if ( !isOn ) 
					{
						contextMessage.changeMsg('SWITCH ON');
					}
					else 
					{
						contextMessage.changeMsg('SWITCH OFF');
					}
					contextMessage.isActive = true;
				}
				else contextMessage.isActive = false;
				
				if ( Input.pressed('Action') && ( (useOnce && !used) || !useOnce ) )
				{
					if ( isOn ) //switch off
					{
						image.play('off');
						for each ( var i:int in targetIndexes )
						{							
							GV.CURRENT_LEVEL.levelInteractives[i].sendSignalOff();
							world.add( new Message('Disabled ' + GV.CURRENT_LEVEL.levelInteractives[i], GC.MSG_DURATION) );
						}
					}
					else //switch on
					{
						image.play('on');
						for each ( i in targetIndexes )
						{							
							GV.CURRENT_LEVEL.levelInteractives[i].sendSignalOn();
							world.add( new Message('Enabled ' + GV.CURRENT_LEVEL.levelInteractives[i], GC.MSG_DURATION) );
						}
					}							
					isOn = !isOn;
					used = true;
				}
			}
			
			else //no longer touching, turn of context message
			{
				contextMessage.isActive = false;
			}
		}
		
	}

}