package {
	import core.Level;
	
	import display.enemy.Enemy;
	import display.map.Map;
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
		
		//the names of these variables explain what they do
		public var isGameOver:Boolean;
		
		public var money:int;//how much money the player has to spend on turrets
		public var lives:int;//how many lives the player has
		
		public var rangeCircle:Shape = new Shape();
		public var enemyHolder:Sprite = new Sprite();
		
		
		public var map:Map;
		public var level:Level = new Level();
		
		private var txtLevel:TextField = new TextField();		
		private var txtMoney:TextField = new TextField();		
		private var txtLives:TextField = new TextField();		
		private var txtEnemiesLeft:TextField = new TextField();
		private var txtTimer:TextField = new TextField();
		
		private var screenWin:Win;
		private var screenLose:Lose;
		
		public function TowerDefense()
		{
			
			txtLevel.x = 
			txtMoney.x = 
			txtLives.x = 
			txtEnemiesLeft.x = 
			txtTimer.x = 10;
			
			txtLevel.y = 310;
			txtMoney.y = 330;
			txtLives.y = 350;
			txtEnemiesLeft.y = 370;
			txtTimer.y = 390;
			
			
			screenWin = new Win(this);
			screenLose = new Lose(this);
			
			screenLose.addEventListener(MouseEvent.CLICK, restartGame);
			screenWin.addEventListener(MouseEvent.CLICK, restartGame);
			
			addChild(txtLevel);
			addChild(txtMoney);
			addChild(txtLives);
			addChild(txtEnemiesLeft);
			addChild(txtTimer);
			
			rangeCircle.graphics.beginFill(0x006600,.5);
			rangeCircle.graphics.drawCircle(gridScaleHalf,gridScaleHalf,100);
			rangeCircle.graphics.endFill();
			
			map = new Map(this)
			addChild(map);
			
			addChild(enemyHolder);
			
			restartGame(null);
		}
		
		private function startGame():void{//we'll run this function every time a new level begins
			for(var i:int=0;i<level.enemyArray[level.currentLvl-1].length;i++){
				if(level.enemyArray[level.currentLvl-1][i] != 0){
					level.enemiesLeft ++;
				}
			}
		}
		
		private function restartGame(e:MouseEvent):void
		{
			if(contains(screenLose)) removeChild(screenLose);
			if(contains(screenWin)) removeChild(screenWin);
					
			initVars();
			map.makeRoad();
			startGame();
			
			addEventListener(Event.ENTER_FRAME, update);//adding an update function
		}
		
		private function gameOver():void
		{
			isGameOver=true;//set the game to be over
			
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		public function initVars():void{
			level.start();
			
			isGameOver = false;
			
			money=100;
			lives=20;
			
		}
		
		public function makeTurret(xValue:int,yValue:int):void{//this will need to be told the x and y values
			var turret:Turret = new Turret(this);//creating a variable to hold the Turret
			//changing the coordinates
			turret.x = xValue+gridScaleHalf;
			turret.y = yValue+gridScaleHalf;
			addChild(turret);//add it to the stage
		}
		
		private function update(e:Event):void{
			//if there aren't any levels left
			if(lives<=0){//if the user runs out of lives
				gameOver();
				addChild(screenLose);
			}else if(!isGameOver){
				
				makeEnemies();//we'll just make some enemies
				
				if(level.enemiesLeft==0){//if there are no more enemies left
					
					level.currentLvl ++;//continue to the next level
					
					if(level.currentLvl > level.enemyArray.length){
						addChild(screenWin);
						gameOver();
					}else{
						level.currentEnemy = 0;//reset the amount of enemies there are
						startGame();//restart the game
					}
					
				}
				//Updating the text fields
				txtLevel.text = 'Level '+level.currentLvl;
				txtMoney.text = '$'+money;
				txtLives.text = 'Lives: '+lives;
				txtEnemiesLeft.text = 'Enemies Left:  '+level.enemiesLeft;
				txtTimer.text = 'Time: '+level.timeElapsed;
			}
		}
		
		private function makeEnemies():void{//this function will add enemies to the field
			if(level.enemyTime < level.enemyLimit){//if it isn't time to make them yet
				level.enemyTime ++;//then keep on waiting
			} else {
				var theCode:int = level.enemyArray[level.currentLvl-1][level.currentEnemy];//get the code from the array
				if(theCode != 0){//if it isn't an empty space
					var newEnemy:Enemy = new Enemy(this, theCode);//then create a new enemy and pass in the code
					enemyHolder.addChild(newEnemy);//and add it to the enemyholder
				}
				level.currentEnemy ++;//move on to the next enemy
				level.enemyTime = 0;//and reset the time
			}
		}
	}
}
