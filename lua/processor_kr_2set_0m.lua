--- @@ kr_2set_0m
--[[
（hangeul2set_zeromenu）
韓語 2set 零選項方案專用，使選單變為零。
--]]


local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}  --> {a=true,b=true...}
local set_number = Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}


local function kr_2set_0m(key,env)
  local engine = env.engine
  local context = engine.context

  --- pass ascii_mode
  if context:get_option('ascii_mode') then
    return 2

  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

  --- pass reverse_lookup prefix （使反查鍵可展示全部選項）
  elseif string.find(context.input, '=[a-z]*$') then
    return 2

  --- 修正「Shift+Return」commit_raw_input 設定失效問題
  elseif key:eq(KeyEvent("Shift+Return")) and (context:is_composing()) then
    engine:commit_text(context.input)
    context:clear()
    return 1

  --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
  -- local asciikeys = string.char(key.keycode)
  elseif set_char[string.char(key.keycode)] then
    context:reopen_previous_segment()
    context.input = context.input .. string.char(key.keycode)
    context:confirm_current_selection()
    return 1

  --- 修正尾綴「;」出漢字，使其可展示選單
  elseif key:repr() == 'semicolon' then
    context:reopen_previous_segment()
    context.input = context.input .. ';'
    return 1

  --- 修正「數字」不能直接上屏問題
  elseif set_number[key:repr()] and (not context:is_composing()) then
    engine:commit_text(key:repr())
    -- context:clear()
    return 1

  end
  return 2
end


return kr_2set_0m