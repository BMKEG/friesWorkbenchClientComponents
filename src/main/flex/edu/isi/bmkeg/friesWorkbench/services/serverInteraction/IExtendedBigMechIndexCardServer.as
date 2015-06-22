package edu.isi.bmkeg.friesWorkbench.services.serverInteraction
{

	import mx.rpc.AbstractOperation;

	public interface IExtendedBigMechIndexCardServer {

		// ~~~~~~~~~~~~~~~
		//  functions
		// ~~~~~~~~~~~~~~~
		function get listIndexCardsByArticleId():AbstractOperation;
		
		
	}

}