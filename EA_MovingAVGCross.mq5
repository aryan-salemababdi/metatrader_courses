//+------------------------------------------------------------------+
//|                                            EA_MovingAVGCross.mq5 |
//|                                                 Aryan Salemabadi |
//|                             https://github.com/aryan-salemababdi |
//+------------------------------------------------------------------+
#property copyright "Aryan Salemabadi"
#property link      "https://github.com/aryan-salemababdi"
#property version   "1.00"

MqlRates candles[];
MqlTick tick;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
   int ma_Handle;
   double ma_Buffer[];
int OnInit()
  {
//---
   
   ma_Handle = iMA(_Symbol, _Period, 7, 0, MODE_EMA, PRICE_CLOSE);
   if(ma_Handle<0){
      Alert("Error: handle not initialize properly");
      return(-1);
   }
   else {
      ChartIndicatorAdd(0, 0, ma_Handle); 
   }
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
     IndicatorRelease(ma_Handle);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   CopyBuffer(ma_Handle, 0, 0, 3, ma_Buffer);
   ArraySetAsSeries(ma_Buffer, true);
   Comment("index 0:" + ma_Buffer[0] + "\n" + 
            "index 1:" + ma_Buffer[1]);
  }
//+------------------------------------------------------------------+
