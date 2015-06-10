package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	
	import flash.events.Event;
	
	public class DownloadCorpusZipCommand extends Command
	{
		
		[Inject]
		public var event:DownloadCorpusZipEvent;
		
		[Inject]
		public var service:IExtendedDigitalLibraryService;
		
		override public function execute():void
		{
			service.packageCorpusArchive(event.corpusId);
		}
		
	}
	
}