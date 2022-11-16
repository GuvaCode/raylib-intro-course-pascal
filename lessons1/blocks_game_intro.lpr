{*******************************************************************************************
*
*   PROJECT:        BLOCKS GAME
*   LESSON 01:      raylib intro
*   DESCRIPTION:    Introduction to raylib and the basic videogames life cycle
*
*   Example originally created with raylib 2.0, last time updated with raylib 4.2

*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2017-2022 Ramon Santamaria (@raysan5)
*   Pascal translation 2022 Vadim Gunko (@guvacode)
*
********************************************************************************************}

program blocks_game_intro;

{$mode objfpc}{$H+}

uses 
cmem, raylib;

// LESSON 01: Window initialization and screens management
type
  TGameScreen = (LOGO, TITLE, GAMEPLAY, ENDING);


// TODO: Define required structs

const
  screenWidth = 800;
  screenHeight = 450;

var
  screen: TGameScreen;
  framesCounter, gameResult: Integer;
  gamePaused: Boolean;

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

  // TODO: Define and Initialize game variables

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
              DrawText('PRESS ENTER or TAP to JUMP to GAMEPLAY SCREEN', 120, 220, 20, DARKGREEN);
            end;

          GAMEPLAY:
            begin
              // TODO: Draw GAMEPLAY screen here!
              DrawRectangle(0, 0, screenWidth, screenHeight, PURPLE);
              DrawText('GAMEPLAY SCREEN', 20, 20, 40, MAROON);
              DrawText('PRESS ENTER or TAP to JUMP to ENDING SCREEN', 130, 220, 20, MAROON);
            end;

          ENDING:
            begin
                // TODO: Draw ENDING screen here!
                DrawRectangle(0, 0, screenWidth, screenHeight, BLUE);
                DrawText('ENDING SCREEN', 20, 20, 40, DARKBLUE);
                DrawText('PRESS ENTER or TAP to RETURN to TITLE SCREEN', 120, 220, 20, DARKBLUE);
            end;
        end;


      EndDrawing();
    end;

  // De-Initialization

  // NOTE: Unload any loaded resources (texture, fonts, audio)
  CloseWindow();        // Close window and OpenGL context

end.

