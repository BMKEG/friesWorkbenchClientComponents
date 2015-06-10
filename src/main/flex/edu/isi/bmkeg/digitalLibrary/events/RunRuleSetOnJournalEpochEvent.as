package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunRuleSetOnJournalEpochEvent extends Event 
	{
		
		public static const RUN_RULE_SET_ON_JOURNAL_EPOCH:String = 
			"runRuleSetOnJournalEpoch";
		
		public var epochId:Number;
		
		public function RunRuleSetOnJournalEpochEvent(
			epochId:Number, bubbles:Boolean, cancelable:Boolean)
		{
			super(RUN_RULE_SET_ON_JOURNAL_EPOCH, bubbles, cancelable);
			this.epochId = epochId;
		}
		
		override public function clone() : Event
		{
			return new RunRuleSetOnJournalEpochEvent(
				epochId, bubbles, cancelable
			);
		}
		
	}
	
}
