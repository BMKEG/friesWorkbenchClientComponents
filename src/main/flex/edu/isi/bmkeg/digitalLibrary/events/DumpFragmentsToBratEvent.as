package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class DumpFragmentsToBratEvent extends Event 
	{
		
		public static const DUMP_FRAGMENTS_TO_BRAT:String = "dumpFragmentsToBrat";
		
		public var ftdId:Number;
		
		public function DumpFragmentsToBratEvent(ftdId:Number, 
										  bubbles:Boolean=false, 
										  cancelable:Boolean=false)
		{
			this.ftdId = ftdId;
			super(DUMP_FRAGMENTS_TO_BRAT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new DumpFragmentsToBratEvent(ftdId, bubbles, cancelable);
		}
		
	}
	
}
