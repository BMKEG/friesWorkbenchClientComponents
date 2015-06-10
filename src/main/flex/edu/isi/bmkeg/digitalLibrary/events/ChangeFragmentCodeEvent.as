package edu.isi.bmkeg.digitalLibrary.events
{
	import edu.isi.bmkeg.ftd.model.FTDFragmentBlock;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ChangeFragmentCodeEvent extends Event 
	{
		
		public static const ADD_FRAGMENT_CODE:String = "addFragmentCode";
		public static const REMOVE_FRAGMENT_CODE:String = "removeFragmentCode";
		
		public var addRemove:String;
		public var block:FTDFragmentBlock;
		
		public function ChangeFragmentCodeEvent(addRemove:String,
												block:FTDFragmentBlock,
												bubbles:Boolean=false, 
												cancelable:Boolean=false ) {
			this.addRemove = addRemove;
			this.block = block;
			super(addRemove, bubbles, cancelable);
		}
		
		override public function clone(): Event {

			return new ChangeFragmentCodeEvent(addRemove, block, bubbles, cancelable);
		
		}
		
	}
	
}
