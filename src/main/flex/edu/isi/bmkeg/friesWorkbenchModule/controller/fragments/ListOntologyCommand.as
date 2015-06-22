package edu.isi.bmkeg.friesWorkbenchModule.controller.fragments
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.terminology.rl.services.ITerminologyService;
	import edu.isi.bmkeg.terminology.rl.events.*;

	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;

	import flash.events.Event;
	
	public class ListOntologyCommand extends Command
	{
	
		[Inject]
		public var event:ListOntologyEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
		
		[Inject]
		public var service:ITerminologyService;
				
		override public function execute():void
		{
			service.listOntology(event.object);	
		}
		
	}
	
}