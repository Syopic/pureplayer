package ua.com.syo.data {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	public class CurrentData extends EventDispatcher {
		
		/**
		 * Singleton
		 */
		private static var _instance:CurrentData;

		public static function get instance():CurrentData {
			if (_instance == null) {
				_instance = new CurrentData();
			}
			return _instance;
		}
		
		private var playlistXML:XML;
		
		private var rootURL:String;
		
		private var id:String;
		private var imageURL:String;
		public var videoURL:String;
		private var thumbURL:String;
		
		public var startImage:Sprite;
		
		private var loader:Loader;
		/* <playlist root="D:/_work/FlexWorkspace/PurePlayer/assets/itemtest/">
		  <item id="1" video="depeche.flv" image="splash.jpg" thumb="thumb.jpg">
		    <title>
		      <![CDATA[Title text]]>
		    </title>
		    <description>
		      <![CDATA[Description text]]>
		    </description>
		    <date>
		      12.11.2008
		    </date>
		  </item>
		</playlist> */
		
		public function parsePlayList(xml:XML):void {
			playlistXML = xml;
			
			rootURL = xml.@root;
			var firstItem:XMLList = xml.item;
			
			id = firstItem.@id;
			imageURL = firstItem.@image;
			videoURL = firstItem.@video;
			thumbURL = firstItem.@thumb;
			
			loadStartImage();
		}
		
		private function loadStartImage():void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, startImageLoadedHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, assetLoadedErrorHandler);
			var request:URLRequest = new URLRequest(rootURL + imageURL);
			loader.load(request);
			
		}
		
		private function startImageLoadedHandler(event:Event):void {
			 loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, startImageLoadedHandler);
			 loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, assetLoadedErrorHandler);
			 dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function assetLoadedErrorHandler(eevent:IOErrorEvent):void {
			//Error
		}
		
		public function getStartImage():Bitmap {
			return loader.content as Bitmap;
		}
	}
}