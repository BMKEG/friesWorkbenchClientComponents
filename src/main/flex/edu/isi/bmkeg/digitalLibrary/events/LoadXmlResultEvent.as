package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.*;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadXmlResultEvent extends Event 
	{
		
		public static const LOAD_XML_RESULT:String = "loadXmlResult";
		
		public var xml:String;
		
		public function LoadXmlResultEvent(xml:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.xml = xml;
			super(LOAD_XML_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadXmlResultEvent(xml, bubbles, cancelable);
		}
		
	}
	
}
