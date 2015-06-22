package edu.isi.bmkeg.friesWorkbench.services.impl
{

	import edu.isi.bmkeg.friesWorkbench.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.ArticleCitation_qo;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListArticleCitationPagedResultEvent;
	import edu.isi.bmkeg.friesWorkbench.services.*;
	import edu.isi.bmkeg.friesWorkbench.services.serverInteraction.*;
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
	
	public class ExtendedBigMechIndexCardServiceImpl extends Actor implements IExtendedBigMechIndexCardService {

		private var _server:IExtendedBigMechIndexCardServer;

		private var ldr:Loader;
		private var clip:MovieClip;
		
		[Inject]
		public function get server():IExtendedBigMechIndexCardServer

		{
			return _server;
		}

		public function set server(s:IExtendedBigMechIndexCardServer):void
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
		
		public function listIndexCardsByArticleId(object:Number):void {
			server.listIndexCardsByArticleId.cancel();
			server.listIndexCardsByArticleId.addEventListener(FaultEvent.FAULT, faultHandler);
			server.listIndexCardsByArticleId.addEventListener(ResultEvent.RESULT, listIndexCardsByArticleIdHandler);
			server.listIndexCardsByArticleId.send(object);	
		}
		
		private function listIndexCardsByArticleIdHandler(event:ResultEvent):void
		{
			var list:ArrayCollection = event.result as ArrayCollection;
			dispatch(new ListIndexCardsByArticleIdResultEvent(list));
		}
			
	}

}
