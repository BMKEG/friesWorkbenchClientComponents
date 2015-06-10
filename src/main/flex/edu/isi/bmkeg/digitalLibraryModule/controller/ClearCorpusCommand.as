package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.digitalLibraryModule.events.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ClearCorpusCommand extends Command
	{
	
		[Inject]
		public var event:ClearCorpusEvent;

		[Inject]
		public var model:DigitalLibraryModel;
				
		override public function execute():void
		{
			
			model = new DigitalLibraryModel();

		}
		
	}
	
}