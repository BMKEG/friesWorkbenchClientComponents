package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.system.LoaderContext;
	
	import mx.collections.ArrayCollection;
	import mx.controls.SWFLoader;
	
	import org.robotlegs.mvcs.Command;
	
	public class LoadHtmlResultCommand extends Command
	{
		
		[Inject]
		public var event:LoadHtmlResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;

		override public function execute():void
		{
			model.html = event.html;
		}
		
	}
	
}