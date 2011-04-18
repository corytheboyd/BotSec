package 
{
	import flash.ui.Mouse;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import worlds.GameWorld;
	import splash.Splash;
	import worlds.MainMenu;
	
	public class Main extends Engine
	{		
		public function Main()
		{
			super(960, 480, 60);
			//Mouse.hide();
			
			FP.world = new GameWorld;
			//FP.world = new MainMenu;
			
			/*
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start( new GameWorld );
			*/	
		}
	}

}