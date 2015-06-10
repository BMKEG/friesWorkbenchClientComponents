package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class TrackFragmentCursor extends Event 
	{
		
		public static const TRACK_FRAGMENT_CURSOR:String = "trackFragmentCursor";
		
		public var p:int;
		public var x:int;
		public var y:int;
		public var sf:Number;
		
		public function TrackFragmentCursor(p:int, x:int, y:int, sf:Number, 
										  bubbles:Boolean=false, 
										  cancelable:Boolean=false)
		{
			this.p = p;
			this.x = x;
			this.y = y;
			this.sf = sf;
			super(TRACK_FRAGMENT_CURSOR, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new TrackFragmentCursor(p, x, y, sf, bubbles, cancelable);
		}
		
	}
	
}
