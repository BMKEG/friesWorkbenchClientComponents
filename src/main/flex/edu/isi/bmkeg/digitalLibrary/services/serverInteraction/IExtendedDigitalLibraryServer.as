package edu.isi.bmkeg.digitalLibrary.services.serverInteraction
{

	import mx.rpc.AbstractOperation;

	public interface IExtendedDigitalLibraryServer {

		// ~~~~~~~~~~~~~~~
		//  functions
		// ~~~~~~~~~~~~~~~
		function get addPmidEncodedPdfToCorpus():AbstractOperation;

		function get removeFragmentBlock():AbstractOperation; 

		function get listTermViews():AbstractOperation; 
		
		function get addArticlesToCorpus():AbstractOperation;

		function get removeArticlesFromCorpus():AbstractOperation;

		function get fullyDeleteArticle():AbstractOperation;

		function get listExtendedJournalEpochs():AbstractOperation;

		function get addRuleFileToJournalEpoch():AbstractOperation;

		function get retrieveFTDRuleSetForArticleCitation():AbstractOperation;

		function get runRuleSetOnArticleCitation():AbstractOperation;

		function get generateRuleFileFromLapdf():AbstractOperation;

		function get runRuleSetOnJournalEpoch():AbstractOperation;

		function get runRulesOverAllEpochs():AbstractOperation;

		function get loadSwf():AbstractOperation;
	
		function get loadXml():AbstractOperation;
		
		function get loadPmcXml():AbstractOperation;
		
		function get loadHtml():AbstractOperation;
		
		function get listArticleCitationPaged():AbstractOperation;

		function get dumpFragmentsToBrat():AbstractOperation;

		function get retrieveFragmentTree():AbstractOperation;
		
		function get packageCorpusArchive():AbstractOperation;
		
	}

}