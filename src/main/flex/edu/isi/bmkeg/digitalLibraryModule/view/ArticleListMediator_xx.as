package edu.isi.bmkeg.digitalLibraryModule.view
{
	
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.FindArticleCitationByIdEvent;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.digitalLibraryModule.view.forms.*;
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.external.ExternalInterface;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ArticleListMediator_xx extends Mediator
	{
		[Inject]
		public var view:ArticleList;
		
		[Inject]
		public var listModel:DigitalLibraryPagedListModel;

		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function onRegister():void
		{
			
			addContextListener(PagedListUpdatedEvent.UPDATED + DigitalLibraryPagedListModel.LIST_ID, 
				targetDocumentsListUpdatedHandler);
						
			//
			// SelectCorpus is an intermediate event thrown by the CorpusListPopup view.	
			//
			addContextListener(SelectCorpus.SELECT_CORPUS, 
				addArticlesToCorpus);

			addViewListener(RemoveArticleCitationFromCorpusEvent.REMOVE_ARTICLE_CITATION_FROM_CORPUS, 
				handleRemoveArticlesFromCorpus);

			addViewListener(FullyDeleteArticleEvent.FULLY_DELETE_ARTICLE, 
				dispatch);
			
			addViewListener(FindArticleCitationByIdEvent.FIND_ARTICLECITATION_BY_ID, 
				dispatch);

			addViewListener(UploadPdfFileEvent.UPLOAD_PDF_FILE, uploadPdfFileEventHandler);

			addViewListener(ActivateCorpusListPopupEvent.ACTIVATE_CORPUS_LIST_POPUP, 
				activateCorpusListPopup);
			
			addViewListener(ActivateUploadPdfPopupEvent.ACTIVATE_PDF_UPLOAD_POPUP, 
				activatePdfUploadPopup);

			addViewListener(ActivateArticleQueryPopupEvent.ACTIVATE_ARTICLE_QUERY_POPUP, 
				activateArticleQueryPopup);
			
			addContextListener(ListArticleCitationPagedResultEvent.LIST_ARTICLECITATION_PAGED_RESULT, 
				selectArticleFromCookie);
			
			listModel.pageSize = model.listPageSize;

			var qo:ArticleCitation_qo = new ArticleCitation_qo();
			var event:ListArticleCitationPagedEvent = new ListArticleCitationPagedEvent(qo,0,200);
			this.dispatch( event );
			
		}
		
		private function selectArticleFromCookie(
				event:ListArticleCitationPagedResultEvent):void {
			
			// if we have already selected an article as a cookie... 
			// set the articleId, we'll now go and select that.
			if (ExternalInterface.available) {
				var articleIdCookie:String = ExternalInterface.call("getCookie", "articleCitationId");
				if( articleIdCookie != null && articleIdCookie.length != 0) {
					var articleId:Number = Number(articleIdCookie);
					dispatch( new FindArticleCitationByIdEvent( articleId ) );
					for( var i:int=0; i<listModel.pagedListLength; i++) {
						var a:Object = listModel.pagedList.getItemAt( i );
						if( a.vpdmfId == articleId ) {
							view.targetDocumentListDataGrid.setSelectedIndex(i);
							break;
						}
					}
					
				}
			}	
			
		}
		
		private function targetDocumentsListUpdatedHandler(event:PagedListUpdatedEvent):void
		{
			
			view.documentsList = listModel.pagedList;
			view.listLength = listModel.pagedListLength;
			
		}
		
		private function uploadPdfFileEventHandler(event:UploadPdfFileEvent):void
		{
			
			if( model.corpus != null ) {
				event.corpusName = model.corpus.name;
			}
			dispatch(event);
			
		}
		
		private function activateCorpusListPopup(e:ActivateCorpusListPopupEvent):void {
			
			var popup:CorpusListPopup = PopUpManager.createPopUp(this.view, CorpusListPopup, true) 
				as CorpusListPopup;
			PopUpManager.centerPopUp(popup);
			
			mediatorMap.createMediator( popup );
					
		}
		
		private function addArticlesToCorpus(event:SelectCorpus):void 
		{

			var selectedArticles:Vector.<Object> = view.targetDocumentListDataGrid.selectedItems;
			
			if( selectedArticles.length == 0 ) {
				return;
			}
			
			var ids:ArrayCollection = new ArrayCollection();
			for each( var a:Object in selectedArticles) {
				var n:Number = new Number(a.vpdmfId);
				ids.addItem( n );
			}

			dispatch(new AddArticleCitationToCorpusEvent(ids, event.corpusId));
			
		}
		
		private function handleRemoveArticlesFromCorpus(event:RemoveArticleCitationFromCorpusEvent):void 
		{
			
			var selectedArticles:Vector.<Object> = view.targetDocumentListDataGrid.selectedItems;
			
			if( selectedArticles == null || selectedArticles.length == 0 ) {
				return;
			}
			
			var ids:ArrayCollection = new ArrayCollection();
			for each( var a:Object in selectedArticles) {
				var n:Number = new Number(a.vpdmfId);
				ids.addItem( n );
			}
			
			event.articleIds = ids;
			event.corpusId = model.corpus.vpdmfId;
			
			dispatch( event );
			
		}
		
		private function activatePdfUploadPopup(e:ActivateUploadPdfPopupEvent):void {
			
			var popup:UploadPdfsPopup = PopUpManager.createPopUp(this.view, UploadPdfsPopup, true) as UploadPdfsPopup;
			PopUpManager.centerPopUp(popup);
			
			mediatorMap.createMediator( popup );
			
			popup.tc = model.corpus;

			if( model.corpus != null) 
				popup.currentState = "corpusSpecified";
				
		}
		
		private function activateArticleQueryPopup(e:ActivateArticleQueryPopupEvent):void {
			
			var popup:ArticleQueryPopup = PopUpManager.createPopUp(this.view, ArticleQueryPopup, true) as ArticleQueryPopup;

			if( model.corpus != null ) {
				popup.corpusControl.text = model.corpus.name;
			}
			
			if( model.queryLiteratureCitation != null ) {
			
				popup.pageControl.text = model.queryLiteratureCitation.pages;
				popup.pmcidControl.text = model.queryLiteratureCitation.pmcid;
				popup.pmidControl.text = model.queryLiteratureCitation.pmid;
				popup.titleControl.text = model.queryLiteratureCitation.title;
				popup.volumeControl.text = model.queryLiteratureCitation.volume;
				popup.yearControl.text = model.queryLiteratureCitation.pubYear;
			
				if( model.queryLiteratureCitation.journal != null) {
					popup.journalControl.text = model.queryLiteratureCitation.journal.abbr;
				}
			
				var auStr:String = "";
				if( model.queryLiteratureCitation.authorList.length > 0 ) {
					for each( var au:Author_qo in model.queryLiteratureCitation.authorList ) {
						auStr += au.surname + ", "
					}
					auStr = auStr.substr(0, auStr.length -2 );
				}
				popup.authorsControl.text = auStr;	

			}			
			
			PopUpManager.centerPopUp(popup);
			
			mediatorMap.createMediator( popup );
			
		}
	}
	
}