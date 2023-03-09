
// Type Define
typedef enum{RUN_STOP = 0,  RUN_START_DELAY, RUN_JIG_IN, RUN_EXHAUST1, RUN_EXHAUST2, RUN_CYL_DOWN, RUN_PRESSURE_DELAY, RUN_CYL_UP, RUN_JIG_OUT, RUN_END} RUN_STEP_TYPE;
typedef enum{MODE1_NOMAL = 0,  MODE1_OCTA, MODE1_TAPE, MODE1_BATTERY, MODE1_ETC, MODE2_PRESSURE_SET, MODE2_PRESSURE_DELAY_SET} MODE1_STEP_TYPE;
typedef enum{HIDDEN1_STEP = 1, HIDDEN1_STEP_DELAY} HIDDEN1_STEP_TYPE;

// EEPROM Variable
extern unsigned long PressureTime; 	// ���� �ð� ���� 0.1sec               
extern unsigned long Pressure;		// ITV ���� �з� ���� 0.00kgf
extern unsigned int PressureStep;	// ITV ���� �з� Step
extern unsigned int PressureStepDelay;	// setp�� ���� ������
extern unsigned int sPressureStepDelay;	// setp�� ���� ������

extern unsigned long CalItvMin;	// ITV �Է� ���� ������ LOW
extern unsigned long CalItvMax;	// ITV �Է� ���� ������ HIGH

// Variable
extern unsigned char bReturn;		// �ֱ� ���� ����
extern unsigned char bReturnRun;		// �ʱ� ���� ����
extern unsigned char bReturnSensor;	// �ʱ� ���� ����
extern unsigned char bDebug;			// DEBUG MODE
extern unsigned char bCalib;			// ITV �Է� �������(CalItvMin, CalItvMax)
extern unsigned char bLongKey;			// Long Ű �Է� ����
extern unsigned char CalibStep;		// ���� �ܰ�
extern unsigned long CalibStepDelay;	// ���� �ܰ� ������
extern unsigned char TestMode;			// �׽�Ʈ ��� ����
extern unsigned char bAgingMode;		// Aging Mode ����
extern unsigned char bAgingEnd;		// Aging �ʱ���� ����

extern unsigned char bAutoMode;   		// �ڵ�/���� ����
extern unsigned char bCylXIn;			// X �Ǹ��� ���� ����
extern unsigned char bCylYDown;		// X �Ǹ��� �ܺ� �������
extern unsigned char bPressureFail;	// �з� �ҷ� - ITV �Է½� �����з°� ���� �з� ���̰� �߻��� ��� 1�� ����
extern unsigned char bDoorSensorFail;
extern unsigned char bSafeSensorFail;

extern unsigned char bMenuDisplay;		// �޴�ȭ�� ǥ��
extern unsigned char bVarDisplay;		// ȭ�� ������ ǥ��

extern unsigned char KeyRunCount;		// Ű �Լ� �����ϱ� ���� ������ - Ű ��ƾ 100ms

extern volatile unsigned char bRun; 	// ���� ����
extern unsigned char RunStep;			// ���� �ܰ�
extern unsigned long RunStepDelay;		// ���� �ܰ� ������
extern unsigned long RunStepTime;		// ���� �ܰ� Ÿ��
extern unsigned long mRunStepTime;		// ���� �ܰ� Ÿ��
extern unsigned char bRunAlarm;			// Run ������ �˶��߻�

extern unsigned char Mode1Step;			// Mode1 �޴� ����, 0=����, 1=�з¼���, 2= �з½ð� ����
extern unsigned char sMode1Step;			// Mode1 �޴� ����, 0=����, 1=�з¼���, 2= �з½ð� ����
extern unsigned char HiddenStep;		// Hidden �޴� ����, 1=Step, 2=Step Delay
extern unsigned int SetupExitTime;		// �޴� ���� ���¿��� �����ð� Ű��ư �ȴ��� ��� �ڵ����� ���� �����·� ����
extern unsigned int SetData;			// �޴� ���� ����Ÿ ǥ�ð�
extern unsigned int Hidden1SetData;	// Hidden �޴� ���� ����Ÿ ǥ�ð�

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
