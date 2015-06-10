package edu.isi.bmkeg.digitalLibraryModule.controller
{
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.FindArticleCitationByIdResultEvent;
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	
	import mx.core.FlexGlobals;
	import flash.external.*;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleCommand;
	
	import spark.components.Application;

	public class FindArticleCitationByIdResultCommand extends ModuleCommand
	{
		[Inject]
		public var event:FindArticleCitationByIdResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void {
		
			model.citation = event.object;
			
			// dispatch this for other modules.
			this.dispatchToModules(event);
			
			//
			// We need to save this as a cookie on the client.
			//
			if (ExternalInterface.available) {
				ExternalInterface.call("setCookie", "articleCitationId", model.citation.vpdmfId, 10);   				
			}
						
		}
		
	}
	
}