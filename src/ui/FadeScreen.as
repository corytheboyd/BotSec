package ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class FadeScreen extends Entity 
	{
		public var image:Image = new Image(GC.GFX_BLACKSCREEN);
		public var fadeInTween:VarTween = new VarTween;
		public var fadeOutTween:VarTween = new VarTween;
		
		public function FadeScreen() 
		{
			image.alpha = 1;			
			graphic = image;
			
			x = FP.camera.x;
			y = FP.camera.y;
			
			fadeInTween.tween(image, 'alpha', 0, 0.40, Ease.cubeIn);
			fadeOutTween.tween(image, 'alpha', 1, 0.40, Ease.cubeOut);
			
			addTween(fadeInTween);
			addTween(fadeOutTween);
		}
		
		override public function update():void 
		{
			x = FP.camera.x;
			y = FP.camera.y;
		}
		
		public function fadeIn(callback:Function=null):void
		{
			if (callback) fadeInTween.complete = callback;
			fadeInTween.start();
		}
		
		public function fadeOut(callback:Function=null):void
		{
			if (callback) fadeOutTween.complete = callback;
			fadeOutTween.start();
		}
		
	}

}