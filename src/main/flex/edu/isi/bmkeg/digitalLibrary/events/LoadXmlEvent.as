package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadXmlEvent extends Event 
	{
		
		public static const LOAD_XML:String = "loadXml";
		
		public var vpdmfId:Number;
		
		public function LoadXmlEvent(vpdmfId:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.vpdmfId = vpdmfId;
			super(LOAD_XML, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadXmlEvent(vpdmfId, bubbles, cancelable);
		}
		
	}
	
}
