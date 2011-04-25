package buttons 
{
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import worlds.GameWorld;

	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class StartButton extends Button 
	{
		protected var imageNormal:Image = new Image(GC.GFX_START_NORMAL);
		
		public function StartButton(x:Number=0, y:Number=0) 
		{
			normal = imageNormal;
			var width:int = 116;
			var height:int = 35;
			
			super(x, y, width, height, startGame);
		}
		
		protected function startGame():void
		{
			FP.world = new GameWorld;
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}