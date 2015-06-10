package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.ftd.rl.events.ListFTDFragmentEvent;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class RemoveAnnotationResultCommand extends Command
	{
		
		[Inject]
		public var event:RemoveAnnotationResultEvent;
		
		[Inject]
		public var service:IFtdService;

		[Inject]
		public var model:DigitalLibraryModel;

		override public function execute():void
		{
			var ftdQo:FTD_qo = new FTD_qo();
			var frgQo:FTDFragment_qo= new FTDFragment_qo();
			frgQo.ftd = ftdQo;
			ftdQo.vpdmfId = String(model.lightFtd.vpdmfId);
			frgQo.frgType = String(model.frgType);
			
			dispatch( new ListFTDFragmentEvent(frgQo) );
			
		}
		
	}
	
}