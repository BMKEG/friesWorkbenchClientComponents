package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunRulesOverAllEpochsResultEvent extends Event 
	{
		
		public static const RUN_RULES_OVER_ALL_EPOCHS_RESULT:String = 
			"runRulesOverAllEpochsResult";
		
		public function RunRulesOverAllEpochsResultEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(RUN_RULES_OVER_ALL_EPOCHS_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new RunRulesOverAllEpochsResultEvent(bubbles, cancelable);
		}
		
	}
	
}
