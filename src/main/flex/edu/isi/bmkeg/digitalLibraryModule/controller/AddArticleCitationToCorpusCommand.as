package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	
	import flash.events.Event;
	
	public class AddArticleCitationToCorpusCommand extends Command
	{
		
		[Inject]
		public var event:AddArticleCitationToCorpusEvent;
		
		[Inject]
		public var service:IExtendedDigitalLibraryService;
		
		override public function execute():void
		{
			service.addArticlesToCorpus(event.articleIds, event.corpusId);
		}
		
	}
	
}