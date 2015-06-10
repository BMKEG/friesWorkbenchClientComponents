package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.utils.serverUpdates.events.ServerUpdateEvent;
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class ServerUpdateCommand extends Command
	{
		
		[Inject]
		public var event:ServerUpdateEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void
		{
			this.model.message = event.message;
		}
		
	}
	
}