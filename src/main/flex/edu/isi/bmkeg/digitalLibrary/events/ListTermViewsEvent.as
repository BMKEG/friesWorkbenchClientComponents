package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ListTermViewsEvent extends Event 
	{
		
		public static const LIST_TERM_VIEWS:String = "listTermViews";
		
		public function ListTermViewsEvent()
		{
			super(LIST_TERM_VIEWS);
		}
		
		override public function clone() : Event
		{
			return new ListTermViewsEvent();
		}
		
	}
	
}
