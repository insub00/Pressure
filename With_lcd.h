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
// DDRAM�� �ִ� 80���ڱ��� ����ϹǷ�, 1���� 0x00~0x27, 2���� 0x40~0x67
// ���� LINE1�� LINE3�� �������� 1��, LINE2�� LINE4�� �������� 2���̴�
// 2*16 LCD�� ���� 16���� ���÷����ϸ� �������� �޸𸮿��� ����� ������
// 4��¥���� �װ� ��� ���÷����Ѵ�. 

#define LINE1		(0x80 | 0x00)	// ȭ�� Ŭ������� LINE�� ù°�ٷ� �̵�
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
