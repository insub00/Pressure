//TEXT LCD Control
#define FUNCSET         0x38    //function set          : 8bit address, 2Line display, 5x7 dot, duty 1/16       
#define FUN_ONELINE     0x30    //                      : 1Line display  ,5x7 dot,       
#define ENTMODE         0x06    // Entry mode Set       : address +1, shift right
#define ALLCLR          0x01    // All Clear            : back (1,1) DDRAM address Counter=1
#define DISPON          0x0c    // Display On           : Cursor off, All Character display
#define DISPOFF         0x08                          
#define CURON           0x0F    // Cursor On   
#define CUROFF          0x0C    
#define HOME            0x02    // Cursor Home
#define RSHIFT          0x1C    // Display Right Shift   
#define LSHIFT          0x18    // Display Left shift
#define N_RSHIFT        0x14    // only cursor shift
#define N_LSHIFT        0x10    //      "
// DDRAM이 최대 80글자까지 기억하므로, 1행은 0x00~0x27, 2행은 0x40~0x67
// 따라서 LINE1과 LINE3이 합쳐져서 1행, LINE2와 LINE4가 합쳐져서 2행이다
// 2*16 LCD의 경우는 16개를 디스플레이하면 나머지는 메모리에만 담겨져 있지만
// 4줄짜리는 그걸 모두 디스플레이한다. 

#define LINE1		(0x80 | 0x00)	// 화면 클리어없이 LINE만 첫째줄로 이동
#define LINE2       (0x80 | 0x40)   // 2nd Line Move    
#define LINE3		(0x80 | 0x14)
#define LINE4		(0x80 | 0x54)

#define LcdCursorOn()	{LcdCommandWrite(CURON);}
#define LcdCursorOff()	{LcdCommandWrite(CUROFF);}

extern void LcdInit(void);
extern void LcdCommandWrite(unsigned char Data);
extern void LcdDataWrite(unsigned char Data);
extern void LineDecision(unsigned char x, unsigned char y);
extern void Lcdprintf(unsigned char x, unsigned char y, flash char *form,...);
extern void LcdClear(void);
