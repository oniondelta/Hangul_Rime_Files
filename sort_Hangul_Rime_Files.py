
import os
import shutil
import time

#※新增資料夾(多層目錄, 如前一層data資料夾不存在, 將自動新增)※
os.makedirs('./sort_hangul_rime_files/', exist_ok=True)
os.makedirs('./sort_hangul_rime_files/other/', exist_ok=True)

#複製檔案(Hangul_2set)
shutil.copytree("./Hangul_2set/", "./sort_hangul_rime_files/Hangul_2set")
shutil.copyfile("./essay-kr-hanja.txt", "./sort_hangul_rime_files/Hangul_2set/essay-kr-hanja.txt")
shutil.copytree("./lua/", "./sort_hangul_rime_files/Hangul_2set/lua")
shutil.copyfile("./rime.lua", "./sort_hangul_rime_files/Hangul_2set/rime.lua")

#複製檔案(Hangul_HNC)
shutil.copytree("./Hangul_HNC/", "./sort_hangul_rime_files/Hangul_HNC")
shutil.copyfile("./essay-kr-hanja.txt", "./sort_hangul_rime_files/Hangul_HNC/essay-kr-hanja.txt")
shutil.copytree("./lua/", "./sort_hangul_rime_files/Hangul_HNC/lua")
shutil.copyfile("./rime.lua", "./sort_hangul_rime_files/Hangul_HNC/rime.lua")

#複製檔案(Hangul_Onion_Structure)
shutil.copytree("./Hangul_Onion_Structure/", "./sort_hangul_rime_files/Hangul_Onion_Structure")
shutil.copyfile("./essay-kr-hanja.txt", "./sort_hangul_rime_files/Hangul_Onion_Structure/essay-kr-hanja.txt")

#其他(other)
shutil.copytree('./cin/', './sort_hangul_rime_files/other/cin')
shutil.copytree('./trime/', './sort_hangul_rime_files/other/trime')




#增加日期
localtime=time.strftime("%Y%m%d", time.localtime())

os.rename('./sort_hangul_rime_files/Hangul_2set/', './sort_hangul_rime_files/Hangul_2set-'+localtime)
os.rename('./sort_hangul_rime_files/Hangul_HNC/', './sort_hangul_rime_files/Hangul_HNC-'+localtime)
os.rename('./sort_hangul_rime_files/Hangul_Onion_Structure/', './sort_hangul_rime_files/Hangul_Onion_Structure-'+localtime)

os.rename('./sort_hangul_rime_files/', './電腦RIME韓文方案-'+localtime)

