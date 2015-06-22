package edu.isi.bmkeg.friesWorkbenchModule.controller.loadIndexCard
{	
	import edu.isi.bmkeg.bigMechIndexCards.rl.events.*;
	import edu.isi.bmkeg.bigMechIndexCards.rl.services.IBigMechIndexCardsService;
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;
	import edu.isi.bmkeg.ftd.model.qo.FTDFragment_qo;
	import edu.isi.bmkeg.ftd.model.FTDFragment;
	import edu.isi.bmkeg.ftd.rl.events.ListFTDFragmentEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class FindBigMechIndexCardByIdResultCommand extends Command
	{
		
		[Inject]
		public var event:FindBigMechIndexCardByIdResultEvent;
		
		[Inject]
		public var model:FriesWorkbenchModel;

		override public function execute():void
		{
			model.indexCard = event.object;
			
			var frgQo:FTDFragment_qo = new FTDFragment_qo();
			var qo:String = "";
			for each (var frg:FTDFragment in event.object.evidence) {
				if( qo.length > 0 ) 
					qo += "<vpdmf-or>";
				qo += frg.vpdmfId;
			}
			frgQo.vpdmfId = qo;
			
			this.dispatch( new ListFTDFragmentEvent(frgQo) );
			
		}
		
	}
	
}