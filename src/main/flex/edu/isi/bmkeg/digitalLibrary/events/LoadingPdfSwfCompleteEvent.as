package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.display.MovieClip;
	
	import mx.rpc.events.FaultEvent;
	
	public class LoadingPdfSwfCompleteEvent extends Event 
	{
		
		public static const LOADING_PDF_SWF_COMPLETE:String = "loadingPdfSwfComplete";
		
		public var swf:MovieClip;
		
		public function LoadingPdfSwfCompleteEvent(swf:MovieClip)
		{
			this.swf = swf;
			super(LOADING_PDF_SWF_COMPLETE);
		}
		
		override public function clone() : Event
		{
			return new LoadingPdfSwfCompleteEvent(swf);
		}
		
	}
	
}
