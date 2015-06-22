package edu.isi.bmkeg.friesWorkbench.services
{

	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.ArticleCitation_qo;
	import edu.isi.bmkeg.ftd.model.*;
	
	import mx.collections.ArrayCollection;
	
	public interface IExtendedBigMechIndexCardService {

		// ~~~~~~~~~~~~~~~
		//  functions
		// ~~~~~~~~~~~~~~~
		function listIndexCardsByArticleId(cId:Number):void;
		
	}

}
