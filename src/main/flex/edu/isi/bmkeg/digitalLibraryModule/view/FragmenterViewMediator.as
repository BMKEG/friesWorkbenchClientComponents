package edu.isi.bmkeg.digitalLibraryModule.view
{

	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.digitalLibraryModule.view.forms.*;
	import edu.isi.bmkeg.ftd.model.*;
	import edu.isi.bmkeg.ftd.model.qo.*;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.terminology.model.Ontology;
	import edu.isi.bmkeg.terminology.model.Term;
	import edu.isi.bmkeg.terminology.model.qo.Ontology_qo;
	import edu.isi.bmkeg.terminology.model.qo.Term_qo;
	import edu.isi.bmkeg.terminology.rl.events.*;
	import edu.isi.bmkeg.utils.dao.Utils;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.display.*;
	import flash.events.*;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.*;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.xml.XMLNode;
	
	import flashx.textLayout.conversion.TextConverter;
	
	import mx.collections.*;
	import mx.collections.ArrayCollection;
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.controls.SWFLoader;
	import mx.core.IFactory;
	import mx.events.CollectionEvent;
	import mx.events.ResizeEvent;
	import mx.graphics.*;
	import mx.managers.PopUpManager;
	import mx.utils.Base64Encoder;
	import mx.utils.StringUtil;
	
	import org.ffilmation.utils.rtree.*;
	import org.libspark.utils.ForcibleLoader;
	import org.robotlegs.mvcs.Command;
	import org.robotlegs.mvcs.Mediator;
	
	import spark.events.IndexChangeEvent;
	import spark.primitives.*;
	
	public class FragmenterViewMediator extends Mediator
	{
		
		[Inject]
		public var view:FragmenterView;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		private var xml:XML;
		
		private var startWordXml:XML;
		private var startChunkXml:XML;
		
		private var finishWordXml:XML;
		private var finishChunkXml:XML;

		private var drawWordsFlag:Boolean = false;
		private var drawChunksFlag:Boolean = true;
		private var drawPagesFlag:Boolean = true;
		
		private var clickDownTime:uint;
		
		import edu.isi.bmkeg.utils.ColorPalette;
		
		override public function onRegister():void {
			
			addViewListener(ResizeEvent.RESIZE, 
				eventDrivenRedraw);
			
			addViewListener(StartFragmenting.START_FRAGMENTING, 
				startFragmenting);

			addViewListener(TrackFragmentCursor.TRACK_FRAGMENT_CURSOR, 
				trackFragmentCursor);

			addViewListener(FinishFragmenting.FINISH_FRAGMENTING, 
				finishFragmenting);
			
			addViewListener(RemoveAnnotationEvent.REMOVE_ANNOTATION, 
				dispatch);
			
			addViewListener(ChangeFragmentTypeEvent.CHANGE_FRAGMENT_TYPE, 
				changeFragmentType);

			addViewListener(ChangeFragmentCodeInViewEvent.CHANGE_FRAGMENT_CODE_IN_VIEW, 
				changeFragmentCode);

			addContextListener(ChangeFragmentCodeEvent.ADD_FRAGMENT_CODE, 
				addFragmentCode);

			addContextListener(ChangeFragmentCodeEvent.REMOVE_FRAGMENT_CODE, 
				removeFragmentCode);
			
			addViewListener(RetrievePmcHtmlEvent.RETRIEVE_PMC_HTML, 
				dispatchLoadHtml);			
			
			addViewListener(ListTermEvent.LIST_TERM, 
				dispatch);			
			
			addViewListener(
				DumpFragmentsToBratEvent.DUMP_FRAGMENTS_TO_BRAT, 
				dumpFragments);
			
			addViewListener(ActivateTermInputPopupEvent.ACTIVATE_TERM_INPUT_POPUP,
				activateTermInputPopupHandler);

			addContextListener(LoadSwfResultEvent.LOAD_SWF_RESULT, 
				swfFileLoadResult);
			
			addContextListener(LoadXmlResultEvent.LOAD_XML_RESULT, 
				xmlFileLoadResult);
				
			addContextListener(LoadHtmlResultEvent.LOAD_HTML_RESULT, 
				loadHtmlResult);
			
			addContextListener(
				FindArticleCitationByIdResultEvent.FIND_ARTICLECITATIONBY_ID_RESULT, 
				buildBitmapsFromFindByIdResult);
		
			addContextListener(
				ListFTDFragmentResultEvent.LIST_FTDFRAGMENT_RESULT, 
				updateFragments);

			addContextListener(
				ListTermResultEvent.LIST_TERM_RESULT, 
				updateTerms);

			addContextListener(
				ListOntologyResultEvent.LIST_ONTOLOGY_RESULT, 
				updateOntologies);
			
			var oQo:Ontology_qo = new Ontology_qo();
			this.dispatch( new ListOntologyEvent(oQo) );
			
			if( model.citation != null ) {
				this.buildBitmaps( model.citation.vpdmfId );
			}

		}

		private function buildBitmapsFromFindByIdResult(event:FindArticleCitationByIdResultEvent):void {

			this.buildBitmaps( event.object.vpdmfId );
		
		}
		
		private function buildBitmaps(vpdmfId:Number):void{
			
			//
			// First, get the swf file on the server for the images
			//
			this.dispatch( new LoadSwfEvent(vpdmfId) );
			
			//
			// Next, get the xml for the page boxes
			//
			this.dispatch( new LoadXmlEvent(vpdmfId) );
				
			view.bitmaps = new ArrayCollection();

		}
		
		private function fileLoadError(event:ErrorEvent):void {
			
			trace("Text is not available for this document: " + event);
			
		}
		
		private function readFragmentHolder(pMinusOne:int):FragmentHolderForPage {
			
			var fh:FragmentHolderForPage;
			
			if( view.bitmaps.length <= pMinusOne ) {
				fh = new FragmentHolderForPage(model.pdfScale);
				fh.page = pMinusOne + 1;
				view.bitmaps.addItem(fh);
			} else {
				fh = FragmentHolderForPage(view.bitmaps.getItemAt(pMinusOne));
			}
			
			return fh;
			
		}

		private function swfFileLoadResult(event:LoadSwfResultEvent):void {

			var clip:MovieClip = event.swf;
			
			var frames:int = clip.totalFrames;
			
			for(var i:int=1; i<=frames; i++){
				clip.gotoAndStop(i)
				var bitmapData:BitmapData = new BitmapData(
					clip.width*model.pdfScale, clip.height*model.pdfScale,
					true, 0x00FFFFFF);

				var mat:Matrix=new Matrix();
				mat.scale(model.pdfScale,model.pdfScale);

				bitmapData.draw(clip, mat);
				var o:FragmentHolderForPage = readFragmentHolder(i-1);			
				o.image = new Bitmap(bitmapData);
			}
			
			//
			// Now that we've loaded the images, go get the fragments.
			//
			var ftdQo:FTD_qo = new FTD_qo();
			var acQo:ArticleCitation_qo = new ArticleCitation_qo();
			ftdQo.citation = acQo;
			acQo.vpdmfId = String(model.citation.vpdmfId);
			model.frgType
			
			this.dispatch( new ListArticleDocumentEvent( ftdQo ) );
			
		}
		
		private function xmlFileLoadResult(event:LoadXmlResultEvent):void {
						
			xml = XML(event.xml);
			
			//
			// Build the spatial index of the PDF content here. 
			//
			model.rTreeArray = new ArrayCollection();
			model.indexedWordsByPage = new ArrayCollection();
		
			var p:int = 0; 
			for each(var pageXml:XML in xml.pages[0].*) {

				var rTree:fRTree = new fRTree();
				model.rTreeArray.addItemAt(rTree,p);
				
				var words:ArrayCollection = new ArrayCollection();
				model.indexedWordsByPage.addItemAt(words,p);
		
				var fh:FragmentHolderForPage = readFragmentHolder(p);
				fh.extraRectangles = new ArrayCollection();
				
				if(this.drawPagesFlag) {
					
					var x1:Number = Number(pageXml.@x) ;
					var y1:Number = Number(pageXml.@y);
					var x2:Number = x1 + Number(pageXml.@w);
					var y2:Number = y1 + Number(pageXml.@h);
					var o:Object = {"x1":x1, "y1":y1, "x2": x2, "y2":y2}; 
					fh.extraRectangles.addItem(o);
				
				}
				
				var wc:int = 0;
				for each(var chunkXml:XML in pageXml.chunks[0].*) {	
					
					if(this.drawChunksFlag) {
						var xx1:Number = Number(chunkXml.@x);
						var yy1:Number = Number(chunkXml.@y);
						var xx2:Number = xx1 + Number(chunkXml.@w);
						var yy2:Number = yy1 + Number(chunkXml.@h);					
						var oo:Object = {"x1":xx1, "y1":yy1, "x2":xx2, "y2":yy2}; 
						fh.extraRectangles.addItem(oo);
					}
					
					for each(var wordXml:XML in chunkXml.words[0].*) {
						
						var xxx1:Number = wordXml.@x;
						var yyy1:Number = wordXml.@y;
						var zzz1:Number = 0;
						var xxx2:Number = xxx1 + Number(wordXml.@w);
						var yyy2:Number = yyy1 + Number(wordXml.@h);
						var zzz2:Number = 1;
						var w:String = new String(wordXml.@t[0]);
						
						var c:fCube = new fCube(xxx1, yyy1, zzz1, xxx2, yyy2, zzz2);
						rTree.addCube(c, wc);
						words.addItemAt(wordXml, wc);

						//trace(wc+ " - p: "+p+", x:"+x1+", y:"+y1+", w:"+w);
						
						wc++;
						
						if(this.drawWordsFlag) {
	
							var ooo:Object = {"x1":xxx1, "y1":yyy1, "x2":xxx2, "y2":yyy2}; 
							fh.extraRectangles.addItem(oo);

						}
						
					}
				
				}
				p++;
			
			}
			
			this.forceRedraw();				
			
		}

		private function startFragmenting(event:StartFragmenting):void {
			
			var rTree:fRTree = fRTree(model.rTreeArray.getItemAt(event.p - 1));
			var words:ArrayCollection = ArrayCollection(model.indexedWordsByPage.getItemAt(event.p-1));

			var x:Number = event.x / (model.pdfScale * event.sf);
			var y:Number = event.y / (model.pdfScale * event.sf);			
			var xyz:Array = [x,y,0];
			
			var ii:Array = rTree.nearest(xyz);
			if( ii.length > 1 ) {
				return;
			}
			
			var i:int = ii[0];

			var startXml:XML = XML( words.getItemAt( i ) );
			var id1:Number = Number(startXml.@id);
			this.startWordXml = this.xml..wd.(attribute('id') == id1)[0];
			this.startChunkXml = this.startWordXml.parent().parent();
			
			this.finishWordXml = null;
			this.finishChunkXml = null;
			this.clickDownTime = getTimer(); 
				
		}
		
		private function trackFragmentCursor(event:TrackFragmentCursor):void {
			
			if( this.startChunkXml == null || this.startWordXml == null )
				return;
			
			var sf:Number = (model.pdfScale * event.sf);
			
			var rTree:fRTree = fRTree(model.rTreeArray.getItemAt(event.p - 1));
			var words:ArrayCollection = ArrayCollection(model.indexedWordsByPage.getItemAt(event.p-1));

			var x:Number = event.x / (model.pdfScale * event.sf);
			var y:Number = event.y / (model.pdfScale * event.sf);			
			var xyz:Array = [x,y,0];
			
			var ii:Array = rTree.nearest(xyz);
			if( ii.length > 1 ) {
				return;
			}
			var i:int = ii[0];
			
			var trackedXml:XML = XML( words.getItemAt( i ) );
			var startId:Number = Number(this.startWordXml.@id);
			var trackedId:Number = Number(trackedXml.@id);
			var trackedWordXml:XML = this.xml..wd.(attribute('id') == trackedId)[0];
			var trackedChunkXml:XML = trackedWordXml.parent().parent();
			
			var chunkW:Number = Number(this.startChunkXml.@w);
			var chunkX:Number = Number(this.startChunkXml.@x);
			
			//
			// bale out of this process if the mouse is not in the column underneath 
			// the starting block
			//
			var dataArray:ArrayCollection = view.bitmaps;
			var data:FragmentHolderForPage = FragmentHolderForPage(dataArray.getItemAt(event.p-1));	
			if( startId > trackedId || 
					Number(trackedWordXml.@x) < chunkX ||
					Number(trackedWordXml.@x) > (chunkX + chunkW) ) {
				data.fragmentInProgress = null;
				return;
			}
				
			var wdXmlList:XMLList = 
				this.startChunkXml..wd.(attribute('id') >= startId && attribute('id') <= trackedId); 
			
			//
			// build 'Fragment' shape
			//
			var path:Path = new Path();
			var x1:Number = Number(this.startWordXml.@x) * sf;
			var y1:Number = (Number(this.startWordXml.@y) + Number(this.startWordXml.@h)) * sf;
			var x2:Number = (chunkW + chunkX) * sf;
			var y2:Number = Number(this.startWordXml.@y) * sf;
			var x3:Number = (Number(trackedWordXml.@x) + Number(trackedWordXml.@w)) * sf;
			var y3:Number = Number(trackedWordXml.@y) * sf;
			var x4:Number = chunkX * sf;
			var y4:Number = (Number(trackedWordXml.@y) + Number(trackedWordXml.@h)) * sf;
			var pathData:String = "m " + x1 + " " + y1 + " " +
					"v " + (y2 - y1) + " " +
					"h " + (x2 - x1) + " " +
					"v " + (y3 - y2) + " " +
					"h " + (x3 - x2) + " " +
					"v " + (y4 - y3) + " " +
					"h " + (x4 - x3) + " " +
					"v " + (y1 - y4) + " " +
					"z";

			//
			// ... but if the fragment is on the same line only draw a simple rectangle
			//
			if( y2 == y3 ) {
				pathData = "m " + x1 + " " + y1 + " " +
						"v " + (y2 - y1) + " " +
						"h " + (x3 - x1) + " " +
						"v " + (y1 - y3) + " " +
						"z";
			}
			
			path.data = pathData;

			var s:SolidColorStroke = new SolidColorStroke();
			s.color = 0xff0000;
			s.alpha = .2;
			path.stroke = s;
			
			var f:SolidColor = new SolidColor();
			f.alpha = .2;
			f.color = 0xffff00;
			path.fill = f;
				
			data.fragmentInProgress = path;
									
		}

		private function finishFragmenting(event:FinishFragmenting):void {
			
			if( this.startChunkXml == null || this.startWordXml == null )
				return;
			
			var clickUpTime:uint = getTimer();
			if( clickUpTime - clickDownTime < 1000 )  {
				this.startWordXml = null;
				this.startChunkXml = null;
				this.finishWordXml = null;
				this.finishChunkXml = null;
				return;
				
			}
			
			var rTree:fRTree = fRTree(model.rTreeArray.getItemAt(event.p - 1));
			var words:ArrayCollection = ArrayCollection(model.indexedWordsByPage.getItemAt(event.p-1));
			
			var sf:Number = (model.pdfScale * event.sf);
			var x:Number = event.x / sf;
			var y:Number = event.y / sf;			
			var xyz:Array = [x,y,0];
			
			var ii:Array = rTree.nearest(xyz);
			if( ii.length > 1 ) {
				return;
			}
			
			var i:int = ii[0];
			
			var finishXml:XML = XML( words.getItemAt( i ) );			
			var id1:Number = Number(this.startWordXml.@id);
			var id2:Number = Number(finishXml.@id);
			this.finishWordXml = this.xml..wd.(attribute('id') == id2)[0];
			this.finishChunkXml = this.finishWordXml.parent().parent();
						
			var chunkW:Number = Number(this.startChunkXml.@w);
			var chunkX:Number = Number(this.startChunkXml.@x);
			
			var dataArray:ArrayCollection = view.bitmaps;
			var fh:FragmentHolderForPage = FragmentHolderForPage(dataArray.getItemAt(event.p-1));
			var finishX:Number = Number(this.finishWordXml.@x);
			if( id1 > id2 || finishX < chunkX || finishX > (chunkX + chunkW) ) {
				fh.fragmentInProgress = null;
				this.startWordXml = null;
				this.startChunkXml = null;
				return;
			}
						
			var x1:Number = Number(this.startWordXml.@x) ;
			var y1:Number = (Number(this.startWordXml.@y) + Number(this.startWordXml.@h));
			var x2:Number = (chunkW + chunkX);
			var y2:Number = Number(this.startWordXml.@y);
			var x3:Number = (Number(finishWordXml.@x) + Number(finishWordXml.@w));
			var y3:Number = Number(finishWordXml.@y);
			var x4:Number = chunkX;
			var y4:Number = (Number(finishWordXml.@y) + Number(finishWordXml.@h));
			
			var ftd:FTD = model.lightFtd;

			//
			// Is this a new fragment or does it already exist in the system?
			//
			var frgOrd:String = view.frgNumberInput.text;
			var frg:FTDFragment = null;
			for( var iii:int=0; iii<this.model.fragments.length; iii++) {
				var tempFrg:FTDFragment = FTDFragment(this.model.fragments.getItemAt(iii));
				if( tempFrg.frgOrder == frgOrd )  {
					frg = tempFrg;
					break;
				}
			}
			var newFrg:Boolean = false;
			if( frg == null ) {
				frg = new FTDFragment();
				frg.frgOrder = frgOrd
				frg.ftd = ftd;
				frg.frgType = model.frgType;
				newFrg = true;
			}

			var ftdAnn:FTDFragmentBlock = new FTDFragmentBlock();
			frg.annotations.addItem(ftdAnn);
			frg.frgType = view.frgType;
						
			ftdAnn.x1 = x1;
			ftdAnn.y1 = y1;
			ftdAnn.x2 = x2;
			ftdAnn.y2 = y2;
			ftdAnn.x3 = x3;
			ftdAnn.y3 = y3;
			ftdAnn.x4 = x4;
			ftdAnn.y4 = y4;
			ftdAnn.p = event.p;
			ftdAnn.code = model.frgCode;
			
			var annXml:XMLList = this.xml..wd.(attribute('id') >= id1 && attribute('id') <= id2); 
			var annStr:String = "";
			for each(var wordXml:XML in annXml) {
				annStr += wordXml.@t + " ";
			}
			if(annStr.length > 0)
				annStr = annStr.substr(0, annStr.length-1);
			ftdAnn.text = annStr;
			
			if( newFrg ) 
				this.dispatch( new InsertFTDFragmentEvent( frg ) );
			else 
				this.dispatch( new UpdateFTDFragmentEvent( frg ) );
			
			this.startWordXml = null;
			this.startChunkXml = null;
			this.finishWordXml = null;
			this.finishChunkXml = null;
			
		}
		
		private function updateFragments(event:ListFTDFragmentResultEvent):void {
			
			var pageArray:ArrayCollection = view.bitmaps;
			
			var l:ArrayCollection = new ArrayCollection();
			var holder:Object = new Object();
			
			view.xmlRoot = <root/>;
			
			for each(var frg:FTDFragment in model.fragments) {
				
				frg.ftd = model.lightFtd;

				var label:String = "";
				
				for(var i:int=0; i<frg.annotations.length; i++) {
					var ftdAnn:FTDFragmentBlock = FTDFragmentBlock(frg.annotations.getItemAt(i));
					
					label += ftdAnn.text;
										
					if( holder[ftdAnn.p] == null )
						holder[ftdAnn.p] = new ArrayCollection();

					ArrayCollection(holder[ftdAnn.p]).addItem(ftdAnn);				
				
				}	
				
				var frgNode:XML = <node data={frg.frgOrder} label={frg.frgOrder + ":" + label}/>;				
				view.xmlRoot.appendChild( frgNode );

			}

			for each (var frgH:FragmentHolderForPage in pageArray ) {
				frgH.fragmentsAdded = new ArrayCollection();	
				frgH.fragmentInProgress = null;
			}
			
			for (var pStr:* in holder ) {
				var p:Number = Number(pStr);
				var fh:FragmentHolderForPage = FragmentHolderForPage(pageArray.getItemAt(p-1));
				fh.fragmentsAdded = holder[p];
			}			
			
			this.updateRunningCounts();

		}
		
		private function removeAnnotation(event:RemoveAnnotationEvent):void {
			
			var p:int = event.ftdAnn.p-1;
			
			var dataArray:ArrayCollection = view.bitmaps;
			var fh:FragmentHolderForPage = FragmentHolderForPage(dataArray.getItemAt(p));	
			var ftdAnn:FTDFragmentBlock = event.ftdAnn;

			for( var i:int=0; i<fh.fragmentsAdded.length; i++ ) {
				var frg:FTDFragment = FTDFragment ( fh.fragmentsAdded.getItemAt(i) );	
				var rId:int = frg.annotations.getItemIndex(ftdAnn);
				if( rId != -1 ) {
					frg.annotations.removeItemAt(rId);
				}
			}
			
			var fragmentsAdded:ArrayCollection = new ArrayCollection();
			for each( var f:FTDFragment in fh.fragmentsAdded) {
				if( f.annotations.length > 0 ) {
					fragmentsAdded.addItem( f );
				}
			}
			fh.fragmentsAdded.removeAll();			
			fh.fragmentsAdded.addAll(fragmentsAdded);			
			this.updateRunningCounts();
			
			fh.fragmentsAdded = fragmentsAdded;
			
		}
		
		private function updateRunningCounts():void {

			var dataArray:ArrayCollection = view.bitmaps;
			var runningCount:int = 0;
			for(var i:int=0; i<dataArray.length; i++) {
				var fh:FragmentHolderForPage = FragmentHolderForPage(dataArray.getItemAt(i));	
				fh.runningCount = runningCount;
				runningCount += fh.fragmentsAdded.length;
			}
			
		}
		
		private function updateTerms(event:ListTermResultEvent):void {
			
			this.view.terms = model.terms;
			view.colorLookup = new Object();
			
			for( var i:int=0; i<model.terms.length; i++) {
				var t:Object = model.terms.getItemAt(i);
				var o:Object = ColorPalette.colors.getItemAt(i);
				var str:String = String(o.color);
				var tempColor:uint = uint("0x" + str.substr(1) );
				view.colorLookup[ t.tree.toLowerCase() ] = tempColor;
			}

			this.view.autoComplete.clear();
					
		}
		
		private function updateOntologies(event:ListOntologyResultEvent):void {
			
			this.view.ontologies = model.ontologies;
			for each( var lvi:LightViewInstance in this.view.ontologies ) {
				if(lvi.vpdmfLabel == "frg") {					
					this.view.ontologyCombo.selectedItem = lvi;
					break;
				}
			}
			
		}
		
		private function dumpFragments(event:DumpFragmentsToBratEvent):void {
			
			event.ftdId = model.lightFtd.vpdmfId;
			this.dispatch( event );
			
		}
		
		private function loadHtmlResult(event:Event):void {
			
			var htmlString:String = model.html;
			
			if( htmlString != null && view.textControl != null) {
				view.textControl.textFlow = TextConverter.importToFlow(
					htmlString, TextConverter.TEXT_FIELD_HTML_FORMAT);
			}
			
		}
		
		private function dispatchLoadHtml(event:Event):void {
			
			var vpdmfId:Number = model.citation.vpdmfId;

			this.dispatch(new LoadHtmlEvent(vpdmfId) ); 
						
		}

		private function changeFragmentCode(event:ChangeFragmentCodeInViewEvent):void {
			
			model.frgCode = view.frgCode;
		
		}
		
		private function addFragmentCode(event:ChangeFragmentCodeEvent):void {
			
			model.frgCode = view.frgCode;
			
			event.block.code = model.frgCode;
			
			this.dispatch( new UpdateFTDFragmentEvent( event.block.fragment ) );
			
		}
		
		private function removeFragmentCode(event:ChangeFragmentCodeEvent):void {
			
			model.frgCode = "";
			
			var found:Boolean = false;
			for each (var f:FTDFragment in model.fragments) {
				for each (var b:FTDFragmentBlock in f.annotations) {
					if( b == event.block ) {
						found = true;
						break;
					}
				}	
			}
			
			if(!found) {
				return;
			}
			
			b.code = model.frgCode;
			
			this.dispatch( new UpdateFTDFragmentEvent( f ) );			
			
		}

		private function changeFragmentType(event:ChangeFragmentTypeEvent):void {
			
			model.frgType = event.fType;
			view.frgType = event.fType;

			var termQo:Term_qo = new Term_qo();
			var ontQo:Ontology_qo = new Ontology_qo();
			termQo.ontology = ontQo;

			ontQo.vpdmfLabel = event.fType;
			
			this.dispatch( new ListTermEvent(termQo) );

			var ftdQo:FTD_qo = new FTD_qo();
			ftdQo.vpdmfId = String(model.lightFtd.vpdmfId);
			var frgQo:FTDFragment_qo = new FTDFragment_qo();
			frgQo.frgType = String(model.frgType);
			frgQo.ftd = ftdQo;
			
			this.dispatch( new ListFTDFragmentEvent( frgQo ) );
			
		}
		
		private function eventDrivenRedraw(event:Event):void {
			this.forceRedraw();
		}

		//
		// Force a redraw for the List control.
		// from: http://blog.9mmedia.com/?p=709
		//
		private function forceRedraw():void {
			var _itemRenderer:IFactory = this.view.pgList.itemRenderer;
			this.view.pgList.itemRenderer = null;
			this.view.pgList.itemRenderer = _itemRenderer;
		}
		
		private function activateTermInputPopupHandler(event:ActivateTermInputPopupEvent):void {

			var popup:TermInputPopup = new TermInputPopup();
			popup.title = "Update Term for Fragment?";
				
			popup.block = event.ftdAnn;
			popup.frgCode = model.frgCode;
			popup.x = event.x;
			popup.y = event.y;
			
			PopUpManager.addPopUp(popup, this.view);
			mediatorMap.createMediator( popup );
			
		}
		
	}

}