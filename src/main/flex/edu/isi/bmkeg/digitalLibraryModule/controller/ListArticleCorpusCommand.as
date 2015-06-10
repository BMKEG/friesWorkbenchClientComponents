package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListArticleCorpusEvent;
	
	import flash.events.Event;
	
	public class ListArticleCorpusCommand extends Command
	{
	
		[Inject]
		public var event:ListArticleCorpusEvent;

		[Inject]
		public var service:IDigitalLibraryService;
				
		override public function execute():void
		{
			service.listArticleCorpus( event.object );
		}
		
	}
	
}