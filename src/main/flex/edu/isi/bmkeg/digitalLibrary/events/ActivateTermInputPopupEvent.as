package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.ftd.model.FTDFragmentBlock;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ActivateTermInputPopupEvent extends Event 
	{
		
		public static const ACTIVATE_TERM_INPUT_POPUP:String = "activateTermInputPopup";
		
		public var ftdAnn:FTDFragmentBlock;
		public var x:Number;
		public var y:Number;
		
		public function ActivateTermInputPopupEvent(ftdAnn:FTDFragmentBlock, x:Number, y:Number, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.ftdAnn = ftdAnn;
			this.x = x;
			this.y = y;
			super(ACTIVATE_TERM_INPUT_POPUP, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new ActivateTermInputPopupEvent(ftdAnn, x, y, bubbles, cancelable);
		}
		
	}
	
}
