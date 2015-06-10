package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.citations.ArticleCitation;
	
	import mx.rpc.events.FaultEvent;
	
	public class UploadPdfFileResultEvent extends Event 
	{
		
		public static const UPLOAD_PDF_FILE_RESULT:String = "uploadPdfFileResult";
		
		public var ac:ArticleCitation;
		
		public function UploadPdfFileResultEvent(ac:ArticleCitation) {
			this.ac = ac;
			super(UPLOAD_PDF_FILE_RESULT);
		}
		
		override public function clone() : Event
		{
			return new UploadPdfFileResultEvent(ac);
		}
		
	}
}
