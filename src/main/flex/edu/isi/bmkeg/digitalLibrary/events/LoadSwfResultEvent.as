package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.*;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadSwfResultEvent extends Event 
	{
		
		public static const LOAD_SWF_RESULT:String = "loadSwfResult";
		
		public var swf:MovieClip;
		
		public function LoadSwfResultEvent(swf:MovieClip, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.swf = swf;
			super(LOAD_SWF_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new LoadSwfResultEvent(swf, bubbles, cancelable);
		}
		
	}
	
}
