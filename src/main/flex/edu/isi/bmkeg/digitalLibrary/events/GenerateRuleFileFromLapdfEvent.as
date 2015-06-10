package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class GenerateRuleFileFromLapdfEvent extends Event 
	{
		
		public static const GENERATE_RULE_FILE_FROM_LAPDF:String = 
			"generateRuleFileFromLapdf";
		
		public var articleId:Number;
		
		public function GenerateRuleFileFromLapdfEvent(
			articleId:Number)
		{
			super(GENERATE_RULE_FILE_FROM_LAPDF);
			this.articleId = articleId;
		}
		
		override public function clone() : Event
		{
			return new GenerateRuleFileFromLapdfEvent(
				articleId
			);
		}
		
	}
	
}
