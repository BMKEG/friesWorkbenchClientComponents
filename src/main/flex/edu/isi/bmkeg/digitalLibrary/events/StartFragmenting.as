package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class StartFragmenting extends Event 
	{
		
		public static const START_FRAGMENTING:String = "startFragmenting";
		
		public var p:int;
		public var x:int;
		public var y:int;
		public var sf:Number;
		
		public function StartFragmenting(p:int, x:int, y:int, sf:Number,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false )
		{
			this.p = p;
			this.x = x;
			this.y = y;
			this.sf = sf;
			super(START_FRAGMENTING, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new StartFragmenting(p, x, y, sf, bubbles, cancelable);
		}
		
	}
	
}
