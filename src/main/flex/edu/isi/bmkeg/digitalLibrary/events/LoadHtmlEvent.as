package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadHtmlEvent extends Event 
	{
		
		public static const LOAD_HTML:String = "loadHtml";
		
		public var vpdmfId:Number;
		
		public function LoadHtmlEvent(vpdmfId:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.vpdmfId = vpdmfId;
			super(LOAD_HTML, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadHtmlEvent(vpdmfId, bubbles, cancelable);
		}
		
	}
	
}
