package edu.isi.bmkeg.digitalLibrary.events
{

	import flash.events.Event;
	import edu.isi.bmkeg.ftd.model.FTD;

	public class AddRuleFileToJournalEpochEvent extends Event {

		public static const ADD_RULE_FILE_TO_JOURNAL_EPOCH:String = 
			"addRuleFileToJournalEpoch";

		public var ruleFileId:Number;
		public var epochId:Number;
		public var epochJournal:String;
		public var epochStart:Number;
		public var epochEnd:Number;
		
		public function AddRuleFileToJournalEpochEvent(ruleFileId:Number, 
													   epochId:Number,
													   epochJournal:String,
													   epochStart:Number,
													   epochEnd:Number,
													   bubbles:Boolean=false, 
													   cancelable:Boolean=false ) {
			super(ADD_RULE_FILE_TO_JOURNAL_EPOCH, bubbles, cancelable);
			
			this.ruleFileId = ruleFileId;
			this.epochId = epochId;
			this.epochJournal = epochJournal;
			this.epochStart = epochStart;
			this.epochEnd = epochEnd;

		}

		override public function clone() : Event {
			return new AddRuleFileToJournalEpochEvent(
				ruleFileId, epochId, 
				epochJournal, epochStart, epochEnd,
				bubbles, cancelable);
		}

	}
	
}
