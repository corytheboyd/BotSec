/*
 * Wrapper class for all objects that can receive input from switches.
 * */

package interactives 
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Cory Boyd
	 */
	public class Interactive extends Entity 
	{
		public var isOn:Boolean;
		public var id:String;
		
		public function Interactive() 
		{
			
		}
		
		/*
		 * Overide this function to change behavior when ON signal is received
		 * */
		public function sendSignalOn():void
		{
			
		}
		
		/*
		 * Overide this function to change behavior when OFF signal is received
		 * */
		public function sendSignalOff():void
		{
			
		}
		
	}

}