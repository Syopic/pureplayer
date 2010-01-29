package ua.com.syo.model {
	public class VideoItem {
		
		public var id:String;
		public var videoUrl:String;
		public var startImageUrl:String;
		public var thumbUrl:String;
		public var title:String;
		public var description:String;
		public var date:String;
		public var url:String;
		
		
		public function VideoItem(xml:XML) {
			id = xml.@id;
			startImageUrl = xml.@image;
			videoUrl = xml.@video;
			thumbUrl = xml.@thumb;	
			title = xml.title;
			url = xml.@url;
		}
	}
}