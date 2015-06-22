package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Feature;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Mutation extends Feature
	{
		public function Mutation(){}

		public var site:int;

		public var from_base:String;

		public var to_base:String;
	}
}