/*
 * Displays a popup message with the provided text.
 * */
package ui 
{
	import flash.display.MovieClip;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Message extends Entity 
	{
		public var image:Image = new Image(GC.GFX_MESSAGE); //the background image of the message
		public var msg:Text = new Text('none', 0, 0, 500, 36); //the text of the message
		
		public var timeElapsed:Number = 0; //keeps track of how long it has existed
		public var duration:Number = 0;
		
		public var showSound:Sfx = new Sfx(GC.SFX_MESSAGE_SHOW);
		
		public function Message( msgText:String, duration:Number ) 
		{
			msg.alpha = 0.0001;
			image.alpha = 0.0001;
			graphic = image;
			this.duration = duration;			
			setHitbox(560, 48);
			layer = 0;
			
			msg.text = msgText; //adds the text to message
			msg.size = 24;
		}
		
		override public function added():void 
		{
			world.addGraphic(msg);
			showSound.play();
		}
		
		override public function update():void 
		{
			//puts the message + text at top of screen, relative to camera
			x = FP.camera.x + FP.screen.width / 2 - width / 2;
			y = FP.camera.y;
			msg.x = FP.camera.x + FP.screen.width / 2 - msg.width / 2;
			msg.y = FP.camera.y + 10;
			
			//updates timer
			timeElapsed += FP.elapsed;
			
			if (timeElapsed < duration)
			{
				image.alpha += GC.MSG_FADE_RATE;
				msg.alpha += GC.MSG_FADE_RATE;
			}
			else 
			{
				image.alpha -= GC.MSG_FADE_RATE;
				msg.alpha -= GC.MSG_FADE_RATE;
			}
			
			if (image.alpha <= 0)
			{
				world.remove(this);
			}
			
			super.update();
		}
		
	}

}