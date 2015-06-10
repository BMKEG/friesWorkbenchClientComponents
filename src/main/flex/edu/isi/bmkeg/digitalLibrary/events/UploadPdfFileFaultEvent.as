package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	
	import mx.rpc.events.FaultEvent;
	
	public class UploadPdfFileFaultEvent extends Event 
	{
		
		public static const UPLOAD_PDF_FILE_FAULT:String = "uploadPdfFileFault";
		
		public var event:FaultEvent;
		
		public function UploadPdfFileFaultEvent(event:FaultEvent)
		{
			this.event = event;
			super(UPLOAD_PDF_FILE_FAULT);
		}
		
		override public function clone() : Event
		{
			return new UploadPdfFileFaultEvent(event);
		}
		
	}
}
