package {
	import core.Level;
	
	import display.enemy.Enemy;
	import display.map.Block;
	import display.map.DirectBlock;
	import display.map.EmptyBlock;
	import display.map.Map;
	import display.map.RoadBlock;
	import display.screen.Lose;
	import display.screen.Win;
	import display.shooter.Turret;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	[SWF(width="550", height="400", frameRate="30", backgroundColor="#ffffff")]
	public class TowerDefense extends Sprite
	{
		public const blockWidth:int = 25;
		public const blockHalfWidth:Number = 12.5;
		
		//setting vars to step in for turns and special blocks
		private const S:String = 'START';
		private const F:String = 'FINISH';
		private const U:String = 'UP';
		private const R:String = 'RIGHT';
		private const D:String = 'DOWN';
		private const L:String = 'LEFT';
		
		//the names of these variables explain what they do
		public var isGameOver:Boolean;
		
		private var currentEnemy:int;//the current enemy that we're creating from the array
		private var enemyTime:int;//how many frames have elapsed since the last enemy was created
		private var enemyLimit:int;//how many frames are allowed before another enemy is created
		private var enemyArray:Array;//this array will tell the function when to create an enemy
		public var enemiesLeft:int;//how many enemies are left on the field
		
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
		
		private var screenWin:Win = new Win();
		private var screenLose:Lose = new Lose();
		
		public function TowerDefense()
		{
			
			txtLevel.x = 
			txtMoney.x = 
			txtLives.x = 
			txtEnemiesLeft.x = 10;
			
			txtLevel.y = 310;
			txtMoney.y = 330;
			txtLives.y = 350;
			txtEnemiesLeft.y = 370;
			
			screenLose.addEventListener(MouseEvent.CLICK, restartGame);
			screenWin.addEventListener(MouseEvent.CLICK, restartGame);
			
			addChild(txtLevel);
			addChild(txtMoney);
			addChild(txtLives);
			addChild(txtEnemiesLeft);
			
			rangeCircle.graphics.beginFill(0x006600,.5);
			rangeCircle.graphics.drawCircle(12.5,12.5,100);
			rangeCircle.graphics.endFill();
			
			map = new Map(this)
			addChild(map);
			
			addChild(enemyHolder);
			
			restartGame(null);
		}
		
		private function startGame():void{//we'll run this function every time a new level begins
			for(var i:int=0;i<enemyArray[level.currentLvl-1].length;i++){
				if(enemyArray[level.currentLvl-1][i] != 0){
					enemiesLeft ++;
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
			
			//reset all the stats
			currentEnemy = 0;
			enemyTime = 0;
			enemyLimit = 12;
			enemiesLeft = 0;
			
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		public function initVars():void{
			level.start();
			
			enemyArray = [
				[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],//1's will just represent an enemy to be created
				[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2],//another row means another level
				[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3],
				[100],
				[5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5,6,7,6,5],
				[250,250,250]
			];
			
			isGameOver = false;
			
			currentEnemy = 0;
			enemyTime = 0;
			enemyLimit = 12;
			money=100;
			lives=20;
			
		}
		
		public function makeTurret(xValue:int,yValue:int):void{//this will need to be told the x and y values
			var turret:Turret = new Turret(this);//creating a variable to hold the Turret
			//changing the coordinates
			turret.x = xValue+12.5;
			turret.y = yValue+12.5;
			addChild(turret);//add it to the stage
		}
		
		private function update(e:Event):void{
			//if there aren't any levels left
			if(lives<=0){//if the user runs out of lives
				gameOver();
				addChild(screenLose);
			}else if(!isGameOver){
				
				makeEnemies();//we'll just make some enemies
				
				if(enemiesLeft==0){//if there are no more enemies left
					
					level.currentLvl ++;//continue to the next level
					
					if(level.currentLvl > enemyArray.length){
						gameOver();
						addChild(screenWin);
					}else{
						currentEnemy = 0;//reset the amount of enemies there are
						startGame();//restart the game
					}
					
				}
				//Updating the text fields
				txtLevel.text = 'Level '+level.currentLvl;
				txtMoney.text = '$'+money;
				txtLives.text = 'Lives: '+lives;
				txtEnemiesLeft.text = 'Enemies Left:  '+enemiesLeft;
			}
		}
		
		private function makeEnemies():void{//this function will add enemies to the field
			if(enemyTime < enemyLimit){//if it isn't time to make them yet
				enemyTime ++;//then keep on waiting
			} else {//otherwise
				var theCode:int = enemyArray[level.currentLvl-1][currentEnemy];//get the code from the array
				if(theCode != 0){//if it isn't an empty space
					var newEnemy:Enemy = new Enemy(this, theCode);//then create a new enemy and pass in the code
					enemyHolder.addChild(newEnemy);//and add it to the enemyholder
				}
				currentEnemy ++;//move on to the next enemy
				enemyTime = 0;//and reset the time
			}
		}
	}
}
