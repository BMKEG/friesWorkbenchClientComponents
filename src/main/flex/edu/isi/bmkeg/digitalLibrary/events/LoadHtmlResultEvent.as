package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.*;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadHtmlResultEvent extends Event 
	{
		
		public static const LOAD_HTML_RESULT:String = "loadHtmlResult";
		
		public var html:String;
		
		public function LoadHtmlResultEvent(html:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.html = html;
			super(LOAD_HTML_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadHtmlResultEvent(html, bubbles, cancelable);
		}
		
	}
	
}
