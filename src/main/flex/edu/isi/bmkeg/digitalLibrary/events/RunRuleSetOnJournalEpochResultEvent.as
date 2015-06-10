package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunRuleSetOnJournalEpochResultEvent extends Event 
	{
		
		public static const RUN_RULE_SET_ON_JOURNAL_EPOCH_RESULT:String = 
			"runRuleSetOnJournalEpochResult";
		
		public var epochId:Number;
		
		public function RunRuleSetOnJournalEpochResultEvent(
			epochId:Number)
		{
			super(RUN_RULE_SET_ON_JOURNAL_EPOCH_RESULT);
			this.epochId = epochId;
		}
		
		override public function clone() : Event
		{
			return new RunRuleSetOnArticleCitationResultEvent(
				epochId
			);
		}
		
	}
	
}
