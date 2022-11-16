{*******************************************************************************************
*
*   PROJECT:        BLOCKS GAME
*   LESSON 02:      basic drawing
*   DESCRIPTION:    Basic shapes drawing (lines, circles, rectangles)
*
*   Example originally created with raylib 2.0, last time updated with raylib 4.2

*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2022 Ramon Santamaria (@raysan5)
*   Pascal translation 2022 Vadim Gunko (@guvacode)
*
********************************************************************************************}

program blocks_game_drawing;

{$mode objfpc}{$H+}

uses 
cmem, raylib;

// LESSON 01: Window initialization and screens management
type
  TGameScreen = (LOGO, TITLE, GAMEPLAY, ENDING);

  // Player structure
  TPlayer = record
    position : TVector2;
    speed    : TVector2;
    size     : TVector2;
    bounds   : TRectangle;
    lifes    : Integer;
  end;

 // Ball structure
 TBall = record
   position : TVector2;
   speed    : TVector2;
   radius   : Integer;
   active   : Boolean;
 end;

 // Bricks structure
 TBrick = record
   position : TVector2;
   size     : TVector2;
   bounds   : TRectangle;
   active   : Boolean;
end;

const
  screenWidth = 800;
  screenHeight = 450;
  PLAYER_LIFES = 5;
  BRICKS_LINES = 5;
  BRICKS_PER_LINE = 20;
  BRICKS_POSITION_Y = 50;

var
  screen: TGameScreen;
  framesCounter, gameResult: Integer;
  gamePaused: Boolean;
  player: TPlayer;
  ball: TBall;
  bricks: array [0..BRICKS_LINES, 0..BRICKS_PER_LINE] of TBrick;
  i,j : integer;

begin
  //--------------------------------------------------------------------------------------
  // Initialization
  //--------------------------------------------------------------------------------------

  // LESSON 01: Window initialization and screens management
  InitWindow(screenWidth, screenHeight, 'PROJECT: BLOCKS GAME');

  // NOTE: Load resources (textures, fonts, audio) after Window initialization
  // Game required variables
  screen := LOGO;       // Current game screen state

  framesCounter := 0;          // General pourpose frames counter
  gameResult := -1;            // Game result: 0 - Loose, 1 - Win, -1 - Not defined
  gamePaused := false;         // Game paused state toggle

  // Initialize player
  player.position := Vector2Create( screenWidth/2, screenHeight*7/8 );
  player.speed := Vector2Create( 8.0, 0.0 );
  player.size := Vector2Create( 100, 24 );
  player.lifes := PLAYER_LIFES;

  // Initialize ball
  ball.radius := 10;
  ball.active := false;
  ball.position := Vector2Create( player.position.x + player.size.x/2, player.position.y - ball.radius*2 );
  ball.speed := Vector2Create( 4.0, 4.0 );

  // Initialize bricks
  for  j:= 0 to BRICKS_LINES -1 do
     for i:=0 to BRICKS_PER_LINE -1 do
      begin
          bricks[j][i].size := Vector2Create( screenWidth/BRICKS_PER_LINE, 20 );
          bricks[j][i].position := Vector2Create( i*bricks[j][i].size.x, j*bricks[j][i].size.y + BRICKS_POSITION_Y );
          bricks[j][i].bounds := RectangleCreate( bricks[j][i].position.x, bricks[j][i].position.y, bricks[j][i].size.x, bricks[j][i].size.y );
          bricks[j][i].active := true;
      end;

  SetTargetFPS(60);            // Set desired framerate (frames per second)

  //--------------------------------------------------------------------------------------

  // Main game loop
  while not WindowShouldClose() do  // Detect window close button or ESC key
    begin
      // Update
      case screen of
        LOGO:
          begin
          // Update LOGO screen data here!
            Inc(framesCounter);
            if framesCounter > 180 then
              begin
                screen := TITLE;    // Change to TITLE screen after 3 seconds
                framesCounter := 0;
              end;
          end;

        TITLE:
          begin
          // Update TITLE screen data here!
            Inc(framesCounter);
            // LESSON 03: Inputs management (keyboard, mouse)
            if IsKeyPressed(KEY_ENTER) then screen := GAMEPLAY;
          end;

        GAMEPLAY:
          begin
          // Update GAMEPLAY screen data here!
            if not gamePaused then
            begin
            // TODO: Gameplay logic
            end;
            if IsKeyPressed(KEY_ENTER) then screen := ENDING;
          end;

        ENDING:
          begin
          // Update END screen data here!
            Inc(framesCounter);
            // LESSON 03: Inputs management (keyboard, mouse)
            if IsKeyPressed(KEY_ENTER) then screen := TITLE;
          end;
      end;

      // Draw
      //----------------------------------------------------------------------------------
      BeginDrawing();
        ClearBackground(RAYWHITE);

        case screen of

          LOGO:
            begin
              // TODO: Draw LOGO screen here!
              DrawText('LOGO SCREEN', 20, 20, 40, LIGHTGRAY);
              DrawText('WAIT for 3 SECONDS...', 290, 220, 20, GRAY);
            end;

          TITLE:
            begin
              // TODO: Draw TITLE screen here!
              DrawRectangle(0, 0, screenWidth, screenHeight, GREEN);
              DrawText('TITLE SCREEN', 20, 20, 40, DARKGREEN);

              if (framesCounter div 30) mod 2 = 0 then
              DrawText('PRESS [ENTER] to START', GetScreenWidth div 2 - MeasureText('PRESS [ENTER] to START', 20) div 2,
              GetScreenHeight div 2 + 60, 20, DARKGRAY);
            end;

          GAMEPLAY:
            begin
              // TODO: Draw GAMEPLAY screen here!
              // LESSON 02: Draw basic shapes (circle, rectangle)
              DrawRectangle(Round(player.position.x), Round(player.position.y),
                            Round(player.size.x), Round(player.size.y), BLACK);   // Draw player bar

              DrawCircleV(ball.position, ball.radius, MAROON);    // Draw ball

              // Draw bricks
              for j:=0 to BRICKS_LINES-1 do
                for i:=0 to BRICKS_PER_LINE-1 do
                  begin
                      if (bricks[j][i].active) then
                        begin
                          if (i + j) mod 2 = 0 then
                            DrawRectangle(Round(bricks[j][i].position.x),
                                          Round(bricks[j][i].position.y),
                                          Round(bricks[j][i].size.x),
                                          Round(bricks[j][i].size.y), GRAY)
                          else
                            DrawRectangle(Round(bricks[j][i].position.x),
                                          Round(bricks[j][i].position.y),
                                          Round(bricks[j][i].size.x),
                                          Round(bricks[j][i].size.y), DARKGRAY);
                        end;
                  end;
              // Draw GUI: player lives
              for i:=0 to player.lifes-1 do DrawRectangle(20 + 40*i, screenHeight - 30, 35, 10, LIGHTGRAY);

              // Draw pause message when required
              if gamePaused then DrawText('GAME PAUSED', screenWidth div 2 - MeasureText('GAME PAUSED', 40) div 2, screenHeight div 2 + 60, 40, GRAY);
            end;

          ENDING:
            begin
              // TODO: Draw ENDING screen here!
              DrawText('ENDING SCREEN', 20, 20, 40, DARKBLUE);
              if (framesCounter div 30) mod 2 = 0 then
                DrawText('PRESS [ENTER] TO PLAY AGAIN', GetScreenWidth div 2 - MeasureText('PRESS [ENTER] TO PLAY AGAIN', 20) div 2,
                GetScreenHeight div 2 + 80, 20, GRAY);
            end;
        end;

      EndDrawing();
    end;

  // De-Initialization

  // NOTE: Unload any loaded resources (texture, fonts, audio)
  CloseWindow();        // Close window and OpenGL context

end.

