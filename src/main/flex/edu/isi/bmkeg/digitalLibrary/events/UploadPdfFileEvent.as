package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class UploadPdfFileEvent extends Event 
	{
		
		public static const UPLOAD_PDF_FILE:String = "uploadPdfFile";
		
		public var data:ByteArray;
		public var fileName:String;
		public var corpusName:String;
		
		public function UploadPdfFileEvent(data:ByteArray, fileName:String, corpusName:String)
		{
			this.data = data;
			this.fileName = fileName;
			this.corpusName = corpusName;
			super(UPLOAD_PDF_FILE);
		}
		
		override public function clone() : Event
		{
			return new UploadPdfFileEvent(data, fileName, corpusName);
		}
		
	}
	
}
