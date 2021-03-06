package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.Font;
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	import flash.text.TextField;
	import net.flashpunk.*
	
	[SWF(width = "960", height = "480")]
	
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Preloader extends MovieClip 
	{
		//[Embed(source = 'data/loading.png')] static public var imgLoading:Class;
		
		public var loading:Bitmap = new GC.GFX_BLACKSCREEN;
		
		public var square:Sprite = new Sprite();
		public var border:Sprite = new Sprite();
		public var wd:Number = (loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * 240;
		public var text:TextField = new TextField();
		
		public function Preloader() 
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			// show loader
			addChild(square);
			square.x = 200;
			square.y = stage.stageHeight / 2;
			
			addChild(border);
			border.x = 200-4;
			border.y = stage.stageHeight / 2 - 4;
		
			addChild(text);
			text.x = 194;
			text.y = stage.stageHeight / 2 - 30;
			
			addChild(loading);
			loading.x = 0;
			loading.y = 48;
			
		}
		
		public function progress(e:ProgressEvent):void 
		{
			// update loader
			square.graphics.beginFill(0xF2F2F2);
			square.graphics.drawRect(0,0,(loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * 240,20);
			square.graphics.endFill();
			
			border.graphics.lineStyle(2,0xFFFFFF);
			border.graphics.drawRect(0, 0, 248, 28);
			
			text.textColor = 0xFFFFFF;
			text.text = "Loading: " + Math.ceil((loaderInfo.bytesLoaded/loaderInfo.bytesTotal)*100) + "%";
			
		}
		
		public function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				removeEventListener(Event.ENTER_FRAME, checkFrame);
				startup();
			}
		}
		
		public function startup():void 
		{
			var a:Class = Main; //puts Main in the namespace
			
			// hide loader
			stop();
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
	}
	
}