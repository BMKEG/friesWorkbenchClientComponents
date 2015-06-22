package edu.isi.bmkeg.friesWorkbench.services.serverInteraction.impl
{

	import edu.isi.bmkeg.friesWorkbench.services.serverInteraction.*;

	import mx.collections.ArrayCollection;
	import mx.rpc.AbstractOperation;
	import mx.rpc.AbstractService;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	import mx.rpc.AbstractOperation;

	import edu.isi.bmkeg.utils.dao.Utils;
	import edu.isi.bmkeg.friesWorkbench.services.serverInteraction.IExtendedBigMechIndexCardServer;

	public class ExtendedBigMechIndexCardServerImpl 
			extends RemoteObject 
			implements IExtendedBigMechIndexCardServer
	{

		private static const SERVICES_DEST:String = "extendedBigMechIndexCardsServiceImpl";

		public function ExtendedBigMechIndexCardServerImpl()
		{
			destination = SERVICES_DEST;
			endpoint = Utils.getRemotingEndpoint();
			showBusyCursor = true;
		}
		
		// ~~~~~~~~~~~~~~~
		// functions
		// ~~~~~~~~~~~~~~~
		public function get listIndexCardsByArticleId():AbstractOperation
		{
			return getOperation("listIndexCardsByArticleId");
		}	
		
	}

}