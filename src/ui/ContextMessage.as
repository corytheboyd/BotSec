package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;

	public class ContextMessage extends Entity 
	{
		protected var image:Image = new Image(GC.GFX_MINI_MESSAGE);
		protected var msg:Text = new Text('ACTION', 0, 0, 176, 24); //the text of the message
		
		public var isActive:Boolean = false; //true if the message is displayed
		
		public function ContextMessage( newMsg:String='ACTION' )
		{
			msg.text = newMsg;			
			msg.alpha = 0.0001;
			msg.size = 18;
			image.alpha = 0.0001;
			
			graphic = image;
			setHitbox(176, 48);	
		}
		
		public function changeMsg(newStr:String):void
		{
			msg.text = newStr;
		}
		
		override public function update():void 
		{
			show();
		}
		
		override public function added():void 
		{
			world.addGraphic(msg);
		}
		
		protected function show():void 
		{			
			//puts the message + text at bottom of screen, relative to camera
			x = FP.camera.x + FP.screen.width / 2 - width / 2;
			y = FP.camera.y + FP.screen.height - height;
			msg.x = FP.camera.x + FP.screen.width / 2 - msg.width / 2;
			msg.y = FP.camera.y + FP.screen.height - height + 15;
			
			if ( isActive )
			{				
				image.alpha += GC.MSG_FADE_RATE;
				msg.alpha += GC.MSG_FADE_RATE;
			}
			else
			{
				image.alpha -= GC.MSG_FADE_RATE;
				msg.alpha -= GC.MSG_FADE_RATE;
			}
		}
		
	}

}