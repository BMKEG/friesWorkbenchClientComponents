package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.rl.events.*;

	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;

	import flash.events.Event;
	
	public class ListArticleDocumentCommand extends Command
	{
	
		[Inject]
		public var event:ListArticleDocumentEvent;

		[Inject]
		public var model:DigitalLibraryModel;
		
		[Inject]
		public var service:IFtdService;
				
		override public function execute():void
		{
			service.listArticleDocument(event.object);	
		}
		
	}
	
}