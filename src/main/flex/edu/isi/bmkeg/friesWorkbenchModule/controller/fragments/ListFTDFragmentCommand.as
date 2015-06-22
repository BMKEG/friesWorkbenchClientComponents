package edu.isi.bmkeg.friesWorkbenchModule.controller.fragments
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.rl.events.*;

	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;

	import flash.events.Event;
	
	public class ListFTDFragmentCommand extends Command
	{
	
		[Inject]
		public var event:ListFTDFragmentEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
		
		[Inject]
		public var service:IFtdService;
				
		override public function execute():void
		{
			service.listFTDFragment(event.object);	
		}
		
	}
	
}