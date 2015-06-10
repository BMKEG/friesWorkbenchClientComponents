package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.*;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadPmcXmlResultEvent extends Event 
	{
		
		public static const LOAD_PMCXML_RESULT:String = "loadPmcXmlResult";
		
		public var pmcXml:String;
		
		public function LoadPmcXmlResultEvent(pmcXml:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.pmcXml = pmcXml;
			super(LOAD_PMCXML_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadPmcXmlResultEvent(pmcXml, bubbles, cancelable);
		}
		
	}
	
}
