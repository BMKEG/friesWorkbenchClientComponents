package edu.isi.bmkeg.digitalLibrary.services.impl
{

	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.ArticleCitation_qo;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListArticleCitationPagedResultEvent;
	import edu.isi.bmkeg.digitalLibrary.services.*;
	import edu.isi.bmkeg.digitalLibrary.services.serverInteraction.*;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.utils.*;
	import edu.isi.bmkeg.utils.dao.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.*;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.libspark.utils.ForcibleLoader;
	import org.robotlegs.mvcs.Actor; 
	
	public class ExtendedDigitalLibraryServiceImpl extends Actor implements IExtendedDigitalLibraryService {

		private var _server:IExtendedDigitalLibraryServer;

		private var ldr:Loader;
		private var clip:MovieClip;
		
		[Inject]
		public function get server():IExtendedDigitalLibraryServer

		{
			return _server;
		}

		public function set server(s:IExtendedDigitalLibraryServer):void
		{
			_server = s;
			initServer();
		}

		private function initServer():void
		{
			if (_server is AbstractService)
			{
				AbstractService(_server).addEventListener(FaultEvent.FAULT,faultHandler);
			}
		}

		private function asyncResponderFailHandler(fail:Object, token:Object):void
		{
			dispatch(fail as FaultEvent);
		}

		private function faultHandler(event:FaultEvent):void
		{
			dispatch(event);
		}

		// ~~~~~~~~~
		// functions
		// ~~~~~~~~~

		public function addPmidEncodedPdfToCorpus(pdfFileData:Object, fileName:String, corpusName:String=null):void {
			server.addPmidEncodedPdfToCorpus.cancel();
			server.addPmidEncodedPdfToCorpus.addEventListener(ResultEvent.RESULT, addPmidEncodedPdfToCorpusResultHandler);
			server.addPmidEncodedPdfToCorpus.addEventListener(FaultEvent.FAULT, addPmidEncodedPdfToCorpusFaultHandler);
			server.addPmidEncodedPdfToCorpus.send(pdfFileData, fileName, corpusName);
		}

		private function addPmidEncodedPdfToCorpusFaultHandler(event:FaultEvent):void
		{
			dispatch(new UploadPdfFileFaultEvent(event));
		}

		
		private function addPmidEncodedPdfToCorpusResultHandler(event:ResultEvent):void
		{
			var ac:ArticleCitation = ArticleCitation(event.result);
			dispatch(new UploadPdfFileResultEvent(ac));
		}

		// ~~~~~~~~~
		
		public function removeFragmentBlock(frgBlk:FTDFragmentBlock):void {
			server.removeFragmentBlock.cancel();
			server.removeFragmentBlock.addEventListener(ResultEvent.RESULT, removeFragmentBlockResultHandler);
			server.removeFragmentBlock.addEventListener(FaultEvent.FAULT, faultHandler);
			server.removeFragmentBlock.send(frgBlk);			
		}
		
		private function removeFragmentBlockResultHandler(event:ResultEvent):void
		{
			var completed:Boolean = Boolean(event.result);
			dispatch(new RemoveAnnotationResultEvent(completed));
		}

		// ~~~~~~~~~

		public function listTermViews():void 
		{
			server.listTermViews.cancel();
			server.listTermViews.addEventListener(ResultEvent.RESULT, listTermViewsResultHandler);
			server.listTermViews.addEventListener(FaultEvent.FAULT, faultHandler);
			server.listTermViews.send();				
		}
		
		private function listTermViewsResultHandler(event:ResultEvent):void
		{
			var termList:ArrayCollection = ArrayCollection(event.result);
			dispatch(new ListTermViewsResultEvent(termList));
		}
		
		// ~~~~~~~~~

		public function addArticlesToCorpus(articleIds:ArrayCollection, corpusId:Number):void {
			server.addArticlesToCorpus.cancel();
			server.addArticlesToCorpus.addEventListener(ResultEvent.RESULT, addArticlesToCorpusResultHandler);
			server.addArticlesToCorpus.addEventListener(FaultEvent.FAULT, faultHandler);
			server.addArticlesToCorpus.send(articleIds, corpusId);				
		}
		
		private function addArticlesToCorpusResultHandler(event:ResultEvent):void
		{
			var count:Number = Number(event.result);
			dispatch(new AddArticleCitationToCorpusResultEvent(count));
		}

		// ~~~~~~~~~

		public function removeArticlesFromCorpus(articleIds:ArrayCollection, corpusId:Number):void {
			server.removeArticlesFromCorpus.cancel();
			server.removeArticlesFromCorpus.addEventListener(ResultEvent.RESULT, removeArticlesFromCorpusResultHandler);
			server.removeArticlesFromCorpus.addEventListener(FaultEvent.FAULT, faultHandler);
			server.removeArticlesFromCorpus.send(articleIds, corpusId);				
		}
		
		private function removeArticlesFromCorpusResultHandler(event:ResultEvent):void
		{
			var count:Number = Number(event.result);
			dispatch(new RemoveArticleCitationFromCorpusResultEvent(count));
		}

		// ~~~~~~~~~

		public function fullyDeleteArticle(articleId:Number):void {
			server.fullyDeleteArticle.cancel();
			server.fullyDeleteArticle.addEventListener(ResultEvent.RESULT, fullyDeleteArticleResultHandler);
			server.fullyDeleteArticle.addEventListener(FaultEvent.FAULT, faultHandler);
			server.fullyDeleteArticle.send(articleId);				
		}
		
		private function fullyDeleteArticleResultHandler(event:ResultEvent):void
		{
			var success:Boolean = Boolean(event.result);
			dispatch(new FullyDeleteArticleResultEvent(success));
		}

		// ~~~~~~~~~

		public function listExtendedJournalEpochs():void {
			server.listExtendedJournalEpochs.cancel();
			server.listExtendedJournalEpochs.addEventListener(ResultEvent.RESULT, listExtendedJournalEpochsResultHandler);
			server.listExtendedJournalEpochs.addEventListener(FaultEvent.FAULT, faultHandler);
			server.listExtendedJournalEpochs.send();				
		}
		
		private function listExtendedJournalEpochsResultHandler(event:ResultEvent):void
		{
			var epochList:ArrayCollection = ArrayCollection(event.result);
			dispatch(new ListExtendedJournalEpochsResultEvent(epochList));
		}
		
		// ~~~~~~~~~
		
		public function addRuleFileToJournalEpoch(ruleFileId:Number, 
												  epochId:Number,
												  epochJournal:String,
												  epochStart:Number,
												  epochEnd:Number):void {
			server.addRuleFileToJournalEpoch.cancel();
			server.addRuleFileToJournalEpoch.addEventListener(ResultEvent.RESULT, addRuleFileToJournalEpochResultHandler);
			server.addRuleFileToJournalEpoch.addEventListener(FaultEvent.FAULT, faultHandler);
			server.addRuleFileToJournalEpoch.send(ruleFileId, epochId, 
				epochJournal, epochStart, epochEnd);				
		}
		
		private function addRuleFileToJournalEpochResultHandler(event:ResultEvent):void
		{
			var id:Number = Number(event.result);
			dispatch(new AddRuleFileToJournalEpochResultEvent(id));
		}
		
		// ~~~~~~~~~
		
		public function retrieveFTDRuleSetForArticleCitation(articleId:Number):void {
			server.retrieveFTDRuleSetForArticleCitation.cancel();
			server.retrieveFTDRuleSetForArticleCitation.addEventListener(ResultEvent.RESULT, retrieveFTDRuleSetForArticleCitationHandler);
			server.retrieveFTDRuleSetForArticleCitation.addEventListener(FaultEvent.FAULT, faultHandler);
			server.retrieveFTDRuleSetForArticleCitation.send(articleId);				
		}
		
		private function retrieveFTDRuleSetForArticleCitationHandler(event:ResultEvent):void
		{
			var ruleSet:FTDRuleSet = FTDRuleSet(event.result);
			dispatch(new RetrieveFTDRuleSetForArticleCitationResultEvent(ruleSet));
		}

		// ~~~~~~~~~
		
		public function runRuleSetOnArticleCitation(ruleSetId:Number, articleId:Number):void {
			server.runRuleSetOnArticleCitation.cancel();
			server.runRuleSetOnArticleCitation.addEventListener(ResultEvent.RESULT, runRuleSetOnArticleCitationHandler);
			server.runRuleSetOnArticleCitation.addEventListener(FaultEvent.FAULT, faultHandler);
			server.runRuleSetOnArticleCitation.send(ruleSetId, articleId);				
		}
		
		private function runRuleSetOnArticleCitationHandler(event:ResultEvent):void
		{
			var articleId:Number = Number(event.result);
			dispatch(new RunRuleSetOnArticleCitationResultEvent(articleId));
		}
		
		// ~~~~~~~~~
		
		public function runRuleSetOnJournalEpoch(epochId:Number):void {
			server.runRuleSetOnJournalEpoch.cancel();
			server.runRuleSetOnJournalEpoch.addEventListener(ResultEvent.RESULT, runRuleSetOnJournalEpochResultHandler);
			server.runRuleSetOnJournalEpoch.addEventListener(FaultEvent.FAULT, faultHandler);
			server.runRuleSetOnJournalEpoch.send(epochId);				
		}
		
		private function runRuleSetOnJournalEpochResultHandler(event:ResultEvent):void
		{
			var epochId:Number = Number(event.result);
			dispatch(new RunRuleSetOnJournalEpochResultEvent(epochId));
		}
		
		// ~~~~~~~~~
		
		public function generateRuleFileFromLapdf(articleId:Number):void {
			server.generateRuleFileFromLapdf.cancel();
			server.generateRuleFileFromLapdf.addEventListener(ResultEvent.RESULT, generateRuleFileFromLapdfHandler);
			server.generateRuleFileFromLapdf.addEventListener(FaultEvent.FAULT, faultHandler);
			server.generateRuleFileFromLapdf.send(articleId);				
		}
		
		private function generateRuleFileFromLapdfHandler(event:ResultEvent):void
		{
			var csvText:String = String(event.result);
			dispatch(new GenerateRuleFileFromLapdfResultEvent(csvText));
		}
		
		// ~~~~~~~~~
		
		public function runRulesOverAllEpochs():void {
			server.runRulesOverAllEpochs.cancel();
			server.runRulesOverAllEpochs.addEventListener(ResultEvent.RESULT, runRulesOverAllEpochsHandler);
			server.runRulesOverAllEpochs.addEventListener(FaultEvent.FAULT, faultHandler);
			server.runRulesOverAllEpochs.send();				
		}
		
		private function runRulesOverAllEpochsHandler(event:ResultEvent):void
		{
			dispatch(new RunRulesOverAllEpochsResultEvent());
		}
			
		// ~~~~~~~~~
		
		public function loadSwf(vpdmfId:Number):void {
			server.loadSwf.cancel();
			server.loadSwf.addEventListener(ResultEvent.RESULT, loadSwfHandler);
			server.loadSwf.addEventListener(FaultEvent.FAULT, faultHandler);
			server.loadSwf.send(vpdmfId);				
		}
		
		private function loadSwfHandler(event:ResultEvent):void
		{
			var swfBytes:ByteArray = ByteArray(event.result);

			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, initializationComplete);
			var fldr:ForcibleLoader = new ForcibleLoader(ldr);
			
			fldr.loadBytes(swfBytes);
		
		}			
		
		private function initializationComplete(event:Event):void {
			
			var clip:MovieClip = event.target.content as MovieClip;
			
			dispatch(new LoadSwfResultEvent(clip));
			
		}
		
		// ~~~~~~~~~
		
		public function loadXml(vpdmfId:Number):void {
			server.loadXml.cancel();
			server.loadXml.addEventListener(ResultEvent.RESULT, loadXmlHandler);
			server.loadXml.addEventListener(FaultEvent.FAULT, faultHandler);
			server.loadXml.send(vpdmfId);				
		}
		
		private function loadXmlHandler(event:ResultEvent):void
		{
			var xml:String = String(event.result);
			
			dispatch(new LoadXmlResultEvent(xml));
			
		}		
		
		// ~~~~~~~~~
		
		public function loadPmcXml(vpdmfId:Number):void {
			server.loadPmcXml.cancel();
			server.loadPmcXml.addEventListener(ResultEvent.RESULT, loadPmcXmlHandler);
			server.loadPmcXml.addEventListener(FaultEvent.FAULT, faultHandler);
			server.loadPmcXml.send(vpdmfId);				
		}
		
		private function loadPmcXmlHandler(event:ResultEvent):void
		{
			var xml:String = String(event.result);
			
			dispatch(new LoadPmcXmlResultEvent(xml));
			
		}		
		
		// ~~~~~~~~~
		
		public function loadHtml(vpdmfId:Number):void {
			server.loadHtml.cancel();
			server.loadHtml.addEventListener(ResultEvent.RESULT, loadHtmlHandler);
			server.loadHtml.addEventListener(FaultEvent.FAULT, faultHandler);
			server.loadHtml.send(vpdmfId);				
		}
		
		private function loadHtmlHandler(event:ResultEvent):void
		{
			var html:String = String(event.result);
			
			dispatch(new LoadHtmlResultEvent(html));
			
		}		

		// ~~~~~~~~~
		
		public function listArticleCitationPaged(object:ArticleCitation_qo, offset:int, cnt:int):void {
			server.listArticleCitationPaged.cancel();
			var token:AsyncToken = server.listArticleCitationPaged.send(object, offset, cnt);
			var synRes:AsyncResponder = new AsyncResponder(
				listArticleCitationPagedResultHandler,
				asyncResponderFailHandler,
				{offset:offset});
			token.addResponder(synRes);
		}
		
		private function listArticleCitationPagedResultHandler(event:ResultEvent, token:Object):void
		{
			var list:ArrayCollection = event.result as ArrayCollection;
			var offset:int = int(token.offset);
			dispatch(new ListArticleCitationPagedResultEvent(list, offset));
		}

		// ~~~~~~~~~
		
		public function dumpFragmentsToBrat(ftdId:Number):void  {
			server.dumpFragmentsToBrat.cancel();
			server.dumpFragmentsToBrat.addEventListener(FaultEvent.FAULT, faultHandler);
			server.dumpFragmentsToBrat.addEventListener(ResultEvent.RESULT, dumpFragmentsToBratHandler);
			server.dumpFragmentsToBrat.send(ftdId);				
		}

		private function dumpFragmentsToBratHandler(event:ResultEvent):void
		{						
			var url:URLRequest = new URLRequest(event.result as String);
			navigateToURL(url,"_blank");			
		}

		// ~~~~~~~~~
		
		public function retrieveFragmentTree(acId:Number):void  {
			server.retrieveFragmentTree.cancel();
			server.retrieveFragmentTree.addEventListener(FaultEvent.FAULT, faultHandler);
			server.retrieveFragmentTree.addEventListener(ResultEvent.RESULT, retrieveFragmentTreeHandler);
			server.retrieveFragmentTree.send(acId);				
		}
		
		private function retrieveFragmentTreeHandler(event:ResultEvent):void
		{
			var tree:XML = event.result as XML;
			dispatch(new RetrieveFragmentTreeResultEvent(tree));
		}
		
		// ~~~~~~~~~
		
		public function packageCorpusArchive(corpusId:Number):void {
			server.packageCorpusArchive.cancel();
			server.packageCorpusArchive.addEventListener(FaultEvent.FAULT, faultHandler);
			server.packageCorpusArchive.addEventListener(ResultEvent.RESULT, packageCorpusArchiveHandler);
			server.packageCorpusArchive.send(corpusId);				
		}
		
		private function packageCorpusArchiveHandler(event:ResultEvent):void
		{
			var zipFile:ByteArray = event.result as ByteArray;
			
			if( zipFile != null ) {
				var saveFile:FileReference = new FileReference();
				saveFile.addEventListener(Event.OPEN, saveBeginHandler);
				saveFile.addEventListener(Event.COMPLETE, saveCompleteHandler);
				saveFile.addEventListener(IOErrorEvent.IO_ERROR, saveIOErrorHandler);
				saveFile.save(zipFile);
			}
			
		}

		private function saveBeginHandler(event:Event):void
		{
			/* IT'D BE NICE TO HAVE A PROGRESS BAR HERE*/
		}
		
		private function saveCompleteHandler(event:Event):void
		{
			event.target.removeEventListener(Event.OPEN, saveBeginHandler);
			event.target.removeEventListener(Event.COMPLETE, saveCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, saveIOErrorHandler);
		}
		
		private function saveIOErrorHandler(event:IOErrorEvent):void
		{
			event.target.removeEventListener(Event.COMPLETE, saveCompleteHandler);
			event.target.removeEventListener(IOErrorEvent.IO_ERROR, saveIOErrorHandler);
			
			trace("Error while trying to save:");
			trace(event);
		}
		
	
	}

}
