package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	
	import flash.events.Event;
	
	public class UpdateFTDFragmentCommand extends Command
	{
	
		[Inject]
		public var event:UpdateFTDFragmentEvent;

		[Inject]
		public var service:IFtdService;
				
		override public function execute():void
		{
			service.updateFTDFragment(event.object);
		}
		
	}
	
}