with raylib;

procedure game is
   use raylib;
   use type raylib.int;
   use type raylib.c_float;

   last_button : Int;
   gamepad_count : Natural;
   subtype gamepad_id is raylib.int range 0..3;

   FPS : Int := 30;

   player : Texture2D;
   player_pos : Vector2 := (100.0, 100.0);
   move_step : constant C_Float := 1.0 / C_Float (FPS) * 64.0;
begin

   raylib.window.init (1200, 800, "The Struggle");

   player := raylib.textures.load_texture ("sprites/perso.png");

   -- gamepad detection not working
   gamepad_count := 0;
   for id in gamepad_id'range loop
     if raylib.core.is_gamepad_available (id)
     then gamepad_count  := gamepad_count + 1;
     else exit;
     end if;
   end loop;

   raylib.set_target_FPS (30);

   while not raylib.window.should_close loop

      last_button := raylib.core.get_gamepad_button_pressed;

      if last_button = 11 then player_pos.y := player_pos.y - move_step;
      elsif last_button = 12 then player_pos.x := player_pos.x + move_step;
      elsif last_button = 13 then player_pos.y := player_pos.y + move_step;
      elsif last_button = 14 then player_pos.x := player_pos.x - move_step;
      end if;

      raylib.begin_drawing;
      raylib.clear_background (raylib.RAYWHITE);

      raylib.text.draw_FPS (10, 10);
      raylib.text.draw ("Gamepad count : " & gamepad_count'img, 10, 42, 14, raylib.BLACK);
      raylib.text.draw ("Dernier boutton : " & last_button'img, 10, 60, 14, raylib.BLACK);
      raylib.textures.draw_texture_rec (player, (0.0, 0.0, 32.0, 32.0) , player_pos ,raylib.WHITE);

      raylib.end_drawing;

   end loop;

   raylib.textures.unload_texture (player);
   raylib.window.close;

end game;
