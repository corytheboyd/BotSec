package interactives 
{
	import flash.display.Sprite;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class TV extends Interactive 
	{
		public var image:Spritemap = new Spritemap(GC.GFX_TV, 112, 143);
		public var flickerAlarm:Alarm = new Alarm(0.5);
		public var onSound:Sfx = new Sfx(GC.SFX_TV_ON);
		public var offSound:Sfx = new Sfx(GC.SFX_TV_OFF);
		
		public var messageGraphic:Entity = new Entity; 
		protected var message:Text = new Text('', 0, 0, 89, 24);
		protected var currentMessageIndex:int = 0; //the currently displayed message
		protected var messages:Array = []; //stores the messages to loop over
		protected var changeMessageAlarm:Alarm = new Alarm(1, changeMessageFrame);
		
		public function TV( x:Number, y:Number, messageStrings:Array, id:String, isOn:Boolean ) 
		{
			image.add('on', [1, 2], 10, true);
			image.add('off', [0], 0, false);
			
			image.play( isOn ? 'on' : 'off' );
			
	 		type = GC.TV_TYPE;
			graphic = image;
			setHitbox(112, 143);
			
			this.x = x;
			this.y = y;
			this.id = id;
			this.isOn = isOn;
			
			if (messageStrings.length > 0)
			{	
				for each ( var msg:String in messageStrings )
				{
					messages.push(msg);
				}
				
				this.message.text = messages[0];
				this.message.size = 12;
				this.message.color = 0x52E93A;
				this.message.alpha = isOn ? 1 : 0;
				this.message.x = x + halfWidth - this.message.width / 2; //- messageText.width; //centered x
				this.message.y = y + 103 - this.message.height / 2; //centered y on the screen			
			}
			
			addTween(flickerAlarm);
			addTween(changeMessageAlarm);
		}
		
		override public function added():void 
		{
			messageGraphic = world.addGraphic(message);
			messageGraphic.layer = 3;
			layer = 4;
		}
		
		override public function update():void 
		{
			this.message.x = x + halfWidth - this.message.width / 2; //- messageText.width; //centered x
			this.message.y = y + 103 - this.message.height / 2; //centered y on the screen	
			
			if ( flickerAlarm.active )
			{
				image.play( FP.rand(2) == 0 ? 'on' : 'off' );
				message.alpha = FP.rand(2) == 0 ? 0.25 : 0.75;
			}
			else if (isOn)
			{
				if (messages.length > 0)
				{
					if (message.alpha < 1) message.alpha = 1; //make message visible again
					if ( !changeMessageAlarm.active ) changeMessageAlarm.start(); //start message change timer
				}
				
				FP.rand(2) == 0 ? image.setAnimFrame('on', 0) : image.setAnimFrame('on', 1);
			}
			else
			{
				image.play('off');
				if ( changeMessageAlarm.active ) changeMessageAlarm.reset(1); //start message change timer
			}
		}
		
		protected function changeMessageFrame():void
		{
			if ( currentMessageIndex == messages.length - 1 )
			{
				currentMessageIndex = 0;
			}
			else
			{
				currentMessageIndex++;
			}
			
			message.text = messages[currentMessageIndex];
		}
		
		/*
		 * Handle ON signal from switch 
		 */
		override public function sendSignalOn():void 
		{
			isOn = true;
			flickerAlarm.start();
			onSound.play();
		}
		
		/*
		 * Handle OFF signal from switch 
		 */
		override public function sendSignalOff():void 
		{
			image.play('off');		
			isOn = false;
			offSound.play();
		}
		
	}

}