package edu.isi.bmkeg.digitalLibrary.events
{

	import flash.events.Event;
	import edu.isi.bmkeg.ftd.model.FTD;

	public class AddRuleFileToJournalEpochResultEvent extends Event {

		public static const ADD_RULE_FILE_TO_JOURNAL_EPOCH_RESULT:String = 
			"addRuleFileToJournalEpochResult";

		public var id:Number;
		
		public function AddRuleFileToJournalEpochResultEvent(id:Number,
												bubbles:Boolean=false, 
												cancelable:Boolean=false ) {
			super(ADD_RULE_FILE_TO_JOURNAL_EPOCH_RESULT, bubbles, cancelable);
			this.id = id;
		}

		override public function clone() : Event {
			return new AddRuleFileToJournalEpochResultEvent(id, 
				bubbles, 
				cancelable);
		}

	}
}
