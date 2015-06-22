package edu.isi.bmkeg.friesWorkbenchModule.controller.listIndexCardsFromArticle
{	
	import edu.isi.bmkeg.pagedList.model.*;
	
	import edu.isi.bmkeg.friesWorkbench.events.ListIndexCardsByArticleIdResultEvent;
	
	import edu.isi.bmkeg.friesWorkbenchModule.model.*;

	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListIndexCardsByArticleIdResultCommand extends Command
	{
		
		[Inject]
		public var event:ListIndexCardsByArticleIdResultEvent;
		
		[Inject]
		public var model:FriesWorkbenchModel;

		override public function execute():void
		{
			model.indexCards = event.list;
		}
		
	}
	
}