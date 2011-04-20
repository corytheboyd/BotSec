package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;

	public class ContextMessage extends Entity 
	{
		protected var image:Image = new Image(GC.GFX_MINI_MESSAGE);
		protected var msg:Text = new Text('none', 0, 0, 176, 24); //the text of the message
		
		public var isActive:Boolean = false; //true if the message is displayed
		
		public function ContextMessage()
		{
			msg.alpha = 0.0001;
			image.alpha = 0.0001;
			graphic = image;
			setHitbox(176, 48);
			layer = 0;
			
			msg.size = 18;
		}
		
		/*
		 * Change the message text
		 * */
		public function changeMsg( newMsg:String ):void
		{
			msg.text = newMsg;
		}
		
		override public function added():void 
		{
			world.addGraphic(msg);
		}
		
		override public function update():void 
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
			
			super.update();
		}
		
	}

}