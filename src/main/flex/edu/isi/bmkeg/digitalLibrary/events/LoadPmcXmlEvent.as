package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadPmcXmlEvent extends Event 
	{
		
		public static const LOAD_PMCXML:String = "loadPmcXml";
		
		public var vpdmfId:Number;
		
		public function LoadPmcXmlEvent(vpdmfId:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.vpdmfId = vpdmfId;
			super(LOAD_PMCXML, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadPmcXmlEvent(vpdmfId, bubbles, cancelable);
		}
		
	}
	
}
