package splash 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class NGSplash extends Entity
	{
		public var image:Image = new Image(GC.GFX_MAIN_MENU_NG_TANK);
		public var fadeIn:VarTween;
		public var fadeOut:VarTween;
		public var waitTimer:Timer; //how long to wait before fading out
		public var onComplete:Function; //called when the splash screen finishes
		
		public function NGSplash( onComplete:Function=null, waitDuration:Number=1 ) 
		{
			graphic = image;
			
			waitTimer = new Timer(waitDuration * 1000, 0); //converts duration from seconds to milliseconds
			waitTimer.addEventListener(TimerEvent.TIMER, fadeOutFn);
			
			this.onComplete = onComplete;
		}
		
		override public function added():void 
		{
			image.alpha = 0;
			x = FP.width / 2 - 127;
			y = FP.height / 2 - 118;
			
			fadeIn =  new VarTween(waitTimer.start);
			fadeOut = new VarTween(splashEnd);
			
			fadeIn.tween(image, 'alpha', 1, 2, Ease.cubeIn);			
			addTween(fadeIn, true);
		}
		
		/*
		 * Called when fade in completes
		 * */
		public function fadeInFn():void
		{
			waitTimer.start(); //start the wait timer, after which fadout is called
		}		
		
		/*
		 * Called when the wait timer finishes
		 * */
		public function fadeOutFn(e:TimerEvent):void
		{
			waitTimer.stop();
			
			fadeOut.tween(image, 'alpha', 0, 2, Ease.cubeOut);
			addTween(fadeOut, true);
		}
		
		/*
		 * Called when the splash is over
		 * */
		public function splashEnd():void
		{			
			if (onComplete != null) onComplete(); //call the callback function if provided
		}
	}

}