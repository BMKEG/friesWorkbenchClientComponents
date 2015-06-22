package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Entity;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Interaction
	{
		public function Interaction(){}

		public var interaction_type:String;

		public var negative_information:Boolean;

		public var participant_a:Entity;

		public var participant_b:Entity;
	}
}