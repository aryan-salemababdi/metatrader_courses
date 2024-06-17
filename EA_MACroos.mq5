//+------------------------------------------------------------------+
//|                                                   EA_MACroos.mq5 |
//|                                                 Aryan Salemabadi |
//|                             https://github.com/aryan-salemababdi |
//+------------------------------------------------------------------+
#property copyright "Aryan Salemabadi"
#property link      "https://github.com/aryan-salemababdi"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Input Parameters                          |
//+------------------------------------------------------------------+
input group "Moving Avereage inputs"
sinput string sp; //--fast MA inputs
input int ma_fast_p = 12;
input ENUM_MA_METHOD ma_fast_method = MODE_SMA;
input ENUM_APPLIED_PRICE ma_fast_app = PRICE_CLOSE;
input ENUM_TIMEFRAMES ma_fast_tm = PERIOD_H1;
sinput string sp1; //--slow MA inputs
input int ma_slow_p = 32;
input ENUM_MA_METHOD ma_slow_method = MODE_SMA;
input ENUM_APPLIED_PRICE ma_slow_app = PRICE_CLOSE;
input ENUM_TIMEFRAMES ma_slow_tm = PERIOD_H1;

input group "Automatic Trading Inputs"
input int TK = 100; //pip
input int SL = 30; //pip
input double lots_vol = 0.01;

//+------------------------------------------------------------------+
//| Indicators variables                                                                  |
//+------------------------------------------------------------------+
int ma_fast_handle;
double ma_fast_buffer[];

int ma_slow_handle;
double ma_slow_buffer[];


//+------------------------------------------------------------------+
//| Global variables                                                                  |
//+------------------------------------------------------------------+
MqlRates candle[];
MqlTick tick;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   ma_fast_handle = iMA(_Symbol, ma_fast_tm, ma_fast_p, 0, ma_fast_method, ma_fast_app);
   ma_slow_handle = iMA(_Symbol, ma_slow_tm, ma_slow_p, 0, ma_slow_method, ma_slow_app);
   if (ma_fast_handle < 0 || ma_slow_handle < 0) {
   Alert("init failed");
   return(INIT_FAILED);
   }
   CopyRates(_Symbol, _Period, 0, 5, candle);
   ArraySetAsSeries(candle, true);
   ChartIndicatorAdd(0, 0, ma_fast_handle);
   ChartIndicatorAdd(0, 0, ma_slow_handle);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   IndicatorRelease(ma_fast_handle);
   IndicatorRelease(ma_slow_handle);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

         
      
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Functions for auto trading                                                     |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|Functions for signaling and strategy visualization                                       |
//+------------------------------------------------------------------+
void drawBuySignal(string name, datetime dt, double price, color clr=clrBlue){
   
   ObjectDelete(0, name);
   ObjectCreate(0, name, OBJ_ARROW_UP, 0, dt, price);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 6);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_TOP);
   
   
}
void drawSellSignal(string name, datetime dt, double price, color clr=clrRed){

   
   ObjectDelete(0, name);
   ObjectCreate(0, name, OBJ_ARROW_DOWN, 0, dt, price);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 6);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_TOP);

}
void drawExitSignal(string name, datetime dt, double price, color clr=clrPurple){

   
   ObjectDelete(0, name);
   ObjectCreate(0, name, OBJ_ARROW_STOP, 0, dt, price);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 6);
   ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_TOP);

}

//+------------------------------------------------------------------+
//| Utils Functions                                                                |
//+------------------------------------------------------------------+

bool isNewBar(){
   bool newBar = false;
   
   static datetime last_time = 0;
   
   datetime lastBar_time = (datetime)SeriesInfoInteger(Symbol(), Period(), SERIES_LASTBAR_DATE);
    
    if(lastBar_time == 0){
      newBar = false;
    }
    else if(lastBar_time != lastBar_time) {
    newBar = true;
    }
    
   return newBar;
}