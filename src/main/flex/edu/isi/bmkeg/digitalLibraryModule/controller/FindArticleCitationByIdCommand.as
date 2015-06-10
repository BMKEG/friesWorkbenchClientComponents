package edu.isi.bmkeg.digitalLibraryModule.controller
{
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.rl.events.FindArticleCitationByIdEvent;
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;
	
	public class FindArticleCitationByIdCommand extends Command
	{
		[Inject]
		public var event:FindArticleCitationByIdEvent;
		
		[Inject]
		public var service:IDigitalLibraryService;
		
		override public function execute():void {
			service.findArticleCitationById( event.id );	
		}
		
	}
}