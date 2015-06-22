package edu.isi.bmkeg.friesWorkbenchModule.controller.findAndLoadArticle
{
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.FindArticleCitationByIdResultEvent;
	import edu.isi.bmkeg.friesWorkbench.events.ListIndexCardsByArticleIdEvent;
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	
	import flash.external.*;
	
	import mx.core.FlexGlobals;
	
	import org.robotlegs.utilities.modular.mvcs.ModuleCommand;
	
	import spark.components.Application;

	public class FindArticleCitationByIdResultCommand extends ModuleCommand
	{
		[Inject]
		public var event:FindArticleCitationByIdResultEvent;
		
		[Inject]
		public var model:FriesWorkbenchModel;
		
		override public function execute():void {
		
			model.citation = event.object;
			
			this.dispatch(
				new ListIndexCardsByArticleIdEvent(model.citation.vpdmfId)
			);
						
		}
		
	}
	
}