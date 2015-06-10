package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ChangeFragmentTypeEvent extends Event 
	{
		
		public static const CHANGE_FRAGMENT_TYPE:String = "changeFragmentType";
		
		public var fType:String;
		
		public function ChangeFragmentTypeEvent(fType:String,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false )
		{
			this.fType = fType;
			super(CHANGE_FRAGMENT_TYPE, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new ChangeFragmentTypeEvent(fType, bubbles, cancelable);
		}
		
	}
	
}
