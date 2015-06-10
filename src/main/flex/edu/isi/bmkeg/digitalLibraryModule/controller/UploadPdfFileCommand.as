package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	
	import flash.events.Event;
	
	public class UploadPdfFileCommand extends Command
	{
		
		[Inject]
		public var event:UploadPdfFileEvent;
		
		[Inject]
		public var service:IExtendedDigitalLibraryService;
		
		override public function execute():void
		{
			service.addPmidEncodedPdfToCorpus(event.data, event.fileName, event.corpusName);
		}
		
	}
	
}