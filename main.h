
// Type Define
typedef enum{RUN_STOP = 0,  RUN_START_DELAY, RUN_JIG_IN, RUN_EXHAUST1, RUN_EXHAUST2, RUN_CYL_DOWN, RUN_PRESSURE_DELAY, RUN_CYL_UP, RUN_JIG_OUT, RUN_END} RUN_STEP_TYPE;
typedef enum{MODE1_NOMAL = 0,  MODE1_OCTA, MODE1_TAPE, MODE1_BATTERY, MODE1_ETC, MODE2_PRESSURE_SET, MODE2_PRESSURE_DELAY_SET} MODE1_STEP_TYPE;
typedef enum{HIDDEN1_STEP = 1, HIDDEN1_STEP_DELAY} HIDDEN1_STEP_TYPE;

// EEPROM Variable
extern unsigned long PressureTime; 	// 압착 시간 단위 0.1sec               
extern unsigned long Pressure;		// ITV 설정 압력 단위 0.00kgf
extern unsigned int PressureStep;	// ITV 설정 압력 Step
extern unsigned int PressureStepDelay;	// setp별 압착 딜레이
extern unsigned int sPressureStepDelay;	// setp별 압착 딜레이

extern unsigned long CalItvMin;	// ITV 입력 센서 교정값 LOW
extern unsigned long CalItvMax;	// ITV 입력 센서 교정값 HIGH

// Variable
extern unsigned char bReturn;		// 최기 시작 상태
extern unsigned char bReturnRun;		// 초기 복기 시작
extern unsigned char bReturnSensor;	// 초기 복기 시작
extern unsigned char bDebug;			// DEBUG MODE
extern unsigned char bCalib;			// ITV 입력 교정모드(CalItvMin, CalItvMax)
extern unsigned char bLongKey;			// Long 키 입력 상태
extern unsigned char CalibStep;		// 교정 단계
extern unsigned long CalibStepDelay;	// 교정 단계 딜레이
extern unsigned char TestMode;			// 테스트 모드 상태
extern unsigned char bAgingMode;		// Aging Mode 설정
extern unsigned char bAgingEnd;		// Aging 초기상태 변경

extern unsigned char bAutoMode;   		// 자동/수동 상태
extern unsigned char bCylXIn;			// X 실린더 내부 진입
extern unsigned char bCylYDown;		// X 실린더 외부 도출상태
extern unsigned char bPressureFail;	// 압력 불량 - ITV 입력시 설정압력과 센서 압력 차이가 발생할 경우 1로 설정
extern unsigned char bDoorSensorFail;
extern unsigned char bSafeSensorFail;

extern unsigned char bMenuDisplay;		// 메뉴화면 표시
extern unsigned char bVarDisplay;		// 화면 설정값 표시

extern unsigned char KeyRunCount;		// 키 함수 실행하기 위한 딜레이 - 키 루틴 100ms

extern volatile unsigned char bRun; 	// 동작 상태
extern unsigned char RunStep;			// 동작 단계
extern unsigned long RunStepDelay;		// 동작 단계 딜레이
extern unsigned long RunStepTime;		// 동작 단계 타임
extern unsigned long mRunStepTime;		// 동작 단계 타임
extern unsigned char bRunAlarm;			// Run 동작중 알람발생

extern unsigned char Mode1Step;			// Mode1 메뉴 상태, 0=동작, 1=압력설정, 2= 압력시간 설정
extern unsigned char sMode1Step;			// Mode1 메뉴 상태, 0=동작, 1=압력설정, 2= 압력시간 설정
extern unsigned char HiddenStep;		// Hidden 메뉴 상태, 1=Step, 2=Step Delay
extern unsigned int SetupExitTime;		// 메뉴 진입 상태에서 일정시간 키버튼 안누를 경우 자동으로 동작 대기상태로 빠짐
extern unsigned int SetData;			// 메뉴 설정 데이타 표시값
extern unsigned int Hidden1SetData;	// Hidden 메뉴 설정 데이타 표시값

extern unsigned int BuzzerOnTime;
extern unsigned int BuzzerOffTime;
extern unsigned int BuzzerRepeatCount;
extern unsigned int BuzzerOnCount;
extern unsigned int BuzzerOffCount;

extern unsigned long ReadPressure;
extern unsigned int DownPressure;

extern volatile unsigned char bEmoState;
extern unsigned char bDownPressureEnd;
extern unsigned char bPressureReward;

extern unsigned int TestCnt;

void SetItv(unsigned int Data);
unsigned long GetItv(void);

void FirstReturn(void);
void HwInit(void);
void UserMain(void);
void HalfSecMain(void);
