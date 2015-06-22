package edu.isi.bmkeg.friesWorkbenchModule.controller.fragments
{	
	import edu.isi.bmkeg.terminology.rl.events.*;
	import edu.isi.bmkeg.terminology.rl.services.ITerminologyService;
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.*;
	
	import org.robotlegs.mvcs.Command;

	public class ListOntologyResultCommand extends Command
	{
	
		[Inject]
		public var event:ListOntologyResultEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
		
		override public function execute():void
		{
			model.frgType = "frg"
			model.ontologies = event.list;			
		}
		
	}
	
}