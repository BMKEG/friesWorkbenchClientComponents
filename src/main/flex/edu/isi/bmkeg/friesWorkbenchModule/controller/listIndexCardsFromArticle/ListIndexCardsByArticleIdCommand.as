package edu.isi.bmkeg.friesWorkbenchModule.controller.listIndexCardsFromArticle
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.friesWorkbench.events.ListIndexCardsByArticleIdEvent;
	import edu.isi.bmkeg.friesWorkbench.services.IExtendedBigMechIndexCardService;
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListIndexCardsByArticleIdCommand extends Command
	{
	
		[Inject]
		public var event:ListIndexCardsByArticleIdEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
		
		[Inject]
		public var service:IExtendedBigMechIndexCardService;
				
		override public function execute():void
		{	
			service.listIndexCardsByArticleId(event.object);	
		}
		
	}
	
}