package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class DumpFragmentsToCoNLLFormatEvent extends Event 
	{
		
		public static const DUMP_FRAGMENTS_TO_CONLL_FORMAT:String = "dumpFragmentsToCoNLLFormat";
		
		public var ftdId:Number;
		
		public function DumpFragmentsToCoNLLFormatEvent(ftdId:Number, 
										  bubbles:Boolean=false, 
										  cancelable:Boolean=false)
		{
			this.ftdId = ftdId;
			super(DUMP_FRAGMENTS_TO_CONLL_FORMAT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new DumpFragmentsToCoNLLFormatEvent(ftdId, bubbles, cancelable);
		}
		
	}
	
}
