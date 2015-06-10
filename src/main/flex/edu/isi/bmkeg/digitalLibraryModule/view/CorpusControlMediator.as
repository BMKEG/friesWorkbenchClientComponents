package edu.isi.bmkeg.digitalLibraryModule.view
{
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.digitalLibraryModule.view.forms.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.external.ExternalInterface;
	
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CorpusControlMediator extends Mediator
	{
		[Inject]
		public var view:CorpusControl;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function onRegister():void
		{
									
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// list the corpora. 
			addContextListener(ListArticleCorpusResultEvent.LIST_ARTICLECORPUS_RESULT, 
				listCorpusResultHandler);
			
			addContextListener(FindCorpusByIdResultEvent.FIND_CORPUSBY_ID_RESULT, 
				handleLoadedTargetCorpus);
			
			addViewListener(ListArticleCorpusEvent.LIST_ARTICLECORPUS, 
				dispatch);
			
			addViewListener(FindArticleCorpusByIdEvent.FIND_ARTICLECORPUS_BY_ID, 
				dispatchFindCorpusById);
			
			addViewListener(ActivateCorpusPopupEvent.ACTIVATE_CORPUS_POPUP, 
				activateCorpusPopup);

			addViewListener(ListArticleCitationPagedEvent.LIST_ARTICLECITATION_PAGED, 
				dispatch);

			addViewListener(DeleteCorpusByIdEvent.DELETE_CORPUS_BY_ID, 
				dispatch);
			
			addViewListener(DownloadCorpusZipEvent.DOWNLOAD_CORPUS_ZIP, 
				dispatch);

			addContextListener(ListArticleCorpusResultEvent.LIST_ARTICLECORPUS_RESULT, 
				selectCorpusFromCookie);
			
			addContextListener(SelectCorpus.SELECT_CORPUS, 
				selectCorpus);

			addContextListener(
				AddArticleCitationToCorpusResultEvent.ADD_ARTICLE_CITATION_TO_CORPUS_RESULT, 
				addArticleCitationToCorpusResult);

			addContextListener(
				RemoveArticleCitationFromCorpusResultEvent.REMOVE_ARTICLE_CITATION_FROM_CORPUS_RESULT, 
				removeArticleCitationFromCorpusResult);

			addContextListener(FullyDeleteArticleResultEvent.FULLY_DELETE_ARTICLE_RESULT, 
				fullyDeleteArticleResult);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// On loading this control, we first list all the corpora on the server
			dispatch(new ListArticleCorpusEvent(new Corpus_qo()));
						
		}

		public function listCorpusResultHandler(event:ListArticleCorpusResultEvent):void {
			view.corpusList = model.corpora;
			view.corpusCombo.selectedIndex = 0;
		}
		
		public function dispatchFindCorpusById(event:FindArticleCorpusByIdEvent):void {
			
			model.corpus = new Corpus();
			model.corpus.vpdmfId = event.id;

			var ac:ArticleCitation_qo = new ArticleCitation_qo();
			var c:Corpus_qo = new Corpus_qo();			
			ac.corpora.addItem(c);
			
			c.vpdmfId = String(model.corpus.vpdmfId);
				
			this.dispatch(new ListArticleCitationPagedEvent(
				ac, 0, model.listPageSize));
			
			this.dispatch( event );
			
		}
		
		private function activateCorpusPopup(e:ActivateCorpusPopupEvent):void {

			var popup:CorpusPopup = PopUpManager.createPopUp(this.view, CorpusPopup, true) as CorpusPopup;
			PopUpManager.centerPopUp(popup);

			mediatorMap.createMediator( popup );

			if( e.corpus == null || e.corpus.name == null )			
				popup.cName = "<Name>";
			else 
				popup.cName = e.corpus.name;
				
			if( e.corpus == null || e.corpus.description == null )			
				popup.desc = "<Description>";
			else 
				popup.desc = e.corpus.description;
			
			if( e.corpus == null || e.corpus.regex == null )			
				popup.regexCode = "<Regex Code>";
			else 
				popup.regexCode = e.corpus.regex;
				
			popup.vpdmfId = e.corpus.vpdmfId;
			
		}
		
		private function handleLoadedTargetCorpus(event:FindCorpusByIdResultEvent):void {

			this.view.corpus = event.object;
	
			this.reloadArticleList();

		}

		private function selectCorpusFromCookie(event:ListArticleCorpusResultEvent):void {
			
			// if we have already selected a corpus as a cookie... 
			// set the model corpus appropriately we'll now go and select that.
			if (ExternalInterface.available) {
				var corpusIdCookie:String = ExternalInterface.call("getCookie", "corpusCitationId");
				if( corpusIdCookie != null && corpusIdCookie.length != 0) {
					
					this.selectCorpus( new SelectCorpus(Number(corpusIdCookie)) );
					
					dispatch( new FindArticleCorpusByIdEvent( Number(corpusIdCookie) ) );
					
					var ac:ArticleCitation_qo = new ArticleCitation_qo();
					var c:Corpus_qo = new Corpus_qo();			
					ac.corpora.addItem(c);
					c.vpdmfId = String( Number(corpusIdCookie) );
					dispatch(new ListArticleCitationPagedEvent(ac, 
						0, model.listPageSize));
					
				}
			}	
			
		}
		
		private function selectCorpus(event:SelectCorpus):void {
			for each( var c:Object in model.corpora ) {
				if( c.vpdmfId == event.corpusId ) {
					view.corpusCombo.selectedItem = c;
					break;
				}
			}
		}

		private function addArticleCitationToCorpusResult(
			event:AddArticleCitationToCorpusResultEvent):void {
			
			this.reloadArticleList();
			
		}
		
		private function removeArticleCitationFromCorpusResult(
			event:RemoveArticleCitationFromCorpusResultEvent):void {
				
			this.reloadArticleList();
				
		}

		private function fullyDeleteArticleResult(
			event:FullyDeleteArticleResultEvent):void {
			
			this.reloadArticleList();
			
		}
		
		// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		// Reset everything
		//
		public function clearCorpusHandler(event:ClearCorpusEvent):void {

			view.currentState = "empty";
			view.corpusCombo.selectedIndex = -1;
			dispatch(new ListArticleCorpusEvent(new Corpus_qo()));
			
		}
		
		private function reloadArticleList():void {
			
			var acQ:ArticleCitation_qo = new ArticleCitation_qo();
			
			if( model.corpus != null ) {
				var corpQ:Corpus_qo = new Corpus_qo();
				acQ.corpora.addItem(corpQ);
				
				corpQ.name = model.corpus.name;
				corpQ.vpdmfId = model.corpus.vpdmfId + "";
			}
			
			this.dispatch( new ListArticleCitationPagedEvent(acQ, 0, 300) );		
		}

		
	}
	
}