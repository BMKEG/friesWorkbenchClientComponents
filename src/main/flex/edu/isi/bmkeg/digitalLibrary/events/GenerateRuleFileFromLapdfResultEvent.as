package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class GenerateRuleFileFromLapdfResultEvent extends Event 
	{
		
		public static const GENERATE_RULE_FILE_FROM_LAPDF_RESULT:String = 
			"generateRuleFileFromLapdfResult";
		
		public var csv:String;
				
		public function GenerateRuleFileFromLapdfResultEvent(csv:String)
		{
			super(GENERATE_RULE_FILE_FROM_LAPDF_RESULT);
			this.csv = csv;
		}
		
		override public function clone() : Event
		{
			return new GenerateRuleFileFromLapdfResultEvent(csv);
		}
		
	}
	
}
