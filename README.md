# Hangul_Rime_Files（韓文方案）

#### ※ 請勿使用於商業營利相關行為
#### ※ Commercial use is prohibited

## 內含韓文三種不同鍵位方案

- [Hangul_2set](https://github.com/oniondelta/Hangul_Rime_Files/blob/main/Hangul_2set/README.md)

  > 最流行，左右手輪流按，手感佳

  > 有 Shift + [QWEROP] 鍵位，需習慣
  
- [Hangul_HNC](https://github.com/oniondelta/Hangul_Rime_Files/blob/main/Hangul_HNC/README.md)

  > 在韓文各種音碼鍵位中，有較短碼之優勢

- [Hangul_Onion_Structure](https://github.com/oniondelta/Hangul_Rime_Files/blob/main/Hangul_Onion_Structure/README.md)（自創洋蔥形碼鍵位）

  > 使用簡速字根，每字只要 2～3 碼，碼長最短

  > 前後韓文字會有切分變數，雖已用詞典去校正避免，但有時還是得選字


## 特殊鍵

單音特殊鍵只在 Hangul_HNC 和 Hangul_Onion_Structure 適用

- 後綴「 ; 」可出諺文對映漢字

- 後綴「 / 」可出諺文單音

- 後綴「 / 」「 / 」可出諺文單音（會合併之單音）

- 前綴「 = 」反查漢字其諺文發音


## hangeul2set_zeromenu 方案可隱藏候選項

該方案有用到 librime-lua 新函數 KeyEvent，務必更換新的 librime 核心，否則無效果且報錯，詳見[說明](https://github.com/oniondelta/Onion_Rime_Files/wiki/%E6%8E%A8%E8%96%A6-Rime-%E4%B8%BB%E7%A8%8B%E5%BC%8F%E5%AE%89%E8%A3%9D%E4%B9%8B%E7%89%88%E6%9C%AC%E5%92%8C%E6%96%B9%E6%B3%95) 

![193610423-fe3faffa-3143-45ab-a347-e9bba7b00425](https://user-images.githubusercontent.com/54584047/203571115-e429b0c6-5714-4456-95fa-a9667e3deec0.gif)


## 使用方案

1. 點右上綠色 〔↓Code〕 選擇 Download ZIP 下載

2. 解壓縮 ZIP 進入資料夾，選擇欲使用方案資料夾：Hangul_2set、Hangul_HNC、Hangul_Onion_Structure

3. 內含文件通通放入『 Rime 』用戶設定資料夾

4. 使用 Hangul_2set 或 Hangul_HNC 方案，另須把「lua」資料夾和「rime.lua」放入『 Rime 』用戶設定資料夾中

5. 按「重新部署」完成！


## 贊助 (Donate)

方案已持續更新五年以上！大改、新創、新增非常多功能！做了許多圖文說明！花了族繁不及備載的心力！

贊助 (Donate) 支持，讓 Rime 洋蔥一系列方案更新更有動力！

- [按此以〈綠界〉贊助 Donate：](https://p.ecpay.com.tw/D555162)

  #### [![donate1](https://payment.ecpay.com.tw/Upload/QRCode/202010/QRCode_170c287e-2db8-4b50-b87f-8d36500a3958.png)](https://p.ecpay.com.tw/D555162)

- [按此以〈歐付寶〉贊助 Donate：](https://qr.opay.tw/q1ql7)

  #### [![donate2](https://payment.opay.tw/Upload/Broadcaster/2294343/QRcode/QRCode_7AC0FA1CAD39F0B66CFD5513A2173D1A.png)](https://qr.opay.tw/q1ql7)

