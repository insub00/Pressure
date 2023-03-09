#include "hwdefine.h"

// EEPROM Variable
unsigned long PressureTime = 50; 	// ���� �ð� ���� 0.1sec
unsigned long Pressure = 300;		// ITV ���� �з� ���� 0.00kgf

unsigned long CalItvMin = 11490;	// ITV �Է� ���� ������ LOW
unsigned long CalItvMax = 60400;	// ITV �Է� ���� ������ HIGH

// Variable
unsigned char bReturn = 0;			// �ֱ� ���� ����
unsigned char bReturnRun = 0;		// �ʱ� ���� ����
unsigned char bReturnSensor = 0;	// �ʱ� ���� ����
unsigned char bDebug = 1;			// DEBUG MODE
unsigned char bCalib = 0;			// ITV �Է� �������(CalItvMin, CalItvMax0
unsigned char bLongKey = 0;			// Long Ű �Է� ����
unsigned char CalibStep = 0;		// ���� �ܰ�
unsigned long CalibStepDelay = 0;	// ���� �ܰ� ������
unsigned char TestMode = 0;			// �׽�Ʈ ��� ����

unsigned char bCylXIn = 0;			// X �Ǹ��� ���� ����
unsigned char bCylYDown = 0;		// X �Ǹ��� �ܺ� �������
unsigned char bPressureFail = 0;	// �з� �ҷ� - ITV �Է½� �����з°� ���� �з� ���̰� �߻��� ��� 1�� ����
unsigned char bDoorSensorFail = 0;
unsigned char bSafeSensorFail = 0;

unsigned char bMenuDisplay = 1;		// �޴�ȭ�� ǥ��
unsigned char bVarDisplay = 1;		// ȭ�� ������ ǥ��

unsigned char KeyRunCount = 0;		// Ű �Լ� �����ϱ� ���� ������ - Ű ��ƾ 100ms

volatile unsigned char bRun = 0; 			// ���� ����
unsigned char RunStep = 0;			// ���� �ܰ�
unsigned long RunStepDelay = 0;		// ���� �ܰ� ������
unsigned long RunStepTime = 0;		// ���� �ܰ� Ÿ��
unsigned long mRunStepTime = 0;		// ���� �ܰ� Ÿ��
unsigned char bRunAlarm = 0;		// Run ������ �˶��߻�
unsigned char bAgingMode = 0;		// Aging Mode ����
unsigned char bAgingEnd = 0;		// Aging �ʱ���� ����

unsigned char Mode1Step = 0;		// Mode1 �޴� ����, 0=����, 1=�з¼���, 2= �з½ð� ����
unsigned char sMode1Step = 4;		// Mode1 �޴� ����, 0=����, 1=�з¼���, 2= �з½ð� ����
unsigned char HiddenStep = 0;		// Hidden �޴� ����, 1=Step, 2=Step Delay
unsigned int SetupExitTime = 0;		// �޴� ���� ���¿��� �����ð� Ű��ư �ȴ��� ��� �ڵ����� ���� �����·� ����
unsigned int SetData = 0;			// �޴� ���� ����Ÿ ǥ�ð�
unsigned int Hidden1SetData = 0;	// Hidden �޴� ���� ����Ÿ ǥ�ð�

unsigned int BuzzerOnTime = 0;
unsigned int BuzzerOffTime = 0;
unsigned int BuzzerRepeatCount = 0;
unsigned int BuzzerOnCount = 0;
unsigned int BuzzerOffCount = 0;

unsigned long ReadPressure = 0;

volatile unsigned char bEmoState = 0;

void SetBuzzer(unsigned char Mode, unsigned char Repeat);


void SetItv(unsigned int Data)
{	// 0.05 ~ 9.00
    unsigned long Result = 0;

	Result = (Data - ITV_MIN);
    Result *= 4095;
    Result /= (ITV_MAX - ITV_MIN);
    Dac7512Write(Result);	// 0 ~ 4095
}

unsigned long GetItv(void)
{
	unsigned long Result = 0;

	Result = Ltc1865Read(0);

    if (Result < CalItvMin) Result = CalItvMin;
    if (Result > CalItvMax) Result = CalItvMax;

    Result -= CalItvMin;

    Result *= (PRESSURE_MAX - PRESSURE_MIN);  
	Result /= (CalItvMax - CalItvMin);

    Result += PRESSURE_MIN;

/*
    Result *= 5000;
    Result /= 65535;



    Result -= 1000;
	Result /= 4000;

    Result += ITV_MIN;
*/

	return Result;
}

void FirstReturn(void)
{
	LcdInit();
	Lcdprintf(0, 0, "WINDOW PRESS BASE:");
	Lcdprintf(18, 0, VERSION);
	Lcdprintf(0, 1, "WITHSYSTEM");
	Lcdprintf(0, 2, "INITIALIZE..");
    LcdCursorOff();

	SetItv(PRESSURE_STOP);
//    GetItv();

	SetItv(PRESSURE_RETURN);
//    GetItv();
	
	// ����
	CYL_Y_UP;
	DelayMs(2000);
	CYL_X_OUT;
	DelayMs(2000);
}

void HwInit(void)
{
	unsigned int GetTestCnt = 0;
	
	Led1Off();
    Led2Off();
    LedComOff();
    LedPassOff();
    LedFailOff();

	Sol3Off();	// 14.12.08 SIS Edge�� ���� �ʱ� ����
	//Sol3On();	// 14.12.08 SIS Edge�� ���� �ʱ� ����

	bMenuDisplay = 1;
	bVarDisplay = 1;

    bEmoState = 0;

	FirstReturn();	// ���� ���۽� ���������� �о ���� �ʱ�ȭ

    if (GetEeprom2(INIT_POS) != INIT_CODE)
    {
		SetEeprom2(0, PressureTime);	// ���� �ð�
		SetEeprom2(2, Pressure);		// �з�
		SetEeprom2(4, bAutoMode);		// ��� (Edge, Manual)
		SetEeprom2(6, sMode1Step);		// ���1 (Octa, Type, Battery, Etc)
		
		SetEeprom2(10, CalItvMin);		// �Է� ���� �ּҰ�
		SetEeprom4(12, CalItvMax);		// �Է� ���� �ִ밪
	
		SetEeprom2(16, PressureStep);			// Hidden ���� Step ��
		SetEeprom2(18, sPressureStepDelay);		// Hidden Step Delay ��
		
        SetEeprom2(INIT_POS, INIT_CODE);	// ���α׷� ���� 
    }else { // Initalize Value Load
//		PressureTime = GetEeprom2(0);
//		Pressure = GetEeprom2(2);
		bAutoMode = GetEeprom2(4);
		sMode1Step = GetEeprom2(6);
		if (sMode1Step > MODE1_ETC) sMode1Step = MODE1_ETC;
		
		CalItvMin = GetEeprom2(10);
		CalItvMax = GetEeprom4(12); 
		
		PressureStep = GetEeprom2(16);
		if (PressureStep > PRESSURE_STEP_MAX) PressureStep = PRESSURE_STEP_DEFAULT;
		sPressureStepDelay = GetEeprom2(18);
		if (sPressureStepDelay > PRESSURE_STEP_DELAY_MAX) sPressureStepDelay = PRESSURE_STEP_DELAY_DEFAULT;
    }

	GetTestCnt = GetEeprom2(20);
	if (GetTestCnt != 0 && GetTestCnt != 0xFFFF) TestCnt = GetTestCnt;	
	
	switch (sMode1Step)
	{
	case MODE1_OCTA:
		PressureTime = OCTA_PRESSURE_TIME;
		Pressure = OCTA_PRESSURE;
		break;
	case MODE1_BATTERY:
		PressureTime = BATTERY_PRESSURE_TIME;
		Pressure = BATTERY_PRESSURE;
		break;
	case MODE1_TAPE:
		PressureTime = TYPE_PRESSURE_TIME;
		Pressure = TYPE_PRESSURE;
		break;
	case MODE1_ETC:
		PressureTime = GetEeprom2(0);
		Pressure = GetEeprom2(2);
		break;
	}
		
    #ifdef DEBUG_MODE
    DebugComm("\n\r");
	DebugComm("******************************\n\r");
	DebugComm("*          WINDOW PRESSURE   *\n\r");
	DebugComm("*               Bestpro      *\n\r");
	DebugComm("*            2014/10/02      *\n\r");
	DebugComm("******************************\n\r");
	DebugComm(VERSION);
	DebugComm("Prompt:> ");
    #endif

	LcdInit();
    SetItv(Pressure);
    GetItv();
	SetBuzzer(0, 1);

	TestMode = 0;  
    bCalib = 0;
}


void BuzzerSubroutine(void)
{
	if (BuzzerOnCount)
    {
    	BuzzerOnCount--;
        BuzzerOn();
    }else if (BuzzerOffCount) {
    	BuzzerOffCount--;
        BuzzerOff();
    }else if (BuzzerRepeatCount) {
		BuzzerRepeatCount--;
        BuzzerOnCount = BuzzerOnTime;
        BuzzerOffCount = BuzzerOffTime;
    }else if (bEmoState || bReturnSensor) {	// ��� ����ġ �Է»��� �̰ų� Door & Safe sensor on����
    	if (bRun)
        {
    	if (bBlink)
        {
         	BuzzerOn();
        }else {
         	BuzzerOff();
        }
        }
    }else if (bPressureFail)
	{
		if (!bRun)
        {
                if (bBlink)
                {
         	        BuzzerOn();
                }else {
         	        BuzzerOff();
                }
        } else {
            BuzzerOn();        
        }
    }else {
        BuzzerOff();
    }
}

void CalibSubroutine(void)
{
    unsigned long ReadData = 0;
	if (bCalib)
    {
		if (CalibStepDelay) {
        	CalibStepDelay--;
            if (CalibStep == 2) // �ڵ� �������
            {
                ReadData = GetItv();
                if (ReadData > PRESSURE_MAX / 2)
                {
                    CalItvMax += (abs(ReadData - 450) * 5);
                }else {
                    CalItvMax -= (abs(ReadData - 450) * 5);
                }
            }
        }else {
			switch(CalibStep)
            {
            	case 0:
                	CalibStep++;
                    SetItv(PRESSURE_MIN);	// Set Min
                    CalibStepDelay = 1500;
	                SetBuzzer(0, 0);
                    break;

                case 1:
                	CalibStep++;
                	CalItvMin = Ltc1865Read(0);
                	SetEeprom2(10, CalItvMin);

                    SetItv(PRESSURE_MAX / 2);	// Set Max
                    CalibStepDelay = 500;
	                SetBuzzer(0, 0);
    				break;

				case 2:
                	CalibStep++;
//                	CalItvMax = (unsigned long)((unsigned long)Ltc1865Read(0) * 2);     
                	SetEeprom4(12, CalItvMax);

                    SetItv(Pressure);	// Set Pressure
                    CalibStepDelay = 0;
                    bCalib = 0;
	                SetBuzzer(1, 0);
					break;
                    
                case 10:    // Manual ITV min output
                    SetItv(5); 
                    break;
                    
                case 11:    // Manual ITV max output
                    SetItv(900); 
                    break;
                
                case 12:    // Manual ITV input min calib 
                    SetItv(5); 
                    break;       
                
                case 13:
                    SetItv(900); 
                    break;
                
                
                    
                
            }
        }
    }
}

void UserMain(void)	// Main 10ms Routine
{
    RunSubroutine();
    DisplaySubroutine();
    BuzzerSubroutine();
    CalibSubroutine();

    if (KeyRunCount++ >= 10)	// 10ms * 10 = 100ms
    {
		if (bAutoMode == 2) StepPressureSubroutine();
    	KeySubroutine();
        KeyRunCount = 0;
        PressureRewardSubroutine();
		PressureCheckSubroutine();

        if (Sensor & DOOR_SENSOR) bDoorSensorFail = 0;
        else bDoorSensorFail = 1;

        if (Sensor & SAFE_SENSOR) bSafeSensorFail = 0;
        else bSafeSensorFail = 1;

		if (!bRun) bReturnSensor = 0;
		else if (bRun && (bDoorSensorFail || bSafeSensorFail)) bReturnSensor = 1;

//        if (TestMode) bVarDisplay = 1;
		bVarDisplay = 1;
    }
}

void HalfSecMain(void)
{
	unsigned int Count;

    if (bBlink)
    {
    	Led1On();
    }else {
    	Led1Off();
    }

    if (bDebug)
    {
    	MsgPrintf("Run = %d, Step = %2d, Delay = %3d\n\r", bRun, RunStep, RunStepDelay);
    	MsgPrintf("Key = 0x%02X, ExtKey = 0x%02X, Sensor = 0x%02X, Emp = %d\n\r", Key, ExtKey, Sensor, Emo);
    	MsgPrintf("Mode1Step = %d\n\r", Mode1Step);
    	MsgPrintf("CH0 = %ld(0x%04X)\n\r", Ltc1865Read(0), Ltc1865Read(0));
    	MsgPrintf("CH0 = %ld(0x%04X)\n\r", Ltc1865Read(0), Ltc1865Read(0));
    }

}