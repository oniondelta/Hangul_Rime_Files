--- @@ 零選項
--[[
（hangeul2set）
韓語零選項" "
--]]

local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" } --> {a=true,b=true...}
local set_number = Set {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

local function kr_2set_0m(key,env)
  local engine = env.engine
  local context = engine.context
  local ascii_m = context:get_option("ascii_mode")
  -- local orig_es = context:get_commit_text()

  local function check_qwertop()
    -- local key_s_q= KeyEvent("Shift+Q")
    -- local key_s_w= KeyEvent("Shift+W")
    -- local key_s_e= KeyEvent("Shift+E")
    -- local key_s_r= KeyEvent("Shift+R")
    -- local key_s_t= KeyEvent("Shift+T")
    -- local key_s_o= KeyEvent("Shift+O")
    -- local key_s_p= KeyEvent("Shift+P")
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

  -- local hot_key = KeyEvent("Shift+q")
  -- local hot_key= KeyEvent("Shift+4")
  -- hot_key:repr()
  -- local iii = context.input
  -- local i2 = string.match(iii, "[QWERTOP]")

  if (not ascii_m) and set_char[key:repr()] and (not check_prefix) or (not ascii_m) and check_qwertop() and (not check_prefix) then
  -- if set_char[key:repr()] or key:eq(EventKey('shift+P')) and (not ascii_m) then
  -- if set_char[key:repr()] or i2~=nil and (not ascii_m) then
  -- if set_char[key:repr()] and (not ascii_m) then

    local addend = string.gsub(key:repr(), 'Shift%+', '')
    -- local addend_c = string.find(addend, '^[a-zQWERTOP]$')
    -- if (not addend_c) then
    --   addend=''
    --   return
    -- end

    context:reopen_previous_segment()
    -- context:confirm_current_selection()

    -- context.input = context.input
    context.input = context.input .. addend

    -- context.input:push(key:repr())
    -- context.input:push('dj')
    -- engine:process_key("c")
    -- engine:process_key("Left")
    context:confirm_current_selection()

    -- engine:commit_text("()")
    -- context:clear()
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








-- local function kr1_p(key,env) -- lua_processor@xxx 
--   local kRejected, kAccepted, kNoop = 0,1,2
--   local context= env.engine.context
--   if key:repr() == "a" then 
--       context:push("j")  -- 將~~ a 加入 context.input
--       return kAccepted  -- 收下此~~key  
--   elseif key:repr() == "b" then 
--       return kRejected   --  librime 不處理
--  elseif key:repr() == "c" then 
--        return kNoop   -- 此~~processor 不處理
--  elseif key:repr() == "d" then 
      
--  end
--   return kNoop
-- end






-- local keycher=     key:modify ==0  and string.char( key.keycode)
--       if  keycher=="c" then    --  max_level  -- 預設層數 
--              context.input:push(keycher) 
--              env.engine:process_key("c")
--       end 
--       if keycher == "d"  and env.engine.count_level < 10 then  -- 用戶自行限制層數
--             context.input:push(keycher)
--             env.engine:process_key("d")
--        end 
-- end

-- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"} --> {a=true,b=true...}
-- function kr1_p(key,env)
--   if set_char[key:repr()] then

-- local function kr1_p(key, env)
--   local engine = env.engine
--   local context = engine.context
  -- local input = context.input
  -- local check_input = string.find(context.input, 'sj$')
  -- local caret_pos_es = context.caret_pos
  -- local orig_es = context:get_commit_text()
  -- local arr = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}
  --- accept: space_do_space when: composing
  -- if (isintable(key:repr(),arr)) and (context:is_composing()) then
-- if (check_input) then

  -- if (isintable(key:repr(),arr)) then --"Release+Shift_L+[QWERTOP]"

  -- if (isintable(key:repr(),arr)) or key:repr() == "Release+Shift_L" then --"Release+Shift_L+[QWERTOP]"

    -- local caret_pos_es = context.caret_pos
    -- local orig_es = context:get_commit_text()
    -- local orig_es = context:get_commit_composition()
    -- local orig_es = context:commit()
    -- local orig_es = context:get_script_text()
    -- local orig_es = string.gsub(context:get_script_text(), " ", "a")
    -- 以下「含有英文字母、控制字元、空白」和「切分上屏時」不作用（用字數統計驗證是否切分）
    -- if (not string.find(orig_es, "[%a%c%s]")) and (caret_pos_es == context.input:len()) then
    -- if (not string.find(orig_es, "[%a%c%s]")) and (caret_pos_es == context.input:len()) then
    -- if (string.find(orig_es, "[%a%c%s]")) and (caret_pos_es == context.input:len()) then
      -- local orig_es = context:get_commit_text()
      -- 下一句：游標位置向左一格，在本例無用，單純記錄用法
      -- context.caret_pos = caret_pos - 1
      -- 下兩句合用可使輸出句被電腦記憶
      -- engine:commit_text("a")
      -- engine:confirm_current_selection()
      -- 下一句：用冒號為精簡寫法，該句為完整寫法
      -- engine.commit_text(engine, orig_es .. "a")
      -- engine:commit_text(orig_es .. "a")
      -- context:push( 'j' )
      -- context:confirm_current_selection() --「return 1」時用
      -- context:push('r')


      -- context.input = context.input .. key:repr()
      -- key.keycode = 0
      -- context:confirm_current_selection()
      -- save_log( context.input .. "\n")


--   -- local orig_es = context:get_commit_text()
--   --     engine:commit_text(orig_es) --「return 0」「return 2」時用
--   --     context:clear()
--       return 1 -- kAccepted
--       -- 「0」「2」「kAccepted」「kRejected」「kNoop」：直接後綴產生空白
--       -- 「1」：後綴不會產生空白，可用.." "增加空白或其他符號
--       -- （該條目有問題，實測對應不起來）「拒」kRejected、「收」kAccepted、「不認得」kNoop，分別對應返回值：0、1、2。
--       -- 返回「拒絕」時，雖然我們已經處理過按鍵了，但系統以為沒有，於是會按默認值再處理一遍。
--     -- end
--   end
--   return 2 -- kNoop
--   -- end
-- end








-- local function isintable(value,tb)
--   for k,v in pairs(tb) do
--     if v == value then
--     return true
--     end
--   end
--   return false
-- end

-- local function Set(tab)
--   local rtab = {}
--   for i,v in ipairs(tab) do  rtab[v]=true  end
--   return rtab
-- end

-- local ktab={"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}
-- local key= Set(ktab)

-- local function t1()
--   local tab = Set{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}
--   return tab['p']
-- end

-- local function t2()
--   return key['p']
-- end

-- local function t3()
--   return ('p'):match('^[a-zQWERTOP]$') and true
-- end

-- local function chk(chr, tab)
--   for i,v in ipairs(tab) do 
--     if chr == v then return true end
--   end
-- end

-- local function t4()
--   local  ktab={"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"}
--   return chk('p', ktab)
-- end


-- local function t5()
--   return chk('p',ktab)
-- end

-- local set_char = Set {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" , "Q", "W", "E", "R", "T" ,"O" ,"P"} --> {a=true,b=true...}


-- -- test
-- function test(func,msg, time)
--   local t1=os.clock()
--   for i=1,time do  func() end
--   print(msg,os.clock() - t1)
-- end

-- n=10000
-- test(t1,'init Set in t1 func', n)
-- test(t2, 'init Set out of t2 func ', n)
-- test(t3, ' string.match ',n)
-- test(t4, ' loop chk, init arr in func' , n)
-- test(t5, ' loop chk  init arr out of func' ,n )

