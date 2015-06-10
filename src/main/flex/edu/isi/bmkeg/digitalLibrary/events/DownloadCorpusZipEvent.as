package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class DownloadCorpusZipEvent extends Event 
	{
		
		public static const DOWNLOAD_CORPUS_ZIP:String = 
			"downloadCorpusZip";
		
		public var corpusId:Number;
				
		public function DownloadCorpusZipEvent(corpusId:Number)
		{
			this.corpusId = corpusId;
			super(DOWNLOAD_CORPUS_ZIP);
		}
		
		override public function clone() : Event
		{
			return new DownloadCorpusZipEvent(corpusId);
		}
		
	}
	
}
