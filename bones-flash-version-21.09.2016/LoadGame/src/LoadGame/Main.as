package LoadGame
{
	import com.vk.MainVKBanner;
	import com.vk.MainVKBannerEvent;
	import com.vk.vo.BannersPanelVO;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.events.ProgressEvent;
	import flash.display.Bitmap;
	
	// ------------------------------------
	import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.net.URLLoader;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.system.Security;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;
	// ------------------------------------
		
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Main extends Sprite 
	{
		[Embed(source = '../../assets/background.jpg')]
		private var BackgroundImage:Class;
		private var _image:Bitmap = new BackgroundImage();
		
		[Embed(source = '../../assets/logo.png')]
		private var LogoImage:Class;
		private var _imageLogo:Bitmap = new LogoImage();
		
		
		private var _request:URLRequest;
		private var _loader:Loader;
		private var _loaderContext:LoaderContext;
		
		private var loader: Loader;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initGame();
			
			this.loader = new Loader();
			var context: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			context.securityDomain = SecurityDomain.currentDomain;
			try
			{
				// Загружается библиотека с указанным LoaderContext
				this.loader.load(new URLRequest('http://api.vk.com/swf/vk_ads.swf'), context);
				// По окончанию загрузки выполнится функция loader_onLoad
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.loader_onLoad);
			}
			catch (e: Error)
			{
				// если приложение запущено локально, то здесь можно разместить заглушку рекламного блока
				trace('Main.init; error:', e.message);
			}
		}
		
		private var _progressText:Label; // текст загрузки в процентах
		
		private function initGame(e:Event = null):void 
		{
			/* Текстовое отображение загругки в процентах */
			_progressText = new Label(638, 680, 200, 30, "Monotype Corsiva", 25, 0xFFFFAA, "Загрузка...", false);
			_progressText.text = "Загрузка ...";
			this.addChild(_progressText);
			
			_loader = new Loader();
			_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			_request = new URLRequest("http://app.vk.com/c420925/u99302165/968a79468a38a5.swf");
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadComplite);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadError);
			_loader.load(_request, _loaderContext);
		}
		
		private function LoadComplite(e:Event):void 
		{
			this.removeChild(_progressText);
			_progressText = null;
			this.addChild(_loader);
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			var nPercent:Number = Math.round((e.bytesLoaded / e.bytesTotal) * 100);    
			_progressText.text = "Загрузка " + nPercent.toString() + "%";
		}
		
		private function LoadError(e:IOErrorEvent):void 
		{
			_progressText.text = "Ошибка загрузки!!! ";
			trace("Error!!! " + e.toString() );
		}
		
		private function loader_onLoad(e: Event) : void 
		{
			// если библиотека загружена правильно, то выполнится функция initBanner, в ином случае вы получите ошибку 1014
			try
			{
				this.initBanner();
			}
			catch (e: Error)
			{
				trace('Main.loader_onLoad :', 'error: ', e.message);
			}
		}
		
		private function initBanner() : void 
		{
			var ad_unit_id: String = "75957"; // укажите тут свой id
			var block: MainVKBanner = new MainVKBanner(ad_unit_id); // создание баннера и присвоение ему id
			block.x = 860;
			block.y = 0;
			addChild(block); // добавление баннера на сцену
			
			var params: BannersPanelVO = new BannersPanelVO(); // создание класса параметров баннера
			// изменение стандартных параметров:
			params.demo = '0'; // 1 - показывает тестовые баннеры
			
			// вертикальный (AD_TYPE_VERTICAL) или горизонтальный (AD_TYPE_HORIZONTAL) блок баннеров
			params.ad_type = BannersPanelVO.AD_TYPE_VERTICAL; 
			// Вертикальный (AD_UNIT_TYPE_VERTICAL) или горизонтальный (AD_UNIT_TYPE_HORIZONTAL) баннер внутри блока баннеров
			params.ad_unit_type = BannersPanelVO.AD_UNIT_TYPE_VERTICAL;
			params.title_color = '#3C5D80'; // цвет заголовка 
			params.desc_color = '#010206'; // цвет описания
			params.domain_color = '#70777D'; // цвет ссылки
			params.bg_color = '#FFFFFF'; // цвет фона
			params.bg_alpha = 0.8; // прозрачность фона (0 - прозрачно, 1 - непрозрачно)
			
			// размер шрифта. FONT_SMALL, FONT_MEDIUM или FONT_BIG
			params.font_size = BannersPanelVO.FONT_MEDIUM;
			params.lines_color = '#E3E3E3'; // цвет разделителей
			params.link_color = '#666666'; // цвет надписи "Реклама ВКонтакте"
			params.ads_count = 3; // количество выдаваемых баннеров
			params.ad_width = 150; // максимальная ширина блока
			block.initBanner(this.loaderInfo.parameters, params); // инициализация баннера
			
			
			block.addEventListener(MainVKBannerEvent.LOAD_COMPLETE, this.banner_onLoad);
			block.addEventListener(MainVKBannerEvent.LOAD_IS_EMPTY, this.banner_onAdsEmpty);
			block.addEventListener(MainVKBannerEvent.LOAD_ERROR, this.banner_onError);
		}
		
		private function banner_onLoad(e: Event) : void 
		{
			// прячете альтернативную рекламу, в случае, если она показана
			trace('Main.banner_onLoad :');
		}
		
		private function banner_onAdsEmpty(e: Event) : void 
		{
			// показываете альтернативную рекламу
			trace('Main.banner_onAdsEmpty :');
		}
		
		private function banner_onError(e: Event) : void 
		{
			var event: MainVKBannerEvent = e as MainVKBannerEvent;
			trace('Main.banner_onError :', event.errorMessage, event.errorCode);
		}
		
	}
	
}