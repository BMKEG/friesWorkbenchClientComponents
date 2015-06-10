package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.ftd.model.FTD;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListArticleDocumentResultCommand extends Command
	{
		
		[Inject]
		public var event:ListArticleDocumentResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void
		{
			if( event.list.length > 1 ) {
				model.lightFtd = null;
				return;
				trace("Error in number of FTD objects returned");
			} else if (event.list.length == 0) {
				model.lightFtd = null;
				return;
			}
			
			var lvi:LightViewInstance = LightViewInstance(event.list.getItemAt(0));
			var o:Object = new Object();
			o.vpdmfLabel = lvi.vpdmfLabel;
			o.vpdmfId = lvi.vpdmfId;
			var fields:Array = lvi.indexTupleFields.split(/\{\|\}/);
			var tuple:Array = lvi.indexTuple.split(/\{\|\}/);
			
			for(var i:int=0; i<fields.length; i++) {
				var f:String = fields[i] as String;
				var v:String = tuple[i] as String;			
				if( v == null )
					v = "";
				v = v.replace(/,/,", ");
				o[f]=v;	
			}
			var lFtd:FTD = new FTD();
			lFtd.vpdmfId = lvi.vpdmfId;
			lFtd.vpdmfLabel = lvi.vpdmfLabel;
			lFtd.name = o['ArticleDocument_2'];
			lFtd.checksum = o['ArticleDocument_3'];
			model.lightFtd = lFtd;
			
			var ftdQo:FTD_qo = new FTD_qo();
			ftdQo.vpdmfId = String(model.lightFtd.vpdmfId);
			var frgQo:FTDFragment_qo = new FTDFragment_qo();
			frgQo.ftd = ftdQo;
			frgQo.frgType = String(model.frgType);

			this.dispatch( new ListFTDFragmentEvent( frgQo ) );
			
		}
		
	}
	
}