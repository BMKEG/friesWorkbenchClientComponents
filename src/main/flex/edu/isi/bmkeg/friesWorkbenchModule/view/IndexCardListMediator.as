package edu.isi.bmkeg.friesWorkbenchModule.view
{
	
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.bigMechIndexCards.model.*;
	import edu.isi.bmkeg.bigMechIndexCards.model.qo.*;
	import edu.isi.bmkeg.bigMechIndexCards.rl.events.*;
	import edu.isi.bmkeg.friesWorkbench.events.*;
	import edu.isi.bmkeg.friesWorkbenchModule.events.*;
	import edu.isi.bmkeg.friesWorkbenchModule.model.*;
	
	import mx.core.ClassFactory;
	
	import org.robotlegs.mvcs.Mediator;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	import spark.events.GridEvent;
	
	import flash.external.ExternalInterface;
	
	public class IndexCardListMediator extends Mediator
	{
		[Inject]
		public var view:IndexCardList;
				
		[Inject]
		public var model:FriesWorkbenchModel;
		
		private var itemRendererClassFactory:ClassFactory;

		private var forward:Boolean = true;
		
		override public function onRegister():void
		{
						
			addViewListener(FindBigMechIndexCardByIdEvent.FIND_BIGMECHINDEXCARD_BY_ID, 
				dispatch);
			
			addViewListener(SwitchInOutEvent.SWITCH, 
				switchInOutCodes);

			addContextListener(ListIndexCardsByArticleIdResultEvent.LIST_INDEX_CARDS_BY_ARTICLE_PAGED_RESULT, 
				listIndexCardsHandler);

			view.indexCards = model.indexCards;
			
			// if we have already selected an article as a cookie... 
			// set the articleId, we'll now go and select that.
			if (ExternalInterface.available) {
				var articleIdCookie:String = ExternalInterface.call("getCookie", "articleCitationId");
				if( articleIdCookie != null && articleIdCookie.length != 0) {
					var articleId:Number = Number(articleIdCookie);
					dispatch( new FindArticleCitationByIdEvent( articleId ) );
				}
			}	

			
		}
		
		/** 
		 * Capture the click of the sort function.
		 */ 
		private function cycleSortStateListener( event:GridEvent ): void {
	
			var ts:BigMechIndexCard_qo = new BigMechIndexCard_qo();
			var tc:FTDFragment_qo = new FTDFragment_qo();			
			
/*			ts.evidence.addItem( ts );
			tc.vpdmfId = String(model.triageCorpus.vpdmfId);
			
			if( event.columnIndex == 0 ) {

				var lcQo:ArticleCitation_qo = new ArticleCitation_qo();
				ts.citation = lcQo;
				lcQo.pmid = "<vpdmf-sort-0>"
				
				model.queryCorpusCount = model.corpora.length;	

			} else if( event.columnIndex == 1 ) {

				var lcQo2:ArticleCitation_qo = new ArticleCitation_qo();
				ts.citation = lcQo2;
				lcQo2.vpdmfLabel = "<vpdmf-sort-0>"

				model.queryCorpusCount = model.corpora.length;	

			} else {
					
				var sortCorpus:String = event.column.headerText;
				var c:Corpus_qo = new Corpus_qo();			
				ts.targetCorpus = c;
				c.name = sortCorpus;
				
				if( this.forward ) {
					ts.inOutCode = "<vpdmf-sort-0>";
					this.forward = false;
				} else {
					ts.inOutCode = "<vpdmf-rev-sort-0>";
					this.forward = true;
				}
				
				ts.inScore = "<vpdmf-rev-sort-1>";
						
				model.queryCorpusCount = 1;	

			}

			this.dispatch(new ListBigMechIndexCardPagedEvent(
				ts, 0, model.listPageSize));*/

			
		}
		
		private function triageScoreDataTip(item:Object, column:GridColumn):String 
		{
			var columnName:String = column.headerText;
			var inOut:String = item[columnName + ".inOut"];
			var score:String = item[columnName + ".score"];
			return inOut + " (" + score + ")";
		}
		
		// This function provides the means of dynamically generating item renderers
		// in the flex control.
		private function get makeInOutPullDownItemRenderer():ClassFactory
		{
			if (itemRendererClassFactory == null)
			{
				itemRendererClassFactory = new ClassFactory();
				itemRendererClassFactory.generator = IndexCardList__InOutCodeItemRenderer;
			}
			return itemRendererClassFactory;
		}

		private function triageDocumentsListUpdatedHandler(event:PagedListUpdatedEvent):void
		{
			if( event.listId != view.id )
				return;
			
			view.indexCards = model.indexCards;
			
		}

		
		private function switchInOutCodes(event:SwitchInOutEvent):void {
			
			var td:BigMechIndexCard = BigMechIndexCard(model.indexCards.getItemAt(0));
			td.code = event.code;
			
			dispatch( new UpdateBigMechIndexCardEvent(td) ); 
			
		}

		private function listIndexCardsHandler(event:ListIndexCardsByArticleIdResultEvent):void {
			
			view.indexCards = model.indexCards;	
		
		}
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		/*public function clearTriageCorpusHandler(event:ClearTriageCorpusEvent):void {
			
			view.triageDocumentsList = listModel.pagedList;
			
		}*/
		
	}
	
}