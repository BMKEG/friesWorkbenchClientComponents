package edu.isi.bmkeg.friesWorkbenchModule.model
{
	
	import edu.isi.bmkeg.bigMechIndexCards.model.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.terminology.model.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.ftd.model.FTD;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.display.*;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Actor;
	
	[Bindable]
	public class FriesWorkbenchModel extends Actor
	{
		
		// number of entries returned in each page for the article list
		public var listPageSize:int = 200;
		
		// conditions that specify the articles currently listed
		public var queryLiteratureCitation:ArticleCitation_qo;

		// the selected article
		public var citation:ArticleCitation;

		// A light version (equivalent of a LightViewInstance) of the FTD associated with the citation
		// We don't load the 'heavy' swf data or the lapdftext binary over the application's 
		// standard amf interface to cut down the I/O to just what is needed. 
		public var lightFtd:FTD;
		
		// the SWF of the PDF file
		public var swf:MovieClip;

		// An array of adapted org.ffilmation.utils.rtree.fRTree objects 
		public var rTreeArray:ArrayCollection = new ArrayCollection();
		
		// An array of arrays of words, indexed by page, then by rtree index
		public var indexedWordsByPage:ArrayCollection = new ArrayCollection();
		
		// The fragmenter renders each page as a bitmap. This is the scaling factor 
		// used to mitigate pixelation so that the pages look OK in the interface.
		public var pdfScale:Number = 2.0;

		// The text of the current Full Text Document expressed as HTML.
		public var html:String;

		// All fragments loaded from the current indexcard
		public var fragments:ArrayCollection = new ArrayCollection();

		// All ontologies loaded for annotation purposes.
		public var ontologies:ArrayCollection = new ArrayCollection();

		// All Index Cards
		public var indexCards:ArrayCollection = new ArrayCollection();

		// Currently selected Index Card
		public var indexCard:BigMechIndexCard;

		// The ontology currently set to annotate fragments
		public var frgType:String;
		
		// All terms loaded to annotate the current fragment
		public var terms:ArrayCollection = new ArrayCollection();	

		// The term currently set to annotate new fragments
		public var frgCode:String;

		// Message returned from server
		public var message:String = "";
		
		// Path to where a zip archive can be saved.
		public var saveFilePath:String = "";
		
		public var queryCorpusCount:int;


	}

}