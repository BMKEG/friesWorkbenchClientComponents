package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateArticleCorpusResultCommand extends Command
	{
		
		[Inject]
		public var event:UpdateArticleCorpusResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void
		{	
			this.dispatch(new FindArticleCorpusByIdEvent(event.id));				
		}
		
	}
	
}