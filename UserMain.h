
// =====PGM Ver======
//#define VERSION	"01"
//#define VERSION	"02"
//#define VERSION	"03"
//#define VERSION	"04"
//#define VERSION	"05"	// 15.04.22 이원욱D 요청
#define VERSION	"06"	// 15.04.23 Step별 압력 진행중 알람시 초기화 추가 및 문구 수정

#define PRESSURE_RETURN 200     // 15.01.27 SEC 이원욱D 승인완료
#define PRESSURE_STOP 0
#define PRESSURE_NOMAL 200
#define PRESSURE_Y_DOWN 100
#define PRESSURE_EXHAUST2 20

// =======================DeFault Value Setting==============================
// OCTA MODE Default Value
#define OCTA_PRESSURE			550			// 5.5kgf (10kgf 단위)
#define OCTA_PRESSURE_TIME		117			// 11.7초 (100ms 단위)

// TYPE MODE Default Value
#define TYPE_PRESSURE			300			// 3kgf (10kgf 단위)
#define TYPE_PRESSURE_TIME		46			// 4.6초 (100ms 단위)

// BATTERY MODE Default Value
#define BATTERY_PRESSURE		550			// 5.5kgf (10kgf 단위)
//#define BATTERY_PRESSURE_TIME	47			// 4.7초 (100ms 단위)
#define BATTERY_PRESSURE_TIME	117			// 11.7초 (100ms 단위)	// 15.04.22 이원욱D 요청
// ==========================================================================

#define PRESSURE_STEP_MIN			2		// Hidden Pressure Step Min
#define PRESSURE_STEP_MAX			10		// Hidden Pressure Step Max
#define PRESSURE_STEP_DELAY_MIN		1		// Hidden Pressure Step Delay Min
#define PRESSURE_STEP_DELAY_MAX		10		// Hidden Pressure Step Delay Max

#define PRESSURE_STEP_DEFAULT		6			// 압력 Step 기본설정값
#define PRESSURE_STEP_DELAY_DEFAULT		1		// 압력 Step Delay 기본설정값


void CommSubroutine(void);
void RunSubroutine(void);
void KeySubroutine(void);
void DisplaySubroutine(void);
void PressureRewardSubroutine(void);
void StepPressureSubroutine(void);
void PressureCheckSubroutine(void);


