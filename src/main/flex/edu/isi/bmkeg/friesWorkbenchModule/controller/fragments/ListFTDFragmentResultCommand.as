package edu.isi.bmkeg.friesWorkbenchModule.controller.fragments
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	
	import edu.isi.bmkeg.friesWorkbenchModule.model.FriesWorkbenchModel;
	
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ListFTDFragmentResultCommand extends Command
	{
	
		[Inject]
		public var event:ListFTDFragmentResultEvent;

		[Inject]
		public var model:FriesWorkbenchModel;
				
		override public function execute():void
		{
			model.fragments = new ArrayCollection();
			
			for each(var lvi:LightViewInstance in event.list) {
			
				var o:Object = lvi.convertToIndexTupleObject();
				
				var frg:FTDFragment = new FTDFragment();			
				frg.ftd = model.lightFtd;
				
				frg.vpdmfId = lvi.vpdmfId;
				frg.frgOrder = o['FTDFragment_2'];
				
				frg.frgType = o['FTDFragment_13'];
				
				var textArray:Array = o['FTDFragment_3'].toString().split("<|>");
				var x1Array:Array = o['FTDFragment_4'].toString().split("<|>");
				var y1Array:Array = o['FTDFragment_5'].toString().split("<|>");
				var x2Array:Array = o['FTDFragment_6'].toString().split("<|>");
				var y2Array:Array = o['FTDFragment_7'].toString().split("<|>");
				var x3Array:Array = o['FTDFragment_8'].toString().split("<|>");
				var y3Array:Array = o['FTDFragment_9'].toString().split("<|>");
				var x4Array:Array = o['FTDFragment_10'].toString().split("<|>");
				var y4Array:Array = o['FTDFragment_11'].toString().split("<|>");
				var pArray:Array = o['FTDFragment_12'].toString().split("<|>");
				
				var codeArray:Array = null;
				if( o['FTDFragment_14'] != null ) {
					codeArray = o['FTDFragment_14'].toString().split("<|>");
				}
					
				for(var i:int=0; i<textArray.length; i++) {
					var data:String = frg.frgOrder + "." + i;
					
					var ftdAnn:FTDFragmentBlock = new FTDFragmentBlock();
					frg.annotations.addItem(ftdAnn);
					ftdAnn.fragment = frg;
					
					ftdAnn.text = textArray[i];
					ftdAnn.p = pArray[i];
					ftdAnn.x1 = x1Array[i];
					ftdAnn.y1 = y1Array[i];
					ftdAnn.x2 = x2Array[i];
					ftdAnn.y2 = y2Array[i];
					ftdAnn.x3 = x3Array[i];
					ftdAnn.y3 = y3Array[i];
					ftdAnn.x4 = x4Array[i];
					ftdAnn.y4 = y4Array[i];
										
					if( codeArray[i] != null && codeArray[i] != "null" ) {
						ftdAnn.code = codeArray[i];
					} else {
						ftdAnn.code = "-";
					}
						
				}	
								
				model.fragments.addItem(frg);
				
			}
								
		}
		
	}
	
}