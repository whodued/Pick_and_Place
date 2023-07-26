PROGRAM filling_tank
  VAR
    manual AT %QX0.0 : BOOL;
    auto AT %QX0.1 : BOOL;
    emergency_stop AT %QX0.2 : BOOL;
    start AT %QX0.3 : BOOL;
    stop AT %QX0.4 : BOOL;
    reset_button AT %QX0.5 : BOOL;
    start_light AT %QX1.0 : BOOL;
    stop_light AT %QX1.1 : BOOL;
    reset_light AT %QX1.2 : BOOL;
    bottom_valve_open AT %QX1.3 : BOOL;
    top_valve_open AT %QX1.4 : BOOL;
    fictoryioreset AT %QX1.5 : BOOL;
    top_flow AT %QW0 : INT;
    top_level AT %QW1 : INT;
    bottom_flow AT %QW2 : INT;
    bottom_level AT %QW3 : INT;
    top_fill_valve AT %QW4 : INT;
    top_discharge_valve AT %QW5 : INT;
    bottom_fill_valve AT %QW6 : INT;
    bottom_discharge_valve AT %QW7 : INT;
    top_tank AT %QW8 : INT;
    bottom_tank AT %QW9 : INT;
    number_cycles AT %QW10 : INT;
  END_VAR
  VAR
    CTU0 : CTU;
    reset : BOOL;
    _TMP_MOVE9_ENO : BOOL;
    _TMP_MOVE9_OUT : INT;
    _TMP_LT31_ENO : BOOL;
    _TMP_LT31_OUT : BOOL;
    _TMP_LT32_ENO : BOOL;
    _TMP_LT32_OUT : BOOL;
    _TMP_MOVE36_ENO : BOOL;
    _TMP_MOVE36_OUT : INT;
    _TMP_MOVE38_ENO : BOOL;
    _TMP_MOVE38_OUT : INT;
    _TMP_GT19_ENO : BOOL;
    _TMP_GT19_OUT : BOOL;
    _TMP_MOVE22_ENO : BOOL;
    _TMP_MOVE22_OUT : INT;
    _TMP_MOVE24_ENO : BOOL;
    _TMP_MOVE24_OUT : INT;
    _TMP_GT49_ENO : BOOL;
    _TMP_GT49_OUT : BOOL;
    _TMP_MOVE54_ENO : BOOL;
    _TMP_MOVE54_OUT : INT;
    _TMP_MOVE56_ENO : BOOL;
    _TMP_MOVE56_OUT : INT;
    _TMP_MOVE64_ENO : BOOL;
    _TMP_MOVE64_OUT : INT;
    _TMP_MOVE50_ENO : BOOL;
    _TMP_MOVE50_OUT : INT;
    _TMP_GT73_ENO : BOOL;
    _TMP_GT73_OUT : BOOL;
    _TMP_GT81_ENO : BOOL;
    _TMP_GT81_OUT : BOOL;
    R_TRIG1 : R_TRIG;
  END_VAR

  start_light := emergency_stop AND stop AND (start OR start_light);
  _TMP_MOVE9_OUT := MOVE(EN := NOT(start_light), IN := 0, ENO => _TMP_MOVE9_ENO);
  stop_light := _TMP_MOVE9_ENO;
  IF _TMP_MOVE9_ENO THEN
      top_discharge_valve := _TMP_MOVE9_OUT;
  END_IF;
  IF _TMP_MOVE9_ENO THEN
      top_fill_valve := _TMP_MOVE9_OUT;
  END_IF;
  IF _TMP_MOVE9_ENO THEN
      bottom_discharge_valve := _TMP_MOVE9_OUT;
  END_IF;
  IF _TMP_MOVE9_ENO THEN
      bottom_fill_valve := _TMP_MOVE9_OUT;
  END_IF;
  _TMP_LT31_OUT := LT(EN := start, IN1 := bottom_level, IN2 := 900, ENO => _TMP_LT31_ENO);
  _TMP_LT32_OUT := LT(EN := _TMP_LT31_OUT, IN1 := top_level, IN2 := 900, ENO => _TMP_LT32_ENO);
  _TMP_MOVE36_OUT := MOVE(EN := _TMP_LT32_OUT, IN := 0, ENO => _TMP_MOVE36_ENO);
  IF _TMP_MOVE36_ENO THEN
      top_discharge_valve := _TMP_MOVE36_OUT;
  END_IF;
  IF _TMP_MOVE36_ENO THEN
      bottom_fill_valve := _TMP_MOVE36_OUT;
  END_IF;
  _TMP_MOVE38_OUT := MOVE(EN := _TMP_LT32_OUT, IN := 200, ENO => _TMP_MOVE38_ENO);
  IF _TMP_MOVE38_ENO THEN
      top_fill_valve := _TMP_MOVE38_OUT;
  END_IF;
  IF _TMP_MOVE38_ENO THEN
      bottom_discharge_valve := _TMP_MOVE38_OUT;
  END_IF;
  _TMP_GT19_OUT := GT(EN := start_light, IN1 := top_level, IN2 := 900, ENO => _TMP_GT19_ENO);
  _TMP_MOVE22_OUT := MOVE(EN := _TMP_GT19_OUT, IN := 200, ENO => _TMP_MOVE22_ENO);
  IF _TMP_MOVE22_ENO THEN
      top_discharge_valve := _TMP_MOVE22_OUT;
  END_IF;
  IF _TMP_MOVE22_ENO THEN
      bottom_fill_valve := _TMP_MOVE22_OUT;
  END_IF;
  _TMP_MOVE24_OUT := MOVE(EN := _TMP_GT19_OUT, IN := 0, ENO => _TMP_MOVE24_ENO);
  IF _TMP_MOVE24_ENO THEN
      top_fill_valve := _TMP_MOVE24_OUT;
  END_IF;
  IF _TMP_MOVE24_ENO THEN
      bottom_discharge_valve := _TMP_MOVE24_OUT;
  END_IF;
  _TMP_GT49_OUT := GT(EN := start_light, IN1 := bottom_level, IN2 := 900, ENO => _TMP_GT49_ENO);
  _TMP_MOVE54_OUT := MOVE(EN := _TMP_GT49_OUT, IN := 0, ENO => _TMP_MOVE54_ENO);
  IF _TMP_MOVE54_ENO THEN
      top_discharge_valve := _TMP_MOVE54_OUT;
  END_IF;
  IF _TMP_MOVE54_ENO THEN
      bottom_fill_valve := _TMP_MOVE54_OUT;
  END_IF;
  _TMP_MOVE56_OUT := MOVE(EN := _TMP_GT49_OUT, IN := 200, ENO => _TMP_MOVE56_ENO);
  IF _TMP_MOVE56_ENO THEN
      top_fill_valve := _TMP_MOVE56_OUT;
  END_IF;
  IF _TMP_MOVE56_ENO THEN
      bottom_discharge_valve := _TMP_MOVE56_OUT;
  END_IF;
  _TMP_MOVE64_OUT := MOVE(EN := TRUE, IN := top_level, ENO => _TMP_MOVE64_ENO);
  IF _TMP_MOVE64_ENO THEN
      top_tank := _TMP_MOVE64_OUT;
  END_IF;
  _TMP_MOVE50_OUT := MOVE(EN := _TMP_MOVE64_ENO, IN := top_level, ENO => _TMP_MOVE50_ENO);
  IF _TMP_MOVE50_ENO THEN
      top_tank := _TMP_MOVE50_OUT;
  END_IF;
  _TMP_GT73_OUT := GT(EN := start_light, IN1 := bottom_discharge_valve, IN2 := 0, ENO => _TMP_GT73_ENO);
  bottom_valve_open := _TMP_GT73_OUT;
  _TMP_GT81_OUT := GT(EN := start_light, IN1 := top_discharge_valve, IN2 := 0, ENO => _TMP_GT81_ENO);
  top_valve_open := _TMP_GT81_OUT;
  R_TRIG1(CLK := _TMP_GT81_OUT);
  CTU0(CU := R_TRIG1.Q, R := reset, PV := 32767);
  reset := CTU0.Q;
  number_cycles := CTU0.CV;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : filling_tank;
  END_RESOURCE
END_CONFIGURATION
