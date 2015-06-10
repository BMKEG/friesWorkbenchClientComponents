package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.terminology.rl.events.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.*;
	
	import org.robotlegs.mvcs.Command;

	public class ListTermResultCommand extends Command
	{
	
		[Inject]
		public var event:ListTermResultEvent;

		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void
		{

			model.terms = new ArrayCollection();
			
			var colorId:int = 0;
			for each(var lvi:LightViewInstance in event.list) {	
				var oo:Object = lvi.convertToIndexTupleObject();
				var o:Object = {
					'id':oo["vpdmfId"], 
					'code':oo["Term_2"], 
					'tree':oo["Term_3"], 
					'colorId':colorId++
				};
				model.terms.addItem(o);
			}
			
			var srt:Sort = new Sort();
			srt.fields = [new SortField("code")];
			model.terms.sort = srt;
			model.terms.refresh();
			
		}
		
	}
	
}