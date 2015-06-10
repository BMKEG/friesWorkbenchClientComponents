package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunRulesOverAllEpochsEvent extends Event 
	{
		
		public static const RUN_RULES_OVER_ALL_EPOCHS:String = 
			"runRulesOverAllEpochs";
				
		public function RunRulesOverAllEpochsEvent(bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(RUN_RULES_OVER_ALL_EPOCHS, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new RunRulesOverAllEpochsEvent(bubbles, cancelable);
		}
		
	}
	
}
