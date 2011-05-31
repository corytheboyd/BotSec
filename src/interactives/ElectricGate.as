package interactives 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.TiledSpritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class ElectricGate extends Interactive 
	{
		public var image:TiledSpritemap; //the image file, set to tile
		public var horizontal:Boolean; //true if its horizontal, false if vertical
		public var hitbox:Hitbox; //sets the hitbox of the hazard
		public var h:int; //height of the hazard
		public var w:int; //width of the hazard	
		public var pulses:Boolean; //true if it pulses on/off
		public var flickerAlarm:Alarm = new Alarm(0.75, enable);
		public var pulseAlarm:Alarm = new Alarm(1, toggle);
		
		public var onSound:Sfx = new Sfx(GC.SFX_ELECTRIC_GATE_ON);
		public var offSound:Sfx = new Sfx(GC.SFX_ELECTRIC_GATE_OFF);
		public var loopSound:Sfx = new Sfx(GC.SFX_ELECTRIC_GATE_LOOP);
		
		public function ElectricGate( x:Number, y:Number, h:uint, w:uint, pulses:Boolean, id:String, isOn:Boolean ) 
		{			
			type = GC.HAZARD_TYPE;
			
			this.x = x;
			this.y = y;
			this.h = h;
			this.w = w;
			this.isOn = isOn;
			this.id = id;
			this.pulses = pulses;
			
			if ( w == 0 ) //its vertical
			{
				horizontal = false;
				graphic = image = new TiledSpritemap(GC.GFX_ELECTRIC_GATE_V, 16, 16, w, h);
				mask = hitbox = new Hitbox(16, h);
			}
			else if ( h == 0 ) //horizontal
			{
				horizontal = true;
				graphic = image = new TiledSpritemap(GC.GFX_ELECTRIC_GATE_H, 16, 16, w, h);
				mask = hitbox = new Hitbox(w, 16);
			}
			
			image.add('on', [0, 1, 2, 3], 8, true);
			image.play('on');
			
			addTween(flickerAlarm);
			addTween(pulseAlarm);
		}
		
		override public function added():void 
		{
			//if it is initially disabled
			if (!isOn) disable();
			
			if (pulses) pulseAlarm.start();
			
			layer = 3;
		}
		
		override public function removed():void 
		{
			if (loopSound.playing) loopSound.stop();
		}
		
		override public function update():void 
		{			
			if ( flickerAlarm.active )
			{
				image.alpha = ( FP.rand(2) == 0 ? 0.25 : 0.50 );
			}
			else if ( isOn )
			{
				image.play('on');
				if (!loopSound.playing) loopSound.loop();
				enable();
			}
		}
		
		/*
		 * Handle ON signal from switch 
		 */
		override public function sendSignalOn():void 
		{
			flickerAlarm.start();
			onSound.play();
			
			if (pulses) pulseAlarm.start();
		}
		
		/*
		 * Handle OFF signal from switch 
		 */
		override public function sendSignalOff():void 
		{
			disable();
			
			if (pulses) pulseAlarm.reset(0);
		}
		
		/*
		 * Switches the state to its opposite
		 * */
		protected function toggle():void
		{
			isOn ? disable() : enable();
			pulseAlarm.reset(1);
		}
		
		/*
		 * Disables the hazard
		 * */
		public function disable():void
		{
			if (loopSound.playing) 
			{
				loopSound.stop();
				if (!pulses) offSound.play();
			}			
			image.alpha = 0;
			mask = null;
			type = '';
			isOn = false;
		}
		
		/*
		 * Enables the hazard
		 * */
		public function enable():void
		{
			image.alpha = 1;
			mask = hitbox;
			type = GC.HAZARD_TYPE;
			isOn = true;
		}
		
	}

}