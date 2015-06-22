package edu.isi.bmkeg.friesWorkbenchModule.view
{
	import com.adobe.serialization.json.JSON;
	
	import edu.isi.bmkeg.bigMechIndexCards.model.*;
	import edu.isi.bmkeg.bigMechIndexCards.rl.events.*;
	import edu.isi.bmkeg.friesWorkbenchModule.events.*;
	import edu.isi.bmkeg.friesWorkbenchModule.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.collections.HierarchicalData;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class IndexCardViewMediator extends Mediator
	{
		
		[Inject]
		public var view:IndexCardView;
		
		[Inject]
		public var model:FriesWorkbenchModel;

		override public function onRegister():void {
			
			addContextListener(FindBigMechIndexCardByIdResultEvent.FIND_BIGMECHINDEXCARDBY_ID_RESULT, 
				findBigMechIndexCardByIdResultHandler);

		}
		
		private function findBigMechIndexCardByIdResultHandler(event:FindBigMechIndexCardByIdResultEvent):void {
			
			loadCurrentSelection();
			
		}
		
		private function loadCurrentSelection():void {
			
			var a:BigMechIndexCard = model.indexCard;
			var o:Object = JSON.decode(a.json);
			
			view.card = this.buildTreeNodeRecursively(String(o['pmcid']), o);
			
			view.indexCardTree.validateNow();
			view.indexCardTree.expandChildrenOf(view.card,true);
			
		}
		
		private function buildTreeNodeRecursively(label:String, node:Object):Object {
				
			var o:Object = new Object();
			var children:ArrayCollection = new ArrayCollection();
 			
			if( node is String || node is Number || node is Boolean) {
				
				o['data'] = node;
				o['children'] = null;
				o['label'] = label;
				return o;
								
			} else if ( node is ArrayCollection ) {
				
				o['label'] = label;
				o['data'] = null;
				var a:ArrayCollection = node as ArrayCollection;
				var c:ArrayCollection = new ArrayCollection();
				for(var i:int=0; i<a.length; i++) {
					c.addItem(this.buildTreeNodeRecursively(i + "", a.getItemAt(i)));
				}	
				o['children'] = c;
				
			} else if ( node is Array) {
				
				o['label'] = label;
				o['data'] = null;
				var aa:Array = node as Array; 
				var cc:ArrayCollection = new ArrayCollection();
				for (var ii:int=0; ii<aa.length; ii++) {
					cc.addItem(this.buildTreeNodeRecursively(ii + "", aa[ii]));
				}	
				o['children'] = cc;
				
			} else if( node is Object ) {
				
				var attArray:Array = new Array();
				for( var att1:* in node ) {
					attArray.push(att1);
				}
				attArray.sort();
				
				var ccc:ArrayCollection = new ArrayCollection();
				o['label'] = label;
				for each( var att:String in attArray) {
					ccc.addItem(this.buildTreeNodeRecursively(att + "", node[att]));
				}	
				o['data'] = null;
				o['children'] = ccc;
				
			} 
			
			return o;
				
		}
			
	}

}