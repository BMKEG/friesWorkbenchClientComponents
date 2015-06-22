package edu.isi.bmkeg.friesWorkbenchModule.controller.loadIndexCard
{	
	import edu.isi.bmkeg.bigMechIndexCards.rl.events.*;
	import edu.isi.bmkeg.bigMechIndexCards.rl.services.IBigMechIndexCardsService;
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindBigMechIndexCardByIdCommand extends Command
	{
	
		[Inject]
		public var event:FindBigMechIndexCardByIdEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
		
		[Inject]
		public var service:IBigMechIndexCardsService;
				
		override public function execute():void
		{	
			service.findBigMechIndexCardById(event.id);	
		}
		
	}
	
}