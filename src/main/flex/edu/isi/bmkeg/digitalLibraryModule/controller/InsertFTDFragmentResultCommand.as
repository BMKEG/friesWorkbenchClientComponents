package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.model.qo.FTDFragment_qo;
	import edu.isi.bmkeg.ftd.model.qo.FTD_qo;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class InsertFTDFragmentResultCommand extends Command
	{
	
		[Inject]
		public var event:InsertFTDFragmentResultEvent;

		[Inject]
		public var service:IFtdService;

		[Inject]
		public var model:DigitalLibraryModel;
				
		override public function execute():void
		{
			if( model.lightFtd == null ) {
				trace("Error, ftdVpdmfId not set");
				return;						
			}
			
			var ftdQo:FTD_qo = new FTD_qo();
			var frgQo:FTDFragment_qo= new FTDFragment_qo();
			frgQo.ftd = ftdQo;
			ftdQo.vpdmfId = String(model.lightFtd.vpdmfId);
			frgQo.frgType = String(model.frgType);
			
			service.listFTDFragment(frgQo);
		
		}
		
	}
	
}