package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;

	import org.robotlegs.mvcs.Command;
	
	public class FindArticleCorpusByIdResultCommand extends Command
	{
		
		[Inject]
		public var event:FindArticleCorpusByIdResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		
		override public function execute():void
		{	
			model.corpus = event.object;	

			//
			// We need to save this as a cookie on the client.
			//
			if (ExternalInterface.available) {
				ExternalInterface.call("setCookie", "corpusCitationId", model.corpus.vpdmfId, 10);   				
			}

		}
		
	}
	
}