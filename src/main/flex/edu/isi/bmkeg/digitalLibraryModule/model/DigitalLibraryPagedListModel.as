package edu.isi.bmkeg.digitalLibraryModule.model
{
	import edu.isi.bmkeg.pagedList.model.PagedListModel;
	
	public class DigitalLibraryPagedListModel extends PagedListModel
	{
		
		public static var LIST_ID:String = "digitalLibrayCorpusList"

		public function DigitalLibraryPagedListModel()
		{
			super();
			this.id = LIST_ID;
		}
	}
}