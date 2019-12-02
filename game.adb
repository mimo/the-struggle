with raylib;

procedure game is
   use raylib;
   use raylib.core;

   FPS : constant int := 30;

   player : Texture2D;
   player_pos : Vector2 := (100.0, 100.0);
   player_bounds : constant Rectangle := (0.0, 0.0, 32.0, 32.0);
   player_speed  : constant Float := 1.0 / Float (FPS) * 64.0;
begin

   raylib.window.init (1200, 800, "The Struggle");

   player := raylib.textures.load ("sprites/perso.png");

   raylib.set_target_FPS (30);

   while not raylib.window.should_close loop

      if is_gamepad_button_down (
            GAMEPAD_PLAYER1,
            GAMEPAD_BUTTON_LEFT_FACE_UP)
      then
         player_pos.y := player_pos.y - player_speed;
      end if;

      if is_gamepad_button_down (
            GAMEPAD_PLAYER1,
            GAMEPAD_BUTTON_LEFT_FACE_LEFT)
      then
         player_pos.x := player_pos.x - player_speed;
      end if;

      if is_gamepad_button_down (
            GAMEPAD_PLAYER1,
            GAMEPAD_BUTTON_LEFT_FACE_RIGHT)
      then
         player_pos.x := player_pos.x + player_speed;
      end if;

      if is_gamepad_button_down (
         GAMEPAD_PLAYER1,
         GAMEPAD_BUTTON_LEFT_FACE_DOWN)
      then
         player_pos.y := player_pos.y + player_speed;
      end if;

      raylib.begin_drawing;
      raylib.clear_background (raylib.RAYWHITE);

      raylib.text.draw_FPS (10, 10);
      textures.draw_texture_rec (
         player,
         player_bounds,
         player_pos,
         raylib.WHITE);

      raylib.end_drawing;

   end loop;

   raylib.textures.unload (player);
   raylib.window.close;

end game;
