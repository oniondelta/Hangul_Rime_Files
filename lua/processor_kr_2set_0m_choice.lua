--- @@ kr_2set_0m_choice
--[[
（hangeul2set_zeromenu）
韓語 2set 零選項方案專用，使選單變為零。
增加是否折疊選單之開關選項。
開關（space_mode）：輸出末位空白
開關（kr_0m）：是否折疊選單
--]]


-- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}  --> {a=true,b=true...}
local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}  --> {a=true,b=true...}
local set_number = Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}


local function kr_2set_0m_choice(key,env)
  local engine = env.engine
  local context = engine.context
  local hangul = context:get_commit_text()
  local caret_pos = context.caret_pos
  local o_ascii_mode = context:get_option("ascii_mode")
  local o_kr_0m = context:get_option("kr_0m")
  local o_space_mode = context:get_option("space_mode")


  --- pass ascii_mode
  if (o_ascii_mode) then
  -- if context:get_option('ascii_mode') then
    return 2


  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2


  --- 修正「Shift+Return」commit_raw_input 設定失效問題
  elseif key:repr() == "Shift+Return" and (context:is_composing()) then
  -- elseif key:eq(KeyEvent("Shift+Return")) and (context:is_composing()) then  -- KeyEvent 在官版小狼毫中會有問題
    engine:commit_text(context.input)
    context:clear()
    return 1

  --- pass reverse_lookup prefix （使反查鍵可展示全部選項）(沒開，即使 commit_composition 上屏，還是無法顯示選單)
  elseif string.find(context.input, "=[a-z]?[a-z]?[a-z]?[a-z]?[a-z]?$") then
    return 2


  --- 修正開頭輸入「數字」，不能直接上屏問題
  elseif set_number[key:repr()] and (not context:is_composing()) then
    engine:commit_text(key:repr())
    -- context:clear()
    return 1


  elseif (o_kr_0m) then
  -- elseif context:get_option("kr_0m") then

    --------------------------------------------
    --- 函數格式 ascii(key, "a-zQWERTOP")，function ascii(key,pat) 該函數需打開

    --- return char(0x20~0x7f) or ""
    local function ascii(key,pat)
      local pat = pat and ('^[%s]$'):format(pat) or "^.$"
      local code = key.keycode
      return key.modifier <=1 and
             code >=0x20 and code <=0x7f and
             string.char(code):match(pat) or ""
    end

    --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
    if set_char[ascii(key, "a-zQWERTOP")] then
      context:reopen_previous_segment()
      context.input = context.input .. ascii(key, "a-zQWERTOP")
      context:confirm_current_selection()
      return 1

    --------------------------------------------
    -- ---- 功能正常，但輸入時，錯誤日誌會報錯 char 超出範圍

    -- --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
    -- -- local asciikeys = string.char(key.keycode)  -- char 沒限定範圍會報錯
    -- if set_char[string.char(key.keycode)] then  -- char 沒限定範圍會報錯
    --   context:reopen_previous_segment()
    --   context.input = context.input .. string.char(key.keycode)  -- char 沒限定範圍會報錯
    --   context:confirm_current_selection()
    --   return 1

    --------------------------------------------
    -- ---- 最初方法，function check_qwertop() 該函數需打開

    -- local function check_qwertop()
    --   if key:eq(KeyEvent("Shift+Q")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+W")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+E")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+R")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+T")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+O")) then
    --     return true
    --   elseif key:eq(KeyEvent("Shift+P")) then
    --     return true
    --   else
    --     return false
    --   end
    -- end

    -- ---- 與上例函數一樣，只是用向下相容寫法
    -- local function check_qwertop()
    --   if key:repr() == "Shift+Q" then
    --     return true
    --   elseif key:repr() == "Shift+W" then
    --     return true
    --   elseif key:repr() == "Shift+E" then
    --     return true
    --   elseif key:repr() == "Shift+R" then
    --     return true
    --   elseif key:repr() == "Shift+T" then
    --     return true
    --   elseif key:repr() == "Shift+O" then
    --     return true
    --   elseif key:repr() == "Shift+P" then
    --     return true
    --   else
    --     return false
    --   end
    -- end

    -- --- 《最主要部分》使 [a-zQWERTOP] 組字且半上屏
    -- if set_char[key:repr()] or check_qwertop() then
    --   local lastword = string.gsub(key:repr(), "Shift%+", "")
    --   -- local lastword = key:repr():match("^[a-z]$") or ""
    --   context:reopen_previous_segment()
    --   context.input = context.input .. lastword
    --   context:confirm_current_selection()
    --   return 1

    --------------------------------------------

    --- 不在輸入狀態或是有選單時略過處理
    elseif (not context:is_composing()) or (context:has_menu()) then
      return 2

    --- 修正尾綴「;」出漢字，使其可展示選單
    elseif key:repr() == "semicolon" then
      context:reopen_previous_segment()
      context.input = context.input .. ";"
      return 1

    --- 使「\\」可分節
    elseif key:repr() == 'backslash' then
      context:reopen_previous_segment()
      context.input = context.input .. "\\"
      context:confirm_current_selection()
      return 1

    -- --- 修正組字時，按「向下」鍵輸入消失問題（ schema 內可設定，故關閉）
    -- elseif key:eq(KeyEvent("Down")) and string.find(context.input, "[^0-9]$") then
    --   context:reopen_previous_segment()
    --   -- context:confirm_current_selection()
    --   -- key:repr("Release+Right")  -- 無法作用
    --   -- engine:process_key("Right")  -- 輸入法會崩潰
    --   -- engine:process_key(KeyEvent("Right"))  -- 測試OK!
    --   return 1

    --- 修正輸入途中插入「數字」，無法半上屏，需按2次 enter 之問題，改直上屏
    elseif set_number[key:repr()] then
      -- context.input = context.input .. key:repr()
      -- context:confirm_current_selection()
      engine:commit_text(hangul .. key:repr())
      context:clear()
      return 1

    --- 增加一般韓文輸入法操作，空格上屏自動末端空一格。
    elseif (o_space_mode) and key:repr() == "space" and string.find(context.input, "^[a-zQWERTOP]+$") then  --只有韓文，不含漢字。如果漢字如此出字會不能記憶？
      -- if key:repr() == "space" and (context:is_composing()) and (not context:has_menu()) then
      -- if key:repr() == "space" and (context:is_composing()) and (not context:has_menu()) and (not string.find(hangul, "[%a%c%s]")) and (caret_pos == context.input:len()) then
      engine:commit_text(hangul .. " ")
      context:clear()
      return 1

    end


  elseif (not o_kr_0m) then
  -- elseif not context:get_option("kr_0m") then

    --- 不在輸入狀態略過處理
    if (not context:is_composing()) or (not o_space_mode) or key:repr() ~= "space" then
      return 2

    elseif string.find(context.input, "^[a-zQWERTOP]+$") and (not string.find(hangul, "[%a%c%s]")) and (caret_pos == context.input:len()) then
      engine:commit_text(hangul .. " ")
      context:clear()
      return 1

    end

  end


  return 2
end


return kr_2set_0m_choice