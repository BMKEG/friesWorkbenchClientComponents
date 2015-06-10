package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.ftd.model.*;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	public class RetrieveFragmentTreeResultEvent extends Event 
	{
		
		public static const RETRIEVE_FRAGMENT_TREE_RESULT:String = 
			"retrieveFragmentTreeResultEvent";

		public var tree:XML;
		
		public function RetrieveFragmentTreeResultEvent(tree:XML)
		{
			this.tree = tree;
			super(RETRIEVE_FRAGMENT_TREE_RESULT);
		}
		
		override public function clone() : Event
		{
			return new RetrieveFragmentTreeResultEvent(tree);
		}
		
	}
	
}
