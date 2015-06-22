package edu.isi.bmkeg.friesWorkbenchModule.view
{
	import mx.collections.ArrayCollection;
	import mx.collections.CursorBookmark;
	import mx.collections.ICollectionView;
	import mx.collections.IViewCursor;
	import mx.controls.treeClasses.*;
	import mx.controls.treeClasses.ITreeDataDescriptor;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	public class IndexCardDataDescriptor implements ITreeDataDescriptor
	{
		public function IndexCardDataDescriptor()
		{
		}
		
		public function getChildren(node:Object, model:Object=null):ICollectionView
		{
			try {

				if( node is String || node is Number || node is Boolean) {

					return null;
					
				} else if( node['children'] != null && this.hasChildren(node['children'])) {
					
					return this.getChildren(node['children']);
					
				} else if ( node is ArrayCollection ) {
					
					return node as ArrayCollection;
					
				} else if ( node is Array) {
					
					var a:Array = (node as Array);
					var arr1:ArrayCollection = new ArrayCollection();
					for( var i:int=0; i<a.length; i++ ) {
						arr1.addItem(a[i]);
					}	
					return arr1
					
				} else if( node is Object ) {
				
					var arr:ArrayCollection = new ArrayCollection();
					for( var att:* in node ) {
						var o:Object = new Object();
						o['label'] = att;
						o['children'] = node[att];

						arr.addItem(o);
					}	
					return arr;
				
				} 
			
			} 
			catch (e:Error) {
				trace("[Descriptor] exception checking for getChildren");
			}
			
			return null;
			
		}
		
		public function hasChildren(node:Object, model:Object=null):Boolean
		{
			if (node == null) 
				return false;

			if( node is String || node is Number || node is Boolean) {
				
				return false;
				
			} else if( node['children'] != null ) {
				
				return this.hasChildren(node['children']);
			
			} else if ( node is ArrayCollection ) {
				
				if((node as ArrayCollection).length > 0)
					return true;
				else 
					return false;
				
			} else if ( node is Array) {
				
				if((node as Array).length > 0)
					return true;
				else 
					return false;
				
			} else if( node is Object ) {
				
				if( node['children'] != null && 
					(node['children'] is String || node['children'] is Number) )  
					return false;
				else 
					return true;
				
			}
			
			return false;
		
		}
		
		public function isBranch(node:Object, model:Object=null):Boolean
		{
			return hasChildren(node, model);
		}
		
		public function getData(node:Object, model:Object=null):Object
		{
			try {
				return node;
			}
			catch (e:Error) {
			}
			return null;		}
		
		public function addChildAt(parent:Object, newChild:Object, index:int, model:Object=null):Boolean
		{
			return false;
		}
		
		public function removeChildAt(parent:Object, child:Object, index:int, model:Object=null):Boolean
		{
			return false;
		}
	}
}