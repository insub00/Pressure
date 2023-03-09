#include "hwdefine.h"

unsigned int PressureStep = PRESSURE_STEP_DEFAULT;				// ITV 설정 압력 Step	// Default
unsigned int PressureStepDelay = 1;								// setp별 압착 딜레이
unsigned int sPressureStepDelay = PRESSURE_STEP_DELAY_DEFAULT;	// setp별 압착 딜레이	// Default
unsigned char bAutoMode = 2;   			// 자동/수동 상태
unsigned int DownPressure = 0;			// 압력 Step 동작시 압력값 
unsigned char bDownPressureEnd = 0;		// 압력 Step 완료
unsigned char bPressureReward = 0;		// 압력 보상
unsigned int TestCnt = 0;

void CommSubroutine(void)
{
    unsigned int tQueueLast = QueueLast;        //루틴 수행중 QueueLast 값이 바뀔수 있으므로 수신확인되면 QueueLast Count 값을 Buffer(tQueueLast)에 저장

    if (QueueFirst != tQueueLast)
    {
        while(QueueFirst != tQueueLast)
        {
            CommCommandBuffer[CommCommandSize++] = QueueData[QueueFirst++];        //CommCommandBuffer에 수신 Data를 하나씩 저장
            if (CommCommandSize >= COMMAND_BUFFER_SIZE) CommCommandSize = 0;
            if (QueueFirst >= QUEUE_SIZE) QueueFirst = 0;

			if ((CommCommandBuffer[CommCommandSize - 1] == '\n') || (CommCommandBuffer[CommCommandSize - 1] == '\r'))    //데이터 마지막에 '\n','r'에 입력이 되면 수신 완료
			{
                CommCommandBuffer[CommCommandSize] = 0;                                                                                                                       //CommCommandSize - 1 은 수신 시작시 QueueFirst Count를 증가 시키고 시작했기때문에 마지막 Data를 읽으려면 1Byte전 Data를 읽어야 한다.
				if (CommCommandSize != 1)        //CommCommandSize를 위에서 증가 시켰기 때문에 0은 읽을 수 없고, 'n','r'이 1Byte를 차지하므로 CommandSize가 1일 경우에는 Data가 없다고 판단. 1보다 클때부터 Data를 살핀다.
				{
//                    MainComm("CMD[%d][%d]-%s\n", QueueFirst, tQueueLast, CommCommandBuffer);

					switch(CommCommandSize - 1)
					{
                        case 3:
                        case 1:
                            CommCommandBuffer[0] = 'H';
                            CommCommandBuffer[1] = 'E';
                            CommCommandBuffer[2] = 'L';
                            CommCommandBuffer[3] = 'P';
						case 4:
                            if (strncmpf((char *)CommCommandBuffer, "HELP", 4) == 0)
							{

                                DebugComm("\n\r");
                                DebugComm("  Command List\n\r");

                                DebugComm("  HELP       :   Help Meassage\n\r");
                                DebugComm("  TEST       :   TEST Command\n\r");
                                DebugComm("  DEBUG      :   DEBUG Command\n\r");
                                DebugComm("  VER?       :   Version Command\n\r");
                            }
							else if (strncmpf((char *)CommCommandBuffer, "TEST", 4) == 0)
                            {
                                TestMode = Asc2Hex(CommCommandBuffer[4]);
                                if(TestMode) DebugComm("Test Mode %d\n\r", TestMode);
                                else DebugComm("Test Mode Disable\n\r");
                            }
                            break;
                        case 5:
                            if (strncmpf((char *)CommCommandBuffer, "DEBUG", 5) == 0)
                            {
                            	bDebug = !bDebug;
                                if (bDebug)
                                {
                                    DebugComm("Debug Mode Enable\n\r");
                                }
                                else
                                {
                                    DebugComm("Debug Mode Disable\n\r");
								}
                            }
                            break;
                       	default:
							#ifdef DEBUG_MODE
                           	DebugComm("Command ?\n");
                            #else
                            MainComm("ER1:%s\n", CommCommandBuffer);
                            #endif
	                        break;
    	           	}
        	    }
           	    CommCommandSize = 0;
			}
		}
	}

}

void SetBuzzer(unsigned char Mode, unsigned char Repeat)
{
	switch(Mode)
    {
		case 0:
        	BuzzerOnTime = 10;
            BuzzerOffTime = 10;
            break;
        case 1:
        	BuzzerOnTime = 50;
            BuzzerOffTime = 10;
            break;
    }
    BuzzerOnCount = BuzzerOnTime;
    BuzzerOffCount = BuzzerOffTime;
    BuzzerRepeatCount = Repeat;
}

void RunSubroutine(void)	// 10ms
{
	static unsigned int TactTimeCheckIn = 0;
	static unsigned int TactTimeCheckOut = 0;
	static unsigned int TactTimeCheckDown = 0;
	static unsigned int TactTimeCheckUp = 0;
	
    if (bRun)
    {
		if (bEmoState == 1 || bReturnSensor == 1)		// Emo 누른 상태, 인전 센서
		{
			SetItv(PRESSURE_STOP);
			bRunAlarm |= 0x04;

		}else {

			if (RunStep == RUN_STOP) SetItv(PRESSURE_NOMAL);

			// **************************************************************************************************************************************************
			if ((bEmoState == 2) || bReturnSensor == 2)	// Run중 센서 & Emo 받으면
			{
				SetItv(PRESSURE_RETURN);
				bRunAlarm |= 0x08;
			}

			if (((bEmoState == 2) || bReturnSensor == 2) && RunStep <= RUN_PRESSURE_DELAY)	// Emo 입력시 Y축 올리는 단계로 점프하여 실린더 초기상태로 원복시킴
			{
				RunStepDelay = 0;
				RunStep = RUN_PRESSURE_DELAY;
				bRunAlarm |= 0x01;
			}
			// **************************************************************************************************************************************************

			if (RunStepDelay)
			{
				RunStepDelay--;
				RunStepTime++;										// RunStepDelay 사용시 시간 카운터로 사용됨.
				if ((RunStepDelay % 10) == 0) bVarDisplay = 1;		// 100ms에 한번씩 상태 LCD에 출력
			}else {													// RunStepDelay 0일때만 실행
				if (RunStep == RUN_PRESSURE_DELAY && bPressureFail) bRunAlarm |= 0x02;

				RunStepTime = 0;
				switch(RunStep)
				{
				case RUN_STOP:
					RunStep = RUN_START_DELAY;
					RunStepDelay = 10;	// 100ms delay (2014.10.15_이원욱D 초기 빨리 진입하게 변경요청)
					bVarDisplay = 1;
					break;

				case RUN_START_DELAY:
					RunStep = RUN_JIG_IN;
					CYL_X_IN;
					bVarDisplay = 1;
					break;

				case RUN_JIG_IN:
					if (Sensor & CYL_X_IN_SENSOR)
					{
                        if (bAutoMode == 2)
                        {
    						SetItv(PRESSURE_Y_DOWN);
						    RunStep = RUN_EXHAUST1;
                        }else {
    						SetItv(Pressure);
						    RunStep = RUN_CYL_DOWN;   
                            bDownPressureEnd = 1;

                        }
						CYL_Y_DOWN;
						bVarDisplay = 1;

						RunStepDelay = 100;
					}
					break;

				case RUN_EXHAUST1:
					SetItv(PRESSURE_EXHAUST2);

					RunStep = RUN_CYL_DOWN;
					RunStepDelay = 100;		// 1sec
					break;

				case RUN_CYL_DOWN:
					if (Sensor & CYL_Y_DOWN_SENSOR)
					{
						//PressureTime = GetEeprom2(0);
						//Pressure = GetEeprom2(2);

						if (bDownPressureEnd == 1)
						{
							RunStep = RUN_PRESSURE_DELAY;
							RunStepDelay = PressureTime * 10;
							bPressureReward = 1;
						}
						bVarDisplay = 1;
					}
					break;

				case RUN_PRESSURE_DELAY:
					RunStep = RUN_CYL_UP;
					bDownPressureEnd = 0;    
                    
                    if (bRunAlarm == 0x01) RunStepDelay = 100; 	// 14.10.14
				    else RunStepDelay = 10;

					SetItv(PRESSURE_NOMAL);

					CYL_Y_UP;  
                    
                    if (bPressureFail) SetBuzzer(1, 2);
                    else SetBuzzer(0, 0);
                    
                    RunStepDelay = 30;
					bVarDisplay = 1;
					break;

				case RUN_CYL_UP:
					//if (Sensor & CYL_Y_UP_SENSOR)	// TactTime 축소로 센서 받기전 X축 Out적용으로 주석처리
					{
						if (bReturnSensor == 2 || (bEmoState == 2))
						{
							RunStep = RUN_JIG_OUT;
							RunStepDelay = 10;
							CYL_X_OUT;
							bVarDisplay = 1;
						}else {
							if (bDoorSensorFail == 0 && bSafeSensorFail == 0)
							{
								RunStep = RUN_JIG_OUT;
								RunStepDelay = 10;
								CYL_X_OUT;
								bVarDisplay = 1;
							}
						}
					}
					break;

				case RUN_JIG_OUT:
					if (Sensor & CYL_X_OUT_SENSOR)
					{
						RunStep = RUN_END;
						RunStepDelay = 10;
						bVarDisplay = 1;
					}
					break;

				case RUN_END:
                    bPressureFail = 0; 
                    bRunAlarm = 0;
					DownPressure = 0;
					if (bRunAlarm) SetBuzzer(1, 1);
					else SetBuzzer(0, 1);

					if ((!bAgingMode) || (!bReturnSensor) || (!bEmoState))
					{
						if (TestCnt < 1000) TestCnt++;	// 최대 세자리수
						SetEeprom2(20, TestCnt);
					}
					if (bReturnSensor || (bEmoState == 2))
					{
						bReturnSensor = 0;
						bEmoState = 0;
						//PressureTime = GetEeprom2(0);
						//Pressure = GetEeprom2(2);

						CalItvMin = GetEeprom2(10);
                        CalItvMax = GetEeprom4(12);  

						SetItv(Pressure);
						//GetItv();
					}
					//bReturnRun = 0;
					if (bAgingEnd) bRun = 0;
            	    else if (!bAgingEnd && bAgingMode) bRun = 1;		// Aging Mode시 반복되게 bRun 플래그 ON
				    else bRun = 0;

					RunStep = RUN_STOP;
					bMenuDisplay = 1;
					bVarDisplay = 1;
					break;
				}
			}
		}
    }else {
		RunStep = RUN_STOP;
		RunStepDelay = 0;
        RunStepTime = 0;
		bDownPressureEnd = 0;

		if (bAutoMode)	// AutoMode & EdgeMode
        {
            bCylXIn = 0;
            bCylYDown = 0;
        	CYL_X_OUT;
        	CYL_Y_UP;
        } else{
			if (bCylXIn) 	// X IN
			{
				if ((Sensor & CYL_X_IN_SENSOR) != CYL_X_IN_SENSOR) 
				{
					TactTimeCheckOut = 0;
					mRunStepTime = TactTimeCheckIn++;
					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
				}
			} else {	// X OUT
				if ((Sensor & CYL_X_OUT_SENSOR) != CYL_X_OUT_SENSOR) 
				{
					TactTimeCheckIn = 0;
					mRunStepTime = TactTimeCheckOut++;
					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
				}
			} 
			if (bCylYDown){	// Y Down
 				if ((Sensor & CYL_Y_DOWN_SENSOR) != CYL_Y_DOWN_SENSOR) 
				{
					TactTimeCheckUp = 0;
					mRunStepTime = TactTimeCheckDown++;
					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
				}
			} else{	// Y Up
 				if ((Sensor & CYL_Y_UP_SENSOR) != CYL_Y_UP_SENSOR) 
				{
					TactTimeCheckDown = 0;
					mRunStepTime = TactTimeCheckUp++;
					if ((mRunStepTime % 10) == 0) bVarDisplay = 1;
				} 
			}  
		}
    }
}

void DisplaySubroutine(void)	// 10ms
{
	// LCD
	if (bMenuDisplay)
    {
		LcdClear();
       	switch(Mode1Step)
		{
        case MODE1_NOMAL:	// NORMAL
          	if (TestMode)
            {

        	}else if (HiddenStep){
			
			}else {
		    	//Lcdprintf(0, 0, "WINDOW PRESS BASE:");
		    	//Lcdprintf(0, 0, "WINDOW PRESS ");
				switch (sMode1Step)
				{
				case MODE1_OCTA:
					//Lcdprintf(13, 0, "WINDOW PRESS OCTA:");
					Lcdprintf(0, 0, "MODE:OCTA C:     V");
					break;
				case MODE1_TAPE:
					//Lcdprintf(13, 0, "WINDOW PRESS TAPE:");
					Lcdprintf(0, 0, "MODE:TAPE C:     V");
					break;
				case MODE1_BATTERY:
					//Lcdprintf(13, 0, "WINDOW PRESS BATT:");
					Lcdprintf(0, 0, "MODE:BATT C:     V");
					break;
				case MODE1_ETC:
					//Lcdprintf(13, 0, "WINDOW PRESS  ETC:");
					Lcdprintf(0, 0, "MODE:ETC  C:     V");
					break;
				}
                Lcdprintf(18, 0, VERSION);
                Lcdprintf(0, 2, "Status:");
                if (bRun) Lcdprintf(7, 2, "RUN  TIM:");
                else Lcdprintf(7, 2, "STOP TIM:");

            	if (bAutoMode == 1)							// AutoMode
                {
					Lcdprintf(0, 1, "AUTO:");
				}else if (bAutoMode == 2){					// EdgeMode
					Lcdprintf(0, 1, "EDGE:");
                }else {
					Lcdprintf(0, 1, "MAN :");				// ManualMode
                }
				if (bAgingMode) Lcdprintf(0, 1, "AGING:");	// AgingMode

                Lcdprintf(5, 1, "%2d.%dsec %d.%02dkgf", PressureTime / 10, PressureTime % 10, Pressure / 100, Pressure % 100);
            }
            LcdCursorOff();
            break;

        case MODE2_PRESSURE_SET:	// 압력
			Lcdprintf(0, 0, "       SETUP");
    		Lcdprintf(0, 1, " PRESSURE :      kgf");
            Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_MIN, PRESSURE_MAX_);
            LcdCursorOn();
            break;

        case MODE2_PRESSURE_DELAY_SET:	// TIME
			Lcdprintf(0, 0, "       SETUP");
    		Lcdprintf(0, 1, " TIME     :      sec");
            Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_TIME_MIN, PRESSURE_TIME_MAX);
            LcdCursorOn();
            break;
		
		case MODE1_OCTA:	
			Lcdprintf(0, 0, "       OCTA");
    		Lcdprintf(0, 1, " PRESSURE :      kgf");
            Lcdprintf(0, 2, " TIME     :      sec");
			Lcdprintf(12, 1, "%d.%02d", OCTA_PRESSURE / 100, OCTA_PRESSURE % 100);
			Lcdprintf(12, 2, "%2d.%d", OCTA_PRESSURE_TIME / 10, OCTA_PRESSURE_TIME % 10);
//            LcdCursorOn();
			break;
			
		case MODE1_TAPE:	
			Lcdprintf(0, 0, "       TAPE");
    		Lcdprintf(0, 1, " PRESSURE :      kgf");
            Lcdprintf(0, 2, " TIME     :      sec");
			Lcdprintf(12, 1, "%d.%02d", TYPE_PRESSURE / 100, TYPE_PRESSURE % 100);
			Lcdprintf(12, 2, "%2d.%d", TYPE_PRESSURE_TIME / 10, TYPE_PRESSURE_TIME % 10);
//            LcdCursorOn();
			break;
		
		case MODE1_BATTERY:	
			Lcdprintf(0, 0, "       BATT");
    		Lcdprintf(0, 1, " PRESSURE :      kgf");
            Lcdprintf(0, 2, " TIME     :      sec");
			Lcdprintf(12, 1, "%d.%02d", BATTERY_PRESSURE / 100, BATTERY_PRESSURE % 100);
			Lcdprintf(12, 2, "%2d.%d", BATTERY_PRESSURE_TIME / 10, BATTERY_PRESSURE_TIME % 10);
//            LcdCursorOn();
            break;
			
		case MODE1_ETC:	
			Lcdprintf(0, 0, "       ETC");
    		Lcdprintf(0, 1, " PRESSURE :      kgf");
            Lcdprintf(0, 2, " TIME     :      sec");
			Lcdprintf(12, 1, "%d.%02d", Pressure / 100, Pressure % 100);
			Lcdprintf(12, 2, "%2d.%d", PressureTime / 10, PressureTime % 10);
//            LcdCursorOn();
            break;
        }
		
		switch(HiddenStep)
		{
		case HIDDEN1_STEP:	
			Lcdprintf(0, 0, "   PRESSURE-STEP");
    		Lcdprintf(0, 1, " STEP     :     STEP");
            Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_STEP_MIN, PRESSURE_STEP_MAX);
            LcdCursorOn();
            break;
			
		case HIDDEN1_STEP_DELAY:	
			Lcdprintf(0, 0, "     STEP-TIME");
    		Lcdprintf(0, 1, " DELAY    :      sec");
            Lcdprintf(0, 2, " LIMIT (%d ~ %d)", PRESSURE_STEP_DELAY_MIN, PRESSURE_STEP_DELAY_MAX);
            LcdCursorOn();
            break;
		}

	    bMenuDisplay = 0;
        bVarDisplay = 1;
    }

    if (bVarDisplay)
    {
		switch(Mode1Step)
		{
		case MODE1_NOMAL:	// NORMAL
			if (TestMode)
			{
				ReadPressure = GetItv();
				Lcdprintf(0, 0, "Ky=%02X,EK=%02X,Ss=%02X", Key, ExtKey, Sensor);
				Lcdprintf(0, 1, "Run=%d,Step=%2d,Dly=%2d", bRun, RunStep, RunStepDelay);
				Lcdprintf(0, 2, "Mode1Step = %d", Mode1Step);
				//Lcdprintf(0, 3, "CH0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
				Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
			}else if (bCalib) {
				switch(CalibStep)
				{
					case 0:
					
					case 1:
					
						break;
						
					case 10:    // ITV 0.05 Output  4mA  Set VR
						Lcdprintf(0, 0, "ITV 4mA Calib Mode!!");
						Lcdprintf(0, 1, "Set VR10            ");
						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
						break;
					case 11:    // ITV 9.00 Output  20mA  Set VR
						Lcdprintf(0, 0, "ITV 20mA Calib Mode!");
						Lcdprintf(0, 1, "Set VR11            ");
						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
						break;
							  
					case 12:    // ITV INPUT CALIB 
						Lcdprintf(0, 0, "ITV 1V Calib Mode! ");
						Lcdprintf(0, 1, "Set Volt 1V  :%ld", CalItvMin);
						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
						break;
					case 13:    // ITV INPUT CALIB
						Lcdprintf(0, 0, "ITV 5V Calib Mode! ");
						Lcdprintf(0, 1, "Set Volt 5V  :%ld", CalItvMax);
						Lcdprintf(0, 2, "AD0 = %ld(0x%04X)", Ltc1865Read(0), Ltc1865Read(0));
						Lcdprintf(0, 3, "CH0 = %d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
						break;
				
				}            
			}else if (HiddenStep) {
			
			}
			else {
				Lcdprintf(12, 0, "%03d", TestCnt);	// 151216(SIS) SEC이원욱D 요청으로 검사 횟수 출력
				
				ReadPressure = GetItv();
				//Lcdprintf(13, 3, "%d.%02dkgf", Pressure / 100, Pressure % 100);
				Lcdprintf(13, 3, "%d.%02dkgf", ReadPressure / 100, ReadPressure % 100);
				if (bAutoMode) Lcdprintf(16, 2, "%2d.%d", (RunStepTime / 10) / 10, (RunStepTime / 10) % 10);
				else Lcdprintf(16, 2, "%2d.%d", (mRunStepTime / 10) / 10, (mRunStepTime / 10) % 10);
				if (bRun)
				{
					switch(RunStep)
					{
					case RUN_STOP:
						Lcdprintf(0, 3, "STOP       ");
						break;

					case RUN_START_DELAY:
						Lcdprintf(0, 3, "START DELAY");
						break;

					case RUN_JIG_IN:
						Lcdprintf(0, 3, "JIG IN     ");
						break;

					case RUN_EXHAUST1:
						Lcdprintf(0, 3, "CYL D1     ");
						break;

					case RUN_EXHAUST2:
						Lcdprintf(0, 3, "CYL D2     ");
						break;

					case RUN_CYL_DOWN:
						Lcdprintf(0, 3, "CYL DOWN   ");
						break;

					case RUN_PRESSURE_DELAY:
						Lcdprintf(0, 3, "PRESSURE");
						break;

					case RUN_CYL_UP:
						Lcdprintf(0, 3, "CYL UP     ");
						break;

					case RUN_JIG_OUT:
						Lcdprintf(0, 3, "JIG OUT    ");
						break;

					case RUN_END:
						Lcdprintf(0, 3, "END        ");
						break;

					}
				}else {
					if ((bEmoState == 1) || (bEmoState == 2))
					{
						if (bBlink)
						{
							Lcdprintf(0, 3, "EMERGENCY!!!");
							//Lcdprintf(0, 3, "EME%d", bEmoState);
						}else {
							Lcdprintf(0, 3, "            ");
						}
					}else if (bAutoMode && bSafeSensorFail) {
						if (bBlink)
						{
							Lcdprintf(0, 3, "SAFE SENSOR!");
						}else {
							Lcdprintf(0, 3, "            ");
						}
					}else if (bAutoMode && bDoorSensorFail) {
						if (bBlink)
						{
							Lcdprintf(0, 3, "DOOR SENSOR!");
						}else {
							Lcdprintf(0, 3, "            ");
						}
					}else if (bAutoMode && bPressureFail) {
						if (bBlink)
						{
							Lcdprintf(0, 3, "PRESSURE AL!");
						}else {
							Lcdprintf(0, 3, "            ");
						}
					}else if (bAutoMode) {
						Lcdprintf(0, 3, "READY        ");
					}else {
						Lcdprintf(0, 3, "CYL : ");
						if (bCylXIn) Lcdprintf(6, 3, "IN -");
						else Lcdprintf(6, 3, "OUT-");

						if (bCylYDown) Lcdprintf(10, 3, "DO");
						else Lcdprintf(10, 3, "UP");
					}
				}

			}
			break;

		case MODE2_PRESSURE_SET:	// 압력
			Lcdprintf(12, 1, "%d.%02d", SetData / 100, SetData % 100);
			LineDecision(15, 1);
			break;

		case MODE2_PRESSURE_DELAY_SET:	// TIME
			Lcdprintf(12, 1, "%2d.%d", SetData / 10, SetData % 10);
			LineDecision(15, 1);
			break;
		}
		
		switch(HiddenStep)
		{
		case HIDDEN1_STEP:	
			Lcdprintf(13, 1, "%02d", Hidden1SetData);
			LineDecision(14, 1);
            break;
			
		case HIDDEN1_STEP_DELAY:	
			Lcdprintf(12, 1, "%2d.%d", Hidden1SetData / 10, Hidden1SetData % 10);
            LineDecision(15, 1);
            break;
		}
    	bVarDisplay = 0;
    }


	// LED
    if (bPressureFail)
    {
		if (!bRun)
        {
        	LedPassOff();
        	LedFailOn();
        }
    }else {
    	if (bRunAlarm) {
        	if (bBlink)
            {
				LedPassOff();
       			LedFailOn();
            }else {
				LedPassOff();
       			LedFailOff();
            }
        }else {
			LedFailOff();
        	LedPassOff();
        }
    }

    if (bRun)
	{
       	if (bBlink)
        {
	        LedComOn();
        }else {
	        LedComOff();
        }
        
        if (RunStep == RUN_PRESSURE_DELAY) 
        {
            if (!bPressureFail && !bRunAlarm)
            {        
                if (bBlink)
                {
                    LedPassOn();
       			    LedFailOff();  
                } else{
                    LedPassOff();
       			    LedFailOff(); 
                }
            }else { 
                if (bBlink)
                {  
                    LedPassOff();
       			    LedFailOn();
                } else {
                    LedPassOff();
       			    LedFailOff();
                }
            }
        }
    }else {
    	if (bLongKey) LedComOff();
        else LedComOn();
    }
}

void KeySubroutine(void)	// 100ms
{
	static unsigned char KeyDownCount = 0;
    static unsigned char PrevDownKey = 0;

    if (Key)	// 키 눌려진 상태
    {
		PrevDownKey = Key;
    	if (++KeyDownCount >= 200) KeyDownCount--;
		
        if (KeyDownCount > 10)	//1sec 이상
        {
			bLongKey = 1;
        	switch(Key)
        	{
				case KEY_UP:
                	switch(Mode1Step)
                    {
                    	case MODE1_NOMAL:
                        	break;
                        case MODE2_PRESSURE_SET:	// 압력 설정
                        	if (KeyDownCount > 30) {
                            	SetData += 10;
                        		if (SetData > PRESSURE_MAX_) SetData = PRESSURE_MAX_;
							}else {
                        		if (++SetData > PRESSURE_MAX_) SetData--;
                            }
                            bVarDisplay = 1;
                            break;
                    	case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
                        	if (KeyDownCount > 30) {
                            	SetData += 10;
                        		if (SetData > PRESSURE_TIME_MAX) SetData = PRESSURE_TIME_MAX;
                            }else {
                        		if (++SetData > PRESSURE_TIME_MAX) SetData--;
                            }
                            bVarDisplay = 1;
                            break;
                    }
					
					switch(HiddenStep)
					{
					case HIDDEN1_STEP:				// 압착 Step Set
						if (KeyDownCount > 30) {
							Hidden1SetData += 10;
							if (Hidden1SetData > PRESSURE_STEP_MAX) Hidden1SetData = PRESSURE_STEP_MAX;
						}else {
							if (++Hidden1SetData > PRESSURE_STEP_MAX) Hidden1SetData--;
						}
						bVarDisplay = 1;
						break;
					case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
						if (KeyDownCount > 30) {
							Hidden1SetData += 10;
							if (Hidden1SetData > PRESSURE_STEP_DELAY_MAX) Hidden1SetData = PRESSURE_STEP_DELAY_MAX;
						}else {
							if (++Hidden1SetData > PRESSURE_STEP_DELAY_MAX) Hidden1SetData--;
						}
						bVarDisplay = 1;
						break;
					}
					break;

                case KEY_DOWN:
                	switch(Mode1Step)
                    {
                    	case MODE1_NOMAL:
                        	break;
                        case MODE2_PRESSURE_SET:
                        	if (KeyDownCount > 30) {
                            	if (SetData > PRESSURE_MIN + 10) SetData -= 10;
                                else SetData = PRESSURE_MIN;
                        	}else {
	                        	if (SetData > PRESSURE_MIN) SetData--;
                            }
                            bVarDisplay = 1;
                            break;
                    	case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
                        	if (KeyDownCount > 30) {
                            	if (SetData > PRESSURE_TIME_MIN + 10) SetData -= 10;
                                else SetData = PRESSURE_TIME_MIN;
                        	}else {
                            	if (SetData > PRESSURE_TIME_MIN) SetData--;
                            }
                            bVarDisplay = 1;
                            break;
                    }
					
					switch(HiddenStep)
					{
					case HIDDEN1_STEP:				// 압착 Step Set
						if (KeyDownCount > 30) {
							if (Hidden1SetData > PRESSURE_STEP_MIN + 10) Hidden1SetData -= 10;
							else Hidden1SetData = PRESSURE_STEP_MIN;
						}else {
							if (Hidden1SetData > PRESSURE_STEP_MIN) Hidden1SetData--;
						}
						bVarDisplay = 1;
						break;
					case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
						if (KeyDownCount > 30) {
							if (Hidden1SetData > PRESSURE_STEP_DELAY_MIN + 10) Hidden1SetData -= 10;
							else Hidden1SetData = PRESSURE_STEP_DELAY_MIN;
						}else {
							if (Hidden1SetData > PRESSURE_STEP_DELAY_MIN) Hidden1SetData--;
						}
						bVarDisplay = 1;
						break;
					}
                	break;
        	}

			if (Key == (SW_START1 | SW_START2))
            {
				if (bAgingMode)
				{
					KeyDownCount = 0;
					SetBuzzer(1, 2);
					if (!bRun)	//Aging Mode 시작
					{
						bAgingEnd = 0;
						if (!bAgingEnd)
						{
							if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
							{
								Mode1Step = 0;
								bRun = 1;
								bRunAlarm = 0;
								bMenuDisplay = 1;
								bVarDisplay = 1;
							}else {
								SetBuzzer(1, 1);
								bVarDisplay = 1;
							}
						}
					}else {
						bAgingEnd = 1;
						if (bAgingEnd)
						{
							//bRun = 0;
							bRunAlarm = 0;
							bMenuDisplay = 1;
							bVarDisplay = 1;

							//SetBuzzer(0, 2);
						}
					}
				}
            }

        }else {
        	if (Key == (SW_START1 | SW_START2))
            {
				if (bReturnSensor == 1 || bEmoState == 1)
				{
					bReturnSensor = 2;
					bEmoState = 2;
				}else if (!bAgingMode && bAutoMode && !bRun)
				{
					bAgingMode = 0;
					if (bDoorSensorFail == 0 && bSafeSensorFail == 0 && !Emo && !bPressureFail)
					{
						Mode1Step = 0;
						bRun = 1;
						bRunAlarm = 0;
						bMenuDisplay = 1;
						bVarDisplay = 1;
					}else {
						SetBuzzer(1, 1);
						bVarDisplay = 1;
					}
				}
            }
        }
    }else {	// 키 UP 상태
    	if (PrevDownKey)
        {
        	SetupExitTime = SETUP_EXIT_TIME;
    		if (KeyDownCount < 10)	// Short Key 1sec 이하
        	{
        		switch(PrevDownKey)
                {
				case KEY_MENU:	// Mode 설정
					/*
                	if (Mode1Step)
                    {
						//  Type 설정 모드
						if (Mode1Step >= MODE1_OCTA && Mode1Step <= MODE1_ETC)	
						{
							if (++Mode1Step >= 5) Mode1Step = 1;	// 복귀
//							sMode1Step = Mode1Step;
//							SetEeprom2(6, Mode1Step);
							
						} else {
							//  압력/시간 설정모드
 							if (Mode1Step >= MODE2_PRESSURE_SET && Mode1Step <= MODE2_PRESSURE_DELAY_SET)	
							{
								if (++Mode1Step >= 7) Mode1Step = 5;

								if (Mode1Step == MODE2_PRESSURE_SET) SetData = Pressure;
								else if (Mode1Step == MODE2_PRESSURE_DELAY_SET) SetData = PressureTime;
							} 
						}

	                    bMenuDisplay = 1;
                    }
					*/
                    break;
				case KEY_MODE:	// 자동/수동
                	break;

				case KEY_ENTER:
					if (HiddenStep)
					{
						switch(HiddenStep)
						{
							case HIDDEN1_STEP:				// 압착 Step Set
								PressureStep = Hidden1SetData;
								SetEeprom2(16, PressureStep);
								
								HiddenStep = HIDDEN1_STEP_DELAY;
								Hidden1SetData = sPressureStepDelay;
								bMenuDisplay = 1;
								SetBuzzer(0, 0);
								break;
							case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
								sPressureStepDelay = Hidden1SetData;
								SetEeprom2(18, sPressureStepDelay);
								
								HiddenStep = HIDDEN1_STEP;
								Hidden1SetData = PressureStep;
								bMenuDisplay = 1;
								SetBuzzer(0, 0);
								break;
						}
					} else if (Mode1Step >= MODE1_OCTA && Mode1Step <= MODE1_ETC){ 	// Zone Mode일때만
						// Mode Switching
						sMode1Step = Mode1Step;
						SetEeprom2(6, Mode1Step);
						switch (Mode1Step)
						{
						case MODE1_OCTA:
							Pressure = OCTA_PRESSURE;
							PressureTime = OCTA_PRESSURE_TIME;
							break;
						case MODE1_TAPE:
							Pressure = TYPE_PRESSURE;
							PressureTime = TYPE_PRESSURE_TIME;
							break;
						case MODE1_BATTERY:
							Pressure = BATTERY_PRESSURE;
							PressureTime = BATTERY_PRESSURE_TIME;
							break;
						case MODE1_ETC:
							Pressure = GetEeprom2(2);
							PressureTime = GetEeprom2(0);
							break;
						}
							
						Mode1Step = MODE2_PRESSURE_SET;	
						SetData = Pressure;
						SetEeprom2(2, Pressure);
						SetItv(Pressure);
						bMenuDisplay = 1;
						SetBuzzer(0, 0);
					} else{				
						switch(Mode1Step)
						{
						case MODE2_PRESSURE_SET:	// 압력
							Pressure = SetData;
							SetEeprom2(2, Pressure);
							SetItv(Pressure);

							Mode1Step = MODE2_PRESSURE_DELAY_SET;
							SetData = PressureTime;
							bMenuDisplay = 1;
							SetBuzzer(0, 0);
							break;
						case MODE2_PRESSURE_DELAY_SET:	// 압력시간
							PressureTime = SetData;
							SetEeprom2(0, PressureTime);

							Mode1Step = MODE2_PRESSURE_SET;
							SetData = Pressure;
							bMenuDisplay = 1;
							SetBuzzer(0, 0);
							break;
						}
					}
					
                    
                    if (bCalib && CalibStep >= 10){
                        switch(CalibStep)
                        {
                            case 12:
                            	CalItvMin = Ltc1865Read(0);
                            	SetEeprom2(10, CalItvMin);
                                break;
                                
                            case 13:
                            	CalItvMax = (unsigned long)((unsigned long)Ltc1865Read(0) * 1);     
                            	SetEeprom4(12, CalItvMax);
                                break;
                        }
                       SetBuzzer(0, 0);
                    }
            		break;

				case KEY_UP:
					if (!HiddenStep)
					{
						switch(Mode1Step)
						{
							case MODE1_NOMAL:
								if (!bAutoMode)	// Manual Mode 동작
								{
									SetItv(PRESSURE_NOMAL);     // 15.01.27 기구적 실린더 동작 문제로 2.0k로 고정
									if (Sensor & CYL_X_IN_SENSOR || Sensor & CYL_X_OUT_SENSOR)
									{
										bCylYDown = !bCylYDown;
										if (bCylYDown) CYL_Y_DOWN;
										else CYL_Y_UP;
									}
									bVarDisplay = 1;
								}
								break;
							case MODE1_OCTA:
							case MODE1_TAPE:
							case MODE1_BATTERY:
							case MODE1_ETC:
								if (++Mode1Step >= 5) Mode1Step = 4;	// 복귀
								bMenuDisplay = 1;
								break;
							case MODE2_PRESSURE_SET:
								if (++SetData > PRESSURE_MAX_) SetData--;
								bVarDisplay = 1;
								break;
							case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
								if (++SetData > PRESSURE_TIME_MAX) SetData--;
								bVarDisplay = 1;
								break;
						}
					} else{
						switch(HiddenStep)
						{
						case HIDDEN1_STEP:				// 압착 Step Set
							if (++Hidden1SetData > PRESSURE_STEP_MAX) Hidden1SetData--;
							bVarDisplay = 1;
							break;
						case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
							if (++Hidden1SetData > PRESSURE_STEP_DELAY_MAX) Hidden1SetData--;
							bVarDisplay = 1;
							break;
						}
					}
                    SetBuzzer(0, 0);
                    break;

				case KEY_DOWN:
					if (!HiddenStep)
					{
						switch(Mode1Step)
						{
							case MODE1_NOMAL:
								if (!bAutoMode && !bCylYDown)
								{
									SetItv(PRESSURE_NOMAL);     // 15.01.27 기구적 실린더 동작 문제로 2.0k로 고정
									if (Sensor & CYL_Y_UP_SENSOR)
									{
										bCylXIn = !bCylXIn;
										if (bCylXIn) CYL_X_IN;
										else CYL_X_OUT;
									}
									bVarDisplay = 1;
								}
								break;
							case MODE1_OCTA:
							case MODE1_TAPE:
							case MODE1_BATTERY:
							case MODE1_ETC:
								if (--Mode1Step <= 0) Mode1Step = 1;	// 복귀
								bMenuDisplay = 1;
								break;
							case MODE2_PRESSURE_SET:
								if (SetData > PRESSURE_MIN) SetData--;
								bVarDisplay = 1;
								break;
							case MODE2_PRESSURE_DELAY_SET:	// Pressure Time
								if (SetData > PRESSURE_TIME_MIN) SetData--;
								bVarDisplay = 1;
								break;
						}
					} else{					
						switch(HiddenStep)
						{
						case HIDDEN1_STEP:				// 압착 Step Set
							if (Hidden1SetData > PRESSURE_STEP_MIN) Hidden1SetData--;
							bVarDisplay = 1;
							break;
						case HIDDEN1_STEP_DELAY:		// 압착 Step Delay Set
							if (Hidden1SetData > PRESSURE_STEP_DELAY_MIN) Hidden1SetData--;
							bVarDisplay = 1;
							break;
						}
					}
                    SetBuzzer(0, 0);
                    break;
				case KEY_FN:
                    if (bCalib && CalibStep >= 10)
                    {
                        if (++CalibStep >= 12) CalibStep = 10;
                    }
                    SetBuzzer(0, 0);
                    bMenuDisplay = 1;
                	break;

                }
        	}else {	// Long Key
               	switch(PrevDownKey)
                {
				case KEY_MENU:	// 압력/시간
					if (!HiddenStep)	// Hidden Mode가 아닐때만
					{
						if (Mode1Step)
						{
							Mode1Step = 0;
						}else {
							Mode1Step = 1;
						}
						SetData = Pressure;
						bMenuDisplay = 1;
						SetBuzzer(0, 1);
					}
                    break;

				case KEY_MODE:	// 자동/수동
                	if (!bRun && Mode1Step == 0 && !HiddenStep)
                    {
						if (++bAutoMode >= 3) bAutoMode = 0;
						if (bAutoMode == 1) bAutoMode = 2;		// 15.04.02 SIS 이원욱D 요청으로 AutoMode 삭제
                        bMenuDisplay = 1;
						bAgingMode = 0;
						SetEeprom2(4, bAutoMode);
						if (bAutoMode) mRunStepTime = 0;
                    }
                    SetBuzzer(0, 1);
					break;
				case KEY_ENTER:
                	break;
				case KEY_UP:
                    break;
                case KEY_DOWN:
                	break;
				case KEY_FN:
                	if (TestMode)
                    {
                		bCalib = 1;
                        CalibStep = 0;
                        CalibStepDelay = 100;
	                    SetBuzzer(1, 0);
                    }
                	break;
				case KEY_FN | KEY_ENTER:
					if (!bRun && Mode1Step == 0)
					{
						bAgingMode = !bAgingMode;
						bMenuDisplay = 1;
						// bAutoMode = 0;
					}
					SetBuzzer(0, 1);
					break;
					
                case KEY_UP | KEY_DOWN:
                	TestMode = !TestMode;
                    bCalib = 0; 
                    bMenuDisplay = 1;
                    SetBuzzer(1, 0);
                    break;   
                    
                case KEY_FN | KEY_MENU: // 교정모드 키
                    bCalib = !bCalib;
					bMenuDisplay = 1;
                    
                    if (bCalib)
                    {
                        CalibStep = 10;
                    }else {
                        SetItv(Pressure);
                    }
                    SetBuzzer(1, 0);
                    break;
					
				case KEY_FN | KEY_DOWN: // TestCnt 초기화
                    TestCnt = 0;
					bMenuDisplay = 1;
                    SetBuzzer(1, 0);
                    break;
					
				case KEY_FN | KEY_MODE:	// Hidden Mode 1 진입
                	if (!bRun && Mode1Step == 0)	// Mode 1 진입했을때만 구동
					{
						HiddenStep = !HiddenStep;
						Hidden1SetData = PressureStep;
						bMenuDisplay = 1;
						SetBuzzer(0, 1);
					}
                    break;  
                }
            }
        }else {
			if (SetupExitTime && Mode1Step)
            {
            	SetupExitTime--;
                if (SetupExitTime == 0)
                {
                	Mode1Step = 0;
                    bMenuDisplay = 1;
                    SetBuzzer(0, 1);
                }
            }
        }
		bLongKey = 0;
    	KeyDownCount = 0;
		PrevDownKey = 0;
    }
}

/*
void StepPressureSubroutine(void)
{
	int r = 0;
	if (RunStep == RUN_CYL_DOWN)
	{
		if (Sensor & CYL_Y_DOWN_SENSOR)
		{
			if (PressureStepDelay)
			{
				PressureStepDelay--;
			} else{
				r = Pressure - DownPressure;
				if(r < 0) r = 0;

				if (r >= 20)
				{
					SetItv(DownPressure+=20);
				}

				if (r < 20)
				{
					DownPressure = Pressure;
					SetItv(Pressure);
					bDownPressureEnd = 1;
					DownPressure = 0;
				}
				PressureStepDelay = 1;
			}
		}
	}
}
*/

void StepPressureSubroutine(void)
{
	unsigned int DownPressureStep = Pressure / PressureStep;

	if (RunStep == RUN_CYL_DOWN && !bEmoState && !bReturnSensor && !bDownPressureEnd)
	{
		if (Sensor & CYL_Y_DOWN_SENSOR)
		{
			if (PressureStepDelay)
			{
				PressureStepDelay--;
			} else{
				if (DownPressure <= Pressure)
				{
					DownPressure += DownPressureStep;
					if (DownPressure >= Pressure) DownPressure = Pressure;

					SetItv(DownPressure);
					//Lcdprintf(9, 3, "%d", DownPressure);
					
					if (DownPressure >= Pressure)
					{
						bDownPressureEnd = 1;
						DownPressure = 0;
					}
					PressureStepDelay = sPressureStepDelay;
				}
			}
		}
	}
}

void PressureRewardSubroutine(void)
{
	unsigned long GetPressure;

 	if (bPressureReward && RunStepTime >= 50)	// Step 압력 설정 후 딜레이 500 ms 뒤
	{
		GetPressure = GetItv();
		if ((Pressure - GetPressure) > 0) SetItv(Pressure + abs(Pressure - GetPressure));	// 양수
		else if ((Pressure - GetPressure) < 0) SetItv(Pressure - abs(Pressure - GetPressure));	// 음수
		//Lcdprintf(9, 3, "%d", GetPressure);
		bPressureReward = 0;
	}
}

void PressureCheckSubroutine(void)
{
	unsigned long GetPressure;
	
	if (bAutoMode == 2  && (RunStep == RUN_PRESSURE_DELAY) && !bRunAlarm)
	{
		GetPressure = GetItv();
		if (RunStepTime >= 100)	// 1000ms Delay
		{
			if (abs(Pressure - GetPressure) > PRESSURE_LIMIT) bPressureFail = 1;
//				else bPressureFail = 0;
		}
	}
}






