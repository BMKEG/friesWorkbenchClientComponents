package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.JournalEpoch;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RetrievePmcHtmlEvent extends Event 
	{
		
		public static const RETRIEVE_PMC_HTML:String = "retrievePmcHtml";
		
		public function RetrievePmcHtmlEvent()
		{
			super(RETRIEVE_PMC_HTML);
		}
		
		override public function clone() : Event
		{
			return new RetrievePmcHtmlEvent();
		}
		
	}
	
}
