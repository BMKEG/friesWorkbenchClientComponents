package edu.isi.bmkeg.friesWorkbenchModule.controller.findAndLoadArticle
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;

	import flash.events.Event;
	
	public class LoadSwfCommand extends Command
	{
	
		[Inject]
		public var event:LoadSwfEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
		
		[Inject]
		public var service:IExtendedDigitalLibraryService;
				
		override public function execute():void
		{
			service.loadSwf(event.vpdmfId);			
		}
		
	}
	
}