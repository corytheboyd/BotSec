package worlds 
{
	import adobe.utils.CustomActions;
	import buttons.StartButton;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import splash.NGSplash;
	import splash.Splash;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class MainMenu extends World 
	{
		public var isActive:Boolean = false; //true if the game can be started by input
		public var bg:Image = new Image(GC.GFX_MAIN_MENU_BG);
		public var startPrompt:Image = new Image(GC.GFX_MAIN_MENU_START_PROMPT);
		public var title:Image = new Image(GC.GFX_MAIN_MENU_TITLE);
		public var titleTimer:Timer = new Timer(500, 0); //how long to wait after the bg fades in to show title
		public var startPromptTimer:Timer = new Timer(1250, 0); //how long to wait after the bg fades in to show start prompt
		
		public var musicTrack:Sfx = new Sfx(GC.SFX_TITLE_TRACK);
		
		public function MainMenu()
		{
			musicTrack.loop(); //play the bg music
			
			var s:Splash = new Splash;
			s.layer = 3;
			add(s);
			s.start( NG ); //after, play the Newgrounds splash
		}
		
		override public function end():void 
		{
			removeAll(); //remove everything before switching to new world
			super.end();
		}
		
		override public function update():void 
		{
			if ( isActive && Input.check(Key.X) && Input.check(Key.Z) )
			{				
				var black:Image = new Image(GC.GFX_BLACKSCREEN);
				black.alpha = 0;
				
				addGraphic(black, -1);
				
				var a:VarTween = new VarTween(gotoGameWorld);
				a.tween(black, 'alpha', 1, 1.5, Ease.quadOut);
				addTween(a, true);
				
				var s:SfxFader = new SfxFader(musicTrack);
				s.fadeTo(0, 1.25, Ease.quadOut);
				addTween(s, true);
				
				isActive = false;
			}
			
			super.update();
		}
		
		public function gotoGameWorld():void
		{
			removeAll();
			FP.world = new GameWorld;
		}
		
		public function NG():void
		{
			var a:NGSplash = new NGSplash(initMenu);
			add(a);
		}
		
		public function initMenu():void
		{				
			//to make everything fade in. super cool
			bg.alpha = 0;
			title.alpha = 0;
			startPrompt.alpha = 0;
			
			addGraphic(bg, 2);
			addGraphic(title, 1, FP.width / 2 - 316, 25);
			addGraphic(startPrompt, 1, FP.width / 2 - 264, FP.height - 200);
			
			var bgFadeIn:VarTween = new VarTween(titleFadeIn);
			bgFadeIn.tween(bg, 'alpha', 1, 1, Ease.quadIn);
			addTween(bgFadeIn, true);
		}
		
		public function titleFadeIn():void
		{			
			titleTimer.addEventListener(TimerEvent.TIMER, showTitle);
			titleTimer.start();
			
			startPromptTimer.addEventListener(TimerEvent.TIMER, showStartPrompt);
			startPromptTimer.start();
		}
		
		public function showTitle(e:TimerEvent):void
		{
			titleTimer.stop();
			titleTimer.removeEventListener(TimerEvent.TIMER, showTitle);
			
			var a:VarTween = new VarTween;
			a.tween(title, 'alpha', 1, 1, Ease.quadIn);
			addTween(a, true);
		}
		
		public function showStartPrompt(e:TimerEvent):void
		{
			startPromptTimer.stop();
			startPromptTimer.removeEventListener(TimerEvent.TIMER, showStartPrompt);
			
			var a:VarTween = new VarTween(initUpdate);
			a.tween(startPrompt, 'alpha', 1, 1, Ease.quadIn);
			addTween(a, true);
		}
		
		/*
		 * Called when the game is ready for user to start it
		 * */
		public function initUpdate():void
		{
			isActive = true;
		}
		
	}

}