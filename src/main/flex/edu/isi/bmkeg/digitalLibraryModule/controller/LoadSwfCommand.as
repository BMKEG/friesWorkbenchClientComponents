package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.events.*;

	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;

	import flash.events.Event;
	
	public class LoadSwfCommand extends Command
	{
	
		[Inject]
		public var event:LoadSwfEvent;

		[Inject]
		public var model:DigitalLibraryModel;
		
		[Inject]
		public var service:IExtendedDigitalLibraryService;
				
		override public function execute():void
		{
			service.loadSwf(event.vpdmfId);			
		}
		
	}
	
}