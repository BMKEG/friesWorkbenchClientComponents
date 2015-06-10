package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	public class ListExtendedJournalEpochsResultEvent extends Event 
	{
		
		public static const LIST_EXTENDED_JOURNAL_EPOCHS_RESULT:String = "listExtendedJournalEpochsResult";

		public var epochList:ArrayCollection = new ArrayCollection();
		
		public function ListExtendedJournalEpochsResultEvent(epochList:ArrayCollection)
		{
			this.epochList = epochList;
			super(LIST_EXTENDED_JOURNAL_EPOCHS_RESULT);
		}
		
		override public function clone() : Event
		{
			return new ListExtendedJournalEpochsResultEvent(epochList);
		}
		
	}
	
}
