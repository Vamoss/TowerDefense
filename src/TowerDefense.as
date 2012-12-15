package {
	import core.Level;
	
	import display.enemy.Enemy;
	import display.map.Map;
	import display.screen.Game;
	import display.screen.Lose;
	import display.screen.Win;
	import display.shooter.Turret;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	//TODO:
	//metas passar de fase em 10s
	//bola especial
	//inimigos que nao devem morrer
	//controlar atiradores
	
	[SWF(width="550", height="400", frameRate="30", backgroundColor="#ffffff")]
	public class TowerDefense extends Sprite
	{
		public const gridScale:int = 25;
		public const gridScaleHalf:Number = 12.5;
		
		private var win:Win;
		private var lose:Lose;
		public var game:Game;
		
		public function TowerDefense()
		{
			win = new Win(this);
			lose = new Lose(this);
			game = new Game(this);
			
			lose.addEventListener(MouseEvent.CLICK, restartGame);
			win.addEventListener(MouseEvent.CLICK, restartGame);
			
			game.addEventListener(Game.WIN, gameWin);
			game.addEventListener(Game.LOSE, gameLose);
			
			restartGame(null);
		}
		
		private function gameWin(e:Event):void
		{
			if(contains(game)) removeChild(game);
			
			addChild(win);
		}
		
		private function gameLose(e:Event):void
		{
			if(contains(game)) removeChild(game);
			
			addChild(lose);
		}
		
		private function restartGame(e:MouseEvent):void
		{
			if(contains(lose)) removeChild(lose);
			if(contains(win)) removeChild(win);
			
			game.reset();
			addChild(game);
		}
	}
}
