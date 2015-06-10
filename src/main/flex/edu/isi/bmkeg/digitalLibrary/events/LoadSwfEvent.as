package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadSwfEvent extends Event 
	{
		
		public static const LOAD_SWF:String = "loadSwf";
		
		public var vpdmfId:Number;
		
		public function LoadSwfEvent(vpdmfId:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.vpdmfId = vpdmfId;
			super(LOAD_SWF, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadSwfEvent(vpdmfId, bubbles, cancelable);
		}
		
	}
	
}
