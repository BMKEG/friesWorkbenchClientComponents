package edu.isi.bmkeg.digitalLibrary.events
{
	import edu.isi.bmkeg.ftd.model.FTDFragmentBlock;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ChangeFragmentCodeInViewEvent extends Event 
	{
		
		public static const CHANGE_FRAGMENT_CODE_IN_VIEW:String = "changeFragmentCodeInView";
		
		public var fCode:String;
		
		public function ChangeFragmentCodeInViewEvent(fCode:String,
												bubbles:Boolean=false, 
												cancelable:Boolean=false ) {
			this.fCode = fCode;
			super(CHANGE_FRAGMENT_CODE_IN_VIEW, bubbles, cancelable);
		}
		
		override public function clone(): Event {

			return new ChangeFragmentCodeInViewEvent(fCode, bubbles, cancelable);
		
		}
		
	}
	
}
