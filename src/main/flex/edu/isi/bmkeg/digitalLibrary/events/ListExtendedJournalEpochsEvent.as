package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ListExtendedJournalEpochsEvent extends Event 
	{
		
		public static const LIST_EXTENDED_JOURNAL_EPOCHS:String = "listExtendedJournalEpochsEvent";
		
		public function ListExtendedJournalEpochsEvent()
		{
			super(LIST_EXTENDED_JOURNAL_EPOCHS);
		}
		
		override public function clone() : Event
		{
			return new ListExtendedJournalEpochsEvent();
		}
		
	}
	
}
