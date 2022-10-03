--- @@ kr_2set_0m
--[[
（hangeul2set_zeromenu）
韓語 2set 零選項方案專用，使選單變為零。
--]]

local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" } --> {a=true,b=true...}
local set_number = Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

local function kr_2set_0m(key,env)
  local engine = env.engine
  local context = engine.context
  local ascii_m = context:get_option("ascii_mode")

  local function check_qwertop()
    if key:eq(KeyEvent("Shift+Q")) then
      return true
    elseif key:eq(KeyEvent("Shift+W")) then
      return true
    elseif key:eq(KeyEvent("Shift+E")) then
      return true
    elseif key:eq(KeyEvent("Shift+R")) then
      return true
    elseif key:eq(KeyEvent("Shift+T")) then
      return true
    elseif key:eq(KeyEvent("Shift+O")) then
      return true
    elseif key:eq(KeyEvent("Shift+P")) then
      return true
    else
      return false
    end
  end

  local check_prefix = string.find(context.input, '=[a-z]*$')  --match

  if (not ascii_m) and set_char[key:repr()] and (not check_prefix) or (not ascii_m) and check_qwertop() and (not check_prefix) then
    local addend = string.gsub(key:repr(), 'Shift%+', '')
    context:reopen_previous_segment()
    context.input = context.input .. addend
    context:confirm_current_selection()
    return 1

  -- 修正「;」使可展示選單
  elseif (not ascii_m) and key:repr() == 'semicolon' then
    context:reopen_previous_segment()
    context.input = context.input .. ';'
    return 1

  -- 修正「數字」不能直接上屏問題
  elseif (not ascii_m) and set_number[key:repr()] and (not context:is_composing()) then
    engine:commit_text(key:repr())
    -- context:clear()
    return 1

  -- 修正「Shift+Return」失效問題
  elseif (not ascii_m) and key:eq(KeyEvent("Shift+Return")) and (context:is_composing()) then
    engine:commit_text(context.input)
    context:clear()
    return 1

  end
  return 2
end

return kr_2set_0m
