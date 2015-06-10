package edu.isi.bmkeg.digitalLibrary.services.serverInteraction.impl
{

	import edu.isi.bmkeg.digitalLibrary.services.serverInteraction.*;

	import mx.collections.ArrayCollection;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.AbstractOperation;

	import edu.isi.bmkeg.utils.dao.Utils;
	import edu.isi.bmkeg.digitalLibrary.services.serverInteraction.IExtendedDigitalLibraryServer;

	public class ExtendedDigitalLibraryServerImpl 
			extends RemoteObject 
			implements IExtendedDigitalLibraryServer
	{

		private static const SERVICES_DEST:String = "extendedDigitalLibraryServiceImpl";

		public function ExtendedDigitalLibraryServerImpl()
		{
			destination = SERVICES_DEST;
			endpoint = Utils.getRemotingEndpoint();
			showBusyCursor = true;
		}
		
		// ~~~~~~~~~~~~~~~
		// functions
		// ~~~~~~~~~~~~~~~
		public function get addPmidEncodedPdfToCorpus():AbstractOperation
		{
			return getOperation("addPmidEncodedPdfToCorpus");
		}

		public function get removeFragmentBlock():AbstractOperation
		{
			return getOperation("removeFragmentBlock");
		}
		
		public function get listTermViews():AbstractOperation
		{
			return getOperation("listTermViews");
		}
		
		public function get addArticlesToCorpus():AbstractOperation
		{
			return getOperation("addArticlesToCorpus");
		}
		
		public function get removeArticlesFromCorpus():AbstractOperation
		{
			return getOperation("removeArticlesFromCorpus");
		}		

		public function get fullyDeleteArticle():AbstractOperation
		{
			return getOperation("fullyDeleteArticle");
		}	
	
		public function get listExtendedJournalEpochs():AbstractOperation
		{
			return getOperation("listExtendedJournalEpochs");
		}	

		public function get addRuleFileToJournalEpoch():AbstractOperation
		{
			return getOperation("addRuleFileToJournalEpoch");
		}	

		public function get retrieveFTDRuleSetForArticleCitation():AbstractOperation
		{
			return getOperation("retrieveFTDRuleSetForArticleCitation");
		}	

		public function get runRuleSetOnArticleCitation():AbstractOperation
		{
			return getOperation("runRuleSetOnArticleCitation");
		}	

		public function get runRuleSetOnJournalEpoch():AbstractOperation
		{
			return getOperation("runRuleSetOnJournalEpoch");
		}	

		public function get runRulesOverAllEpochs():AbstractOperation
		{
			return getOperation("runRulesOverAllEpochs");
		}	

		public function get generateRuleFileFromLapdf():AbstractOperation
		{
			return getOperation("generateRuleFileFromLapdf");
		}	

		public function get loadSwf():AbstractOperation
		{
			return getOperation("loadSwf");
		}	
		
		public function get loadXml():AbstractOperation
		{
			return getOperation("loadXml");
		}	
		
		public function get loadPmcXml():AbstractOperation
		{
			return getOperation("loadPmcXml");
		}
		
		public function get loadHtml():AbstractOperation
		{
			return getOperation("loadHtml");
		}	
		
		public function get listArticleCitationPaged():AbstractOperation
		{
			return getOperation("listArticleCitationPaged");
		}	
		
		public function get dumpFragmentsToBrat():AbstractOperation
		{
			return getOperation("dumpFragmentsToBrat");
		}	

		public function get retrieveFragmentTree():AbstractOperation
		{
			return getOperation("retrieveFragmentTree");
		}
		
		public function get packageCorpusArchive():AbstractOperation
		{
			return getOperation("packageCorpusArchive");
		}
		
	}

}