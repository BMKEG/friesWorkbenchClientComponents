package edu.isi.bmkeg.friesWorkbenchModule.controller.findAndLoadArticle
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;

	import flash.display.*;
	import flash.events.Event;
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;
	import mx.controls.SWFLoader;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadXmlResultCommand extends Command
	{
		
		[Inject]
		public var event:LoadXmlResultEvent;
		
		[Inject]
		public var model:FriesWorkbenchModel;

		override public function execute():void
		{
			//model.swf = event.swf;
		}
		
	}
	
}