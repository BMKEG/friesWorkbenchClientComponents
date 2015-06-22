package edu.isi.bmkeg.friesWorkbenchModule.events
{
	
	import flash.events.Event;
	
	public class SwitchInOutEvent extends Event
	{
		public static const SWITCH:String = "SwitchInOutEvent";
		public static const IN:String = "in";
		public static const OUT:String = "out";
		public static const UNCLASSIFIED:String = "unclassified";

		/**
		 * selected Article or null if none is selected
		 */
		public var code:String;
		
		public function SwitchInOutEvent(code:String, 
										bubbles:Boolean=false, 
										cancelable:Boolean=false)
		{
			super(SWITCH, bubbles, cancelable);
			this.code = code;
		}

		override public function clone():Event
		{
			return new SwitchInOutEvent(code, bubbles, cancelable)
		}

	}
}