package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.terminology.rl.services.ITerminologyService;
	import edu.isi.bmkeg.terminology.rl.events.*;

	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;

	import flash.events.Event;
	
	public class ListOntologyCommand extends Command
	{
	
		[Inject]
		public var event:ListOntologyEvent;

		[Inject]
		public var model:DigitalLibraryModel;
		
		[Inject]
		public var service:ITerminologyService;
				
		override public function execute():void
		{
			service.listOntology(event.object);	
		}
		
	}
	
}