package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	public class ListTermViewsResultEvent extends Event 
	{
		
		public static const LIST_TERM_VIEWS_RESULT:String = "listTermViewsResult";

		public var termList:ArrayCollection = new ArrayCollection();
		
		public function ListTermViewsResultEvent(termList:ArrayCollection)
		{
			this.termList = termList;
			super(LIST_TERM_VIEWS_RESULT);
		}
		
		override public function clone() : Event
		{
			return new ListTermViewsResultEvent(termList);
		}
		
	}
	
}
