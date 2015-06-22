package edu.isi.bmkeg.friesWorkbenchModule
{
	import edu.isi.bmkeg.bigMechIndexCards.rl.events.*;
	import edu.isi.bmkeg.bigMechIndexCards.rl.services.IBigMechIndexCardsService;
	import edu.isi.bmkeg.bigMechIndexCards.rl.services.impl.BigMechIndexCardsServiceImpl;
	import edu.isi.bmkeg.bigMechIndexCards.rl.services.serverInteraction.IBigMechIndexCardsServer;
	import edu.isi.bmkeg.bigMechIndexCards.rl.services.serverInteraction.impl.BigMechIndexCardsServerImpl;
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.services.IDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.rl.services.impl.DigitalLibraryServiceImpl;
	import edu.isi.bmkeg.digitalLibrary.rl.services.serverInteraction.IDigitalLibraryServer;
	import edu.isi.bmkeg.digitalLibrary.rl.services.serverInteraction.impl.DigitalLibraryServerImpl;
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.services.impl.ExtendedDigitalLibraryServiceImpl;
	import edu.isi.bmkeg.digitalLibrary.services.serverInteraction.IExtendedDigitalLibraryServer;
	import edu.isi.bmkeg.digitalLibrary.services.serverInteraction.impl.ExtendedDigitalLibraryServerImpl;
	import edu.isi.bmkeg.friesWorkbench.events.*;
	import edu.isi.bmkeg.friesWorkbench.services.*;
	import edu.isi.bmkeg.friesWorkbench.services.impl.*;
	import edu.isi.bmkeg.friesWorkbench.services.serverInteraction.*;
	import edu.isi.bmkeg.friesWorkbench.services.serverInteraction.impl.*;
	import edu.isi.bmkeg.friesWorkbenchModule.controller.listIndexCardsFromArticle.*;
	import edu.isi.bmkeg.friesWorkbenchModule.controller.findAndLoadArticle.*;
	import edu.isi.bmkeg.friesWorkbenchModule.controller.loadIndexCard.*;
	import edu.isi.bmkeg.friesWorkbenchModule.controller.fragments.*;
	import edu.isi.bmkeg.friesWorkbenchModule.controller.*;
	import edu.isi.bmkeg.friesWorkbenchModule.events.*;
	import edu.isi.bmkeg.friesWorkbenchModule.model.*;
	import edu.isi.bmkeg.friesWorkbenchModule.view.*;
	import edu.isi.bmkeg.digitalLibraryModule.view.forms.*;
	import edu.isi.bmkeg.digitalLibraryModule.view.FragmenterView;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.ftd.rl.services.IFtdService;
	import edu.isi.bmkeg.ftd.rl.services.impl.FtdServiceImpl;
	import edu.isi.bmkeg.ftd.rl.services.serverInteraction.IFtdServer;
	import edu.isi.bmkeg.ftd.rl.services.serverInteraction.impl.FtdServerImpl;
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.terminology.rl.events.*;
	import edu.isi.bmkeg.terminology.rl.services.ITerminologyService;
	import edu.isi.bmkeg.terminology.rl.services.impl.TerminologyServiceImpl;
	import edu.isi.bmkeg.terminology.rl.services.serverInteraction.ITerminologyServer;
	import edu.isi.bmkeg.terminology.rl.services.serverInteraction.impl.TerminologyServerImpl;
	import edu.isi.bmkeg.utils.serverUpdates.events.ServerUpdateEvent;
	import edu.isi.bmkeg.utils.serverUpdates.services.IServerUpdateService;
	import edu.isi.bmkeg.utils.serverUpdates.services.impl.ServerUpdateServiceImpl;
	import edu.isi.bmkeg.utils.serverUpdates.services.serverInteraction.IServerUpdateServer;
	import edu.isi.bmkeg.utils.serverUpdates.services.serverInteraction.impl.ServerUpdateServerImpl;
	import edu.isi.bmkeg.utils.uploadDirectoryControl.*;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.utilities.modular.mvcs.ModuleContext;

	public class FriesWorkbenchModuleContext extends ModuleContext
	{

		public function FriesWorkbenchModuleContext(contextView:DisplayObjectContainer,
													injector:IInjector)
		{
			super(contextView, true, injector);
		}
		
		override public function startup():void
		{		
			
			mediatorMap.mapView(IndexCardList, IndexCardListMediator);
			mediatorMap.mapView(IndexCardView, IndexCardViewMediator);
			mediatorMap.mapView(FragmenterView, FragmenterViewMediator);
			
			injector.mapSingleton(FriesWorkbenchModel);
			
			injector.mapSingletonOf(IDigitalLibraryService, DigitalLibraryServiceImpl);
			injector.mapSingletonOf(IDigitalLibraryServer, DigitalLibraryServerImpl);
			injector.mapSingletonOf(IExtendedDigitalLibraryService, ExtendedDigitalLibraryServiceImpl);
			injector.mapSingletonOf(IExtendedDigitalLibraryServer, ExtendedDigitalLibraryServerImpl);
			injector.mapSingletonOf(IExtendedBigMechIndexCardService, ExtendedBigMechIndexCardServiceImpl);
			injector.mapSingletonOf(IExtendedBigMechIndexCardServer, ExtendedBigMechIndexCardServerImpl);
			injector.mapSingletonOf(IBigMechIndexCardsService, BigMechIndexCardsServiceImpl);
			injector.mapSingletonOf(IBigMechIndexCardsServer, BigMechIndexCardsServerImpl);
			injector.mapSingletonOf(IFtdServer, FtdServerImpl);
			injector.mapSingletonOf(IFtdService, FtdServiceImpl);
			injector.mapSingletonOf(ITerminologyServer, TerminologyServerImpl);
			injector.mapSingletonOf(ITerminologyService, TerminologyServiceImpl);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Simple pushed messages from the server.
			injector.mapSingletonOf(IServerUpdateServer, ServerUpdateServerImpl);
			injector.mapSingletonOf(IServerUpdateService, ServerUpdateServiceImpl);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// pushed messages from the server.
			commandMap.mapEvent(ServerUpdateEvent.SERVER_UPDATE, 
				ServerUpdateCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Run a list query for index cards in the target corpus
			commandMap.mapEvent(ListIndexCardsByArticleIdEvent.LIST_INDEX_CARDS_BY_ARTICLE_PAGED, 
					ListIndexCardsByArticleIdCommand);
			commandMap.mapEvent(ListIndexCardsByArticleIdResultEvent.LIST_INDEX_CARDS_BY_ARTICLE_PAGED_RESULT, 
					ListIndexCardsByArticleIdResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Change selection of the targetArticleCitation List control
			// Run a query for the Document. 
			commandMap.mapEvent(FindArticleCitationByIdEvent.FIND_ARTICLECITATION_BY_ID, 
					FindArticleCitationByIdCommand);
			commandMap.mapEvent(FindArticleCitationByIdResultEvent.FIND_ARTICLECITATIONBY_ID_RESULT, 
					FindArticleCitationByIdResultCommand);
	
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Load the swf
			commandMap.mapEvent(LoadSwfEvent.LOAD_SWF, LoadSwfCommand);
			commandMap.mapEvent(LoadSwfResultEvent.LOAD_SWF_RESULT, LoadSwfResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Load the xml
			commandMap.mapEvent(LoadXmlEvent.LOAD_XML, LoadXmlCommand);
			commandMap.mapEvent(LoadXmlResultEvent.LOAD_XML_RESULT, LoadXmlResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Load the pmcxml
			commandMap.mapEvent(LoadPmcXmlEvent.LOAD_PMCXML, LoadPmcXmlCommand);
			commandMap.mapEvent(LoadPmcXmlResultEvent.LOAD_PMCXML_RESULT, LoadPmcXmlResultCommand);

			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Load the html
			commandMap.mapEvent(LoadHtmlEvent.LOAD_HTML, LoadHtmlCommand);
			commandMap.mapEvent(LoadHtmlResultEvent.LOAD_HTML_RESULT, LoadHtmlResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Load an index card
			commandMap.mapEvent(FindBigMechIndexCardByIdEvent.FIND_BIGMECHINDEXCARD_BY_ID, 
				FindBigMechIndexCardByIdCommand);
			commandMap.mapEvent(FindBigMechIndexCardByIdResultEvent.FIND_BIGMECHINDEXCARDBY_ID_RESULT, 
				FindBigMechIndexCardByIdResultCommand);
			
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Fragment based functions. 

			commandMap.mapEvent(ListFTDFragmentEvent.LIST_FTDFRAGMENT, 
				ListFTDFragmentCommand);
			commandMap.mapEvent(ListFTDFragmentResultEvent.LIST_FTDFRAGMENT_RESULT, 
				ListFTDFragmentResultCommand);
						
			// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			// Term-based functions. 
			commandMap.mapEvent(ListOntologyEvent.LIST_ONTOLOGY, 
					ListOntologyCommand);
			commandMap.mapEvent(ListOntologyResultEvent.LIST_ONTOLOGY_RESULT, 
					ListOntologyResultCommand);
			
		}
		
		override public function dispose():void
		{
			mediatorMap.removeMediatorByView(contextView);
			super.dispose();
		}
		
	}
	
}