package edu.isi.bmkeg.digitalLibrary.services
{

	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.ArticleCitation_qo;
	import edu.isi.bmkeg.ftd.model.*;
	
	import mx.collections.ArrayCollection;
	
	public interface IExtendedDigitalLibraryService {

		// ~~~~~~~~~~~~~~~
		//  functions
		// ~~~~~~~~~~~~~~~
		
		function addPmidEncodedPdfToCorpus(pdfFileData:Object, fileName:String, corpusName:String=null):void;
		
		function removeFragmentBlock(frgBlk:FTDFragmentBlock):void;
		
		//java: public List<String> listTermViews() throws Exception
		function listTermViews():void;

		function addArticlesToCorpus(articleIds:ArrayCollection, corpusId:Number):void;

		function removeArticlesFromCorpus(articleIds:ArrayCollection, corpusId:Number):void;

		function fullyDeleteArticle(articleId:Number):void;		
		
		function listExtendedJournalEpochs():void;

		function addRuleFileToJournalEpoch(ruleFileId:Number, 
										   journalEpochId:Number,
										   epochJournal:String,
										   epochStart:Number,
										   epochEnd:Number):void;

		function retrieveFTDRuleSetForArticleCitation(articleId:Number):void;
	
		function runRuleSetOnArticleCitation(ruleSetId:Number, articleId:Number):void;

		function runRuleSetOnJournalEpoch(epochId:Number):void;

		function runRulesOverAllEpochs():void;
		
		function generateRuleFileFromLapdf(articleId:Number):void;

		function loadSwf(vpdmfId:Number):void;

		function loadXml(vpdmfId:Number):void;

		function loadPmcXml(vpdmfId:Number):void;

		function loadHtml(vpdmfId:Number):void;

		function listArticleCitationPaged(o:ArticleCitation_qo, offset:int, cnt:int):void;
			
		function dumpFragmentsToBrat(ftdId:Number):void;

		function retrieveFragmentTree(acId:Number):void;

		function packageCorpusArchive(corpusId:Number):void;
		
	}

}
