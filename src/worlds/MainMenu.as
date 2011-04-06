package worlds 
{
	import buttons.StartButton;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	public class MainMenu extends World 
	{
		protected var startButton:StartButton;
		//protected var instructionsButton;
		
		public function MainMenu() 
		{
			//FP.console.enable();
			
			startButton = new StartButton(FP.screen.width / 2 - 116 / 2, 250);
			startButton.layer = 0;
			
			add(startButton);
			addGraphic( new Image(GC.GFX_MAIN_MENU_BG), 1 ); //background
			addGraphic( new Image(GC.GFX_TITLE), 0, FP.screen.width / 2 - 771 / 2, 10 );
		}
		
		override public function end():void 
		{
			removeAll(); //remove everything before switching to new world
			super.end();
		}
		
	}

}