package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	
	import flash.events.Event;
	
	public class InsertFTDFragmentCommand extends Command
	{
	
		[Inject]
		public var event:InsertFTDFragmentEvent;

		[Inject]
		public var service:IFtdService;
				
		override public function execute():void
		{
			service.insertFTDFragment(event.object);
		}
		
	}
	
}